import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:the_open_quran/constants/constants.dart';
import 'package:word_selectable_text/word_selectable_text.dart';

import '../../models/bookmark_model.dart';
import '../../models/mushaf_backgrund_model.dart';
import '../../models/surah_model.dart';
import '../../models/verse_model.dart';
import '../../providers/bookmark_provider.dart';
import '../../providers/player_provider.dart';
import '../../providers/quran_provider.dart';
import '../../providers/surah_details_provider.dart';
import '../basmala_title.dart';
import '../cards/verse_menu_item.dart';

class QuranPageWidget extends StatefulWidget {
  QuranPageWidget({
    Key? key,
    required this.versesOfPage,
    this.onTap,
    this.textScaleFactor = 1.0,
    required this.fontTypeArabic,
    required this.layoutOptions,
    required this.surahDetailsPageTheme,
  }) : super(key: key);

  final List<SurahModel> versesOfPage;
  final Function()? onTap;
  final double textScaleFactor;
  final String fontTypeArabic;
  final ELayoutOptions layoutOptions;
  final SurahDetailsPageThemeModel surahDetailsPageTheme;
  String? selectedVerseKey;
  @override
  State<QuranPageWidget> createState() => _QuranPageWidgetState();
}

class _QuranPageWidgetState extends State<QuranPageWidget> {
  /// Scroll Controller for Verse List
  final ItemScrollController itemScrollController = ItemScrollController();

