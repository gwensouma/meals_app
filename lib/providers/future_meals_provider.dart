import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/model/meal.dart';

final configProvider = FutureProvider<List<Meal>>((ref) async {
  final content =
      json.decode(await rootBundle.loadString('assets/data/meal_data.json'))
          as List;

  return content.map((e) => Meal.fromJson(e)).toList();
});
