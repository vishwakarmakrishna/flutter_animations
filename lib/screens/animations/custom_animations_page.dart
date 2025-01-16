// # lib/screens/animations/custom_animations_page.dart
import 'dart:convert';

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
  final List<Particle> _particles = [];

  // Customization parameters
  int _particleCount = 50;
  double _particleSize = 3.0;
  double _particleSpeed = 2.0;
  double _particleOpacity = 0.5;
  Color _particleColor = Colors.blue;
  bool _showTrails = true;
  bool _randomColors = true;
  ParticleShape _particleShape = ParticleShape.circle;
  ParticleDirection _direction = ParticleDirection.up;

// Add these presets to the CustomAnimationsPage class
  final List<ParticlePreset> presets = [
    ParticlePreset(
      name: 'Snow',
      particleCount: 100,
      particleSize: 2,
      particleSpeed: 1,
      particleOpacity: 0.7,
      particleColor: Colors.white,
      showTrails: false,
      randomColors: false,
      shape: ParticleShape.circle,
      direction: ParticleDirection.down,
    ),
    ParticlePreset(
      name: 'Fire',
      particleCount: 80,
      particleSize: 4,
      particleSpeed: 3,
      particleOpacity: 0.8,
      particleColor: Colors.orange,
      showTrails: true,
      randomColors: true,
      shape: ParticleShape.triangle,
      direction: ParticleDirection.up,
    ),
    ParticlePreset(
      name: 'Stars',
      particleCount: 50,
      particleSize: 3,
      particleSpeed: 1,
      particleOpacity: 1.0,
      particleColor: Colors.yellow,
      showTrails: true,
      randomColors: false,
      shape: ParticleShape.star,
      direction: ParticleDirection.random,
    ),
    ParticlePreset(
      name: 'Matrix',
      particleCount: 150,
      particleSize: 2,
      particleSpeed: 4,
      particleOpacity: 0.8,
      particleColor: Colors.green,
      showTrails: true,
      randomColors: false,
      shape: ParticleShape.square,
      direction: ParticleDirection.down,
    ),
  ];

