import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class ViewWordsOverlay extends StatefulWidget {
  const ViewWordsOverlay({Key? key}) : super(key: key);

  @override
  State<ViewWordsOverlay> createState() => _ViewWordsOverlayState();
}

class _ViewWordsOverlayState extends State<ViewWordsOverlay> {
  bool isGold = true;

  @override
  void initState() {
    print("*************************** in INITIAL STATE");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          height: double.infinity, // Ensure height is set to fill the screen
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 221, 211, 211).withOpacity(0.5),
          ),
          child: GestureDetector(
            onTap: () {},
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () async {
                      await FlutterOverlayWindow.closeOverlay();
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 100,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ).animate().move(
              begin: Offset(0, 500),
              end: Offset(0, 0),
              duration: 1000.ms,
            ),
      ),
    );
  }
}
