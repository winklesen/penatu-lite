import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// theming
class AppTheme {
  static final Color primaryColor = const Color(0xFF699BF7);
  static final ColorScheme colorScheme = ColorScheme.fromSwatch(
    primarySwatch: MaterialColor(primaryColor.value, {
      50: primaryColor.withOpacity(0.1),
      100: primaryColor.withOpacity(0.2),
      200: primaryColor.withOpacity(0.3),
      300: primaryColor.withOpacity(0.4),
      400: primaryColor.withOpacity(0.5),
      500: primaryColor.withOpacity(0.6),
      600: primaryColor.withOpacity(0.7),
      700: primaryColor.withOpacity(0.8),
      800: primaryColor.withOpacity(0.9),
      900: primaryColor.withOpacity(1),
    }),
    brightness: Brightness.light,
  );

  static final ThemeData lightTheme = ThemeData(
    colorScheme: colorScheme,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16.0),
      bodyMedium: TextStyle(fontSize: 14.0),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(primaryColor),
        textStyle:
            WidgetStateProperty.all(TextStyle(fontWeight: FontWeight.bold)),
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(primaryColor),
        textStyle:
            WidgetStateProperty.all(TextStyle(fontWeight: FontWeight.bold)),
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
        side: WidgetStateProperty.all(BorderSide(color: primaryColor)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(primaryColor),
        textStyle:
            WidgetStateProperty.all(TextStyle(fontWeight: FontWeight.bold)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
    ),
  );

  static final ThemeData darkTheme = lightTheme.copyWith(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    scaffoldBackgroundColor: Colors.black,
  );
}

// const Color kRichBlack = Color(0xFF000814);
// const Color kOxfordBlue = Color(0xFF001D3D);
// const Color kPrussianBlue = Color(0xFF003566);
// const Color kMikadoYellow = Color(0xFFffc300);
// const Color kDavysGrey = Color(0xFF4B5358);
// const Color kGrey = Color(0xFF303030);
//
// const kColorScheme = ColorScheme(
//   primary: kMikadoYellow,
//   primaryContainer: kMikadoYellow,
//   secondary: kPrussianBlue,
//   secondaryContainer: kPrussianBlue,
//   surface: kRichBlack,
//   background: kRichBlack,
//   error: Colors.red,
//   onPrimary: kRichBlack,
//   onSecondary: Colors.white,
//   onSurface: Colors.white,
//   onBackground: Colors.white,
//   onError: Colors.white,
//   brightness: Brightness.dark,
// );
//

