import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key, required this.title, required this.image});

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, width: 150, height: 200),
        Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.buttonDisabled)),
      ],
    );
  }
}
