import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IconListOptionChildCount extends HookConsumerWidget {
  const IconListOptionChildCount({
    Key? key,
    this.childCount,
    this.childCountLabel,
  }) : super(key: key);

  final int? childCount;
  final String? childCountLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(childCount?.toString() ?? ''),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(childCountLabel ?? ''),
          ],
        ),
      ],
    );
  }
}
