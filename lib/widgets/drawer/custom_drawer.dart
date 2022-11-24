import 'package:fabrikod_quran/constants/constants.dart';
import 'package:fabrikod_quran/providers/quran_provider.dart';
import 'package:fabrikod_quran/providers/surah_details_provider.dart';
import 'package:fabrikod_quran/widgets/buttons/custom_button.dart';
import 'package:fabrikod_quran/widgets/buttons/custom_toggle_buttons.dart';
import 'package:fabrikod_quran/widgets/cards/juz_card.dart';
import 'package:fabrikod_quran/widgets/drawer/surah_section_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Utils.unFocus(context),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: kPaddingVertical,
            horizontal: kPaddingHorizontal,
          ),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: context.theme.dividerColor),
            ),
          ),
          child: Column(
            children: [
              buildToggleButton,
              const SizedBox(height: kPaddingHorizontal),
              Expanded(child: body)
            ],
          ),
        ),
      ),
    );
  }

  Widget get buildToggleButton {
    return CustomToggleButtons(
      buttonTitles: [
        context.translate.surah,
        context.translate.juz,
        context.translate.sajda,
      ],
      selectedIndex:
          context.watch<SurahDetailsProvider>().readingSettings.surahDetailScreenMod.index,
      onTap: (index) {
        context.read<SurahDetailsProvider>().changeSurahDetailScreenMod(index);
        Utils.unFocus(context);
      },
    );
  }

  Widget get body {
    return IndexedStack(
      index: context.watch<SurahDetailsProvider>().readingSettings.surahDetailScreenMod.index,
      children: [
        buildSurah,
        buildJuz,
        buildSajda,
      ],
    );
  }

  Widget get buildSurah {
    return SurahSectionDrawer(
      surahs: context.watch<QuranProvider>().surahs,
      versesOfSelectedSurah: context.watch<SurahDetailsProvider>().versesOfSelectedSurah,
    );
  }

  Widget get buildJuz {
    return GridView.builder(
      itemCount: 30,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: kPaddingDefault * 2,
        crossAxisSpacing: kPaddingDefault * 2,
      ),
      itemBuilder: (context, index) => JuzCard(
        index: index,
        onTap: context.read<SurahDetailsProvider>().selectJuz,
      ),
    );
  }

  Widget get buildSajda {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ListView.builder(
            itemCount: context.watch<QuranProvider>().sajdaSurahs.length,
            itemBuilder: (context, index) {
              var surah = context.watch<QuranProvider>().sajdaSurahs[index];
              return CustomButton(
                title: "${surah.id}  ${surah.nameComplex}",
                state:
                    context.watch<SurahDetailsProvider>().readingSettings.sajdaIndex == index,
                centerTitle: false,
                height: 45,
                onTap: () => context.read<SurahDetailsProvider>().changeSajdaIndex(index),
              );
            },
          ),
        ),
        VerticalDivider(
          color: context.theme.dividerColor,
          width: kPaddingHorizontal * 2,
          thickness: 2,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return CustomButton(
                title: "${index + 1}",
                state: true,
                centerTitle: false,
                height: 45,
              );
            },
          ),
        ),
      ],
    );
  }
}
