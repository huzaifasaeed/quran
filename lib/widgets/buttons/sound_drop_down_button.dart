import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:the_open_quran/constants/constants.dart';
import 'package:the_open_quran/database/local_db.dart';
import 'package:the_open_quran/providers/player_provider.dart';

import '../../constants/audio_urls.dart';
import '../title.dart';

class SoundDropDown extends StatefulWidget {
  const SoundDropDown({Key? key}) : super(key: key);

  @override
  State<SoundDropDown> createState() => _SoundDropDownState();
}

class _SoundDropDownState extends State<SoundDropDown> {
  late String selectedSound; 
  


  @override
  void initState() {
    super.initState();
    // Load saved reciter name, fallback to the first reciter if none is saved
    selectedSound =
        LocalDb.getReciter ?? AudioUrls().reciterBaseUrls.keys.first;
  }

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        selectedSound = selectedValue;
      });

      // 🔄 Update PlayerProvider immediately
      final playerProvider =
          Provider.of<PlayerProvider>(context, listen: false);
      playerProvider.setReciter(selectedValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTitle(titleText: context.translate.sound),
        Container(
          width: double.infinity,
          height: Utils.isSmallPhone(context) ? 45 : 50,
          margin: EdgeInsets.only(
            top: Utils.isSmallPhone(context) ? 10 : kSizeM,
            bottom: Utils.isSmallPhone(context) ? 10 : kSizeL,
          ),
          decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Center(
            child: DropdownButtonFormField(
              dropdownColor: AppColors.black,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(right: kSizeL, left: kSizeM),
              ),
              value: selectedSound,
              items: AudioUrls().reciterBaseUrls.keys
                  .map<DropdownMenuItem<String>>((String mascot) {
                return DropdownMenuItem<String>(
                    value: mascot, child: Text(mascot));
              }).toList(),
              onChanged: dropdownCallback,
              style: context.theme.textTheme.bodyMedium,
              isExpanded: true,
              icon: SvgPicture.asset(ImageConstants.dropDownIcon),
            ),
          ),
        ),
      ],
    );
  }
}
