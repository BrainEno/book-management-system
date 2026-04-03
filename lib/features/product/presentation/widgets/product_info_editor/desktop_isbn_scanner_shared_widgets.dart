import 'package:flutter/material.dart';

class ScanWaveIndicator extends StatelessWidget {
  const ScanWaveIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: const LinearProgressIndicator(minHeight: 6),
    );
  }
}

class DesktopScannerFrameOverlay extends StatelessWidget {
  const DesktopScannerFrameOverlay({super.key, required this.scanWindow});

  final Rect scanWindow;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned.fromRect(
            rect: scanWindow,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.82),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.16),
                    blurRadius: 18,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Stack(
                children: const [
                  Positioned(
                    left: 14,
                    right: 14,
                    top: 14,
                    child: DesktopScannerFrameBeam(),
                  ),
                  DesktopScannerCorner(alignment: Alignment.topLeft),
                  DesktopScannerCorner(alignment: Alignment.topRight),
                  DesktopScannerCorner(alignment: Alignment.bottomLeft),
                  DesktopScannerCorner(alignment: Alignment.bottomRight),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DesktopScannerFrameBeam extends StatelessWidget {
  const DesktopScannerFrameBeam({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: const LinearProgressIndicator(minHeight: 5),
    );
  }
}

class DesktopScannerCorner extends StatelessWidget {
  const DesktopScannerCorner({super.key, required this.alignment});

  final Alignment alignment;

  BorderRadius _radius() {
    if (alignment == Alignment.topLeft) {
      return const BorderRadius.only(topLeft: Radius.circular(20));
    }
    if (alignment == Alignment.topRight) {
      return const BorderRadius.only(topRight: Radius.circular(20));
    }
    if (alignment == Alignment.bottomLeft) {
      return const BorderRadius.only(bottomLeft: Radius.circular(20));
    }
    return const BorderRadius.only(bottomRight: Radius.circular(20));
  }

  Border _border() {
    const side = BorderSide(color: Color(0xFF34D399), width: 5);
    if (alignment == Alignment.topLeft) {
      return const Border(left: side, top: side);
    }
    if (alignment == Alignment.topRight) {
      return const Border(right: side, top: side);
    }
    if (alignment == Alignment.bottomLeft) {
      return const Border(left: side, bottom: side);
    }
    return const Border(right: side, bottom: side);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(border: _border(), borderRadius: _radius()),
      ),
    );
  }
}
