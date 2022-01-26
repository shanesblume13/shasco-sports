import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final allImagesStateProvider =
    StateNotifierProvider<AllImagesState, AsyncValue<List<String>>>((ref) {
  final AllImagesState allSeasonsState = AllImagesState();
  allSeasonsState.init();
  return allSeasonsState;
});

class AllImagesState extends StateNotifier<AsyncValue<List<String>>> {
  AllImagesState() : super(const AsyncLoading<List<String>>());

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
