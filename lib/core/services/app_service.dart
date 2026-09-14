import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import "package:flutter/foundation.dart";
import "package:flutter/material.dart" show Axis;
import "package:get_it/get_it.dart";
import "package:logging/logging.dart";
import "package:flutter_template/core/preferences/application_preferences.dart";
import 'package:flutter_template/config/dependencies.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Basic logging setup.
  Logger.root.level = kDebugMode ? Level.FINE : Level.INFO;
  Logger.root.onRecord.listen((record) {
    dev.log(
      record.message,
      time: record.time,
      level: record.level.value,
      name: record.loggerName,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });

  // Register singletons
  registerSingletons();
  await preferences.restore();

  // Default to only allowing portrait mode
  setDeviceOrientation(Axis.vertical);

  // Set preferred refresh rate to the max possible (the OS may ignore this)
  if (defaultTargetPlatform == TargetPlatform.android) {
    await FlutterDisplayMode.setHighRefreshRate();
  }
}

void setDeviceOrientation(Axis? axis) {
  final orientations = <DeviceOrientation>[];
  if (axis == null || axis == Axis.vertical) {
    orientations.addAll([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  if (axis == null || axis == Axis.horizontal) {
    orientations.addAll([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
  SystemChrome.setPreferredOrientations(orientations);
}

ApplicationPreferences get preferences => GetIt.I.get<ApplicationPreferences>();
