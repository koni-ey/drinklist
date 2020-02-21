import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'name.dart';
import 'package:google_fonts/google_fonts.dart';

List<Drink> testilisti = [
  Drink("Zäpfle", 1, 12),
  Drink("Paulaner Spezi", 1, 5)
];
List<Drink> testilisti2 = [
  Drink("Waldhaus", 1, 31),
  Drink("Fritz Cola", 1, 12)
];

Name koni = Name("Koni Ey", 31, testilisti);
Name timi = Name("Timi M", 43, testilisti2);
Name tsdmi = Name("Timi 2", 33, testilisti);
Name lulimi = Name("Timi 5", 3, testilisti);
Name sackmi = Name("huhu", 3, testilisti);
Name tlimi = Name("sacki", 4, testilisti);
Name tomi = Name("Timi M", 33, testilisti);
Name tami = Name("Timi M", 43, testilisti);
Name huhu = Name("HUHUHUHU", 33, testilisti);

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
    GoogleFonts.montserrat(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black54);

final TextStyle tablehead =
    TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black45);

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Name selectedName = timi;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Getränkeliste',
        theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme(
      Theme.of(context).textTheme),
          primaryColor: Color.fromRGBO(246, 246, 246, 1),
          accentColor: Colors.white,  
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
            ),
            body: Row(
              children: [
                Expanded(flex: 1, child: NameList(this)),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Expanded(flex: 3, child: Detailview(selectedName)),
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
  _MyAppState parent;
  NameList(this.parent);

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
                  this.widget.parent.setState(() {
                    this.widget.parent.selectedName = namelist[index];
                  });
                },
              );
            }),
            itemCount: namelist.length),
      ),
      decoration: BoxDecoration(color: Color.fromRGBO(246, 246, 246, 1), boxShadow: [
        BoxShadow(color: Colors.black12, offset: Offset(10, 10), blurRadius: 10),
        BoxShadow(color: Colors.white, offset: Offset(-10, -10), blurRadius: 10)
      ],borderRadius: BorderRadius.all(Radius.circular(20))),margin: EdgeInsets.all(30),
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
      padding: EdgeInsets.all(20),
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: placeholderdrinklist.length,
      itemBuilder: (BuildContext context, int index) => Container(
        child: Center(
            child: Container(
          child: Center(child: Image.asset('assets/rothaus.png')),
          padding: EdgeInsets.all(10),
          width: 200,margin: EdgeInsets.all(20)
        )),
        margin: EdgeInsets.all(20), 
      decoration: BoxDecoration(color: Color.fromRGBO(246, 246, 246, 1), boxShadow: [
        BoxShadow(color: Colors.black12, offset: Offset(10, 10), blurRadius: 10),
        BoxShadow(color: Colors.white, offset: Offset(-10, -10), blurRadius: 10)
      ],borderRadius: BorderRadius.all(Radius.circular(20)),),
      ),
    ));
  }
}

class Detailview extends StatefulWidget {
  Name currentName;
  Detailview(this.currentName);
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
                    backgroundColor: Colors.grey.shade600,
                    child: Text(
                        this.widget.currentName.displayname.substring(0, 1),
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
                    this.widget.currentName.displayname,
                    style: GoogleFonts.montserrat(
                        fontSize: 50,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ))),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  this.widget.currentName.total.toString(),
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
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
                DataCell(Text(
                    this.widget.currentName.consumedDrinks[0].displayName,
                    style: tabletext)),
                DataCell(Text(
                  this.widget.currentName.consumedDrinks[0].amount.toString(),
                  style: tabletext,
                ))
              ]),
              DataRow(cells: [
                DataCell(Text(
                    this.widget.currentName.consumedDrinks[1].displayName,
                    style: tabletext)),
                DataCell(Text(
                  this.widget.currentName.consumedDrinks[1].amount.toString(),
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
