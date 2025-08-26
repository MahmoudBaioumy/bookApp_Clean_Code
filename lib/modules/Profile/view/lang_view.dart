import 'package:easy_localization/easy_localization.dart';
import 'package:flustra_template/core/constants/app_constant.dart';
import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/widgets/image_asset_widget.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/localization/localization_supported_data.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flutter/material.dart';


class LanguageSelectionScreen extends StatefulWidget {
  static void navigateToMe() => navigateTo(AppRoutes.languageSelectionScreen);

  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  late LanguageOption _selectedLanguage = AppLocalizationController.currentLanguage ?? AppConstant.defaultLanguage; // Default to English

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  BackButton(
          color: AppColors.primary,
        ),
        title: Text(AppStrings.chooseLanguage.tx(),style: TextStyle(
          color: AppColors.primary
        ),),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: AppConstant.supportedLanguagesModels.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final lang = AppConstant.supportedLanguagesModels[index];
          final isSelected = lang == _selectedLanguage;
          return InkWell(
            onTap: () => onTapChangeLang(lang),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppColors.secondaryPrimary : Colors.grey,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  ImageAssetWidget(
                    assetPath: lang.flagAsset,
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(lang.nameWithTr(), style: AppTextStyle.titleMedium),
                        Text(lang.nameRaw, style: AppTextStyle.bodyMedium.copyWith(color: Colors.grey,)),
                      ],
                    ),
                  ),
                  Radio<LanguageOption>(
                    value: lang,
                    groupValue: _selectedLanguage,
                    onChanged: onTapChangeLang,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void onTapChangeLang(LanguageOption? lang) {
    if (lang == null) return;
    setState(() {});
    context.setLocale(lang.locale);
    _selectedLanguage = lang;
  }
}
