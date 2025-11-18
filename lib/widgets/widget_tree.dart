import 'package:flutter/material.dart';
import 'package:healthapp/data/notifiers.dart';
import 'package:healthapp/data/shared_preferences.dart';
import 'package:healthapp/pages/home_page.dart';
import 'package:healthapp/pages/nutrition_page.dart';
import 'nav_bar_widget.dart';

List<Widget> pages = [HomePage(), NutritionPage()];

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    getDarkModePreference();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vivezza',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              isDarkModeNotifier.value = !isDarkModeNotifier.value;
              saveDarkModePreference();
            },
            icon: ValueListenableBuilder(
              valueListenable: isDarkModeNotifier,
              builder: (context, isDarkMode, child) {
                return Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode);
              },
            ),
          ),
        ],
      ),

      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Center(child: Text('Menu'))),
            SizedBox(height: 25),
            GestureDetector(
              child: Text('Reset'),
              onTap: () {
                resetPreferences();
                loadNutritionData();
                loadHomeData();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),

      bottomNavigationBar: NavBarWidget(),
    );
  }
}
