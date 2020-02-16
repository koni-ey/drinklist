import 'package:flutter/material.dart';

final List<String> placeholderlist = [
  'Lel S.',
  'Rofl P.',
  'Timmi',
  'Koni',
  'Dario',
  'Phipsi',
  'Nilso',
  'Lel S.',
  'Rofl P.',
  'Timmi',
  'Koni',
  'Dario',
  'Phipsi',
  'Nilso',
  'Lel S.',
  'Rofl P.',
  'Timmi',
  'Koni',
  'Dario',
  'Phipsi',
  'Nilso',
  'Lel S.',
  'Rofl P.',
  'Timmi',
  'Koni',
  'Dario',
  'Phipsi',
  'Nilso'
];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Drinklist',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                "Getränkeliste",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87),
              ),centerTitle: true,
            ),
            body: Row(
              children: [
                Expanded(flex: 1, child: NameList()),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            flex: 3,
                            child: Container(
                                color: Colors.grey,
                                child: Center(child: Text("PersonDetails")))),
                        Expanded(
                            flex: 2,
                            child: Container(
                                color: Colors.blue,
                                child: Center(child: Text("DrinkPicker")))),
                      ],
                    )),
              ],
            )));
  }
}

class NameList extends StatefulWidget {
  @override
  _NameListState createState() => _NameListState();
}

class _NameListState extends State<NameList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: placeholderlist.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(
              placeholderlist[i],
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54),
            ),
            trailing: Icon(Icons.favorite_border),
          );
        },
      ),
    );
  }
}
