import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const endpoint_consume = 'http://localhost:8080/api/consume';
const endpoint_drinkTypes = 'http://localhost:8080/api/drinkTypes';
const endpoint_persons = 'http://localhost:8080/api/persons';
const encoded_credentials_api_user = 'ZGxjbGllbnQ6Mkh4OGdkOW5rRVJ1ZkMzNEtUVVlQd0JjWjNUV1JwQTc=';

class DrinkTypes {
  int id;
  String label;
  double price;
  String imageName;

  DrinkTypes({this.id, this.label, this.price, this.imageName});

  DrinkTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    price = json['price'];
    imageName = json['imageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['price'] = this.price;
    data['imageName'] = this.imageName;
    return data;
  }
}

class Person {
  int id;
  String displayName;
  int totalDrinkCount;
  List<ConsumedDrinksByDrinkType> consumedDrinksByDrinkType;

  Person(
      {this.id,
      this.displayName,
      this.totalDrinkCount,
      this.consumedDrinksByDrinkType});

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['displayName'];
    totalDrinkCount = json['totalDrinkCount'];
    if (json['consumedDrinksByDrinkType'] != null) {
      consumedDrinksByDrinkType = new List<ConsumedDrinksByDrinkType>();
      json['consumedDrinksByDrinkType'].forEach((v) {
        consumedDrinksByDrinkType
            .add(new ConsumedDrinksByDrinkType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['displayName'] = this.displayName;
    data['totalDrinkCount'] = this.totalDrinkCount;
    if (this.consumedDrinksByDrinkType != null) {
      data['consumedDrinksByDrinkType'] =
          this.consumedDrinksByDrinkType.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConsumedDrinksByDrinkType {
  int drinkTypeId;
  int consumedDrinkCount;
  String drinkTypeLabel;

  ConsumedDrinksByDrinkType(
      {this.drinkTypeId, this.consumedDrinkCount, this.drinkTypeLabel});

  ConsumedDrinksByDrinkType.fromJson(Map<String, dynamic> json) {
    drinkTypeId = json['drinkTypeId'];
    consumedDrinkCount = json['consumedDrinkCount'];
    drinkTypeLabel = json['drinkTypeLabel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['drinkTypeId'] = this.drinkTypeId;
    data['consumedDrinkCount'] = this.consumedDrinkCount;
    data['drinkTypeLabel'] = this.drinkTypeLabel;
    return data;
  }
}

class Selections {
  List<String> displaynames = [];
  List<int> ids = [];
  List<String> personnames = [];
  List<int> personids = [];
  void add(int personid, int id, String displayname, String personname) {
    this.displaynames.add(displayname);
    this.ids.add(id);
    this.personnames.add(personname);
    this.personids.add(personid);
  }

  String getSelections() {
    String selectionstring = "";
    if (this.displaynames.length == 0) {
      return selectionstring;
    } else {
      for (var i = 0; i < this.displaynames.length; i++) {
        selectionstring +=
            this.personnames[i] + ":" + " " + this.displaynames[i] + ",   ";
      }
      return selectionstring;
    }
  }

  applySelection() async {
    var now = new DateTime.now();
    var timestamp = now.toUtc().toIso8601String();
    List consumptionlist = [];

    for (var i = 0; i < personids.length; i++)
      consumptionlist.add({
        "personId": this.personids[i],
        "drinkTypeId": this.ids[i],
      });
    var body =
        json.encode({"timestamp": timestamp, "consumptions": consumptionlist});
    http.post(
      endpoint_consume,
      body: body,
      headers: withAuthenticationHeader(<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }),
    );
    discardSelection();
  }

  discardSelection() {
    this.personids.clear();
    this.displaynames.clear();
    this.ids.clear();
    this.personnames.clear();
  }
}

Future<List<DrinkTypes>> fetchDrinkList() async {
  List<DrinkTypes> myDrinks;

  final response = await http.get(endpoint_drinkTypes, headers: withAuthenticationHeader({}));
  myDrinks = (json.decode(response.body) as List)
      .map((i) => DrinkTypes.fromJson(i))
      .toList();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return myDrinks;
  } else {
    // If the server did not return a 200 OK response, then throw an exception.

    throw Exception('Data couldnt be fetched! (Drinklist)');
  }
}

Future<List<Person>> fetchPersonList() async {
  List<Person> personlist;

  final response = await http.get(endpoint_persons, headers: withAuthenticationHeader({}));
  personlist = (json.decode(response.body) as List)
      .map((i) => Person.fromJson(i))
      .toList();

  if (response.statusCode == 200) {
    print("Fetching succesfull");
    // If the server did return a 200 OK response, then parse the JSON.
    return personlist;
  } else {
    // If the server did not return a 200 OK response, then throw an exception.

    throw Exception('Data couldnt be fetched! (Personlist)');
  }
}

Map<String, String> withAuthenticationHeader(Map<String, String> headers) {
  headers.putIfAbsent(HttpHeaders.authorizationHeader, () => "Basic $encoded_credentials_api_user");
  return headers;
}