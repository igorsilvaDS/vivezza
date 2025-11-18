// ValueNotifier para gerenciar o estado de notificação
// ValueListenableBuilder pode ser usado para ouvir mudanças nesse valor

import 'package:flutter/material.dart';

ValueNotifier<int> selectedPageNotifier = ValueNotifier<int>(0);
ValueNotifier<bool> isDarkModeNotifier = ValueNotifier<bool>(false);

ValueNotifier<List<String>> tempExercisesNotifier = ValueNotifier<List<String>>(
  [],
);

ValueNotifier<List<String>> selectedExercisesNotifier =
    ValueNotifier<List<String>>([]);

ValueNotifier<double> bodyWeightNotifier = ValueNotifier<double>(0.0);

ValueNotifier<Map> metExercisesNotifier = ValueNotifier<Map>({
  'Flexão': 8.0,
  'Abdominal': 8.0,
  'Triceps Afundo': 8.0,
  'Ciclismo Leve': 6.0,
  'Ciclismo Moderado': 8.0,
  'Ciclismo Intenso': 10.0,
  'Corrida Intensa': 12.0,
  'Aeróbico': 6.0,
  'Dança Lenta': 3.0,
  'Basquete': 8.0,
  'Futebol': 10.0,
  'Esgrima': 6.0,
  'Pular Corda Leve': 8.0,
  'Pular Corda Moderado': 10.0,
  'Pular Corda Intenso': 12.0,
});

ValueNotifier<int> healthyFoodNotifier = ValueNotifier<int>(0);
ValueNotifier<int> unhealthyFoodNotifier = ValueNotifier<int>(0);
ValueNotifier<double> todayCaloriesNotifier = ValueNotifier<double>(0.0);
ValueNotifier<int> finishedRotinesNotifier = ValueNotifier<int>(0);
ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(true);
