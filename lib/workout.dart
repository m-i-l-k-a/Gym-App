import 'package:equatable/equatable.dart';
import 'model/exercise.dart';

class Workout extends Equatable {
  final String? title;
  final List<Exercise> exercises;

  Workout({required this.exercises, required this.title});

  factory Workout.fromJson(Map<String, dynamic> json) {
    List<Exercise> exercises = [];
    int index = 0;
    int startTime = 0;
    for (var ex in json['exercises'] as Iterable) {
      exercises.add(Exercise.fromJson(ex, index, startTime));
      index++;
      startTime += exercises.last.prelude! + exercises.last.duration!;
    }
    return Workout(
      title: json['title'] as String?,
      exercises: exercises,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
  };
Workout copyWith({String? title}) =>Workout(title: title??this.title,exercises: exercises);




int getTotal()=>exercises.fold(0,(prev,ex)=> prev +ex.duration! + ex.prelude!);

Exercise getCurrentExercise(int? elapsed) =>
//last smaller element object
    exercises.lastWhere((element) => element.startTime!<= elapsed!);





  @override
  List<Object?> get props => [title, exercises];

  @override
  bool? get stringify => true;
}
