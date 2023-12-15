
import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/workout_cubit.dart';
import '../model/exercise.dart';
import '../states/workout_state.dart';
import '../workout.dart';

class WorkoutProgress extends StatelessWidget {
  const WorkoutProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> _getStats(Workout workout,workoutElapsed ){


      var workoutTotal = workout.getTotal();

      Exercise excercise = workout.getCurrentExercise(workoutElapsed);

      var exerciseElapsed = workoutElapsed - excercise.startTime!;
      var exerciseRemaining = excercise.prelude!- exerciseElapsed;

      bool isPrelude =exerciseElapsed < excercise.prelude!;
      var exerciseTotal = isPrelude ? excercise.prelude!:excercise.duration!;
      if(!isPrelude){
        exerciseElapsed -= excercise.prelude!;
        //-1,+30 =>29
        exerciseRemaining += excercise.duration!;
      }
return {
  "WorkoutTitle":workout.title,
  "workoutProgress":workoutElapsed/workoutTotal,
  "workoutElapsed":workoutElapsed,
  "totalExercise":workout.exercises.length,
  "currentExerciseIndex":excercise.index!.toDouble(),
  "workoutRemaining":workoutTotal - workoutElapsed,
  "exerciseRemaining":exerciseRemaining
};
    }

    return BlocConsumer<WorkoutCubit,WorkoutState>(
        builder: (context,state){
          final stats = _getStats(state.workout!,state.elapsed!);
        return Scaffold(
          appBar: AppBar(
            title:Text(state.workout!.title.toString()),
            leading:BackButton(
              onPressed: ()=>BlocProvider.of <WorkoutCubit>(context).goHome(),
            ) ,
          ),
          body:Container(
            padding:  const EdgeInsets.all(32),
            child: Column(
              children: [
                LinearProgressIndicator(
                  backgroundColor: Colors.blue[100],
                  minHeight: 10,

                  value: stats['workoutProgress']
                )
              ],
            ),
          )
          ,
        );
          },
        listener: (context,state){

        }
    );
  }
}
