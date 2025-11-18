import 'package:healthapp/data/notifiers.dart';

void addExercise(String newExercise) {
  final oldList = selectedExercisesNotifier.value;
  final newList = [...oldList, newExercise];
  selectedExercisesNotifier.value = newList;
}

void popExercise(String exercise) {
  final newList = selectedExercisesNotifier.value;
  newList.remove(exercise);
  selectedExercisesNotifier.value = newList;
}

double kcalCount(double exerciseDuration, double bodyWeight) {
  List<double> metList = [];
  double metSum = 0.0;
  double metMean = 0.0;
  double kcalBurned = 0.0;

  for (var i in selectedExercisesNotifier.value) {
    double? met = metExercisesNotifier.value[i];

    if (met != null) {
      metList.add(met);
    }
  }

  for (var i in metList) {
    metSum = metSum + i;
  }

  metMean = metSum / metList.length;
  kcalBurned = metMean * (exerciseDuration / 60) * bodyWeight;

  return kcalBurned;
}
