import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart'; // For playing sound
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';

class ScannerScreen extends StatefulWidget {
  final String desktopUrl;

  const ScannerScreen({super.key, required this.desktopUrl});

  @override
  State<ScannerScreen> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  final AudioPlayer _audioPlayer = AudioPlayer(); // Audio player for sound
  String _lastScannedIsbn = 'No ISBN scanned yet'; // Default ISBN text
  String? _previousIsbn; // Track the previous ISBN

  @override
  void initState() {
    super.initState();
    // Preload the sound for quick playback
    _audioPlayer.setSource(AssetSource('sounds/scan_success.mp3'));
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _sendIsbn(String isbn) async {
    try {
      final response = await http.post(
        Uri.parse('${widget.desktopUrl}/isbn'),
        body: isbn,
      );
      if (response.statusCode == 200) {
        AppLogger.logger.i('ISBN sent successfully');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('ISBN sent successfully')));
      } else {
        AppLogger.logger.e('Failed to send ISBN');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to send ISBN')));
      }
    } catch (e) {
      AppLogger.logger.e('Error sending ISBN: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error sending ISBN: $e')));
    }
  }

  void _onBarcodeDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        final isbn = barcode.rawValue!;
        setState(
          () => _lastScannedIsbn = isbn,
        ); // Always update the displayed ISBN

        // Check if the ISBN is different from the previous one
        if (isbn != _previousIsbn) {
          _previousIsbn = isbn; // Update the previous ISBN
          _sendIsbn(isbn); // Send ISBN to server
          _audioPlayer.play(
            AssetSource('sounds/scan_success.mp3'),
          ); // Play sound
        }
        break; // Process only the first valid barcode
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('扫描器'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Center the content
        children: [
          // Display the recognized ISBN at the top
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
            child: Text(
              'ISBN识别结果: $_lastScannedIsbn',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20), // Spacing between text and scanner
          // Rectangular scanner with beautiful border
          Center(
            child: Container(
              width: 300, // Fixed width
              height: 300, // Fixed height
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueAccent, // Border color
                  width: 2.0, // Border thickness
                ),
                borderRadius: BorderRadius.circular(12), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(
                      (0.3 * 255).toInt(),
                    ), // Subtle shadow
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  12,
                ), // Match container border
                child: MobileScanner(
                  controller: _controller,
                  onDetect: _onBarcodeDetect,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
