import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthapp/data/notifiers.dart';
import 'package:healthapp/data/shared_preferences.dart';
import 'package:percent_indicator/percent_indicator.dart';

Future<Map<String, int>> loadNutritionData() async {
  int healthyFood = await getHealthyFood();
  int unhealthyFood = await getUnhealthyFood();
  return {'healthyFood': healthyFood, 'unhealthyFood': unhealthyFood};
}

String percentageFunction(int healthyFood, int unhealthyFood) {
  double decimalPercentage =
      ((healthyFood / (healthyFood + unhealthyFood)) * 100);

  if (decimalPercentage.isNaN) {
    return '0';
  } else {
    return '${((healthyFood / (healthyFood + unhealthyFood)) * 100).toStringAsFixed(2)}%';
  }
}

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  late Future<Map<String, int>> _futureNutritionData;

  @override
  void initState() {
    super.initState();
    _futureNutritionData = loadNutritionData();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double percent =
        healthyFoodNotifier.value /
        (healthyFoodNotifier.value + unhealthyFoodNotifier.value);

    return FutureBuilder(
      future: _futureNutritionData,
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
          final int healthyFood = data?['healthyFood'] ?? 0;
          final int unhealthyFood = data?['unhealthyFood'] ?? 0;

          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 15.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25),

                    CircularPercentIndicator(
                      radius: screenSize.width / 3,
                      lineWidth: 20.0,
                      percent: percent,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data == null
                                ? '-'
                                : percentageFunction(
                                    healthyFood,
                                    unhealthyFood,
                                  ),
                            style: GoogleFonts.rubik(fontSize: 30.0),
                          ),
                          Text(
                            'de alimentação saudável',
                            style: GoogleFonts.rubik(fontSize: 12.0),
                          ),
                        ],
                      ),
                      progressColor: Colors.amber,
                    ),
                  ],
                ),

                const SizedBox(height: 25),
                Divider(),
                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Deseja confimar a adição de comida processada?',
                                    style: GoogleFonts.rubik(fontSize: 18.0),
                                  ),
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Não',
                                          style: GoogleFonts.rubik(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),

                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            saveUnhealthyFood(1);
                                            getUnhealthyFood();
                                            _futureNutritionData =
                                                loadNutritionData();
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Sim',
                                          style: GoogleFonts.rubik(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: Column(
                            children: [
                              Icon(Icons.fastfood, size: 60),
                              Icon(Icons.add, size: 20),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Text(
                          data == null ? '-' : '${data['healthyFood']}',
                          style: GoogleFonts.rubik(fontSize: 50.0),
                        ),
                        Text(
                          'Refeições saudáveis',
                          style: GoogleFonts.rubik(fontSize: 12.0),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Deseja confimar a adição de refeição saudável?',
                                    style: GoogleFonts.rubik(fontSize: 18.0),
                                  ),
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Não',
                                          style: GoogleFonts.rubik(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),

                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            saveHealthyFood(1);
                                            getHealthyFood();
                                            _futureNutritionData =
                                                loadNutritionData();
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Sim',
                                          style: GoogleFonts.rubik(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: Column(
                            children: [
                              Icon(Icons.ramen_dining, size: 60),
                              Icon(Icons.add, size: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
