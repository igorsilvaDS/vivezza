import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthapp/data/notifiers.dart';
import 'package:healthapp/widgets/container_item_widget.dart';
import 'package:healthapp/widgets/exercises_confirmation_widget.dart';

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selecione os exercícios realizados',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: metExercisesNotifier.value.length,
            itemBuilder: (context, index) {
              return ContainerItemWidget(
                text: metExercisesNotifier.value.keys.elementAt(index),
              );
            },
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: FilledButton(
                onPressed: () {
                  exercisesConfirmation(context);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 22, 195, 88),
                ),
                child: Text(
                  'Confirmar',
                  style: GoogleFonts.rubik(fontSize: 20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
