import 'package:flutter/material.dart';

enum AppDestination { home, todos, profile }

extension AppDestinationDetails on AppDestination {
  String get path => switch (this) {
    AppDestination.home => '/home',
    AppDestination.todos => '/todos',
    AppDestination.profile => '/profile',
  };

  String get label => switch (this) {
    AppDestination.home => 'Home',
    AppDestination.todos => 'Todos',
    AppDestination.profile => 'Profile',
  };

  IconData get icon => switch (this) {
    AppDestination.home => Icons.home,
    AppDestination.todos => Icons.checklist,
    AppDestination.profile => Icons.person,
  };
}

const primaryDestinations = AppDestination.values;