// Add this method to the CustomAnimationsPage class
  void _applyPreset(ParticlePreset preset) {
    setState(() {
      _particleCount = preset.particleCount;
      _particleSize = preset.particleSize;
      _particleSpeed = preset.particleSpeed;
      _particleOpacity = preset.particleOpacity;
      _particleColor = preset.particleColor;
      _showTrails = preset.showTrails;
      _randomColors = preset.randomColors;
      _particleShape = preset.shape;
      _direction = preset.direction;
      _resetParticles();
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _resetParticles();
  }

  void _resetParticles() {
    _particles.clear();
    for (int i = 0; i < _particleCount; i++) {
      _particles.add(Particle(
        size: _particleSize,
        speed: _particleSpeed,
        baseOpacity: _particleOpacity,
        color: _randomColors ? null : _particleColor,
        shape: _particleShape,
        direction: _direction,
      ));
    }
  }

  void _optimizeParticles() {
    final devicePixelRatio = View.of(context).devicePixelRatio;
    final screenSize = MediaQuery.of(context).size;
    final screenArea = screenSize.width * screenSize.height;

    // Adjust particle count based on screen size and device capabilities
    int optimizedCount =
        (_particleCount * (screenArea / (1080 * 1920))).round();
    optimizedCount = math.min(optimizedCount, 200); // Cap at 200 particles

    // Adjust particle size based on device pixel ratio
    double optimizedSize = _particleSize * (1 / devicePixelRatio);

    setState(() {
      _particleCount = optimizedCount;
      _particleSize = optimizedSize;
      _resetParticles();
    });
  }

// Add export/import capabilities
  Map<String, dynamic> _exportSettings() {
    return {
      'particleCount': _particleCount,
      'particleSize': _particleSize,
      'particleSpeed': _particleSpeed,
      'particleOpacity': _particleOpacity,
      'particleColor': _particleColor,
      'showTrails': _showTrails,
      'randomColors': _randomColors,
      'particleShape': _particleShape.index,
      'direction': _direction.index,
    };
  }

  void _importSettings(Map<String, dynamic> settings) {
    setState(() {
      _particleCount = settings['particleCount'] as int;
      _particleSize = settings['particleSize'] as double;
      _particleSpeed = settings['particleSpeed'] as double;
      _particleOpacity = settings['particleOpacity'] as double;
      _particleColor = Color(settings['particleColor'] as int);
      _showTrails = settings['showTrails'] as bool;
      _randomColors = settings['randomColors'] as bool;
      _particleShape = ParticleShape.values[settings['particleShape'] as int];
      _direction = ParticleDirection.values[settings['direction'] as int];
      _resetParticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Animations')),
      body: Stack(
        children: [
          // Particle animation
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: ParticlePainter(
                  particles: _particles,
                  animation: _controller.value,
                  showTrails: _showTrails,
                ),
                child: Container(),
              );
            },
          ),
          // Controls
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.15,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Particle Settings',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            // Particle Count
                            Text('Particle Count: $_particleCount'),
                            Slider(
                              value: _particleCount.toDouble(),
                              min: 10,
                              max: 200,
                              divisions: 19,
                              onChanged: (value) {
                                setState(() {
                                  _particleCount = value.toInt();
                                  _resetParticles();
                                });
                              },
                            ),
                            // Particle Size
                            Text(
                                'Particle Size: ${_particleSize.toStringAsFixed(1)}'),
                            Slider(
                              value: _particleSize,
                              min: 1,
                              max: 10,
                              divisions: 18,
                              onChanged: (value) {
                                setState(() {
                                  _particleSize = value;
                                  _resetParticles();
                                });
                              },
                            ),
                            // Particle Speed
                            Text(
                                'Particle Speed: ${_particleSpeed.toStringAsFixed(1)}'),
                            Slider(
                              value: _particleSpeed,
                              min: 0.5,
                              max: 5,
                              divisions: 9,
                              onChanged: (value) {
                                setState(() {
                                  _particleSpeed = value;
                                  _resetParticles();
                                });
                              },
                            ),
                            // Particle Opacity
                            Text(
                                'Particle Opacity: ${(_particleOpacity * 100).toInt()}%'),
                            Slider(
                              value: _particleOpacity,
                              min: 0.1,
                              max: 1.0,
                              divisions: 9,
                              onChanged: (value) {
                                setState(() {
                                  _particleOpacity = value;
                                  _resetParticles();
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            // Color Picker
                            Row(
                              children: [
                                const Text('Particle Color: '),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    _showColorPicker(context);
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: _particleColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Switches
                            SwitchListTile(
                              title: const Text('Show Trails'),
                              value: _showTrails,
                              onChanged: (value) {
                                setState(() {
                                  _showTrails = value;
                                });
                              },
                            ),
                            SwitchListTile(
                              title: const Text('Random Colors'),
                              value: _randomColors,
                              onChanged: (value) {
                                setState(() {
                                  _randomColors = value;
                                  _resetParticles();
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            // Shape Selection
                            Text('Particle Shape:',
                                style: Theme.of(context).textTheme.titleMedium),
                            Wrap(
                              spacing: 8,
                              children: ParticleShape.values.map((shape) {
                                return ChoiceChip(
                                  label: Text(shape.name),
                                  selected: _particleShape == shape,
                                  onSelected: (selected) {
                                    if (selected) {
                                      setState(() {
                                        _particleShape = shape;
                                        _resetParticles();
                                      });
                                    }
                                  },
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 16),
                            // Direction Selection
                            Text('Direction:',
                                style: Theme.of(context).textTheme.titleMedium),
                            Wrap(
                              spacing: 8,
                              children:
                                  ParticleDirection.values.map((direction) {
                                return ChoiceChip(
                                  label: Text(direction.name),
                                  selected: _direction == direction,
                                  onSelected: (selected) {
                                    if (selected) {
                                      setState(() {
                                        _direction = direction;
                                        _resetParticles();
                                      });
                                    }
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: presets.map((preset) {
                            bool isSelected = _particleCount ==
                                    preset.particleCount &&
                                _particleSize == preset.particleSize &&
                                _particleSpeed == preset.particleSpeed &&
                                _particleOpacity == preset.particleOpacity &&
                                _particleColor == preset.particleColor &&
                                _showTrails == preset.showTrails &&
                                _randomColors == preset.randomColors &&
                                _particleShape == preset.shape &&
                                _direction == preset.direction;

                            return PresetButton(
                              preset: preset,
                              onPressed: () => _applyPreset(preset),
                              isSelected: isSelected,
                            );
                          }).toList(),
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _optimizeParticles,
                            icon: const Icon(Icons.auto_fix_high),
                            label: const Text('Optimize'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Show dialog to copy settings JSON
                              final settingsJson =
                                  jsonEncode(_exportSettings());
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Export Settings'),
                                  content: SelectableText(settingsJson),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(Icons.save),
                            label: const Text('Export'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Show dialog to paste settings JSON
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Import Settings'),
                                  content: TextField(
                                    maxLines: 4,
                                    decoration: const InputDecoration(
                                      hintText: 'Paste settings JSON here',
                                    ),
                                    onSubmitted: (value) {
                                      try {
                                        final settings = jsonDecode(value)
                                            as Map<String, dynamic>;
                                        _importSettings(settings);
                                        Navigator.pop(context);
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('Invalid settings format'),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Get text from TextField and import
                                        // Implementation depends on how you handle the TextField
                                      },
                                      child: const Text('Import'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(Icons.upload),
                            label: const Text('Import'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showColorPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: Colors.primaries.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _particleColor = Colors.primaries[index];
                    _resetParticles();
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.primaries[index],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

enum ParticleShape { circle, square, triangle, star }

enum ParticleDirection { up, down, left, right, random }

class Particle {
  late double x;
  late double y;
  late Color? color;
  late double speed;
  late double size;
  late double opacity;
  late ParticleShape shape;
  late ParticleDirection direction;
  late num angle;

  Particle({
    required this.size,
    required this.speed,
    required double baseOpacity,
    required this.color,
    required this.shape,
    required this.direction,
  }) {
    reset();
    opacity = baseOpacity;
  }

  void reset() {
    final random = math.Random();
    x = random.nextDouble() * 400;
    y = random.nextDouble() * 800;
    color = color ?? Colors.primaries[random.nextInt(Colors.primaries.length)];
    angle = random.nextDouble() * 2 * math.pi;

    if (direction == ParticleDirection.random) {
      angle = random.nextDouble() * 2 * math.pi;
    } else {
      angle = {
            ParticleDirection.up: -math.pi / 2,
            ParticleDirection.down: math.pi / 2,
            ParticleDirection.left: math.pi,
            ParticleDirection.right: 0,
          }[direction] ??
          0;
    }
  }

  void update(Size size) {
    x += speed * math.cos(angle);
    y += speed * math.sin(angle);

    if (x < 0 || x > size.width || y < 0 || y > size.height) {
      reset();
      switch (direction) {
        case ParticleDirection.up:
          y = size.height;
          break;
        case ParticleDirection.down:
          y = 0;
          break;
        case ParticleDirection.left:
          x = size.width;
          break;
        case ParticleDirection.right:
          x = 0;
          break;
        case ParticleDirection.random:
          // Random reset position handled in reset()
          break;
      }
    }
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double animation;
  final bool showTrails;

  const ParticlePainter({
    required this.particles,
    required this.animation,
    this.showTrails = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      particle.update(size);

      final paint = Paint()
        ..color = (particle.color ?? Colors.transparent)
            .withValues(alpha: particle.opacity)
        ..style = PaintingStyle.fill;

      // Draw particle based on shape
      switch (particle.shape) {
        case ParticleShape.circle:
          canvas.drawCircle(
            Offset(particle.x, particle.y),
            particle.size * (1 + animation),
            paint,
          );
          break;
        case ParticleShape.square:
          canvas.drawRect(
            Rect.fromCircle(
              center: Offset(particle.x, particle.y),
              radius: particle.size * (1 + animation),
            ),
            paint,
          );
          break;
        case ParticleShape.triangle:
          _drawTriangle(canvas, Offset(particle.x, particle.y),
              particle.size * (1 + animation), paint);
          break;
        case ParticleShape.star:
          _drawStar(canvas, Offset(particle.x, particle.y),
              particle.size * (1 + animation), paint);
          break;
      }

      // Draw trail if enabled
      if (showTrails) {
        canvas.drawCircle(
          Offset(
            particle.x - particle.speed * math.cos(particle.angle) * 2,
            particle.y - particle.speed * math.sin(particle.angle) * 2,
          ),
          particle.size * 0.8 * (1 + animation),
          paint..color = paint.color.withValues(alpha: paint.color.a * 0.5),
        );
      }
    }
  }

  void _drawTriangle(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    path.moveTo(center.dx, center.dy - size);
    path.lineTo(center.dx - size, center.dy + size);
    path.lineTo(center.dx + size, center.dy + size);
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawStar(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    final double radius = size;
    final double innerRadius = radius * 0.4;

    for (int i = 0; i < 5; i++) {
      double angle = -math.pi / 2 + i * 4 * math.pi / 5;
      if (i == 0) {
        path.moveTo(
          center.dx + radius * math.cos(angle),
          center.dy + radius * math.sin(angle),
        );
      } else {
        path.lineTo(
          center.dx + radius * math.cos(angle),
          center.dy + radius * math.sin(angle),
        );
      }

      angle += 2 * math.pi / 5;
      path.lineTo(
        center.dx + innerRadius * math.cos(angle),
        center.dy + innerRadius * math.sin(angle),
      );
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}

// Add a PresetManager to save and load particle configurations
class ParticlePreset {
  final String name;
  final int particleCount;
  final double particleSize;
  final double particleSpeed;
  final double particleOpacity;
  final Color particleColor;
  final bool showTrails;
  final bool randomColors;
  final ParticleShape shape;
  final ParticleDirection direction;

  ParticlePreset({
    required this.name,
    required this.particleCount,
    required this.particleSize,
    required this.particleSpeed,
    required this.particleOpacity,
    required this.particleColor,
    required this.showTrails,
    required this.randomColors,
    required this.shape,
    required this.direction,
  });
}

class PresetButton extends StatelessWidget {
  final ParticlePreset preset;
  final VoidCallback onPressed;
  final bool isSelected;

  const PresetButton({
    super.key,
    required this.preset,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Theme.of(context).primaryColor : null,
          foregroundColor: isSelected ? Colors.white : null,
        ),
        child: Text(preset.name),
      ),
    );
  }
}
