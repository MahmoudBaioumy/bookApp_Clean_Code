import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flutter/material.dart';

class BuildContainerHeaderMainProfileView extends StatefulWidget {
  const BuildContainerHeaderMainProfileView({super.key, this.onTap, });
   final void Function()? onTap;
  @override
  State<BuildContainerHeaderMainProfileView> createState() => _BuildContainerHeaderMainProfileViewState();
}

class _BuildContainerHeaderMainProfileViewState extends State<BuildContainerHeaderMainProfileView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(AppSessionManager.user?.image ?? ''),
                  minRadius: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppSessionManager.user?.email ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primary),
                    ),
                    Text(
                      AppSessionManager.user?.name ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primary),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