  /// Item position listener of Verse list
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      itemScrollController.jumpTo(
          index: context.read<SurahDetailsProvider>().jumpToVerseIndex);
      itemPositionsListener.itemPositions.addListener(scrollListener);
      listenToPlayer();
    });
  }

  /// Scroll Listener
  void scrollListener() {
    var first = itemPositionsListener.itemPositions.value.first.index;
    var last = itemPositionsListener.itemPositions.value.last.index;
    var index = first <= last ? first : last;
    context.read<SurahDetailsProvider>().listenToTranslationScreenList(index);
  }

  /// Listen To Player
  void listenToPlayer() {
    context.read<PlayerProvider>().addListener(() {
      if (!mounted) return;
      if (context.read<PlayerProvider>().playerState == EPlayerState.playing) {
        itemScrollController.jumpTo(
            index: context
                .read<PlayerProvider>()
                .verseListToPlay
                .first
                .pageNumber!);

        // setState(() {});
        // context
        //     .read<SurahDetailsProvider>()
        //     .changeSelectedVerseKey(widget.selectedVerseKey);
        // _scrollController.jumpTo(3);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        children: [
          buildSurahCard(),
          const SizedBox(height: kSize3XL),
          buildBottomBorder(context, widget.versesOfPage.last.verses.last)
        ],
      ),
    );
  }

  Widget buildSurahCard() {
    return ScrollablePositionedList.builder(
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
      itemCount: widget.versesOfPage.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final verses = widget.versesOfPage.elementAt(index).verses;
        return Column(
          children: [
            BasmalaTitle(verseKey: verses.first.verseKey ?? ""),
            buildVersesText(context, verses, widget.textScaleFactor,
                widget.layoutOptions, widget.fontTypeArabic),
          ],
        );
      },
    );
  }

  List<TextSpan> createTextSpans(BuildContext context, List<VerseModel> list) {
    List<TextSpan> arrayOfTextSpan = [];
    for (int index = 0; index < list.length; index++) {
      final verse = list[index];
      final span = TextSpan(children: [
        TextSpan(
            text: verse.text,
            style: TextStyle(
                // letterSpacing: 0.1,
                wordSpacing: 0,
                backgroundColor:
                    (context.read<SurahDetailsProvider>().selectedVerseKey ==
                                verse.verseKey! ||
                            context
                                .read<PlayerProvider>()
                                .isPlayingVerse(verse.verseKey ?? ""))
                        ? AppColors.brandy.withOpacity(0.3)
                        : Colors.transparent),
            recognizer: LongPressGestureRecognizer()
              ..onLongPress = () async {
                context
                    .read<SurahDetailsProvider>()
                    .changeSelectedVerseKey(verse.verseKey);

                await showMenu(
                  context: context,
                  color: context.theme.cardColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: AppColors.white.withOpacity(0.1),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  position: new RelativeRect.fromLTRB(
                      MediaQuery.of(context).size.width + 100 / 2,
                      MediaQuery.of(context).size.height / 2,
                      MediaQuery.of(context).size.width / 2,
                      MediaQuery.of(context).size.height / 2),
                  items: [
                    // PopupMenuItem(
                    //   onTap: () => context
                    //       .read<SurahDetailsProvider>()
                    //       .onTapVerseCardPlayOrPause(
                    //         verse.verseNumber! - 1,
                    //         false,
                    //       ),
                    //   child: VerseMenuItem(
                    //     iconPath: context
                    //             .read<PlayerProvider>()
                    //             .isPlayingVerse(verse.verseKey ?? "")
                    //         ? ImageConstants.pauseIcon
                    //         : ImageConstants.play,
                    //     buttonName: context
                    //             .read<PlayerProvider>()
                    //             .isPlayingVerse(verse.verseKey ?? "")
                    //         ? context.translate.pause
                    //         : context.translate.play,
                    //   ),
                    // ),

                     PopupMenuItem(
                      onTap: () => context
                          .read<SurahDetailsProvider>()
                          .onTapVerseCardPlayOrPause(
                            verse.verseNumber! - 1,
                            false,
                          ),
                      child: VerseMenuItem(
                        iconPath: context
                                .read<PlayerProvider>()
                                .isPlayingVerse(verse.verseKey ?? "")
                            ? ImageConstants.pauseIcon
                            : ImageConstants.play,
                        buttonName: context
                                .read<PlayerProvider>()
                                .isPlayingVerse(verse.verseKey ?? "")
                            ? context.translate.pause
                            : context.translate.play,
                      ),
                    ),
                    
                    // PopupMenuItem(
                    //   onTap: () => favoriteFunction(verseModel, isFavorite),
                    //   child: VerseMenuItem(
                    //     iconPath: isFavorite
                    //         ? ImageConstants.favoriteActiveIcon
                    //         : ImageConstants.favoriteInactiveIcon,
                    //     buttonName: context.translate.favorite,
                    //   ),
                    // ),
                    PopupMenuItem(
                      onTap: () =>
                          context.read<BookmarkProvider>().onTapBookMarkButton(
                                EBookMarkType.verse,
                                verse,
                                context.read<BookmarkProvider>().isBookmark(
                                      BookMarkModel(
                                          bookmarkType: EBookMarkType.verse,
                                          verseModel: verse),
                                    ),
                              ),
                      child: VerseMenuItem(
                        iconPath: context.read<BookmarkProvider>().isBookmark(
                                  BookMarkModel(
                                      bookmarkType: EBookMarkType.verse,
                                      verseModel: verse),
                                )
                            ? ImageConstants.bookmarkActiveIcon
                            : ImageConstants.bookmarkInactiveIcon,
                        buttonName: context.translate.bookmark,
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () => context
                          .read<SurahDetailsProvider>()
                          .shareVerse(verse, index),
                      child: VerseMenuItem(
                        iconPath: ImageConstants.shareAppIcon,
                        buttonName: context.translate.share,
                      ),
                    ),
                  ],
                );
                context
                    .read<SurahDetailsProvider>()
                    .changeSelectedVerseKey(null);
                // print("The word touched is $verse")
              }),
        TextSpan(
          children: [
            context.read<BookmarkProvider>().isBookmark(
                      BookMarkModel(
                          bookmarkType: EBookMarkType.verse, verseModel: verse),
                    )
                ? WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: SvgPicture.asset(
                      ImageConstants.bookmarkIconCard,
                      width: 10,
                      color: context
                          .watch<QuranProvider>()
                          .surahDetailsPageThemeColor
                          .textColor,
                    ),
                  )
                : TextSpan(),
            context.read<BookmarkProvider>().isBookmark(
                      BookMarkModel(
                          bookmarkType: EBookMarkType.verse, verseModel: verse),
                    )
                ? WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: SizedBox(
                      width: 5,
                    ))
                : TextSpan(),
            TextSpan(
              text: Utils.getArabicVerseNo(verse.verseNumber.toString()),
            ),
          ],
          style: context.theme.textTheme.headlineLarge?.copyWith(
              fontFamily: Fonts.uthmanicIcon,
              backgroundColor:
                  context.read<SurahDetailsProvider>().selectedVerseKey ==
                          verse.verseKey!
                      ? AppColors.brandy.withOpacity(0.3)
                      : Colors.transparent,
              fontSize: 16,
              letterSpacing: -2.5,
              height: 1.2,
              color: context
                  .watch<QuranProvider>()
                  .surahDetailsPageThemeColor
                  .textColor),
        ),
      ]);
      arrayOfTextSpan.add(span);
    }
    return arrayOfTextSpan;
  }

  Widget buildVersesText(
    BuildContext context,
    List<VerseModel> verses,
    double textScaleFactor,
    ELayoutOptions layoutOptions,
    String fontTypeArabic,
  ) {
    
    List<TextSpan> textSpans = createTextSpans(context, verses);

    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: layoutOptions == ELayoutOptions.justify
          ? TextAlign.justify
          : TextAlign.right,
      textScaleFactor: textScaleFactor,
      text: TextSpan(
        style: context.theme.textTheme.headlineLarge?.copyWith(
            height: 1.7,
            fontSize: 20,
            fontFamily: Fonts.getArabicFont(fontTypeArabic),
            color: context
                .watch<QuranProvider>()
                .surahDetailsPageThemeColor
                .textColor),
        children: textSpans
        // verses
        //     .map(
        //       (e) => TextSpan(
        //         children: [
        //           TextSpan(
        //               text: e.text! /*DartArabic.normalizeAlef(e.text!)*/,
        //               style: TextStyle(letterSpacing: -0.7)),
        //           TextSpan(
        //             text: Utils.getArabicVerseNo(e.verseNumber.toString()),
        //             style: context.theme.textTheme.headlineLarge?.copyWith(
        //               fontFamily: Fonts.uthmanicIcon,
        //               fontSize: 16,
        //               letterSpacing: -2.5,
        //               height: 1.2,
        //               color: context
        //                   .watch<QuranProvider>()
        //                   .surahDetailsPageThemeColor
        //                   .textColor,
        //             ),
        //           ),
        //         ],
        //       ),
        //     )
        //     .toList(),
      ),
    );
  }


  Widget buildBottomBorder(BuildContext context, VerseModel verse) {
    return Container(
      padding: const EdgeInsets.only(bottom: kSizeS),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
            color: widget.surahDetailsPageTheme.transparentVectorColor),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${context.translate.juz} ${verse.juzNumber} | ${context.translate.hizb} ${verse.hizbNumber} - ${context.translate.page} ${verse.pageNumber}",
            style: context.theme.textTheme.bodySmall?.copyWith(

                color: widget.surahDetailsPageTheme.transparentTextColor,
                letterSpacing: 0.15),
          ),
          Text(
            verse.pageNumber?.quranPageNumber ?? "",
            style: context.theme.textTheme.bodyMedium?.copyWith(

                color: widget.surahDetailsPageTheme.transparentVectorColor,
                letterSpacing: 0.04),
          ),
        ],
      ),
    );
  }
}
