import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomAnimationsPage extends StatefulWidget {
  const CustomAnimationsPage({super.key});

  @override
  State<CustomAnimationsPage> createState() => _CustomAnimationsPageState();
}

class _CustomAnimationsPageState extends State<CustomAnimationsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = List.generate(50, (_) => Particle());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Animations')),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: ParticlePainter(_particles, _controller.value),
                child: Container(),
              );
            },
          ),
          Center(
            child: Card(
              color: Colors.white.withOpacity(0.9),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Particle Animation',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'A custom animation using CustomPainter',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
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

class Particle {
  late double x;
  late double y;
  late Color color;
  late double speed;
  late double size;
  late double opacity;

  Particle() {
    reset();
  }

  void reset() {
    final random = math.Random();
    x = random.nextDouble() * 400;
    y = random.nextDouble() * 800;
    color = Colors.primaries[random.nextInt(Colors.primaries.length)];
    speed = 1 + random.nextDouble() * 4;
    size = 2 + random.nextDouble() * 4;
    opacity = 0.1 + random.nextDouble() * 0.4;
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double animation;

  ParticlePainter(this.particles, this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      particle.y = (particle.y + particle.speed) % size.height;

      final paint = Paint()
        ..color = particle.color.withOpacity(particle.opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(particle.x, particle.y),
        particle.size * (1 + animation),
        paint,
      );

      // Draw trailing effect
      canvas.drawCircle(
        Offset(particle.x, particle.y - particle.speed * 2),
        particle.size * 0.8 * (1 + animation),
        paint..color = paint.color.withOpacity(paint.color.opacity * 0.5),
      );
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}
