import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission/W9/model/artists/artist.dart';
import 'package:submission/W9/ui/screens/artist/view_model/artist_view_model.dart';
import 'package:submission/W9/ui/theme/theme.dart';
import 'package:submission/W9/ui/utils/async_value.dart';
import 'package:submission/W9/ui/widgets/artist/artist_tile.dart';

class ArtistContent extends StatelessWidget {
  const ArtistContent({super.key});

  @override
  Widget build(BuildContext context) {
    ArtistViewModel vm = context.watch<ArtistViewModel>();
    AsyncValue<List<Artist>> asyncValue = vm.artistsValue;

    Widget content;
    switch (asyncValue.state) {
      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(
          child: Text(
            'error = ${asyncValue.error!}',
            style: TextStyle(color: Colors.red),
          ),
        );
        break;
      case AsyncValueState.success:
        List<Artist> artists = asyncValue.data!;
        content = ListView.builder(
          itemCount: artists.length,
          itemBuilder: (context, index) => ArtistTile(artist: artists[index]),
        );
    }

    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text('Artists', style: AppTextStyles.heading),
          SizedBox(height: 50),
          Expanded(child: content),
        ],
      ),
    );
  }
}
