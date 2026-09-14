import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:flutter_template/ui/core/custom_bottom_navigation.dart";
import "package:flutter_template/routing/destination.dart";

void main() {
  testWidgets("bottom navigation reports the selected tab", (tester) async {
    int? selectedIndex;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: CustomBottomNavigation(
            destinations: primaryDestinations,
            currentIndex: 0,
            onTabSelected: (index) => selectedIndex = index,
          ),
        ),
      ),
    );

    await tester.tap(find.text("Todos"));

    expect(selectedIndex, 1);
  });
}
