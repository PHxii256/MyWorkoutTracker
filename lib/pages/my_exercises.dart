import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_workout_tracker/Services/my_exercises_data.dart';

class MyExercises extends ConsumerStatefulWidget {
  const MyExercises({super.key});

  @override
  ConsumerState<MyExercises> createState() => _QuickStartState();
}

class _QuickStartState extends ConsumerState<MyExercises> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 152, 11, 11),
            size: 20,
            shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 29, 5, 5), offset: Offset(0, 0), blurRadius: 30)]),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Favourites",
          style: TextStyle(
              color: Color.fromARGB(255, 152, 11, 11),
              fontSize: 30,
              fontWeight: FontWeight.bold,
              shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 113, 2, 2), offset: Offset(0, 0), blurRadius: 40)]),
        ),
      ),
      floatingActionButton: const SpeedDial(
        icon: Icons.add_reaction_outlined,
        backgroundColor: Color.fromARGB(255, 8, 0, 0),
        foregroundColor: Color.fromARGB(255, 152, 11, 11),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final list = ref.watch(currentExercisesProvider); //change to favourite favourite exercise provider
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: ((context, index) {
                return MyExerciseCard(data: list[index]);
              }));
        },
      ),
      backgroundColor: const Color.fromARGB(255, 10, 5, 5),
    );
  }
}

class MyExerciseCard extends StatelessWidget {
  final ExerciseData data;
  const MyExerciseCard({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color.fromARGB(43, 0, 0, 0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 24,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.name == "" ? "Exercise Name" : data.name,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 152, 11, 11),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              constraints: const BoxConstraints(),
                              onPressed: () {},
                              padding: const EdgeInsets.all(0),
                              splashColor: const Color.fromARGB(195, 59, 0, 0),
                              splashRadius: 22,
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                size: 22,
                                color: Color.fromARGB(255, 152, 11, 11),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                            IconButton(
                              onPressed: () {},
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.all(0),
                              splashColor: const Color.fromARGB(195, 59, 0, 0),
                              splashRadius: 22,
                              icon: const Icon(
                                Icons.star_border,
                                size: 22,
                                color: Color.fromARGB(255, 152, 11, 11),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
