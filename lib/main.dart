import 'package:drinklist/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'neo.dart';
import 'const.dart';
import 'api_handler.dart';

final snackBar = SnackBar(
  backgroundColor: Colors.indigo,
  content: Row(
    children: <Widget>[
      Expanded(
          child: Text('1 Bier',
              style: GoogleFonts.montserrat(
                  fontSize: 40, fontWeight: FontWeight.w600, color: neoback))),
      NeoButton(
        child: Text("OK"),
        onPressed: null,
      )
    ],
  ),
  behavior: SnackBarBehavior.fixed,
);

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Person selectedPerson;
  Future<List<DrinkTypes>> availableDrinks;
  Future<List<Person>> personfuture;

  @override
  void initState() {
    super.initState();
    availableDrinks = fetchDrinkList();
    personfuture = fetchPersonList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Getränkeliste',
        theme: ThemeData(
          textTheme:
              GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
          primaryColor: neoback,
          accentColor: Colors.white,
        ),
        home: Scaffold(
            body: Row(
          children: [
            Expanded(
                flex: 1,
                child: FutureBuilder<List<Person>>(
                    future: personfuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return NameList(snapshot.data, this);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      // By default, show a loading spinner.
                      return CircularProgressIndicator();
                    })),
            Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Expanded(flex: 2, child: Detailview(selectedPerson)),
                    Expanded(
                        flex: 2,
                        child: FutureBuilder<List<DrinkTypes>>(
                            future: availableDrinks,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DrinkList(snapshot.data);
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }

                              // By default, show a loading spinner.
                              return CircularProgressIndicator();
                            })),
                  ],
                )),
          ],
        )));
  }
}

class NameList extends StatefulWidget {
  _MyAppState parent;
  List<Person> personlist;
  NameList(this.personlist, this.parent);

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
                title: Text(this.widget.personlist[index].displayName,
                    style: listtext),
                trailing: Icon(Icons.local_drink),
                onTap: () {
                  this.widget.parent.setState(() {
                    this.widget.parent.selectedPerson =
                        this.widget.personlist[index];
                  });
                },
              );
            }),
            itemCount: this.widget.personlist.length),
      ),
      decoration: neodec,
      margin: EdgeInsets.all(30),
    );
  }
}

class DrinkList extends StatefulWidget {
  List<DrinkTypes> availableDrinks;
  DrinkList(this.availableDrinks);
  @override
  _DrinkListState createState() => _DrinkListState();
}

class _DrinkListState extends State<DrinkList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            padding: EdgeInsets.all(20),
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: this.widget.availableDrinks.length,
            itemBuilder: (BuildContext context, int index) => Container(
                  child: Center(
                      child: LimitedBox(
                    child: Column(
                      children: <Widget>[
                        FloatingActionButton(
                          child: Icon(Icons.add),
                          onPressed: () {
                            Scaffold.of(context).showSnackBar(snackBar);
                          },
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            child: Center(
                              child: Container(
                                child: Image.asset("assets/" +
                                    this
                                        .widget
                                        .availableDrinks[index]
                                        .imageName),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child:
                                Text(this.widget.availableDrinks[index].label))
                      ],
                    ),
                  )),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: neodec,
                  padding: EdgeInsets.all(20),
                  width: 200,
                )),
        height: 300);
  }
}

class Detailview extends StatefulWidget {
  Person currentPerson;
  Detailview(this.currentPerson);
  @override
  _DetailviewState createState() => _DetailviewState();
}

class _DetailviewState extends State<Detailview> {
  String displayname() {
    if (this.widget.currentPerson.displayName != null) {
      return this.widget.currentPerson.displayName.toString();
    } else {
      return "Tap on list!!!!!";
    }
  }

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
                    backgroundColor: Colors.grey.shade600,
                    child: Text(displayname().substring(0, 1),
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                    radius: 50,
                  ))),
              Container(
                  padding: EdgeInsets.all(20),
                  child: Center(child: Text(displayname(), style: detailName))),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  this.widget.currentPerson.totalDrinkCount.toString() + "€",
                  style: totalText,
                ),
                alignment: Alignment(1, 0),
                margin: EdgeInsets.all(5),
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
                DataCell(Text(
                    this
                        .widget
                        .currentPerson
                        .consumedDrinksByDrinkType[0]
                        .drinkTypeId
                        .toString(),
                    style: tabletext)),
                DataCell(Text(
                  this
                      .widget
                      .currentPerson
                      .consumedDrinksByDrinkType[0]
                      .consumedDrinkCount
                      .toString(),
                  style: tabletext,
                ))
              ]),
              DataRow(cells: [
                DataCell(Text(
                    this
                        .widget
                        .currentPerson
                        .consumedDrinksByDrinkType[1]
                        .drinkTypeId
                        .toString(),
                    style: tabletext)),
                DataCell(Text(
                  this
                      .widget
                      .currentPerson
                      .consumedDrinksByDrinkType[1]
                      .drinkTypeId
                      .toString(),
                  style: tabletext,
                ))
              ]),
            ],
            columnSpacing: 600,
          )),
        )
      ],
    ));
  }
}
