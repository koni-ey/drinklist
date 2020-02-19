import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'jsonparse.dart';
import 'name.dart';

Detailview mydetailview = Detailview();

List<Drink> testilisti = [Drink("Zäpfle", 1, 12), Drink("waldi", 2, 322)];

Name koni = Name("Koni Ey", 31, testilisti);
Name timi = Name("Timi M", 433, testilisti);
Name tsdmi = Name("Timi 2", 433, testilisti);
Name lulimi = Name("Timi 5", 433, testilisti);
Name sackmi = Name("huhu", 433, testilisti);
Name tlimi = Name("sacki", 433, testilisti);
Name tomi = Name("Timi M", 433, testilisti);
Name tami = Name("Timi M", 433, testilisti);
Name huhu = Name("HUHUHUHU", 433, testilisti);

List<Name> namelist = [
  koni,
  timi,
  tsdmi,
  lulimi,
  sackmi,
  tlimi,
  tomi,
  tami,
  huhu
];

Name selectedName = timi;

final List<String> placeholderdrinklist = [
  'Zäpfle',
  'Waldhaus',
  'Paulaner',
  'Glühwein',
  'Apfelschorli',
  'Radler',
  'Obstler'
];

final TextStyle tabletext =
    TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black);

final TextStyle tablehead =
    TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black54);

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Center(
                          child: Text(
                    "Getränkeliste",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        color: Colors.black87),
                  ))),
                ],
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
        child: Scrollbar(
      child: ListView.builder(
          itemBuilder: ((BuildContext context, int index) {
            return ListTile(
              title: Text(namelist[index].displayname,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
              trailing: Icon(Icons.favorite_border),
              onTap: () {
              
              },
            );
          }),
          itemCount: namelist.length),
    ));
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
  Name currentName = koni;

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
                    this.currentName.displayname,
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87),
                  ))),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  this.currentName.total.toString(),
                  style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87),
                ),
                alignment: Alignment(1, 0),
                margin: EdgeInsets.all(20),
              ))
            ])),
        Expanded(
          flex: 3,
          child: Container(
              child: DataTable(
            columns: [
              DataColumn(
                  label: Text(
                'Getränk',
                style: tablehead,
              )),
              DataColumn(
                  label: Text(
                'Anzahl',
                style: tablehead,
              ))
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('Zäpfle', style: tabletext)),
                DataCell(Text(
                  '20',
                  style: tabletext,
                ))
              ]),
              DataRow(cells: [
                DataCell(Text('Radler', style: tabletext)),
                DataCell(Text(
                  '13',
                  style: tabletext,
                ))
              ]),
              DataRow(cells: [
                DataCell(Text(
                  'Glühwiii',
                  style: tabletext,
                )),
                DataCell(Text(
                  '2',
                  style: tabletext,
                ))
              ]),
              DataRow(cells: [
                DataCell(Text(
                  'Wurschtwasr',
                  style: tabletext,
                )),
                DataCell(Text(
                  '1',
                  style: tabletext,
                ))
              ])
            ],
            columnSpacing: 600,
          )),
        )
      ],
    ));
  }
}
