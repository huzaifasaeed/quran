import 'package:audio_service/audio_service.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_open_quran/constants/audio_urls.dart';
import 'package:the_open_quran/database/local_db.dart';
import 'package:the_open_quran/providers/quran_provider.dart';

import '../constants/enums.dart';
import '../constants/restful.dart';
import '../handlers/audio_player_handler.dart';
import '../models/position_data.dart';
import '../models/verse_model.dart';

class PlayerProvider extends ChangeNotifier {
  /// Audio Player
  final player = AudioPlayer();

  /// Background audio handler
  late AudioHandler _audioHandler;

  /// BuildContext
  late BuildContext _context;

  /// Verses to play
  List<VerseModel> verseListToPlay = [];

  /// Index of the playing verse
  int playerIndex = 0;

  /// Player Speed title
  String playerSpeedTitle = "Normal";

  /// Reciter Title
  late String reciterTitle;

  /// EPlayerState [EPlayerState]
  EPlayerState playerState = EPlayerState.stop;

  /// Are there any processes in the background?
  bool isPlayedFromBackground = true;

  /// Is player repeat
  RepeatState repeatState = RepeatState.none;

  /// Repeat count
  int repeatCount = 1;

  PlayerProvider() {
    reciterTitle =
        LocalDb.getReciter ?? AudioUrls().reciterBaseUrls.keys.first;
    player.playerStateStream.listen(checkIfCompleted);
    player.currentIndexStream.listen((event) {
      if (verseListToPlay.isEmpty) return;
      playerIndex = event ?? 0;
      notifyListeners();
    });
  }

  // final Map<String, String> reciterFolderMap = {
  //   'Mohmoud Al Husary': 'Husary/mp3/',
  //   'Mahir il-Muaykili': 'Maher_AlMuaiqly_64kbps/mp3/',
  //   'Suud eş-Şureym': 'Shuraym/mp3/',
  //   'Abdurrahman es-Sudais': 'Sudais/mp3/',
  //   'Mahir Bin Hamad Al-Muaiqly': 'Maher_AlMuaiqly_128kbps/mp3/',
  // };


