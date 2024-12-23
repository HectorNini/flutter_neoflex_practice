

import 'package:flutter/material.dart';
import 'package:flutter_app/core/di/configure_dependencie.dart';
import 'package:flutter_app/feature/color/presentation/page/color_page.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() 
{
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration tests: MyApp', () 
  {
    testWidgets('Test', (widgetTester) async 
    {
      final testKey = UniqueKey();
      configureDependencies();
      await widgetTester.pumpWidget(
        MyApp(
          key: testKey,
        ),
      );

      expect(find.byKey(testKey), findsOneWidget);
      expect(find.byType(CubitPage), findsOneWidget);
    });   
  });
}