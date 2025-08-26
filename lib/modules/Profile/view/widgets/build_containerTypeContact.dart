import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flutter/material.dart';

class BuildContainerTypeContact extends StatelessWidget {
  const BuildContainerTypeContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 0.15),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Text(
              AppStrings.contactImpl.tx(),
              textAlign: TextAlign.center,
              style: TextTheme.of(context).bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(
              height: 10,
            ),
            buildRowContactType(
              icon: Icons.phone,
              title: '+201115283052',
            ),
            SizedBox(
              height: 10,
            ),
            buildRowContactType(
              title: 'mbaioumy84@gmail,com',
              icon: Icons.email_outlined,
            ),
          ],
        ),
      );
    }
  }
// -------------------------- buildRowContactType -------------------------- //
Row buildRowContactType({required String title, required IconData icon}) {
  return Row(
    children: [
      Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(width: 0.5, color: AppColors.primary),
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: 18,
        ),
      ),
      SizedBox(
        width: 15,
      ),
      Text(title)
    ],
  );
}

