/* -------------------------------------------------------------------------- */
/*                          MOVE TO flutter3x package                         */
/* -------------------------------------------------------------------------- */
// or move the flutter part there only and move the dart part to dart3x
// also make flutter3x export dart3x ..

import 'package:flutter/services.dart';

extension Flutter3xFormatters on FilteringTextInputFormatter {
  /// Allows digits only from both Western and Eastern Arabic Numerals
  ///
  /// When [Eastern Arabic Numerals][] (i.e. `٠١٢٣٤٥٦٧٨٩`) are used, they are replaced with their respective
  /// [Western Arabic Numerals][] (i.e. `0123456789`).
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return TextField(
  ///     inputFormatters: <TextInputFormatter>[
  ///       /// Replaces: any of [٠١٢٣٤٥٦٧٨٩] with its respective [0123456789]
  ///       ...Flutter3xFormatters.digitsOnlyWithReplacingArabicNumeralsFromEastToWest,
  ///     ],
  ///   );
  /// }
  /// ```
  ///
  /// [Eastern Arabic Numerals]: https://en.wikipedia.org/wiki/Eastern_Arabic_numerals
  /// [Western Arabic Numerals]: https://en.wikipedia.org/wiki/Arabic_numerals
  List<TextInputFormatter> get digitsOnlyWithReplacingArabicNumeralsFromEastToWest {
    final replacementRules = arabicNumeralsEastToWest.keys.map(
      (key) {
        return FilteringTextInputFormatter.deny(
          RegExp(key),
          replacementString: arabicNumeralsEastToWest[key]!,
        );
      },
    );

    return [
      ...replacementRules,
      FilteringTextInputFormatter.digitsOnly,
    ];
  }
}

/// The unicode range of Eastern Arabic Numerals (i.e. `٠١٢٣٤٥٦٧٨٩`).
const easternArabicNumeralsUnicodeRange = '[\u0660-\u0669]';

/// A regular expression to detect Eastern Arabic Numerals (i.e. `٠١٢٣٤٥٦٧٨٩`).
final easternArabicNumeralsRegex = RegExp(easternArabicNumeralsUnicodeRange);

/// A map where the keys are the [Eastern Arabic Numerals][] in unicodes
/// and values of [Western Arabic Numerals][]
///
///
/// [Eastern Arabic Numerals]: https://en.wikipedia.org/wiki/Eastern_Arabic_numerals
/// [Western Arabic Numerals]: https://en.wikipedia.org/wiki/Arabic_numerals
const arabicNumeralsEastToWest = <String, String>{
  '\u0660': '0', // ٠ <-> 0
  '\u0661': '1', // ١ <-> 1
  '\u0662': '2', // ٢ <-> 2
  '\u0663': '3', // ٣ <-> 3
  '\u0664': '4', // ٤ <-> 4
  '\u0665': '5', // ٥ <-> 5
  '\u0666': '6', // ٦ <-> 6
  '\u0667': '7', // ٧ <-> 7
  '\u0668': '8', // ٨ <-> 8
  '\u0669': '9', // ٩ <-> 9
};

/// Replaces: any of [٠١٢٣٤٥٦٧٨٩] within a string with its respective [0123456789]
String replaceArabicNumeralsFromEastToWest(String string) {
  if (string.contains(easternArabicNumeralsRegex)) {
    final newString = string.replaceAllMapped(easternArabicNumeralsRegex, (m) {
      return arabicNumeralsEastToWest[m.group(0)!]!;
    });
    return newString;
  } else {
    return string;
  }
}
