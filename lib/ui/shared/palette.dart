import 'package:flutter/material.dart';

// Primary color scheme found at https://coolors.co/f0a202-ed254e-e5e5e5-0d3b66-29bf12
// Palette generator at http://mcg.mbitson.com/#!?mcgpalette0=%233f51b5
class Palette {
  static MaterialColor shascoBlue = const MaterialColor(
    0xff0d3b66, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffE8EAF6), //10%
      100: Color(0xffC5CBE9), //20%
      200: Color(0xff9FA8DA), //30%
      300: Color(0xff7985CB), //40%
      400: Color(0xff5C6BC0), //50%
      500: Color(0xff3F51B5), //60%
      600: Color(0xff3F51B5), //70%
      700: Color(0xff3140A5), //80%
      800: Color(0xff29379D), //90%
      900: Color(0xff1B278D), //100%
    },
  );

  static MaterialColor shascoYellow = const MaterialColor(
    0xffF0A202, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffFDF4E1), //10%
      100: Color(0xffFBE3B3), //20%
      200: Color(0xffF8D181), //30%
      300: Color(0xffF5BE4E), //40%
      400: Color(0xffF2B028), //50%
      500: Color(0xffF0A202), //60%
      600: Color(0xffEE9A02), //70%
      700: Color(0xffEC9001), //80%
      800: Color(0xffE98601), //90%
      900: Color(0xffE57501), //100%
    },
  );

  static MaterialColor shascoGrey = const MaterialColor(
    0xffe5e5e5, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffFCFCFC), //10%
      100: Color(0xffF7F7F7), //20%
      200: Color(0xffF2F2F2), //30%
      300: Color(0xffEDEDED), //40%
      400: Color(0xffE9E9E9), //50%
      500: Color(0xffE5E5E5), //60%
      600: Color(0xffE2E2E2), //70%
      700: Color(0xffDEDEDE), //80%
      800: Color(0xffDADADA), //90%
      900: Color(0xffD3D3D3), //100%
    },
  );

  static MaterialColor shascoRed = const MaterialColor(
    0xffed254e, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffFDE5EA), //10%
      100: Color(0xffFABECA), //20%
      200: Color(0xffF692A7), //30%
      300: Color(0xffF26683), //40%
      400: Color(0xffF04669), //50%
      500: Color(0xffED254E), //60%
      600: Color(0xffEB2147), //70%
      700: Color(0xffE81B3D), //80%
      800: Color(0xffE51635), //90%
      900: Color(0xffE00D25), //100%
    },
  );

  static MaterialColor shascoGreen = const MaterialColor(
    0xff29bf12, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffE5F7E3), //10%
      100: Color(0xffBFECB8), //20%
      200: Color(0xff94DF89), //30%
      300: Color(0xff69D259), //40%
      400: Color(0xff49C936), //50%
      500: Color(0xff29BF12), //60%
      600: Color(0xff24B910), //70%
      700: Color(0xff1FB10D), //80%
      800: Color(0xff19A90A), //90%
      900: Color(0xff0F9B05), //100%
    },
  );
}
