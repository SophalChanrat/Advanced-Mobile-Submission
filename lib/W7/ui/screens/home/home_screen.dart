import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission/W7/data/repositories/songs/song_repository.dart';
import 'package:submission/W7/ui/screens/home/view_model/home_view_model.dart';
import 'package:submission/W7/ui/screens/home/widgets/home_content.dart';
import 'package:submission/W7/ui/states/player_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) { 
        final vm = HomeViewModel(
          context.read<SongRepository>(),
          context.read<PlayerState>(),
        );
        vm.onPlayerChange();
        return vm;
      },
      child: HomeContent(),
    );
  }
}
