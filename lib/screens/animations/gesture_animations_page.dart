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
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              _offset += details.delta;
            });
          },
          onScaleUpdate: (details) {
            setState(() {
              _scale = details.scale;
              _rotation = details.rotation;
            });
          },
          onScaleEnd: (_) {
            setState(() {
              _scale = 1.0;
              _rotation = 0.0;
              _offset = Offset.zero;
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
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}