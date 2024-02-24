import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_test_task/blocs/weather_bloc/weather_bloc.dart';

import 'blocs/tasks_bloc/tasks_bloc.dart';
import 'models/task_model.dart';
import 'screens/main_screen.dart';
import 'utilities/weather_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final WeatherRepository weatherRepository = WeatherRepository();

  @override
  Widget build(BuildContext context) {
    List<Task> tasksList = [];

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc(tasksList: tasksList)),
        BlocProvider(
          create: (context) =>
              WeatherBloc(weatherRepository: weatherRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Tasks App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
