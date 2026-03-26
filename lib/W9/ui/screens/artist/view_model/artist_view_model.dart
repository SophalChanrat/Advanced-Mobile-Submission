import 'package:flutter/widgets.dart';
import 'package:submission/W9/data/repositories/artists/artist_repository.dart';
import 'package:submission/W9/model/artists/artist.dart';
import 'package:submission/W9/ui/utils/async_value.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository artistRepo;
  AsyncValue<List<Artist>> artistsValue = AsyncValue.loading();

  ArtistViewModel({required this.artistRepo}){
    _init();
  }

  void _init() async {
    fetchArtists();
  }

  void fetchArtists() async {
    artistsValue = AsyncValue.loading();
    notifyListeners();

    try {
      List<Artist> artists = await artistRepo.fetchArtists();
      artistsValue = AsyncValue.success(artists);
    } catch (e) {
      artistsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }
}
