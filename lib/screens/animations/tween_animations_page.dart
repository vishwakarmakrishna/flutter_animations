import 'package:flutter/material.dart';
import 'dart:math' as math;

class TweenAnimationsPage extends StatefulWidget {
  const TweenAnimationsPage({super.key});

  @override
  State<TweenAnimationsPage> createState() => _TweenAnimationsPageState();
}

class _TweenAnimationsPageState extends State<TweenAnimationsPage> {
  double _value = 0.0;
  Color _color = Colors.blue;
  AlignmentGeometry _alignment = Alignment.topLeft;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tween Animations')),
      body: Column(
        children: [
          Expanded(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: _value),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) {
                return Transform.rotate(
                  angle: value,
                  child: TweenAnimationBuilder<Color?>(
                    tween: ColorTween(begin: Colors.blue, end: _color),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, color, child) {
                      return TweenAnimationBuilder<AlignmentGeometry>(
                        tween: Tween<AlignmentGeometry>(
                          begin: Alignment.topLeft,
                          end: _alignment,
                        ),
                        duration: const Duration(milliseconds: 500),
                        builder: (context, alignment, child) {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            alignment: alignment,
                            color: color,
                            child: const FlutterLogo(size: 100),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _value = _value + math.pi / 2;
                    });
                  },
                  child: const Text('Rotate'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _color = _color == Colors.blue ? Colors.red : Colors.blue;
                    });
                  },
                  child: const Text('Change Color'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _alignment = _alignment == Alignment.topLeft
                          ? Alignment.bottomRight
                          : Alignment.topLeft;
                    });
                  },
                  child: const Text('Move'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
