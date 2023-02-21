import 'package:flutter/material.dart';
import 'package:my_workout_tracker/Services/my_exercises_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showExerciseSelector(
    {required BuildContext cntxt, required WidgetRef ref, required List<ExerciseData> list}) async {
  await showDialog<void>(
      context: cntxt,
      builder: (BuildContext cntxt) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 15, 24, 29),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          title: const Text(
            'Favourites',
            style: TextStyle(
              color: Color.fromARGB(255, 11, 147, 152),
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                const Divider(
                  color: Color.fromARGB(255, 11, 147, 152),
                  indent: 20,
                  endIndent: 20,
                  height: 20,
                ),
                Flexible(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: favourites.length,
                    itemBuilder: (cntxt, index) {
                      return SimpleDialogOption(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        onPressed: () {
                          ref.read(currentExercisesProvider.notifier).update((state) {
                            return state + <ExerciseData>[favourites[index]];
                          });
                          Navigator.of(cntxt).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              favourites[index].name,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 11, 147, 152),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Icon(
                              Icons.add,
                              color: Color.fromARGB(255, 11, 147, 152),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
