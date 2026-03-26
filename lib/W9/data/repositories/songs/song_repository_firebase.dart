import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  static final Uri baseUri = Uri.http(
    'fir-c216e-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  static final Uri songsUri = baseUri.replace(path: 'songs.json');
  static final Uri artistsUri = baseUri.replace(path: 'artists.json');

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response songResponse = await http.get(songsUri);
    final http.Response artistReponse = await http.get(artistsUri);

    if (songResponse.statusCode == 200 && artistReponse.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(songResponse.body);
      Map<String, dynamic> artistJson = json.decode(artistReponse.body);
      List<Song> result = [];

      for (var iterable in songJson.entries) {
        String id = iterable.key;
        Map<String, dynamic> songData = iterable.value;

        Song song = SongDto.fromJson(id, songData);

        Map<String, dynamic>? artistData = artistJson[song.artistId];
        
        if (artistData != null) {
          song = Song(
            id: song.id,
            title: song.title,
            artistId: song.artistId,
            duration: song.duration,
            imageUrl: song.imageUrl,
            artistName: artistData['name'],
            artistGenre: artistData['genre'],
          );
        }
        result.add(song);
      }

      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
