import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthapp/data/functions.dart';
import 'package:healthapp/data/shared_preferences.dart';

Future<String?> exercisesConfirmation(BuildContext context) async {
  final TextEditingController textTimeController = TextEditingController();
  getBodyWeight();
  String text = 0.0.toString();

  final TextEditingController textWeightController = TextEditingController(
    text: text,
  );

  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Informe os dados para cálculo de gasto calórico:',
          style: GoogleFonts.rubik(fontSize: 18.0),
        ),

        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quanto tempo de exercício?',
              style: GoogleFonts.rubik(fontSize: 15.0),
            ),

            TextField(
              controller: textTimeController,
              autofocus: true,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(hintText: 'Tempo (minutos)'),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
              ],
            ),

            SizedBox(height: 20.0),

            Text(
              'Qual seu peso atual?',
              style: GoogleFonts.rubik(fontSize: 15.0),
            ),

            TextField(
              controller: textWeightController,
              autofocus: false,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(hintText: 'Peso (Kg)'),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
              ],
            ),
          ],
        ),

        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          ElevatedButton(
            child: Text('Confirmar'),
            onPressed: () {
              if (textTimeController.text.isNotEmpty &&
                  textWeightController.text.isNotEmpty) {
                double exerciseDuration =
                    double.tryParse(textTimeController.text) ?? 0;
                double bodyWeight =
                    double.tryParse(textWeightController.text) ?? 0;

                if (exerciseDuration != 0 && bodyWeight != 0) {
                  double resp = kcalCount(exerciseDuration, bodyWeight);
                  DateTime now = DateTime.now();
                  Map<DateTime, double> caloriesRegister = {now: resp};
                  saveBodyWeight(bodyWeight);
                  saveCalories(caloriesRegister);
                  saveFinishedRotines();
                  getBodyWeight();
                  getTodayCalories();
                  getFinishedRotines();
                }
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
          ),
        ],
      );
    },
  );
}
