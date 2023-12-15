import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttergym_app/model/exercise.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../workout.dart';
class WorkOutsCubit extends  HydratedCubit<List<Workout>> {
WorkOutsCubit():super([]);

  getworkouts() async {
    final List<Workout>workouts=[];
   final workoutsJson= jsonDecode(await rootBundle.loadString("assets/workout.json"));
   for(var el in(workoutsJson as Iterable)){
     workouts.add(Workout.fromJson(el));

   }
   emit(workouts);

  }
  saveWorkout(Workout workout,int index){
   Workout newWorkout= Workout(title: workout.title,exercises: []);
   int exIndex=0;
   int startTimes=0;
   for(var ex in workout.exercises){
     newWorkout.exercises.add(
       Exercise(
           title: ex.title,
           prelude:ex.prelude,
           duration:ex.duration,
         index: ex.index,
         startTime: ex.startTime,
       ),
);
     exIndex++;
     startTimes += ex.prelude! + ex.duration!;

   }
   state [index]=newWorkout;
   print("...i have ${state.length} states");
   emit([...state]);

  }

  @override
  List<Workout>? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    List<Workout> workouts = [];
    json['workouts'].forEach(
        (el)=>workouts.add(Workout.fromJson(el))
    );
    return workouts;
  }

  @override
  Map<String, dynamic>? toJson(List<Workout> state) {
    // TODO: implement toJson
    if(state is List<Workout>){
      var json= {
        'workouts':[]
      };
      for(var workout in state){
        json ['workouts']!.add(workout.toJson());
      }
      return json;
    }else{
      return null;
    }
  }

}