import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final allImagePathsStateProvider =
    StateNotifierProvider<AllImagePathsState, AsyncValue<List<String>>>((ref) {
  final AllImagePathsState allImagePathsState = AllImagePathsState();
  allImagePathsState.init();
  return allImagePathsState;
});

class AllImagePathsState extends StateNotifier<AsyncValue<List<String>>> {
  AllImagePathsState() : super(const AsyncLoading<List<String>>());

  void init() async {
    state = const AsyncLoading<List<String>>();

    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .toList();

    state = AsyncData<List<String>>(imagePaths);
  }
}
