import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentExercisesLengthProvider = StateProvider<int>((ref) => 0);
final currentExercisesProvider = StateProvider<List<ExerciseData>>((ref) => <ExerciseData>[]);
final favExercisesLengthProvider = StateProvider<int>((ref) => 0);

final List<ExerciseData> _arms = [];
final List<ExerciseData> _legs = [];
final List<ExerciseData> _core = [];
final List<ExerciseData> _back = [];
final List<ExerciseData> _chest = [];

final List<ExerciseData> _favourites = [
  ExerciseData(name: "Dumbell Bicep Curls", muscleGroup: MuscleGroup.arms),
  ExerciseData(name: "Bench Press", muscleGroup: MuscleGroup.chest),
  ExerciseData(name: "Hack Squat", muscleGroup: MuscleGroup.legs),
];

final List<ExerciseData> _currentExercises = [];

get arms => _arms;
get legs => _legs;
get back => _back;
get core => _core;
get chest => _chest;
get favourites => _favourites;
get currentExercises => _currentExercises;
get favouritesLength => _favourites.length;
get currentExercisesLength => _currentExercises.length;

Map _exerciseCategoryData = {};

void addCurrentExercise({required ExerciseData data}) {
  _currentExercises.add(data);
}

void removeCurrentExercise({required ExerciseData data}) {
  if (_currentExercises.contains(data)) {
    _currentExercises.remove(data);
  }
}

bool tryModifyDb({required ExerciseData data, required ModificationAction action}) {
  init();
  List<ExerciseData> dataList = _exerciseCategoryData[data.muscleGroup];
  if (action == ModificationAction.add) {
    if (dataList.contains(data)) {
      return false;
    } else {
      dataList.add(data);
      return true;
    }
  } else {
    if (dataList.contains(data)) {
      dataList.remove(data);
      return true;
    } else {
      return false;
    }
  }
}

void toogleFavourite({required ExerciseData data}) {
  if (data.favourited) {
    _favourites.remove(data);
  } else {
    _favourites.add(data);
  }
  data.favourited = !data.favourited;
}

void init() {
  if (_exerciseCategoryData != {}) {
    return;
  }

  _exerciseCategoryData = {
    MuscleGroup.arms: arms,
    MuscleGroup.legs: _legs,
    MuscleGroup.chest: _chest,
    MuscleGroup.core: _core,
    MuscleGroup.back: _back,
  };
}

class ExerciseData {
  String name = "";
  MuscleGroup muscleGroup = MuscleGroup.unasigned;
  bool favourited = false;

  ExerciseData({
    required this.name,
    required this.muscleGroup,
  });
}

enum MuscleGroup { arms, chest, legs, back, core, unasigned }

enum ModificationAction { add, remove }
