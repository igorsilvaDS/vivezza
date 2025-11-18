import 'package:flutter/material.dart';
import 'package:healthapp/data/notifiers.dart';
import 'package:healthapp/widgets/widget_tree.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: isDarkModeNotifier.value
                ? Brightness.dark
                : Brightness.light,
          ),
          home: WidgetTree(),
        );
      },
    );
  }
}
