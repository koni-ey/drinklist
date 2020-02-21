import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Name {
  Name(String displayname, int total, List<Drink> consumedDrinks) {
    this.displayname = displayname;
    this.total = total;
    this.consumedDrinks = consumedDrinks;
  }
  String displayname;
  int total;
  Image profilepicture;
  List<Drink> consumedDrinks;
}

class Drink {
  String displayName;
  int price;
  String displaypic;
  int amount;

  Drink(this.displayName, this.price, this.amount);
}
