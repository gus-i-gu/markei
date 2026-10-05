import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'marc_messages.dart';

export 'marc_messages.dart';

class MarcLocalizations {
  const MarcLocalizations(this.locale);
  final Locale locale;
  MarcMessages get messages => MarcMessages(locale.languageCode);
  static const supportedLocales = [
    Locale('en'),
    Locale('pt', 'BR'),
    Locale('es'),
  ];
  static const delegate = _MarcDelegate();
  static MarcMessages of(BuildContext context) =>
      Localizations.of<MarcLocalizations>(
        context,
        MarcLocalizations,
      )?.messages ??
      MarcMessages.english;
}

class _MarcDelegate extends LocalizationsDelegate<MarcLocalizations> {
  const _MarcDelegate();
  @override
  bool isSupported(Locale locale) =>
      const ['en', 'pt', 'es'].contains(locale.languageCode);
  @override
  Future<MarcLocalizations> load(Locale locale) =>
      SynchronousFuture(MarcLocalizations(locale));
  @override
  bool shouldReload(_MarcDelegate old) => false;
}

extension MarcTranslation on BuildContext {
  String tr(String text) => MarcLocalizations.of(this).display(text);
  String message(String source, [List<Object?> arguments = const []]) =>
      MarcLocalizations.of(this).message(source, arguments);
}

/// For application-owned copy only. Keep raw Text for names, notes and IDs.
class MarcText extends StatelessWidget {
  const MarcText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.semanticsLabel,
  });
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;
  final String? semanticsLabel;
  @override
  Widget build(BuildContext context) => Text(
    MarcLocalizations.of(context).numericCopy(context.tr(data)),
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    softWrap: softWrap,
    semanticsLabel: semanticsLabel == null ? null : context.tr(semanticsLabel!),
  );
}

extension LocalizedDecoration on InputDecoration {
  InputDecoration localized(BuildContext context) => copyWith(
    labelText: labelText == null ? null : context.tr(labelText!),
    hintText: hintText == null ? null : context.tr(hintText!),
    helperText: helperText == null ? null : context.tr(helperText!),
    errorText: errorText == null ? null : context.tr(errorText!),
    counterText: counterText == null ? null : context.tr(counterText!),
  );
}
