import 'package:flutter/material.dart';
import 'package:submission/W7/data/repositories/songs/song_repository.dart';
import 'package:submission/W7/model/songs/song.dart';
import 'package:submission/W7/ui/states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository repository;
  final PlayerState playerState;

  List<Song> songs = [];
  bool isLoading = false;

  LibraryViewModel(this.repository, this.playerState);

  Future<void> init() async {
    isLoading = true;
    notifyListeners();

    songs = repository.fetchSongs();

    isLoading = false;
    notifyListeners();
  }

  bool isPlaying(Song song) {
    return playerState.currentSong == song;
  }

  void play(Song song) {
    playerState.start(song);
    notifyListeners();
  }

  void stop() {
    playerState.stop();
    notifyListeners();
  }
}