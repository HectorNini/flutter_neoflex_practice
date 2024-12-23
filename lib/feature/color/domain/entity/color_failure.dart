import 'package:flutter_app/core/failure/failure.dart';

class ColorFailure extends Failure
{
  ColorFailure({required super.code, super.message = ''});
  
  @override
  String getLocalizedString() {
   return 'Ошибка';
  }
}