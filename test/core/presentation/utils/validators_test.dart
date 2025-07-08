import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gazzer/core/presentation/localization/app_localizations.dart';
import 'package:gazzer/core/presentation/localization/app_localizations_en.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';

void main() {
  testWidgets('myValidator returns translated message for English locale using testWidgets', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        navigatorKey: AppNavigator().mainKey,
        locale: const Locale('en'), // Set the desired locale
        home: Builder(
          builder: (BuildContext context) {
            return const LocalizationWidget(testValidators: validatorsTest);
          },
        ),
      ),
    );
  });
}

class LocalizationWidget extends StatefulWidget {
  const LocalizationWidget({super.key, required this.testValidators});
  final Function() testValidators;
  @override
  State<LocalizationWidget> createState() => _LocalizationWidgetState();
}

class _LocalizationWidgetState extends State<LocalizationWidget> {
  @override
  void didChangeDependencies() {
    widget.testValidators();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

/// validatorsTest is a function that tests the Validators.notEmpty method.
///
/// It checks that the method returns the correct error message for empty input.
///
void validatorsTest() {
  print('validatorsTest called');
  // Test the notEmpty validator
  expect(Validators.notEmpty(''), AppLocalizationsEn().thisFieldIsRequired, reason: '[[ blank ]]');
  expect(Validators.notEmpty(null), AppLocalizationsEn().thisFieldIsRequired, reason: '[[ null ]]');
  expect(Validators.notEmpty('  '), AppLocalizationsEn().thisFieldIsRequired, reason: '[[ whitespace ]]');
  expect(Validators.notEmpty(' ss '), null, reason: '[[ valid ]]');
  expect(Validators.notEmpty('word'), null, reason: '[[ valid ]]');

  /// Test the emailValidator
  expect(Validators.emailValidator(''), AppLocalizationsEn().thisFieldIsRequired, reason: '[[ blank ]]');
  expect(Validators.emailValidator('  '), AppLocalizationsEn().thisFieldIsRequired, reason: '[[ whitespace ]]');
  expect(Validators.emailValidator(null), AppLocalizationsEn().thisFieldIsRequired, reason: '[[ null ]]');
  expect(Validators.emailValidator('invalid'), AppLocalizationsEn().invalidEmail, reason: '[[ invalid ]]');
  expect(Validators.emailValidator('invalid@'), AppLocalizationsEn().invalidEmail, reason: '[[ invalid@ ]]');
  expect(
    Validators.emailValidator('invalid@domain'),
    AppLocalizationsEn().invalidEmail,
    reason: '[[ invalid@domain ]]',
  );
  expect(Validators.emailValidator('invalid@domain.com'), null, reason: '[[ valid ]]');

  /// Test the mobileEGValidator
  expect(Validators.mobileEGValidator(''), AppLocalizationsEn().thisFieldIsRequired, reason: '[[ blank ]]');
  expect(Validators.mobileEGValidator('  '), AppLocalizationsEn().thisFieldIsRequired, reason: '[[ whitespace ]]');
  expect(Validators.mobileEGValidator(null), AppLocalizationsEn().thisFieldIsRequired, reason: '[[ null ]]');
  expect(Validators.mobileEGValidator('1012345678'), null, reason: '[[ 1012345678 ]]');
  expect(Validators.mobileEGValidator('1112345678'), null, reason: '[[ 1112345678 ]]');
  expect(Validators.mobileEGValidator('1234567890'), null, reason: '[[ 1234567890 ]]');
  expect(Validators.mobileEGValidator('1534567890'), null, reason: '[[ 1534567890 ]]');
  expect(
    Validators.mobileEGValidator('2012345678'),
    AppLocalizationsEn().invalidPhoneNumber,
    reason: '[[ 2012345678 ]]',
  );
  expect(Validators.mobileEGValidator('asda'), AppLocalizationsEn().invalidPhoneNumber, reason: '[[ asda ]]');
  expect(Validators.mobileEGValidator('22@2#4!'), AppLocalizationsEn().invalidPhoneNumber, reason: '[[ 22@2#4! ]]');

  /// Test the passwordValidation
  expect(Validators.passwordValidation('!Ss123456'), null, reason: '[[ !Ss123456 ]]');
  expect(Validators.passwordValidation(''), AppLocalizationsEn().thisFieldIsRequired, reason: '[[ blank ]]');
  expect(Validators.passwordValidation(' '), contains(L10n.tr().atLEastEightCharacters), reason: '[[ whitespace ]]');
  expect(Validators.passwordValidation('Ss1234'), contains(L10n.tr().atLEastEightCharacters), reason: '[[ Ss1234 ]]');
  expect(Validators.passwordValidation('Ss123456'), contains(L10n.tr().oneSpecialCharacter), reason: '[[ Ss123456 ]]');
  expect(Validators.passwordValidation('@s123456'), contains(L10n.tr().oneUppercaseLetter), reason: '[[ @s123456 ]]');
  expect(Validators.passwordValidation('@S123456'), contains(L10n.tr().oneLowercaseLetter), reason: '[[ @S1234 ]]');
  expect(Validators.passwordValidation('@Ssssss'), contains(L10n.tr().oneDigit), reason: '[[ @Ssssss ]]');

  /// Test the dashedCharactersOnly validator
  expect(Validators.dashedCharactersOnly(''), AppLocalizationsEn().thisFieldIsRequired, reason: '[[ blank ]]');
  expect(Validators.dashedCharactersOnly('  '), AppLocalizationsEn().thisFieldIsRequired, reason: '[[ whitespace ]]');
  expect(Validators.dashedCharactersOnly(null), AppLocalizationsEn().thisFieldIsRequired, reason: '[[ null ]]');
  expect(Validators.dashedCharactersOnly('valid-text'), null, reason: '[[ valid-text ]]');
  expect(
    Validators.dashedCharactersOnly('valid-text-123'),
    AppLocalizationsEn().nameAcceptsOnlyDashedAndCharacters,
    reason: '[[ valid-text-123 ]]',
  );
  expect(
    Validators.dashedCharactersOnly('invalid_text'),
    AppLocalizationsEn().nameAcceptsOnlyDashedAndCharacters,
    reason: '[[ invalid_text ]]',
  );
  expect(
    Validators.dashedCharactersOnly('invalid-text!'),
    AppLocalizationsEn().nameAcceptsOnlyDashedAndCharacters,
    reason: '[[ invalid-text! ]]',
  );
  expect(
    Validators.dashedCharactersOnly('invalid-text@'),
    AppLocalizationsEn().nameAcceptsOnlyDashedAndCharacters,
    reason: '[[ invalid-text@ ]]',
  );

  // Test the valueAtLeastNumber validator
  expect(
    Validators.valueAtLeastNum(null, 'test', 5),
    AppLocalizationsEn().valueMoreThanNum(5, 'test'),
    reason: '[[ null ]]',
  );
  expect(
    Validators.valueAtLeastNum('', 'test', 5),
    AppLocalizationsEn().valueMoreThanNum(5, 'test'),
    reason: '[[ empty ]]',
  );
  expect(
    Validators.valueAtLeastNum('4', 'test', 5),
    AppLocalizationsEn().valueMoreThanNum(5, 'test'),
    reason: '[[ 4 ]]',
  );
  expect(Validators.valueAtLeastNum('55555', 'test', 5), null, reason: '[[ 5 ]]');
  expect(Validators.valueAtLeastNum('0', 'test', 1), null, reason: '[[ 0 ]]');
  expect(Validators.valueAtLeastNum('', 'test', 0), null, reason: '[[ blank ]]');

  // Test the valueMustBeNum validator
  expect(
    Validators.valueMustBeNum(null, 5, 'test'),
    AppLocalizationsEn().valueMustBeNum(5, 'test'),
    reason: '[[ null ]]',
  );
  expect(
    Validators.valueMustBeNum('', 5, 'test'),
    AppLocalizationsEn().valueMustBeNum(5, 'test'),
    reason: '[[ empty ]]',
  );
  expect(
    Validators.valueMustBeNum('1234', 5, 'test'),
    AppLocalizationsEn().valueMustBeNum(5, 'test'),
    reason: '[[ 1234 ]]',
  );
  expect(
    Validators.valueMustBeNum('1234 ', 5, 'test'),
    AppLocalizationsEn().valueMustBeNum(5, 'test'),
    reason: '[[ 1234  ]]',
  );
  expect(Validators.valueMustBeNum('12345', 5, 'test'), null, reason: '[[ 12345 ]]');
  expect(Validators.valueMustBeNum(' 12345 ', 5, 'test'), null, reason: '[[ 12345 ]]');
  expect(
    Validators.valueMustBeNum('123456', 5, 'test'),
    AppLocalizationsEn().valueMustBeNum(5, 'test'),
    reason: '[[ 123456 ]]',
  );
  print('validatorsTest completed');
}
