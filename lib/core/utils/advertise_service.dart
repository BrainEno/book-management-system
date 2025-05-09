import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';

/// Advertise a DNS-SD (zeroconf) TCP service named [serviceType] on port [port].
/// This will send full DNS answer packets (PTR, SRV, TXT, A) to 224.0.0.251:5353.
Future<void> advertiseService(String serviceType, int port) async {
  final logger = AppLogger.logger;

  // 1) Determine our hostname and IPv4 address
  final String hostname = Platform.localHostname; // e.g. "my-desktop"
  final interfaces = await NetworkInterface.list(
    type: InternetAddressType.IPv4,
  );
  final ipv4 =
      interfaces
          .expand((i) => i.addresses)
          .firstWhere((addr) => !addr.isLoopback)
          .address; // e.g. "192.168.1.42"

  // DNS-SD names
  final String serviceDomain = '$serviceType.local'; // "_bookstore._tcp.local"
  final String instanceName =
      '$hostname.$serviceDomain'; // "my-desktop._bookstore._tcp.local"
  final String targetName = '$hostname.local'; // "my-desktop.local"

  // 2) Build individual records
  Uint8List buildPacket() {
    final builder = BytesBuilder();

    // -- DNS Header: zero ID, flags=0x8400 (response, authoritative, no recursion), counts
    builder.add(_u16(0)); // ID
    builder.add(_u16(0x8400)); // Flags
    builder.add(_u16(4)); // QDCOUNT = 0
    builder.add(_u16(4)); // ANCOUNT = 4 (PTR, SRV, TXT, A)
    builder.add(_u16(0)); // NSCOUNT
    builder.add(_u16(0)); // ARCOUNT

    // -- PTR: _bookstore._tcp.local. PTR in CLASS IN
    builder.add(_encodeName(serviceDomain)); // name
    builder.add(_u16(12)); // TYPE PTR
    builder.add(_u16(1)); // CLASS IN
    builder.add(_u32(4500)); // TTL
    final ptrRdata = _encodeName(instanceName);
    builder.add(_u16(ptrRdata.length));
    builder.add(ptrRdata);

    // -- SRV: instanceName SRV priority=0, weight=0, port, target=hostname.local.
    builder.add(_encodeName(instanceName));
    builder.add(_u16(33)); // TYPE SRV
    builder.add(_u16(1)); // CLASS IN
    builder.add(_u32(120)); // TTL
    final srvData =
        BytesBuilder()
          ..add(_u16(0)) // priority
          ..add(_u16(0)) // weight
          ..add(_u16(port)) // port
          ..add(_encodeName(targetName));
    builder.add(_u16(srvData.length));
    builder.add(srvData.toBytes());

    // -- TXT: instanceName TXT (empty TXT record)
    builder.add(_encodeName(instanceName));
    builder.add(_u16(16)); // TYPE TXT
    builder.add(_u16(1)); // CLASS IN
    builder.add(_u32(4500)); // TTL
    builder.add(_u16(1)); // RDLENGTH
    builder.addByte(0); // zero‐length TXT key/value

    // -- A: hostname.local. A record for our IPv4
    builder.add(_encodeName(targetName));
    builder.add(_u16(1)); // TYPE A
    builder.add(_u16(1)); // CLASS IN
    builder.add(_u32(120)); // TTL
    final ipBytes = InternetAddress(ipv4).rawAddress; // 4 bytes
    builder.add(_u16(ipBytes.length));
    builder.add(ipBytes);

    return builder.toBytes();
  }

  final packet = buildPacket();
  final multicastAddress = InternetAddress('224.0.0.251');
  final port5353 = 5353;

  // 3) Open a socket to send our announcements
  final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
  socket.broadcastEnabled = true;
  socket.multicastLoopback = true;
  socket.joinMulticast(multicastAddress);

  // 4) Send immediately, then every 30s (half of lowest TTL) to keep us alive
  void announce() {
    socket.send(packet, multicastAddress, port5353);
    logger.i('Sent DNS-SD announce for $instanceName on port $port');
  }

  announce();
  Timer.periodic(const Duration(seconds: 30), (_) => announce());

  // 5) Clean-up when your app shuts down
  //    _mDns?.stop() and socket.close() in your dispose() will cancel these.
}

// -- helpers to build DNS wire format
Uint8List _u16(int x) {
  return Uint8List(2)..buffer.asByteData().setUint16(0, x, Endian.big);
}

Uint8List _u32(int x) {
  return Uint8List(4)..buffer.asByteData().setUint32(0, x, Endian.big);
}

/// Encode a DNS name like "foo.bar.local" into length-prefixed labels.
Uint8List _encodeName(String name) {
  final parts = name.split('.');
  final b = BytesBuilder();
  for (var label in parts) {
    final bytes = label.codeUnits;
    b.addByte(bytes.length);
    b.add(bytes);
  }
  b.addByte(0); // terminator
  return b.toBytes();
}
