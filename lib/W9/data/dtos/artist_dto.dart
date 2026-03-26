import 'package:submission/W9/model/artists/artist.dart';

class ArtistDto {
  static const nameKey = 'name';
  static const imageUrlKey = 'imageUrl';
  static const genreKey = 'genre';

  static Artist fromJson(String id, Map<String, dynamic> json) {
    assert(json[nameKey] is String);
    assert(json[imageUrlKey] is String);
    assert(json[genreKey] is String);

    return Artist(
      genre: json[genreKey],
      imageUrl: Uri.parse(json[imageUrlKey]),
      name: json[nameKey],
      id: id,
    );
  }

  Map<String, dynamic> toJson(Artist artist) {
    return {
      nameKey: artist.name,
      imageUrlKey: artist.imageUrl.toString(),
      genreKey: artist.genre
    };
  }
}
