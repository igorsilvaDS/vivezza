import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthapp/data/functions.dart';
import 'package:healthapp/data/notifiers.dart';

class ContainerItemWidget extends StatefulWidget {
  const ContainerItemWidget({super.key, required this.text});
  final String text;

  @override
  State<ContainerItemWidget> createState() => _ContainerItemWidgetState();
}

class _ContainerItemWidgetState extends State<ContainerItemWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
            if (!selectedExercisesNotifier.value.contains(widget.text)) {
              addExercise(widget.text);
            } else {
              popExercise(widget.text);
            }
          });
        },
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 129, 233, 183),
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: GoogleFonts.rubik(fontSize: 15, color: Colors.black),
              ),
              Icon(
                selectedExercisesNotifier.value.contains(widget.text)
                    ? Icons.check
                    : Icons.add,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
