import 'package:flutter/material.dart';
import '../widgets/category_card.dart';
import 'animations/basic_animations_page.dart';
import 'animations/container_animations_page.dart';
import 'animations/hero_animations_page.dart';
import 'animations/list_animations_page.dart';
import 'animations/custom_animations_page.dart';
import 'animations/physics_animations_page.dart';
import 'animations/staggered_animations_page.dart';
import 'animations/gesture_animations_page.dart';
import 'animations/tween_animations_page.dart';
import 'animations/explicit_animations_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Showcase'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CategoryCard(
            title: 'Basic',
            icon: Icons.animation,
            color: Colors.blue.shade100,
            page: const BasicAnimationsPage(),
          ),
          CategoryCard(
            title: 'Container',
            icon: Icons.square_outlined,
            color: Colors.green.shade100,
            page: const ContainerAnimationsPage(),
          ),
          CategoryCard(
            title: 'Hero',
            icon: Icons.fort,
            color: Colors.purple.shade100,
            page: const HeroAnimationsPage(),
          ),
          CategoryCard(
            title: 'List',
            icon: Icons.list_alt,
            color: Colors.orange.shade100,
            page: const ListAnimationsPage(),
          ),
          CategoryCard(
            title: 'Custom',
            icon: Icons.palette,
            color: Colors.red.shade100,
            page: const CustomAnimationsPage(),
          ),
          CategoryCard(
            title: 'Physics',
            icon: Icons.sports_basketball,
            color: Colors.teal.shade100,
            page: const PhysicsAnimationsPage(),
          ),
          CategoryCard(
            title: 'Staggered',
            icon: Icons.auto_awesome,
            color: Colors.pink.shade100,
            page: const StaggeredAnimationsPage(),
          ),
          CategoryCard(
            title: 'Gestures',
            icon: Icons.touch_app,
            color: Colors.amber.shade100,
            page: const GestureAnimationsPage(),
          ),
          CategoryCard(
            title: 'Tween',
            icon: Icons.animation,
            color: Colors.indigo.shade100,
            page: const TweenAnimationsPage(),
          ),
          CategoryCard(
            title: 'Explicit',
            icon: Icons.code,
            color: Colors.deepPurple.shade100,
            page: const ExplicitAnimationsPage(),
          ),
        ]
            .map(
              (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10), child: e),
            )
            .toList(),
      ),
    );
  }
}
