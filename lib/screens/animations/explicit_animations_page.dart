import 'package:flutter/material.dart';

class ExplicitAnimationsPage extends StatefulWidget {
  const ExplicitAnimationsPage({super.key});

  @override
  State<ExplicitAnimationsPage> createState() => _ExplicitAnimationsPageState();
}

class _ExplicitAnimationsPageState extends State<ExplicitAnimationsPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationStatus _status = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..addStatusListener((status) {
        setState(() {
          _status = status;
        });
      });

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explicit Animations')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: RotationTransition(
                turns: _animation,
                child: ScaleTransition(
                  scale: _animation,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.animation,
                      color: Colors.white,
                      size: 100,
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
                    'Animation Status: ${_status.toString().split('.').last}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _controller.forward();
                        },
                        child: const Text('Forward'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _controller.reverse();
                        },
                        child: const Text('Reverse'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _controller.repeat();
                        },
                        child: const Text('Repeat'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _controller.stop();
                        },
                        child: const Text('Stop'),
                      ),
                    ],
                  ),
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
