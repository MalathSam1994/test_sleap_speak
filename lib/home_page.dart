import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:unlock_detector/unlock_detector.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();

  static String screenId = '1';
}

class _HomePageState extends State<HomePage> {
  final UnlockDetector _unlockDetector = UnlockDetector();
  UnlockDetectorStatus _status = UnlockDetectorStatus.unknown;
  SendPort? homePort;
  String? latestMessageFromOverlay;

  @override
  void initState() {
    super.initState();
    _unlockDetector.initialize();
    _unlockDetector.stream?.listen((status) {
      if (mounted) {
        setState(() {
          _status = status;
          if (_status == UnlockDetectorStatus.unlocked) {
            _showOverlay();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose the UnlockDetector to stop listening when the widget is removed
    _unlockDetector.dispose();

    // Always call the super.dispose() to ensure the parent class's dispose is also called
    super.dispose();
  }

  Future<void> _showOverlay() async {
    print("Attempting to show overlay...");
    if (await FlutterOverlayWindow.isActive()) {
      await FlutterOverlayWindow.closeOverlay();
    }
    await FlutterOverlayWindow.showOverlay(
      enableDrag: false,
      overlayTitle: "X-SLAYER",
      overlayContent: 'Overlay Enabled',
      flag: OverlayFlag.defaultFlag,
      visibility: NotificationVisibility.visibilityPublic,
      positionGravity: PositionGravity.auto,
      height: WindowSize.matchParent,
      width: WindowSize.matchParent,
      startPosition: const OverlayPosition(0, 0),
    );
    print("Overlay shown.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Lock Phone'),
      ),
    );
  }
}
