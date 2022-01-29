import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/ui/shared/flat_outlined_option.dart';
import 'package:pick/ui/shared/palette.dart';
import 'package:pick/icon-list-option/icon_list_option_image.dart';
import 'package:pick/icon-list-option/icon_list_option_child_count.dart';
import 'package:pick/icon-list-option/icon_list_option_name.dart';

class IconListOption extends HookConsumerWidget {
  const IconListOption({
    Key? key,
    required this.iconData,
    required this.text,
    this.childCount,
    this.childCountLabel,
    required this.onTap,
  }) : super(key: key);

  final IconData iconData;
  final String text;
  final int? childCount;
  final String? childCountLabel;
  final Function onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => onTap,
      child: FlatBorderOption(
        color: Palette.shascoGrey[50]!,
        borderColor: Palette.shascoBlue,
        child: LayoutGrid(
          areas: '''
              icon name count
            ''',
          rowSizes: const [
            auto,
          ],
          columnSizes: [
            1.fr,
            3.fr,
            2.fr,
          ],
          children: [
            gridArea('icon').containing(
              IconListOptionImage(
                iconData: iconData,
              ),
            ),
            gridArea('name').containing(
              IconListOptionName(
                text: text,
              ),
            ),
            gridArea('count').containing(
              IconListOptionChildCount(
                childCount: childCount,
                childCountLabel: childCountLabel ?? '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
