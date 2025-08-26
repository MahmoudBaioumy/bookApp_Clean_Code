import 'package:flutter/material.dart';

InkWell buildLanguageWidget({required double width, required double height,
  required void Function()? onTap, required String title, required Color colorContainer, required Color colorText}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      elevation: 2.5,
      shadowColor: colorContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: colorContainer,
      child: SizedBox(
        //   width: fullWidth(context: context).width,
        height: 70,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              title,
              style: TextStyle(fontSize: 18, color: colorText),
            ),
          ),
        ),
      ),
    ),
  );
}