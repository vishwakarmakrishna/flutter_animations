// # lib/screens/animations/physics_animations_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class PhysicsAnimationsPage extends StatefulWidget {
  const PhysicsAnimationsPage({super.key});

  @override
  State<PhysicsAnimationsPage> createState() => _PhysicsAnimationsPageState();
}

class _PhysicsAnimationsPageState extends State<PhysicsAnimationsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Alignment _dragAlignment = Alignment.center;
  Animation<Alignment>? _animation;

  /// Run the animation with the given simulation
  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );

    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const springDescription = SpringDescription(
      mass: 1,
      stiffness: 500,
      damping: 20,
    );

    final simulation = SpringSimulation(
      springDescription,
      0,
      1,
      -unitVelocity,
    );

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..addListener(() {
        setState(() {
          if (_animation != null) {
            _dragAlignment = _animation!.value;
          }
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Physics Animations')),
      body: Stack(
        children: [
          Align(
            alignment: _dragAlignment,
            child: GestureDetector(
              onPanDown: (details) {
                _controller.stop();
              },
              onPanUpdate: (details) {
                setState(() {
                  _dragAlignment += Alignment(
                    details.delta.dx / (size.width / 2),
                    details.delta.dy / (size.height / 2),
                  );
                });
              },
              onPanEnd: (details) {
                _runAnimation(details.velocity.pixelsPerSecond, size);
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(50),
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
                    Icons.sports_basketball,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Drag and release the ball to see spring physics in action!',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
