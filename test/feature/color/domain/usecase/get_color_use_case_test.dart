
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/feature/color/domain/entity/color_entity.dart';
import 'package:flutter_app/feature/color/domain/entity/color_failure.dart';
import 'package:flutter_app/feature/color/domain/repository/color_repository.dart';
import 'package:flutter_app/feature/color/domain/usecase/get_color_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

class MockColorRepository extends Mock implements ColorRepository{}

void main() 
{
  setUpAll(() => print('setUpAll'));

  group('GetColorUseCase tests: ', () 
  {
    ColorRepository colorRepository = MockColorRepository();

    setUp(()=>print('setUp'));


    test('При успешном получении цвета должен возвращать цвет', () async 
    {
      final ColorEntity colorEntity = ColorEntity(color: Colors.black.value.toString());
      when(()=>colorRepository.read()).thenAnswer((_) async 
      {
        return  Right<ColorFailure, ColorEntity>(colorEntity);
      });

      GetColorUseCase getColorUseCase = GetColorUseCase(colorRepository: colorRepository);
      final result = await getColorUseCase.call();
      verify(()=> colorRepository.read()).called(1);
      expect(result, equals(Right<ColorFailure, ColorEntity>(colorEntity)));
    });

     test('При ошибке получении цвета должен возвращаться failure', () async 
     {
      final ColorFailure failure = ColorFailure(code: 1);
      when(()=>colorRepository.read()).thenAnswer((_) async 
      {
        return  Left<ColorFailure, ColorEntity>(failure);
      });

      GetColorUseCase getColorUseCase = GetColorUseCase(colorRepository: colorRepository);
      final result = await getColorUseCase.call();
      verify(()=> colorRepository.read()).called(1);
      expect(result, equals(Left<ColorFailure, ColorEntity>(failure)));
    });

  });
}