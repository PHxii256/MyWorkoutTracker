import 'package:flutter/material.dart';
import 'package:my_workout_tracker/pages/planed_start.dart';
import 'package:my_workout_tracker/pages/quick_start.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double h = 160;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: h,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 23, 68),
            fontSize: 50,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Divider(
                height: 0,
                color: Color.fromARGB(255, 255, 23, 68),
                indent: 10,
                endIndent: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 20, 8, 0),
                  child: Flexible(
                    fit: FlexFit.loose,
                    child: Text(
                      "Workout",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 23, 68),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 10.0,
                crossAxisCount: 2,
                children: const <Widget>[
                  Card(
                    icon: Icons.bolt,
                    title: "Quick Start",
                    color: Colors.blueGrey,
                    destinationWidget: QuickStart(),
                  ),
                  Card(
                    icon: Icons.menu_book_rounded,
                    title: "Start Plan",
                    color: Colors.blueGrey,
                    destinationWidget: PlannedStart(),
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 20, 8, 0),
                  child: Flexible(
                    fit: FlexFit.loose,
                    child: Text(
                      "Tools",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 23, 68),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Flexible(
                flex: 1,
                child: GridView.count(
                  shrinkWrap: true,
                  primary: true,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 10.0,
                  crossAxisCount: 2,
                  children: const <Widget>[
                    Card(
                      icon: Icons.remove_red_eye_outlined,
                      title: "My Plans",
                      color: Color.fromARGB(255, 49, 185, 112),
                      destinationWidget: QuickStart(),
                    ),
                    Card(
                      icon: Icons.history,
                      title: "History & Progress",
                      color: Color.fromARGB(255, 203, 148, 22),
                      destinationWidget: PlannedStart(),
                    ),
                    Card(
                      icon: Icons.sports_gymnastics,
                      title: "My Exercises",
                      color: Color.fromARGB(255, 245, 35, 88),
                      destinationWidget: QuickStart(),
                    ),
                    Card(
                      icon: Icons.wheelchair_pickup,
                      title: "1 RP MAX",
                      color: Color.fromARGB(255, 39, 145, 216),
                      destinationWidget: PlannedStart(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final Widget destinationWidget;

  const Card({
    required this.icon,
    required this.title,
    required this.color,
    required this.destinationWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 10, 10, 10),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ElevatedButton(
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
            foregroundColor: MaterialStatePropertyAll(Colors.white),
            backgroundColor:
                MaterialStatePropertyAll(Color.fromARGB(255, 12, 12, 12)),
            overlayColor:
                MaterialStatePropertyAll(Color.fromARGB(255, 27, 27, 27)),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => destinationWidget));
          },
          child: Expanded(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Icon(icon, size: 75)),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 160,
                    height: 30,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      child: Align(
                        alignment: Alignment.center,
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
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
