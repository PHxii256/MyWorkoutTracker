import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_workout_tracker/Services/add_exercise_dialog_selector.dart';
import 'package:my_workout_tracker/Services/my_exercises_data.dart';

class QuickStart extends ConsumerStatefulWidget {
  const QuickStart({super.key});

  @override
  ConsumerState<QuickStart> createState() => _QuickStartState();
}

class _QuickStartState extends ConsumerState<QuickStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 11, 147, 152),
            size: 20,
            shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 15, 92, 83), offset: Offset(0, 0), blurRadius: 30)]),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Today's Session",
          style: TextStyle(
              color: Color.fromARGB(255, 11, 147, 152),
              fontSize: 30,
              fontWeight: FontWeight.bold,
              shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 2, 113, 102), offset: Offset(0, 0), blurRadius: 40)]),
        ),
      ),
      floatingActionButton: const AddExerciseFAB(),
      body: Consumer(
        builder: (context, ref, child) {
          final list = ref.watch(currentExercisesProvider);
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: ((context, index) {
                return ExerciseCard(data: list[index]);
              }));
        },
      ),
      backgroundColor: const Color.fromARGB(255, 15, 24, 29),
    );
  }
}

class ExerciseCard extends StatefulWidget {
  final ExerciseData data;
  const ExerciseCard({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color.fromARGB(255, 16, 30, 38),
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
                        widget.data.name == "" ? "Bench Press" : widget.data.name,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 11, 147, 152),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Icon(
                        Icons.history,
                        color: Color.fromARGB(255, 11, 147, 152),
                        size: 24,
                      )
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                const SetDataAndButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SetDataAndButtons extends StatefulWidget {
  const SetDataAndButtons({super.key});

  @override
  State<SetDataAndButtons> createState() => _SetDataAndButtonsState();
}

class _SetDataAndButtonsState extends State<SetDataAndButtons> {
  List<Widget> setColumn = [];

  @override
  void initState() {
    setColumn.add(SetData(index: setColumn.length));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 0,
          child: Column(
            children: setColumn,
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 4)),
        SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ExerciseCardAction(
                  icon: Icons.add,
                  action: () {
                    setState(() {
                      if (setColumn.length < 9) {
                        setColumn.add(SetData(index: setColumn.length));
                      } //the padding breaks after the 9th idk why
                    });
                  }),
              ExerciseCardAction(
                  icon: Icons.remove,
                  action: () {
                    setState(() {
                      if (setColumn.length > 1) {
                        setColumn.removeLast();
                      }
                    });
                  }),
              ExerciseCardAction(icon: Icons.closed_caption_off, action: () {}),
              ExerciseCardAction(icon: Icons.chat_bubble_outline, action: () {}),
              ExerciseCardAction(icon: Icons.done, action: () {}),
            ],
          ),
        ),
      ],
    );
  }
}

class ExerciseCardAction extends StatelessWidget {
  final IconData icon;
  final Function action;
  const ExerciseCardAction({
    required this.icon,
    required this.action,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Flexible(
          flex: 1,
          child: Material(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            shape: const CircleBorder(),
            child: IconButton(
                splashRadius: 20,
                padding: const EdgeInsets.all(0),
                splashColor: const Color.fromARGB(255, 11, 147, 152),
                onPressed: () {
                  action();
                },
                icon: Icon(
                  icon,
                  color: const Color.fromARGB(255, 11, 147, 152),
                  size: 22,
                )),
          ),
        ));
  }
}

class SetData extends StatelessWidget {
  final int index;
  const SetData({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Set ${index + 1}",
              style: const TextStyle(
                color: Color.fromARGB(255, 116, 245, 250),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 2, 8, 2),
              child: SizedBox(
                width: 46,
                height: 22,
                child: TextField(
                  keyboardType: TextInputType.number,
                  cursorColor: Color.fromARGB(255, 116, 245, 250),
                  enableInteractiveSelection: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 116, 245, 250),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlignVertical: TextAlignVertical(y: 0.1),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 1, 7, 1),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 116, 245, 250), width: 2)),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 116, 245, 250), width: 2)),
                  ),
                ),
              ),
            ),
            const Text(
              "KG",
              style: TextStyle(
                color: Color.fromARGB(255, 116, 245, 250),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
              child: SizedBox(
                width: 26,
                height: 22,
                child: TextField(
                  keyboardType: TextInputType.number,
                  cursorColor: Color.fromARGB(255, 116, 245, 250),
                  enableInteractiveSelection: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 116, 245, 250),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlignVertical: TextAlignVertical(y: 0.1),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5, 2, 2, 2),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 116, 245, 250), width: 2)),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 116, 245, 250), width: 2)),
                  ),
                ),
              ),
            ),
            const Text(
              "REPS",
              style: TextStyle(
                color: Color.fromARGB(255, 116, 245, 250),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddExerciseFAB extends ConsumerWidget {
  const AddExerciseFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SpeedDial(
      label: const Text("Add Exercise"),
      buttonSize: const Size(50, 50),
      animatedIcon: AnimatedIcons.add_event,
      foregroundColor: const Color.fromARGB(255, 15, 24, 29),
      backgroundColor: const Color.fromARGB(255, 11, 147, 152),
      spacing: 10,
      overlayColor: Colors.black,
      overlayOpacity: 0.6,
      children: [
        SpeedDialChild(
          shape: const CircleBorder(
            side: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 15, 24, 29),
          child: const Icon(
            Icons.star,
            size: 20,
            color: Color.fromARGB(255, 11, 147, 152),
          ),
          label: "Favourite Exercises",
          labelShadow: <BoxShadow>[const BoxShadow(color: Colors.black)],
          labelBackgroundColor: const Color.fromARGB(255, 15, 24, 29),
          labelStyle:
              const TextStyle(color: Color.fromARGB(255, 11, 147, 152), fontSize: 14, fontWeight: FontWeight.bold),
          onTap: () {
            showExerciseSelector(cntxt: context, ref: ref, list: favourites);
          },
        )
      ],
    );
  }
}
