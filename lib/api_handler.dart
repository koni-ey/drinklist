import 'dart:convert';

import 'package:http/http.dart' as http;

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

Future<List<DrinkTypes>> fetchDrinkList() async {
  List<DrinkTypes> myDrinks;

  final response = await http.get('http://localhost:8080/api/drinkTypes');
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

  final response = await http.get('http://localhost:8080/api/persons');
  personlist = (json.decode(response.body) as List)
      .map((i) => Person.fromJson(i))
      .toList();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return personlist;
  } else {
    // If the server did not return a 200 OK response, then throw an exception.

    throw Exception('Data couldnt be fetched! (Personlist)');
  }
}
