import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  static final Uri baseUri = Uri.https(
    'fir-c216e-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  final Uri songsUri = baseUri.replace(path: 'songs.json');

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> result = [];
      for (final entry in songJson.entries) {
        result.add(SongDto.fromJson(entry.key, entry.value));
      }
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}

  @override
  Future<void> likeSong(String id) async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> songJson = json.decode(response.body);
      for (final song in songJson.entries) {
        if (song.key == id) {
          final currentLikes = song.value['likes'];
          final Uri pathSongsUri = baseUri.replace(path: 'songs/$id.json');

          final patchRes = await http.patch(
            pathSongsUri,
            body: json.encode({
              'likes': currentLikes + 1,
            }),
          );

          if (patchRes.statusCode != 200) {
            throw Exception('Failed to like the song');
          }
          return;
        }
      }
      throw Exception('Failed to load posts');
    }
  }
}
