import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_open_quran/constants/constants.dart';
import 'package:the_open_quran/database/local_db.dart';
import 'package:the_open_quran/providers/surah_details_provider.dart';

import '../../constants/colors.dart';
import '../../constants/padding.dart';
import '../../models/surah_model.dart';

class SurahCard extends StatelessWidget {
  final SurahModel surahModel;
  final Function() onTap;

  const SurahCard({Key? key, required this.surahModel, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String localCountryCode =
        LocalDb.getLocale?.languageCode ?? Platform.localeName.split("_").first;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(kSizeM),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.black2,
          borderRadius: BorderRadius.circular(kSizeM),
        ),
        padding: const EdgeInsets.symmetric(horizontal: kSizeXXL),
        child: Row(
          children: [
            buildSurahNumber(context),
            const SizedBox(width: kSizeXXL),
            Expanded(child: buildSurahNames(context)),
            const SizedBox(width: kSizeXXL),
            localCountryCode=='en'|| localCountryCode == 'tr'
                ?
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildSurahNamesInArabic(context),
                // SizedBox(height: 0),
                buildVersesCount(context),
              ],
            ): buildVersesCount(context),
          ],
        ),
      ),
    );
  }

  // Widget buildSurahNumber(BuildContext context) {
  //   return Text(
  //     surahModel.id.toString(),
  //     style: context.theme.textTheme.displaySmall?.copyWith(
  //       letterSpacing: 0.04,
  //       color: AppColors.grey,
  //     ),
  //   );
  // }
  /// The number of ayat if arabic and latin format
  buildSurahNumber(BuildContext context) {
      return Padding(
        padding:EdgeInsets.all(0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              surahModel.id.toString(),
              textAlign: TextAlign.start,
              style: context.theme.textTheme.displayLarge?.copyWith(
                color: AppColors.grey,
                fontSize: 15,
                fontFamily: Fonts.uthmanicIcon,
              ),
            ),
            SvgPicture.asset(
              ImageConstants.versNumberFrame,
              height: 32,
               color: AppColors.grey,
            ),
          ],
        ),
      );
    }
  

  Widget buildSurahNames(BuildContext context) {
    String localCountryCode = LocalDb.getLocale?.languageCode ?? Platform.localeName.split("_").first;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localCountryCode == "tr"
              ? surahModel.nameTurkish.toString():
              localCountryCode == "ur" || localCountryCode == "ar"
              ? "surah${surahModel.id.toString().padLeft(3, '0')}"
              : surahModel.nameSimple.toString(),
          style: context.theme.textTheme.headlineSmall?.copyWith(
            fontFamily: localCountryCode == "ur" || localCountryCode == "ar" ? "SurahName" : null,
            fontSize: localCountryCode == "ur" || localCountryCode == "ar"? 34 : null,
            letterSpacing: 0.04,
            color: AppColors.grey,
          ),
        ),
        localCountryCode == "tr" || localCountryCode == "en"
            ? const SizedBox(height: kSizeS): const SizedBox(),
        localCountryCode == "tr" || localCountryCode == "en"
            ? Text(surahModel.nameTranslated.toString(),
          style: context.theme.textTheme.labelMedium?.copyWith(
            letterSpacing: 0.04,
            color: AppColors.grey,
          ),
        ):SizedBox(),
      ],
    );
  }
Widget buildSurahNamesInArabic(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "surah${surahModel.id.toString().padLeft(3, '0')}",
          style: context.theme.textTheme.headlineSmall?.copyWith(
            fontFamily: "SurahName",
            fontSize: 30,
            // letterSpacing: 0.04,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
  Widget buildVersesCount(BuildContext context) {
    return Text(
      "${surahModel.verses.length} ${context.translate.ayat}",
      style: context.theme.textTheme.labelMedium?.copyWith(
        letterSpacing: 0.04,
        color: AppColors.grey6,
      ),
    );
  }
}
