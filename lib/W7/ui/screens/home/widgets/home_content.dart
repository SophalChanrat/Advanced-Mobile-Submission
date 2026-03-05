import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission/W7/ui/screens/home/view_model/home_view_model.dart';
import 'package:submission/W7/ui/screens/library/widgets/song_tile.dart';
import 'package:submission/W7/ui/states/settings_state.dart';
import 'package:submission/W7/ui/theme/theme.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final settingsState = context.watch<AppSettingsState>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Center(child: Text("Home", style: AppTextStyles.heading)),
          SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("Your recent songs",
                style: AppTextStyles.label.copyWith(color: Colors.grey)),
          ),
          if (vm.recentSongs.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "No recent songs yet. Play something from the Library!",
                style: AppTextStyles.label.copyWith(color: Colors.grey),
              ),
            )
          else
            ...vm.recentSongs.map((song) => SongTile(
              song: song,
              isPlaying: vm.isPlaying(song),
              onTap: vm.isPlaying(song) ? vm.stop : () => vm.play(song),
            )),
        ],
      ),
    );
  }
}


