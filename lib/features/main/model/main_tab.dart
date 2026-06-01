import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

enum MainTab {
  hero(MingCuteIcons.mgc_lightning_fill, "Hero"),
  setting(MingCuteIcons.mgc_user_3_fill, "Setting");

  const MainTab(this.iconData, this.labelKey);

  final IconData iconData;
  final String labelKey;
}
