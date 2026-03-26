import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:submission/W9/data/dtos/artist_dto.dart';
import 'package:submission/W9/data/repositories/artists/artist_repository.dart';
import 'package:submission/W9/model/artists/artist.dart';

class ArtistRepositoryFirebase extends ArtistRepository {
  static final Uri baseUri = Uri.http(
    'fir-c216e-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  static final Uri artistsUri = baseUri.replace(path: 'artists.json');

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> artistJson = json.decode(response.body);
      List<Artist> result = [];

      for (var iterable in artistJson.entries) {
        String id = iterable.key;
        Map<String, dynamic> data = iterable.value;

        result.add(ArtistDto.fromJson(id, data));
      }

      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load artists');
    }
  }
  
  @override
  Future<Artist?> fetchArtistById(String id) {
    // TODO: implement fetchArtistById
    throw UnimplementedError();
  }
}
