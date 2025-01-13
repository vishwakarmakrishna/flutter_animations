
import 'package:flutter/material.dart';

class ContainerAnimationsPage extends StatefulWidget {
  const ContainerAnimationsPage({super.key});

  @override
  State<ContainerAnimationsPage> createState() => _ContainerAnimationsPageState();
}

class _ContainerAnimationsPageState extends State<ContainerAnimationsPage> {
  bool _expanded = false;
  double _width = 200;
  double _height = 200;
  Color _color = Colors.blue;
  double _borderRadius = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Container Animations')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: _width,
                height: _height,
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular(_borderRadius),
                ),
                curve: Curves.easeInOut,
                child: Center(
                  child: Text(
                    'Tap buttons below',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _expanded ? 24 : 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                        _width = _expanded ? 300 : 200;
                        _height = _expanded ? 300 : 200;
                      });
                    },
                    child: const Text('Toggle Size'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _color = _color == Colors.blue
                            ? Colors.red
                            : Colors.blue;
                      });
                    },
                    child: const Text('Toggle Color'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _borderRadius = _borderRadius == 8 ? 150 : 8;
                      });
                    },
                    child: const Text('Toggle Shape'),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Current Values',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text('Width: $_width'),
                      Text('Height: $_height'),
                      Text('Border Radius: $_borderRadius'),
                      Text('Color: ${_color == Colors.blue ? "Blue" : "Red"}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
