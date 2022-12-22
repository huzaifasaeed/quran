import 'package:fabrikod_quran/constants/constants.dart';
import 'package:fabrikod_quran/providers/quran_provider.dart';
import 'package:fabrikod_quran/widgets/custom_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TranslationsCard extends StatelessWidget {
  final Function() onBack;

  const TranslationsCard({Key? key, required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: context.watch<QuranProvider>().translationService.allTranslation.length,
      itemBuilder: (context, index) {
        var allTranslation = context.read<QuranProvider>().translationService.allTranslation;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: onBack,
            ),
            Text(allTranslation[index].name ?? "", style: context.theme.appBarTheme.titleTextStyle),
            CustomSpace.normal(),
            ...allTranslation[index].translations.map(
                  (e) => ListTile(
                    onTap: () => context.read<QuranProvider>().selectedTranslation(e.resourceId),
                    visualDensity: const VisualDensity(vertical: -2),
                    contentPadding: const EdgeInsets.symmetric(horizontal: kPaddingM * 2),
                    dense: true,
                    title: Row(
                      children: [
                        SvgPicture.asset(
                          e.isShow
                              ? ImageConstants.checkboxActiveIcon
                              : ImageConstants.checkboxInactiveIcon,
                          height: 25,
                          width: 25,
                          color: context.theme.iconTheme.color,
                        ),
                        const SizedBox(width: kPaddingL),
                        Expanded(
                          child: Text(
                            e.translationName ?? "",
                            style: context.theme.textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
          ],
        );
      },
    );
  }
}