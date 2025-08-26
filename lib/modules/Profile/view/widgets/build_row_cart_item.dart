import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flutter/material.dart';

class BuildRowCartItem extends StatelessWidget {
  const BuildRowCartItem({super.key, required this.title, required this.iconContainer, required this.iconCircle, required this.onTap});
  final String title ;
  final IconData iconContainer ;
  final IconData iconCircle ;
  final Function() onTap ;
  @override
  Widget build(BuildContext context) {
      return Row(
        children: [
          CircleAvatar(
            minRadius: 16,
            child: Icon(iconCircle),
          ),
          SizedBox(
            width: 10,
          ),
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          Spacer(),
          Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.primary,
              ),
              child: InkWell(
                  onTap: onTap,
                  child: Icon(iconContainer, size: 15, color: AppColors.background))),
        ],
      );
    }
  }

