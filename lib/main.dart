import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttergym_app/blocs/workouts_cubit.dart';
import 'package:fluttergym_app/screens/edit_workout_screen.dart';
import 'package:fluttergym_app/screens/home_page.dart';
import 'package:fluttergym_app/screens/workout_in_progress.dart';
import 'package:fluttergym_app/states/workout_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'blocs/workout_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory()
  );
  HydratedBlocOverrides.runZoned(() => runApp(WorkoutTime()),
    storage: storage
  );

}

class WorkoutTime extends StatelessWidget {
  const WorkoutTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WorkOutsCubit>(
          create: (BuildContext context) {
            WorkOutsCubit workOutsCubit = WorkOutsCubit();
            if (workOutsCubit.state.isEmpty) {
              print("...loading json since the state is empty");
              workOutsCubit.getworkouts();
            } else {
              print("...the state is not empty");
            }
            return workOutsCubit;
          },
        ),
        BlocProvider<WorkoutCubit>(
          create: (BuildContext context) => WorkoutCubit(), // Create your WorkoutCubit
        ),
      ],
      child: MaterialApp(
        title: 'My Workouts',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: Color.fromARGB(255, 66, 74, 96),
            ),
          ),
        ),
        home: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state) {
            if (state is WorkoutInitial) {
              return HomePage();
            } else if (state is WorkoutEditing) {
              return const EditWorkoutScreen();
            }
            return WorkoutProgress(); // Replace with your default UI
          },
        ),
      ),
    );
  }
}
