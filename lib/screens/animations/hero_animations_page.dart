import 'package:flutter/material.dart';

class HeroAnimationsPage extends StatelessWidget {
  const HeroAnimationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.teal,
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Hero Animations')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        padding: const EdgeInsets.all(8.0),
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return Hero(
            tag: 'hero_$index',
            child: Material(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HeroDetailPage(
                        color: colors[index],
                        index: index,
                      ),
                    ),
                  );
                },
                    child: Card(
                  color: colors[index],
                  child: const Center(
                    child: Icon(
                      Icons.touch_app,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HeroDetailPage extends StatelessWidget {
  final Color color;
  final int index;

  const HeroDetailPage({
    super.key,
    required this.color,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          color: Colors.black54,
          child: Center(
            child: Hero(
              tag: 'hero_$index',
              child: Card(
                color: color,
                child: const SizedBox(
                  width: 300,
                  height: 300,
                  child: Center(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 60,
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
}
