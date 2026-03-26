import 'package:submission/W9/model/artists/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtists();
  Future<Artist?> fetchArtistById(String id);
}
  