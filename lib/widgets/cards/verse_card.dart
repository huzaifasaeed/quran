import 'package:fabrikod_quran/constants/constants.dart';
import 'package:fabrikod_quran/models/verse_model.dart';
import 'package:fabrikod_quran/providers/bookmark_provider.dart';
import 'package:fabrikod_quran/providers/favorites_provider.dart';
import 'package:fabrikod_quran/providers/quran_provider.dart';
import 'package:fabrikod_quran/widgets/cards/action_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerseCard extends StatelessWidget {
  const VerseCard({Key? key, required this.verseModel}) : super(key: key);

  /// Verse model
  final VerseModel verseModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildVerseActionCart(context),
        buildVerse(context),
      ],
    );
  }

  /// The header of the action card
  Widget buildVerseActionCart(BuildContext context) {
    bool isFavorite = context.watch<FavoritesProvider>().isFavoriteVerse(verseModel);
    bool isBookmarked = context.watch<BookMarkProvider>().isBookmarkVerse(verseModel);
    return ActionCard(
      verseKey: verseModel.verseKey,
      isFavorite: isFavorite,
      favoriteButtonOnTap: () => isFavorite
          ? context.read<FavoritesProvider>().deleteVerseFromFavorites(verseModel)
          : context.read<FavoritesProvider>().addVerseToFavorite(verseModel),
      isBookmark: isBookmarked,
      bookmarkButtonOnTap: () => isBookmarked
          ? context.read<BookMarkProvider>().deleteBookmarkVerse(verseModel)
          : context.read<BookMarkProvider>().addBookmarkVerse(verseModel),
    );
  }

  Widget buildVerse(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        buildVerseText(context),
        const SizedBox(height: 20),
        buildVerseTranslationText(context),
        const SizedBox(height: 15),
        Divider(thickness: 1, color: context.theme.dividerColor)
      ],
    );
  }

  /// Verse Text
  Widget buildVerseText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            verseModel.text ?? "",
            textDirection: TextDirection.rtl,
            style: context.theme.textTheme.headlineLarge,
          ),
        ),
      ],
    );
  }

  /// Verse Translation Text
  Widget buildVerseTranslationText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            context
                    .watch<QuranProvider>()
                    .verseTranslation
                    ?.translations
                    ?.elementAt(verseModel.id! - 1)
                    .text ??
                "",
            style: context.theme.textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}