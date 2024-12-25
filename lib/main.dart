
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_projects/events_manager/data/hive/models/type_test.dart';
import 'bloc_counter.dart';
import 'events_manager/screens/events_index.dart';
import 'package:hive_flutter/hive_flutter.dart';
void main() async {
  await Hive.initFlutter();
  Bloc.observer = const AppBlocObserver();
  Hive.registerAdapter(EventModelAdapter());
  runApp(const MyApp());
}

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc,
      Transition<dynamic, dynamic> transition,
      ) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    print('${bloc.runtimeType} has been closed.');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('${bloc.runtimeType} error occured.');
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    print('${bloc.runtimeType} error created.');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (t) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: theme,
            home:  MyHomePageView(),
          );
        },
      ),
    );
  }
}
class MyHomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(" this is title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton( onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BlocCounter()),
              );
            },
            child: const Text("Click to navigate"),),
            TextButton( onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventsIndex()),
              );
            },
            child: const Text("To event page"),),
            FloatingActionButton( child: const Icon(Icons.brightness_6), onPressed:  () => context.read<ThemeCubit>().toggleTheme())
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData.light();

  static final _darkTheme = ThemeData.dark();

  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }
}

