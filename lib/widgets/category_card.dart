import 'package:flutter/material.dart';
import 'package:flutter_animation_showcase/lib/neopop.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Widget page;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return NeoPopTiltedButton(
      isFloating: true,
      onTapUp: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
      decoration: const NeoPopTiltedButtonDecoration(
        color: Color.fromRGBO(255, 235, 52, 1),
        plunkColor: Color.fromRGBO(255, 230, 3, 1),
        shadowColor: Color.fromRGBO(255, 255, 0, 0.451),
        showShimmer: true,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Theme.of(context).iconTheme.color, size: 48),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
