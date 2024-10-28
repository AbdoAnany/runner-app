

import 'package:flutter/material.dart';
enum BadgeLevelTypeFrame {Basic,Advance,Pro,Premium}

class BadgeLevelType extends StatelessWidget {
  const BadgeLevelType({super.key});

  final BadgeLevelTypeFrame levelType = BadgeLevelTypeFrame.Basic;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Color(0xFFE9F0F7),
      ),
      child:  Column(
        children: [
          Text(
            levelType.name,
            style: const TextStyle(
              color: Color(0xFF0067B8),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      )
    );
  }
}



class BadgeLevelFrame extends StatelessWidget {
  const BadgeLevelFrame({
    super.key,
    required this.image,
    this.levelType = BadgeLevelTypeFrame.Basic,
  });

  final BadgeLevelTypeFrame levelType;
  final String image;

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to determine responsive sizes
    double screenWidth = MediaQuery.of(context).size.width;
    double baseRadius = screenWidth * 0.07; // Adjust size based on screen width

    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: baseRadius, // Responsive radius for avatar
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: baseRadius * 1.4, // Slightly larger radius for badge frame
          child: Image.asset(
            'assets/badge/${levelType.name}.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
