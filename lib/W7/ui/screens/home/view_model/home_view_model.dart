import 'package:flutter/material.dart';
import 'package:submission/W7/data/repositories/songs/song_repository.dart';
import 'package:submission/W7/model/songs/song.dart';
import 'package:submission/W7/ui/states/player_state.dart';

class HomeViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;

  final List<String> recentIds = [];

  List<Song> recentSongs = [];

  HomeViewModel(this.songRepository, this.playerState);

  void onPlayerChange() {
    final song = playerState.currentSong;
    if (song != null) {
      recentIds.remove(song.id);
      recentIds.insert(0, song.id);
    }
    
    recentSongs = recentIds
        .map((id) => songRepository.fetchSongById(id))
        .whereType<Song>()
        .toList();
    notifyListeners();
  }

  bool isPlaying(Song song) {
    return playerState.currentSong == song;
  }

  void play(Song song) {
    // recentIds.remove(song.id);
    // recentIds.insert(0, song.id);
    onPlayerChange();
    notifyListeners();
    playerState.start(song);
  }

  void stop() {
    playerState.stop();
    notifyListeners();
  }
}
