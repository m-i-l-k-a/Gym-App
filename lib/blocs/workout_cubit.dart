
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttergym_app/workout.dart';
import 'package:wakelock/wakelock.dart';

import '../states/workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState>{
WorkoutCubit():super( WorkoutInitial());
Timer? _timer;


editWorkout(Workout workout,int index)
 => emit(WorkoutEditing(workout, index,null));

editExercise(int? exIndex) {
 print("...my excercise index is $exIndex");
 emit(WorkoutEditing(state.workout, (state as WorkoutEditing).index, exIndex));
}


 goHome()=> emit( WorkoutInitial());

onTick(Timer timer){
 if(state is WorkoutInProgress){
  WorkoutInProgress wip =state as WorkoutInProgress;
  if(wip.elapsed!<wip.workout!.getTotal()){
emit(WorkoutInProgress(wip.workout, wip.elapsed! + 1 ));
print("...my elapsed time is  ${wip.elapsed}");
  }else{
   _timer!.cancel();
   Wakelock.disable();
   emit(WorkoutInitial());

  }
 }
}

startworkout(Workout workout,[int? index]){
 Wakelock.enable();
 if(index != null){
  
 }else{
  emit(WorkoutInProgress(workout, 0));
 }
 _timer = Timer.periodic(const Duration(seconds:1), onTick);
}
}


