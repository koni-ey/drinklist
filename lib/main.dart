import 'package:drinklist/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'neo.dart';
import 'const.dart';
import 'api_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Person selectedPerson;
  Selections sel = new Selections();
  String selectiontext = "";
  Future<List<DrinkTypes>> availableDrinks;
  bool showSelection = false;
  @override
  void initState() {
    super.initState();
    availableDrinks = fetchDrinkList();
  }

  Widget loadDetailview(Person selectedPerson) {
    if (selectedPerson != null) {
      return Detailview(selectedPerson, this);
    } else {
      return Center(
          child: Text(
        "Bitte wähle deinen Namen aus :)",
        style: pleaseTap,
      ));
    }
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
                child: StreamBuilder<List<Person>>(
                    stream: getPersonList(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Person>> snapshot) {
                      if (snapshot.hasData) {
                        return NameList(snapshot.data, this);
                      } else {
                        return Center(
                            child: CircularProgressIndicator(
                          backgroundColor: neoacc,
                        ));
                      }
                    })),
            Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Expanded(flex: 5, child: loadDetailview(selectedPerson)),
                    Expanded(
                        flex: 4,
                        child: FutureBuilder<List<DrinkTypes>>(
                            future: availableDrinks,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DrinkList(snapshot.data, this);
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }

                              // By default, show a loading spinner.
                              return Center(
                                  child: CircularProgressIndicator(
                                backgroundColor: neoacc,
                              ));
                            })),
                    AnimatedContainer(
                        decoration: neodecaccent,
                        curve: Curves.easeInOut,
                        margin: showSelection
                            ? EdgeInsets.only(
                                left: 0, top: 0, right: 20, bottom: 20)
                            : EdgeInsets.all(0),
                        padding: EdgeInsets.all(7),
                        height: showSelection ? 85 : 0,
                        width: double.infinity,
                        duration: Duration(milliseconds: 300),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 12,
                                child: ListView(children: <Widget>[
                                  Text("Auswahl", style: selectionHead),
                                  Text("" + sel.getSelections(),
                                      style: selectionText)
                                ])),
                            Expanded(
                              flex: 1,
                              child: FlatButton(
                                  onPressed: () {
                                    this.setState(() {
                                      sel.discardSelection();
                                      showSelection = false;
                                    });
                                  },
                                  child: Icon(Icons.do_not_disturb)),
                            ),
                            Expanded(
                              flex: 1,
                              child: NeoButton(
                                  child: Icon(Icons.check),
                                  onPressed: () {
                                    this.setState(() {
                                      sel.applySelection();
                                      selectedPerson = null;
                                      showSelection = false;
                                    });
                                  }),
                            ),
                          ],
                        )),
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
                trailing: Icon(Icons.favorite_border),
                onTap: () {
                  this.widget.parent.setState(() {
                    this.widget.parent.selectedPerson =
                        widget.personlist[index];
                  });
                },
              );
            }),
            itemCount: this.widget.personlist.length),
      ),
      decoration: neodec,
      margin: EdgeInsets.all(20),
    );
  }
}

class DrinkList extends StatefulWidget {
  _MyAppState parent;
  List<DrinkTypes> availableDrinks;
  DrinkList(this.availableDrinks, this.parent);
  @override
  _DrinkListState createState() => _DrinkListState();
}

class _DrinkListState extends State<DrinkList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: this.widget.availableDrinks.length,
            itemBuilder: (BuildContext context, int index) => Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: GestureDetector(
                    child: Card(
                        elevation: 0,
                        color: neoback,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 10,
                              child: Container(
                                padding: EdgeInsets.all(10),
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
                                child: Text(
                                    this.widget.availableDrinks[index].label))
                          ],
                        )),
                    onTap: () {
                      this.widget.parent.setState(() {
                        this.widget.parent.sel.add(
                            this.widget.parent.selectedPerson.id,
                            this.widget.availableDrinks[index].id,
                            this.widget.availableDrinks[index].label,
                            this.widget.parent.selectedPerson.displayName);
                        this.widget.parent.selectiontext =
                            this.widget.parent.sel.getSelections();
                        this.widget.parent.showSelection = true;
                      });
                    },
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: neodec,
                  width: 200,
                )),
        height: 300);
  }
}

class Detailview extends StatefulWidget {
  _MyAppState parent;
  Person currentPerson;
  Detailview(this.currentPerson, this.parent);
  @override
  _DetailviewState createState() => _DetailviewState();
}

class _DetailviewState extends State<Detailview> {
  List<DataRow> generateRows() {
    List<DataRow> rowlist = [];
    for (var i = 0;
        i < this.widget.currentPerson.consumedDrinksByDrinkType.length;
        i++) {
      rowlist.add(DataRow(cells: [
        DataCell(Text(
            this
                .widget
                .currentPerson
                .consumedDrinksByDrinkType[i]
                .drinkTypeLabel,
            style: tabletext)),
        DataCell(Center(
          child: Text(
            this
                .widget
                .currentPerson
                .consumedDrinksByDrinkType[i]
                .consumedDrinkCount
                .toString(),
            style: tabletext,
          ),
        ))
      ]));
    }

    return rowlist;
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
                    child: Text(
                        this.widget.currentPerson.displayName.substring(0, 1),
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                    radius: 50,
                  ))),
              Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                      child: Text(this.widget.currentPerson.displayName,
                          style: detailName))),
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
              margin: EdgeInsets.only(right: 20),
              width: 800,
              child: SingleChildScrollView(
                child: DataTable(
                  horizontalMargin: 50,
                  headingRowHeight: 22,
                  columns: [
                    DataColumn(
                        label: Text(
                      'Getränk',
                      style: tablehead,
                    )),
                    DataColumn(
                        label: Expanded(
                      child: Center(
                        child: Text(
                          '  Anzahl',
                          style: tablehead,
                        ),
                      ),
                    ))
                  ],
                  rows: generateRows(),
                  columnSpacing: 400,
                ),
              )),
        )
      ],
    ));
  }
}

Stream<List<Person>> getPersonList() async* {
  List<Person> personlist;
  while (true) {
    await Future.delayed(Duration(seconds: 2));
    personlist = await fetchPersonList();
    yield personlist;
  }
}
