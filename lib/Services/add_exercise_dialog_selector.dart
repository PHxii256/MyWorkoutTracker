import 'package:flutter/material.dart';
import 'package:my_workout_tracker/Services/my_exercises_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_workout_tracker/pages/my_exercises.dart';

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
          content: SizedBox(
            height: 280,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Favourites',
                        style: TextStyle(
                          color: Color.fromARGB(255, 11, 147, 152),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(cntxt)
                              .pushReplacement(MaterialPageRoute(builder: (context) => const MyExercises()));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 11, 147, 152),
                        ),
                        splashColor: const Color.fromARGB(255, 11, 147, 152),
                        splashRadius: 70,
                        padding: const EdgeInsets.all(0),
                        alignment: Alignment.centerRight,
                        iconSize: 24,
                      ),
                    ],
                  ),
                ),
                Expanded(
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
              ],
            ),
          ),
        );
      });
}