// class MaterialTheme {
//   final TextTheme textTheme;
//
//   const MaterialTheme(this.textTheme);
//
//   static MaterialScheme lightScheme() {
//     return const MaterialScheme(
//       brightness: Brightness.light,
//       primary: Color(4282474385),
//       surfaceTint: Color(4282474385),
//       onPrimary: Color(4294967295),
//       primaryContainer: Color(4292273151),
//       onPrimaryContainer: Color(4278197054),
//       secondary: Color(4283850609),
//       onSecondary: Color(4294967295),
//       secondaryContainer: Color(4292535033),
//       onSecondaryContainer: Color(4279442475),
//       tertiary: Color(4285551989),
//       onTertiary: Color(4294967295),
//       tertiaryContainer: Color(4294629629),
//       onTertiaryContainer: Color(4280816430),
//       error: Color(4290386458),
//       onError: Color(4294967295),
//       errorContainer: Color(4294957782),
//       onErrorContainer: Color(4282449922),
//       background: Color(4294572543),
//       onBackground: Color(4279835680),
//       surface: Color(4294572543),
//       onSurface: Color(4279835680),
//       surfaceVariant: Color(4292928236),
//       onSurfaceVariant: Color(4282664782),
//       outline: Color(4285822847),
//       outlineVariant: Color(4291086032),
//       shadow: Color(4278190080),
//       scrim: Color(4278190080),
//       inverseSurface: Color(4281217078),
//       inverseOnSurface: Color(4293980407),
//       inversePrimary: Color(4289382399),
//       primaryFixed: Color(4292273151),
//       onPrimaryFixed: Color(4278197054),
//       primaryFixedDim: Color(4289382399),
//       onPrimaryFixedVariant: Color(4280829815),
//       secondaryFixed: Color(4292535033),
//       onSecondaryFixed: Color(4279442475),
//       secondaryFixedDim: Color(4290692828),
//       onSecondaryFixedVariant: Color(4282271577),
//       tertiaryFixed: Color(4294629629),
//       onTertiaryFixed: Color(4280816430),
//       tertiaryFixedDim: Color(4292721888),
//       onTertiaryFixedVariant: Color(4283907676),
//       surfaceDim: Color(4292467168),
//       surfaceBright: Color(4294572543),
//       surfaceContainerLowest: Color(4294967295),
//       surfaceContainerLow: Color(4294177786),
//       surfaceContainer: Color(4293783028),
//       surfaceContainerHigh: Color(4293388526),
//       surfaceContainerHighest: Color(4293059305),
//     );
//   }
//
//   ThemeData light() {
//     return theme(lightScheme().toColorScheme());
//   }
//
//   static MaterialScheme lightMediumContrastScheme() {
//     return const MaterialScheme(
//       brightness: Brightness.light,
//       primary: Color(4280501107),
//       surfaceTint: Color(4282474385),
//       onPrimary: Color(4294967295),
//       primaryContainer: Color(4283987368),
//       onPrimaryContainer: Color(4294967295),
//       secondary: Color(4282008404),
//       onSecondary: Color(4294967295),
//       secondaryContainer: Color(4285298056),
//       onSecondaryContainer: Color(4294967295),
//       tertiary: Color(4283578968),
//       onTertiary: Color(4294967295),
//       tertiaryContainer: Color(4287064972),
//       onTertiaryContainer: Color(4294967295),
//       error: Color(4287365129),
//       onError: Color(4294967295),
//       errorContainer: Color(4292490286),
//       onErrorContainer: Color(4294967295),
//       background: Color(4294572543),
//       onBackground: Color(4279835680),
//       surface: Color(4294572543),
//       onSurface: Color(4279835680),
//       surfaceVariant: Color(4292928236),
//       onSurfaceVariant: Color(4282401610),
//       outline: Color(4284243815),
//       outlineVariant: Color(4286085763),
//       shadow: Color(4278190080),
//       scrim: Color(4278190080),
//       inverseSurface: Color(4281217078),
//       inverseOnSurface: Color(4293980407),
//       inversePrimary: Color(4289382399),
//       primaryFixed: Color(4283987368),
//       onPrimaryFixed: Color(4294967295),
//       primaryFixedDim: Color(4282277006),
//       onPrimaryFixedVariant: Color(4294967295),
//       secondaryFixed: Color(4285298056),
//       onSecondaryFixed: Color(4294967295),
//       secondaryFixedDim: Color(4283653231),
//       onSecondaryFixedVariant: Color(4294967295),
//       tertiaryFixed: Color(4287064972),
//       onTertiaryFixed: Color(4294967295),
//       tertiaryFixedDim: Color(4285354866),
//       onTertiaryFixedVariant: Color(4294967295),
//       surfaceDim: Color(4292467168),
//       surfaceBright: Color(4294572543),
//       surfaceContainerLowest: Color(4294967295),
//       surfaceContainerLow: Color(4294177786),
//       surfaceContainer: Color(4293783028),
//       surfaceContainerHigh: Color(4293388526),
//       surfaceContainerHighest: Color(4293059305),
//     );
//   }
//
//   ThemeData lightMediumContrast() {
//     return theme(lightMediumContrastScheme().toColorScheme());
//   }
//
//   static MaterialScheme lightHighContrastScheme() {
//     return const MaterialScheme(
//       brightness: Brightness.light,
//       primary: Color(4278198602),
//       surfaceTint: Color(4282474385),
//       onPrimary: Color(4294967295),
//       primaryContainer: Color(4280501107),
//       onPrimaryContainer: Color(4294967295),
//       secondary: Color(4279837234),
//       onSecondary: Color(4294967295),
//       secondaryContainer: Color(4282008404),
//       onSecondaryContainer: Color(4294967295),
//       tertiary: Color(4281342517),
//       onTertiary: Color(4294967295),
//       tertiaryContainer: Color(4283578968),
//       onTertiaryContainer: Color(4294967295),
//       error: Color(4283301890),
//       onError: Color(4294967295),
//       errorContainer: Color(4287365129),
//       onErrorContainer: Color(4294967295),
//       background: Color(4294572543),
//       onBackground: Color(4279835680),
//       surface: Color(4294572543),
//       onSurface: Color(4278190080),
//       surfaceVariant: Color(4292928236),
//       onSurfaceVariant: Color(4280362027),
//       outline: Color(4282401610),
//       outlineVariant: Color(4282401610),
//       shadow: Color(4278190080),
//       scrim: Color(4278190080),
//       inverseSurface: Color(4281217078),
//       inverseOnSurface: Color(4294967295),
//       inversePrimary: Color(4293258495),
//       primaryFixed: Color(4280501107),
//       onPrimaryFixed: Color(4294967295),
//       primaryFixedDim: Color(4278463579),
//       onPrimaryFixedVariant: Color(4294967295),
//       secondaryFixed: Color(4282008404),
//       onSecondaryFixed: Color(4294967295),
//       secondaryFixedDim: Color(4280560957),
//       onSecondaryFixedVariant: Color(4294967295),
//       tertiaryFixed: Color(4283578968),
//       onTertiaryFixed: Color(4294967295),
//       tertiaryFixedDim: Color(4282065984),
//       onTertiaryFixedVariant: Color(4294967295),
//       surfaceDim: Color(4292467168),
//       surfaceBright: Color(4294572543),
//       surfaceContainerLowest: Color(4294967295),
//       surfaceContainerLow: Color(4294177786),
//       surfaceContainer: Color(4293783028),
//       surfaceContainerHigh: Color(4293388526),
//       surfaceContainerHighest: Color(4293059305),
//     );
//   }
//
//   ThemeData lightHighContrast() {
//     return theme(lightHighContrastScheme().toColorScheme());
//   }
//
//   static MaterialScheme darkScheme() {
//     return const MaterialScheme(
//       brightness: Brightness.dark,
//       primary: Color(4289382399),
//       surfaceTint: Color(4289382399),
//       onPrimary: Color(4278857823),
//       primaryContainer: Color(4280829815),
//       onPrimaryContainer: Color(4292273151),
//       secondary: Color(4290692828),
//       onSecondary: Color(4280824129),
//       secondaryContainer: Color(4282271577),
//       onSecondaryContainer: Color(4292535033),
//       tertiary: Color(4292721888),
//       onTertiary: Color(4282329156),
//       tertiaryContainer: Color(4283907676),
//       onTertiaryContainer: Color(4294629629),
//       error: Color(4294948011),
//       onError: Color(4285071365),
//       errorContainer: Color(4287823882),
//       onErrorContainer: Color(4294957782),
//       background: Color(4279309080),
//       onBackground: Color(4293059305),
//       surface: Color(4279309080),
//       onSurface: Color(4293059305),
//       surfaceVariant: Color(4282664782),
//       onSurfaceVariant: Color(4291086032),
//       outline: Color(4287533209),
//       outlineVariant: Color(4282664782),
//       shadow: Color(4278190080),
//       scrim: Color(4278190080),
//       inverseSurface: Color(4293059305),
//       inverseOnSurface: Color(4281217078),
//       inversePrimary: Color(4282474385),
//       primaryFixed: Color(4292273151),
//       onPrimaryFixed: Color(4278197054),
//       primaryFixedDim: Color(4289382399),
//       onPrimaryFixedVariant: Color(4280829815),
//       secondaryFixed: Color(4292535033),
//       onSecondaryFixed: Color(4279442475),
//       secondaryFixedDim: Color(4290692828),
//       onSecondaryFixedVariant: Color(4282271577),
//       tertiaryFixed: Color(4294629629),
//       onTertiaryFixed: Color(4280816430),
//       tertiaryFixedDim: Color(4292721888),
//       onTertiaryFixedVariant: Color(4283907676),
//       surfaceDim: Color(4279309080),
//       surfaceBright: Color(4281809214),
//       surfaceContainerLowest: Color(4278980115),
//       surfaceContainerLow: Color(4279835680),
//       surfaceContainer: Color(4280098852),
//       surfaceContainerHigh: Color(4280822319),
//       surfaceContainerHighest: Color(4281546042),
//     );
//   }
//
//   ThemeData dark() {
//     return theme(darkScheme().toColorScheme());
//   }
//
//   static MaterialScheme darkMediumContrastScheme() {
//     return const MaterialScheme(
//       brightness: Brightness.dark,
//       primary: Color(4289842175),
//       surfaceTint: Color(4289382399),
//       onPrimary: Color(4278195764),
//       primaryContainer: Color(4285829575),
//       onPrimaryContainer: Color(4278190080),
//       secondary: Color(4290956256),
//       onSecondary: Color(4279047718),
//       secondaryContainer: Color(4287140261),
//       onSecondaryContainer: Color(4278190080),
//       tertiary: Color(4292985061),
//       onTertiary: Color(4280487465),
//       tertiaryContainer: Color(4288972713),
//       onTertiaryContainer: Color(4278190080),
//       error: Color(4294949553),
//       onError: Color(4281794561),
//       errorContainer: Color(4294923337),
//       onErrorContainer: Color(4278190080),
//       background: Color(4279309080),
//       onBackground: Color(4293059305),
//       surface: Color(4279309080),
//       onSurface: Color(4294703871),
//       surfaceVariant: Color(4282664782),
//       onSurfaceVariant: Color(4291349204),
//       outline: Color(4288717740),
//       outlineVariant: Color(4286612364),
//       shadow: Color(4278190080),
//       scrim: Color(4278190080),
//       inverseSurface: Color(4293059305),
//       inverseOnSurface: Color(4280822319),
//       inversePrimary: Color(4280895608),
//       primaryFixed: Color(4292273151),
//       onPrimaryFixed: Color(4278194475),
//       primaryFixedDim: Color(4289382399),
//       onPrimaryFixedVariant: Color(4279449189),
//       secondaryFixed: Color(4292535033),
//       onSecondaryFixed: Color(4278718753),
//       secondaryFixedDim: Color(4290692828),
//       onSecondaryFixedVariant: Color(4281218631),
//       tertiaryFixed: Color(4294629629),
//       onTertiaryFixed: Color(4280092707),
//       tertiaryFixedDim: Color(4292721888),
//       onTertiaryFixedVariant: Color(4282723914),
//       surfaceDim: Color(4279309080),
//       surfaceBright: Color(4281809214),
//       surfaceContainerLowest: Color(4278980115),
//       surfaceContainerLow: Color(4279835680),
//       surfaceContainer: Color(4280098852),
//       surfaceContainerHigh: Color(4280822319),
//       surfaceContainerHighest: Color(4281546042),
//     );
//   }
//
//   ThemeData darkMediumContrast() {
//     return theme(darkMediumContrastScheme().toColorScheme());
//   }
//
//   static MaterialScheme darkHighContrastScheme() {
//     return const MaterialScheme(
//       brightness: Brightness.dark,
//       primary: Color(4294703871),
//       surfaceTint: Color(4289382399),
//       onPrimary: Color(4278190080),
//       primaryContainer: Color(4289842175),
//       onPrimaryContainer: Color(4278190080),
//       secondary: Color(4294703871),
//       onSecondary: Color(4278190080),
//       secondaryContainer: Color(4290956256),
//       onSecondaryContainer: Color(4278190080),
//       tertiary: Color(4294965754),
//       onTertiary: Color(4278190080),
//       tertiaryContainer: Color(4292985061),
//       onTertiaryContainer: Color(4278190080),
//       error: Color(4294965753),
//       onError: Color(4278190080),
//       errorContainer: Color(4294949553),
//       onErrorContainer: Color(4278190080),
//       background: Color(4279309080),
//       onBackground: Color(4293059305),
//       surface: Color(4279309080),
//       onSurface: Color(4294967295),
//       surfaceVariant: Color(4282664782),
//       onSurfaceVariant: Color(4294703871),
//       outline: Color(4291349204),
//       outlineVariant: Color(4291349204),
//       shadow: Color(4278190080),
//       scrim: Color(4278190080),
//       inverseSurface: Color(4293059305),
//       inverseOnSurface: Color(4278190080),
//       inversePrimary: Color(4278200665),
//       primaryFixed: Color(4292732927),
//       onPrimaryFixed: Color(4278190080),
//       primaryFixedDim: Color(4289842175),
//       onPrimaryFixedVariant: Color(4278195764),
//       secondaryFixed: Color(4292798461),
//       onSecondaryFixed: Color(4278190080),
//       secondaryFixedDim: Color(4290956256),
//       onSecondaryFixedVariant: Color(4279047718),
//       tertiaryFixed: Color(4294761983),
//       onTertiaryFixed: Color(4278190080),
//       tertiaryFixedDim: Color(4292985061),
//       onTertiaryFixedVariant: Color(4280487465),
//       surfaceDim: Color(4279309080),
//       surfaceBright: Color(4281809214),
//       surfaceContainerLowest: Color(4278980115),
//       surfaceContainerLow: Color(4279835680),
//       surfaceContainer: Color(4280098852),
//       surfaceContainerHigh: Color(4280822319),
//       surfaceContainerHighest: Color(4281546042),
//     );
//   }
//
//   ThemeData darkHighContrast() {
//     return theme(darkHighContrastScheme().toColorScheme());
//   }
//
//
//   ThemeData theme(ColorScheme colorScheme) => ThemeData(
//     useMaterial3: true,
//     brightness: colorScheme.brightness,
//     colorScheme: colorScheme,
//     textTheme: textTheme.apply(
//       bodyColor: colorScheme.onSurface,
//       displayColor: colorScheme.onSurface,
//     ),
//     scaffoldBackgroundColor: colorScheme.background,
//     canvasColor: colorScheme.surface,
//   );
//
//
//   List<ExtendedColor> get extendedColors => [
//   ];
// }
//
// class MaterialScheme {
//   const MaterialScheme({
//     required this.brightness,
//     required this.primary,
//     required this.surfaceTint,
//     required this.onPrimary,
//     required this.primaryContainer,
//     required this.onPrimaryContainer,
//     required this.secondary,
//     required this.onSecondary,
//     required this.secondaryContainer,
//     required this.onSecondaryContainer,
//     required this.tertiary,
//     required this.onTertiary,
//     required this.tertiaryContainer,
//     required this.onTertiaryContainer,
//     required this.error,
//     required this.onError,
//     required this.errorContainer,
//     required this.onErrorContainer,
//     required this.background,
//     required this.onBackground,
//     required this.surface,
//     required this.onSurface,
//     required this.surfaceVariant,
//     required this.onSurfaceVariant,
//     required this.outline,
//     required this.outlineVariant,
//     required this.shadow,
//     required this.scrim,
//     required this.inverseSurface,
//     required this.inverseOnSurface,
//     required this.inversePrimary,
//     required this.primaryFixed,
//     required this.onPrimaryFixed,
//     required this.primaryFixedDim,
//     required this.onPrimaryFixedVariant,
//     required this.secondaryFixed,
//     required this.onSecondaryFixed,
//     required this.secondaryFixedDim,
//     required this.onSecondaryFixedVariant,
//     required this.tertiaryFixed,
//     required this.onTertiaryFixed,
//     required this.tertiaryFixedDim,
//     required this.onTertiaryFixedVariant,
//     required this.surfaceDim,
//     required this.surfaceBright,
//     required this.surfaceContainerLowest,
//     required this.surfaceContainerLow,
//     required this.surfaceContainer,
//     required this.surfaceContainerHigh,
//     required this.surfaceContainerHighest,
//   });
//
//   final Brightness brightness;
//   final Color primary;
//   final Color surfaceTint;
//   final Color onPrimary;
//   final Color primaryContainer;
//   final Color onPrimaryContainer;
//   final Color secondary;
//   final Color onSecondary;
//   final Color secondaryContainer;
//   final Color onSecondaryContainer;
//   final Color tertiary;
//   final Color onTertiary;
//   final Color tertiaryContainer;
//   final Color onTertiaryContainer;
//   final Color error;
//   final Color onError;
//   final Color errorContainer;
//   final Color onErrorContainer;
//   final Color background;
//   final Color onBackground;
//   final Color surface;
//   final Color onSurface;
//   final Color surfaceVariant;
//   final Color onSurfaceVariant;
//   final Color outline;
//   final Color outlineVariant;
//   final Color shadow;
//   final Color scrim;
//   final Color inverseSurface;
//   final Color inverseOnSurface;
//   final Color inversePrimary;
//   final Color primaryFixed;
//   final Color onPrimaryFixed;
//   final Color primaryFixedDim;
//   final Color onPrimaryFixedVariant;
//   final Color secondaryFixed;
//   final Color onSecondaryFixed;
//   final Color secondaryFixedDim;
//   final Color onSecondaryFixedVariant;
//   final Color tertiaryFixed;
//   final Color onTertiaryFixed;
//   final Color tertiaryFixedDim;
//   final Color onTertiaryFixedVariant;
//   final Color surfaceDim;
//   final Color surfaceBright;
//   final Color surfaceContainerLowest;
//   final Color surfaceContainerLow;
//   final Color surfaceContainer;
//   final Color surfaceContainerHigh;
//   final Color surfaceContainerHighest;
// }
//
// extension MaterialSchemeUtils on MaterialScheme {
//   ColorScheme toColorScheme() {
//     return ColorScheme(
//       brightness: brightness,
//       primary: primary,
//       onPrimary: onPrimary,
//       primaryContainer: primaryContainer,
//       onPrimaryContainer: onPrimaryContainer,
//       secondary: secondary,
//       onSecondary: onSecondary,
//       secondaryContainer: secondaryContainer,
//       onSecondaryContainer: onSecondaryContainer,
//       tertiary: tertiary,
//       onTertiary: onTertiary,
//       tertiaryContainer: tertiaryContainer,
//       onTertiaryContainer: onTertiaryContainer,
//       error: error,
//       onError: onError,
//       errorContainer: errorContainer,
//       onErrorContainer: onErrorContainer,
//       background: background,
//       onBackground: onBackground,
//       surface: surface,
//       onSurface: onSurface,
//       surfaceVariant: surfaceVariant,
//       onSurfaceVariant: onSurfaceVariant,
//       outline: outline,
//       outlineVariant: outlineVariant,
//       shadow: shadow,
//       scrim: scrim,
//       inverseSurface: inverseSurface,
//       onInverseSurface: inverseOnSurface,
//       inversePrimary: inversePrimary,
//     );
//   }
// }
//
// class ExtendedColor {
//   final Color seed, value;
//   final ColorFamily light;
//   final ColorFamily lightHighContrast;
//   final ColorFamily lightMediumContrast;
//   final ColorFamily dark;
//   final ColorFamily darkHighContrast;
//   final ColorFamily darkMediumContrast;
//
//   const ExtendedColor({
//     required this.seed,
//     required this.value,
//     required this.light,
//     required this.lightHighContrast,
//     required this.lightMediumContrast,
//     required this.dark,
//     required this.darkHighContrast,
//     required this.darkMediumContrast,
//   });
// }
//
// class ColorFamily {
//   const ColorFamily({
//     required this.color,
//     required this.onColor,
//     required this.colorContainer,
//     required this.onColorContainer,
//   });
//
//   final Color color;
//   final Color onColor;
//   final Color colorContainer;
//   final Color onColorContainer;
// }
