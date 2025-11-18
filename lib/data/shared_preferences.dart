import 'package:healthapp/data/notifiers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<void> saveDarkModePreference() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setBool('isDarkMode', isDarkModeNotifier.value);
}

Future<void> getDarkModePreference() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  bool? isDarkModePreference = preferences.getBool('isDarkMode');

  if (isDarkModePreference != null) {
    isDarkModeNotifier.value = isDarkModePreference;
  } else {
    isDarkModeNotifier.value = false;
  }
}

Future<void> saveCalories(Map<DateTime, double> calories) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  String? caloriesStored = preferences.getString('caloriesBurned');

  if (caloriesStored != null && caloriesStored != '') {
    Map<String, dynamic> allCaloriesString = json.decode(caloriesStored);

    Map<DateTime, double> allCalories = allCaloriesString.map((key, value) {
      return MapEntry(DateTime.parse(key), value as double);
    });

    double? currentValue = calories[calories.keys.elementAt(0)];

    if (currentValue != null) {
      allCalories[calories.keys.elementAt(0)] = currentValue;
    }

    Map<String, double> convertedMap = allCalories.map((key, value) {
      return MapEntry(key.toIso8601String(), value);
    });
    String caloriesString = json.encode(convertedMap);
    await preferences.setString('caloriesBurned', caloriesString);
  } else {
    Map<String, double> convertedMap = calories.map((key, value) {
      return MapEntry(key.toIso8601String(), value);
    });
    String caloriesString = json.encode(convertedMap);

    await preferences.setString('caloriesBurned', caloriesString);
  }
}

Future<double> getTodayCalories() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  String? caloriesStored = preferences.getString('caloriesBurned');
  double totalCalories = 0.0;
  DateTime now = DateTime.now();

  if (caloriesStored != null && caloriesStored != '') {
    Map<String, dynamic> allCaloriesString = json.decode(caloriesStored);

    Map<DateTime, double> allCalories = allCaloriesString.map((key, value) {
      return MapEntry(DateTime.parse(key), value as double);
    });

    for (var i in allCalories.keys) {
      bool ocurredToday =
          (now.year == i.year && now.month == i.month && now.day == i.day);
      double? currentCaloriess = allCalories[i];

      if (ocurredToday && currentCaloriess != null) {
        totalCalories = totalCalories + currentCaloriess;
      }
    }

    todayCaloriesNotifier.value = totalCalories;
  } else {
    return todayCaloriesNotifier.value;
  }
  return todayCaloriesNotifier.value;
}

Future<void> saveBodyWeight(double bodyWeight) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setDouble('bodyWeight', bodyWeight);
}

Future<void> getBodyWeight() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  double? bodyWeight = preferences.getDouble('bodyWeight');

  if (bodyWeight != null) {
    bodyWeightNotifier.value = bodyWeight;
  } else {
    bodyWeightNotifier.value = 0.0;
  }
}

Future<void> saveHealthyFood(int healthyFood, {bool? isReset}) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  int? foodQty = preferences.getInt('healthyFood');

  if (isReset == true) {
    await preferences.setInt('healthyFood', 0);
  }

  if (foodQty == null && isReset != true) {
    await preferences.setInt('healthyFood', healthyFood);
  } else if (foodQty != null && isReset != true) {
    int value = foodQty + healthyFood;
    await preferences.setInt('healthyFood', value);
  }
}

Future<int> getHealthyFood() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  int? foodQty = preferences.getInt('healthyFood');

  if (foodQty != null) {
    healthyFoodNotifier.value = foodQty;
  } else {
    healthyFoodNotifier.value = 0;
  }
  return healthyFoodNotifier.value;
}

Future<void> saveUnhealthyFood(int unhealthyFood, {bool? isReset}) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  int? foodQty = preferences.getInt('unhealthyFood');

  if (isReset == true) {
    await preferences.setInt('unhealthyFood', 0);
  }

  if (foodQty == null && isReset != true) {
    await preferences.setInt('unhealthyFood', unhealthyFood);
  } else if (foodQty != null && isReset != true) {
    int value = foodQty + unhealthyFood;
    await preferences.setInt('unhealthyFood', value);
  }
}

Future<int> getUnhealthyFood() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  int? foodQty = preferences.getInt('unhealthyFood');

  if (foodQty != null) {
    unhealthyFoodNotifier.value = foodQty;
  } else {
    unhealthyFoodNotifier.value = 0;
  }
  return unhealthyFoodNotifier.value;
}

Future<void> saveFinishedRotines() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  int? finishedRotines = preferences.getInt('finishedRotines');

  if (finishedRotines != null) {
    int value = finishedRotines + finishedRotinesNotifier.value;
    finishedRotinesNotifier.value = value;
    await preferences.setInt('finishedRotines', value);
  } else {
    await preferences.setInt('finishedRotines', 1);
    finishedRotinesNotifier.value = 1;
  }
}

Future<int> getFinishedRotines() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  int? finishedRotines = preferences.getInt('finishedRotines');

  if (finishedRotines != null) {
    finishedRotinesNotifier.value = finishedRotines;
  }

  return finishedRotinesNotifier.value;
}

Future<void> resetPreferences() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  finishedRotinesNotifier.value = 0;
  bodyWeightNotifier.value = 0;
  todayCaloriesNotifier.value = 0;
  healthyFoodNotifier.value = 0;
  unhealthyFoodNotifier.value = 0;
}
