import 'package:flutter/material.dart';
import 'package:submission/W8/ui/screens/library/view_model/async_value.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  // List<Song>? _songs;
  AsyncValue<List<Song>> songs = AsyncValue.loading();

  LibraryViewModel({required this.songRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);

    // init
    _init(); 
  }

  // List<Song> get songs => _songs == null ? [] : _songs!;

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    // 1 - Fetch songs
    // _songs = await songRepository.fetchSongs();
    songs = AsyncValue.loading();
    notifyListeners();

    try {
      final fetchedSongs = await songRepository.fetchSongs();

      songs = AsyncValue.data(fetchedSongs);
    } catch (e) {
      songs = AsyncValue.eror(e);
    }

    // 2 - notify listeners
    notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
