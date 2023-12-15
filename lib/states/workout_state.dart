import 'package:equatable/equatable.dart';

import '../workout.dart';

abstract class WorkoutState extends Equatable{
  final Workout? workout;
  final int?elapsed;
   const WorkoutState (this.workout,this.elapsed);
}
class WorkoutInitial extends WorkoutState{
  WorkoutInitial():super(null,0);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WorkoutInProgress extends WorkoutState{
  WorkoutInProgress(Workout?workout,int? elapsed) :
        super(workout,elapsed);


  @override
  // TODO: implement props
  List<Object?> get props => [workout,elapsed];
}
class WorkoutEditing extends WorkoutState{
   final int index;
   final int?exIndex;
  WorkoutEditing(Workout?workout,this.index,this.exIndex):super(workout,0);

  @override
  // TODO: implement props
  List<Object?> get props => [workout,index,exIndex];


}