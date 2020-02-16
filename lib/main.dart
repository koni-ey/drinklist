import 'dart:io';

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

final List<String> placeholderdrinklist = [
  'Zäpfle',
  'Waldhaus',
  'Paulaner',
  'Glühwein',
  'Apfelschorli',
  'Radler',
  'Obstler'
];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Drinklist',
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.blueAccent,
          textTheme: TextTheme(bodyText1: TextStyle(fontSize: 20.0)),
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                "Getränkeliste",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              ),
              centerTitle: true,
            ),
            body: Row(
              children: [
                Expanded(flex: 1, child: NameList()),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Expanded(flex: 3, child: Detailview()),
                        Expanded(
                            flex: 2,
                            child:
                                Container(child: Center(child: DrinkList()))),
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
        physics: ClampingScrollPhysics(),
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

class DrinkList extends StatefulWidget {
  @override
  _DrinkListState createState() => _DrinkListState();
}

class _DrinkListState extends State<DrinkList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      padding: EdgeInsets.all(0),
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: placeholderdrinklist.length,
      itemBuilder: (BuildContext context, int index) => Card(
        child: Center(
            child: Container(
          child: Center(child: Image.asset('assets/rothaus.png')),
          padding: EdgeInsets.all(20),
          width: 200,
        )),
        margin: EdgeInsets.all(20),
      ),
    ));
  }
}

class Detailview extends StatefulWidget {
  @override
  _DetailviewState createState() => _DetailviewState();
}

class _DetailviewState extends State<Detailview> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Expanded(
            flex: 2,
            child: Row(children: <Widget>[
              Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                      child: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: Text('KE',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                    radius: 50,
                  ))),
              Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                      child: Text(
                    "Koni E.",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87),
                  ))),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "42€",
                  style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87),
                ),
                alignment: Alignment(1, 0),
              ))
            ])),
        Expanded(
          flex: 3,
          child: Container(
              child: DataTable(
            columns: [
              DataColumn(label: Text('Getränk')),
              DataColumn(label: Text('Anzahl'))
            ],
            rows: [
              DataRow(cells: [DataCell(Text('Zäpfle')), DataCell(Text('20'))]),
              DataRow(cells: [DataCell(Text('Radler')), DataCell(Text('13'))]),
              DataRow(cells: [DataCell(Text('Glühwiii')), DataCell(Text('2'))]),
              DataRow(
                  cells: [DataCell(Text('Wurschtwasr')), DataCell(Text('1'))])
            ],
            columnSpacing: 600,
          )),
        )
      ],
    ));
  }
}
