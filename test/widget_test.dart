import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_apps/main.dart';
import 'package:flutter_apps/widgets/pokemon_list.dart';
import 'package:flutter_apps/widgets/pokemon_card.dart';

void main() {
  testWidgets('Pokemon app smoke test and search test', (WidgetTester tester) async {
    // Set a phone-sized screen
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify title is displayed
    expect(find.text('Pokemon Go'), findsOneWidget);

    // Verify search bar is displayed
    expect(find.byType(TextField), findsOneWidget);

    // Verify Bulbasaur card exists in list
    expect(find.widgetWithText(PokemonList, 'Bulbasaur'), findsOneWidget);

    // Test search filter
    await tester.enterText(find.byType(TextField), 'Pikachu');
    await tester.pumpAndSettle();

    // Pikachu should be present in PokemonList, Bulbasaur should not
    expect(find.widgetWithText(PokemonList, 'Pikachu'), findsOneWidget);
    expect(find.widgetWithText(PokemonList, 'Bulbasaur'), findsNothing);
  });

  testWidgets('Pokemon app desktop grid test', (WidgetTester tester) async {
    // Set a desktop-sized screen
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // On desktop, PokemonCard is used
    expect(find.byType(PokemonCard), findsWidgets);
    expect(find.widgetWithText(PokemonCard, 'Bulbasaur'), findsOneWidget);
  });
}
