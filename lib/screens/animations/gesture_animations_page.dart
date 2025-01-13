// # lib/screens/animations/gesture_animations_page.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;

class GestureAnimationsPage extends StatefulWidget {
  const GestureAnimationsPage({super.key});

  @override
  State<GestureAnimationsPage> createState() => _GestureAnimationsPageState();
}

class _GestureAnimationsPageState extends State<GestureAnimationsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  double _rotation = 0.0;
  Offset _previousOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gesture Animations')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: GestureDetector(
                onScaleStart: (details) {
                  _previousOffset = _offset;
                },
                onScaleUpdate: (details) {
                  setState(() {
                    _scale = details.scale;
                    _rotation = details.rotation;
                    // Update offset based on focal point
                    _offset = _previousOffset + details.focalPointDelta;
                  });
                },
                onScaleEnd: (_) {
                  setState(() {
                    _scale = 1.0;
                    _rotation = 0.0;
                    _offset = Offset.zero;
                    _previousOffset = Offset.zero;
                  });
                },
                child: Transform.translate(
                  offset: _offset,
                  child: Transform.rotate(
                    angle: _rotation,
                    child: Transform.scale(
                      scale: _scale,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.touch_app,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Gesture Controls',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  const Text('• Pinch to scale'),
                  const Text('• Rotate with two fingers'),
                  const Text('• Drag to move'),
                  const Text('• Release to reset'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
