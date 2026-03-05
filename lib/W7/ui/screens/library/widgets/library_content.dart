import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission/W7/ui/screens/library/view_model/library_view_model.dart';
import 'package:submission/W7/ui/screens/library/widgets/song_tile.dart';
import 'package:submission/W7/ui/states/settings_state.dart';
import 'package:submission/W7/ui/theme/theme.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LibraryViewModel>();
    final settingsState = context.watch<AppSettingsState>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),

          SizedBox(height: 50),

          Expanded(
            child: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: vm.songs.length,
                    itemBuilder: (context, index) => SongTile(
                      song: vm.songs[index],
                      isPlaying: vm.isPlaying(vm.songs[index]),
                      onTap: vm.isPlaying(vm.songs[index])
                          ? vm.stop
                          : () => vm.play(vm.songs[index]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}