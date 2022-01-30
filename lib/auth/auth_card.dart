import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pick/ui/widgets/auth/auth_card_image_clip.dart';
import 'package:pick/ui/widgets/auth/auth_card_name_container.dart';

class AuthCard extends StatelessWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            elevation: 6,
            child: LayoutGrid(
              areas: '''
                  image name
                ''',
              rowSizes: const [
                auto,
              ],
              columnSizes: [
                1.fr,
                4.fr,
              ],
              children: [
                gridArea('image').containing(
                  const AuthCardImageClip(),
                ),
                gridArea('name').containing(
                  const AuthCardNameConatiner(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