  /// Listens the Player's Position
  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        (position, bufferPosition, duration) => PositionData(
          position: position,
          bufferPosition: bufferPosition,
          duration: duration,
        ),
      );

  /// Creating Audio Handler
  createAudioHandler(BuildContext context) async {
    _context = context;
    _audioHandler = await AudioService.init(
      builder: () => MyAudioHandler(_context),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.quran.holyquran.app',
        androidNotificationChannelName: 'Al Quran',
      ),
    );
  }

  /// Checking player for the next ayat audio
  /// if there is no ayat stop player if there are ayats play
  void checkIfCompleted(PlayerState event) {
    if (event.processingState == ProcessingState.completed) {
      if (repeatState == RepeatState.verse) {
        if (repeatCount > 0) {
          repeatCount--;
          player.seek(Duration.zero);
          player.play();
        } else {
          repeatState = RepeatState.none;
          player.setLoopMode(LoopMode.off);
          stop();
        }
      }
    }
  }

  /// Change Player's Playing Speed
  Future<void> setPlaybackRate(String value) async {
    playerSpeedTitle = value;
    if (value == "Normal") value = "1.0";
    await player.setSpeed(double.tryParse(value) ?? 1.0);
    notifyListeners();
  }

  /// Change Reciter
  Future<void> setReciter(String value) async {
    reciterTitle = value;
    LocalDb.setReciter(reciterTitle);
    // if (value == "Mohmoud Al Husary") value = "Mohmoud Al Husary";
    notifyListeners();
  }

  /// Checking if previous ayat exists
  bool get isPrevious => playerIndex > 0;

  /// Play previous Ayat
  void previous() {
    if (!isPrevious) return;
    playerIndex--;
    play();
  }

  /// Checking if next ayat exists
  bool get isNext => playerIndex < verseListToPlay.length - 1;

  /// Play Next Player
  void next() {
    if (!isNext) return;
    playerIndex++;
    play();
  }

  /// Is selected verse playing?
  bool isPlayingVerse(String verseKey) {
    if (playerState == EPlayerState.stop || verseListToPlay.isEmpty)
      return false;
    return verseKey == verseListToPlay[playerIndex].verseKey;
  }

  /// Is the chosen mushaf page playing?
  bool isPlayingMushaf({int? pageNumber, int? surahId}) {
    if (!player.playing || verseListToPlay.isEmpty) return false;
    return verseListToPlay.first.surahId == surahId &&
        verseListToPlay.first.pageNumber == pageNumber;
  }

  /// OnTap to play or pause
  void onTapPlayOrPause(int index, bool isPlaying, List<VerseModel> verses) {
    repeatState = RepeatState.none;
    verseListToPlay = verses;
    playerIndex = index;
    isPlaying ? pause() : play();
  }

  /// On Tap Repeat Button
  void onTapRepeat(int index, List<VerseModel> verses) {
    if (player.playing && repeatState == RepeatState.verse) {
      repeatState = RepeatState.none;
      player.setLoopMode(LoopMode.off);
      repeatCount = 1;
      return;
    }
    verseListToPlay = [verses[index]];
    playerIndex = 0;
    repeatState = RepeatState.verse;
    repeatCount = 10; // Set initial repeat count
    play();
  }

  void playSurah(BuildContext context, int? surahId) {
    if (surahId == null) return;
    if (player.playing && repeatState == RepeatState.surah) {
      repeatState = RepeatState.none;
      player.setLoopMode(LoopMode.off);
      return;
    }
    verseListToPlay =
        context.read<QuranProvider>().surahs[surahId - 1].verses;
    playerIndex = 0;
    repeatState = RepeatState.surah;
    play();
  }

  /// Play verse
  Future<void> play() async {
    if (verseListToPlay.isEmpty) return;
    final folder = AudioUrls().reciterBaseUrls[reciterTitle];
    if (folder == null) return;

    final playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: verseListToPlay
          .map((verse) => AudioSource.uri(Uri.parse(
              AudioUrls.getVerseUrl(folder, verse.audioUrl!.split('/').last))))
          .toList(),
    );
    await player.setAudioSource(playlist,
        initialIndex: playerIndex, initialPosition: Duration.zero);
    if (repeatState == RepeatState.surah) {
      player.setLoopMode(LoopMode.all);
    } else if (repeatState == RepeatState.verse) {
      player.setLoopMode(LoopMode.one);
    } else {
      player.setLoopMode(LoopMode.off);
    }
    player.play();
    playerState = EPlayerState.playing;
    playOnBackground();
    notifyListeners();
  }


  /// Pause verse
  void pause({bool isRunBackGround = true}) {
    player.pause();
    playerState = EPlayerState.pause;
    if (isRunBackGround) pauseOnBackground();
    notifyListeners();
  }

  /// Resume verse
  void resume({bool isRunBackGround = true}) {
    player.play();
    playerState = EPlayerState.playing;
    if (isRunBackGround) playOnBackground();
    notifyListeners();
  }

  /// Stop verse
  void stop({bool isRunBackGround = true}) {
    repeatState = RepeatState.none;
    verseListToPlay = [];
    player.stop();
    player.setLoopMode(LoopMode.off);
    playerState = EPlayerState.stop;
    if (isRunBackGround) stopOnBackground();
    notifyListeners();
  }

  /// Play when app in background
  Future<void> playOnBackground() async {
    isPlayedFromBackground = false;
    await _audioHandler.play();
    isPlayedFromBackground = true;
  }

  /// Pause app in background
  Future<void> pauseOnBackground() async {
    isPlayedFromBackground = false;
    await _audioHandler.pause();
    isPlayedFromBackground = true;
  }

  /// Stop app in background
  Future<void> stopOnBackground() async {
    isPlayedFromBackground = false;
    await _audioHandler.stop();
    isPlayedFromBackground = true;
  }
}

