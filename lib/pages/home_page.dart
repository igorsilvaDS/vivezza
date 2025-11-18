import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthapp/data/notifiers.dart';
import 'package:healthapp/data/shared_preferences.dart';
import 'package:healthapp/pages/exercises_page.dart';
import 'package:lottie/lottie.dart';

Future<Map<String, dynamic>> loadHomeData() async {
  int finishedRotinesData = await getFinishedRotines();
  double todayCaloriesData = await getTodayCalories();
  return {
    'finishedRotines': finishedRotinesData,
    'todayCalories': todayCaloriesData,
  };
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> _futureHomeData;

  @override
  void initState() {
    super.initState();
    _futureHomeData = loadHomeData();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
      future: _futureHomeData,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Column(children: [CircularProgressIndicator()]));
        }
        if (asyncSnapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Text('"Falha ao carregar a página: ${asyncSnapshot.error}"'),
              ],
            ),
          );
        }
        if (asyncSnapshot.hasData) {
          final data = asyncSnapshot.data;
          final int rotines = data?['finishedRotines'] ?? 0;
          final double kcal = data?['todayCalories'] ?? 0;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 15.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data == null ? '-' : '$rotines',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.rubik(fontSize: 60.0),
                          ),
                          Text(
                            'Rotinas Concluídas',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.rubik(fontSize: 15.0),
                          ),
                        ],
                      ),
                      Lottie.asset(
                        'assets/man_running.json',
                        width: screenSize.width / 1.9,
                      ),
                    ],
                  ),

                  Divider(),
                  const SizedBox(height: 10.0),

                  Center(
                    child: IconButton(
                      icon: Icon(Icons.add_circle, size: 40.0),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ExercisesPage();
                            },
                          ),
                        );
                        setState(() {
                          _futureHomeData = loadHomeData();
                        });
                        selectedExercisesNotifier.value = [];
                      },
                    ),
                  ),

                  Text(
                    'Adicionar exercício',
                    style: GoogleFonts.rubik(fontSize: 12.0),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    height: screenSize.height / 10.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: const Color.fromARGB(255, 129, 233, 183),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                data == null ? '-' : kcal.toStringAsFixed(2),
                                style: GoogleFonts.rubik(
                                  fontSize: 22.0,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "  calorias queimadas hoje",
                                style: GoogleFonts.rubik(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
