import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Name {
  Name(String displayname, int total,
      List<Drink> consumedDrinks){
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
  Drink(String displayName, double price, int consumed){
    this.displayName = displayName;
    this.price = price;
    this.consumed = consumed;
  }
  String displayName;
  double price;
  Image displayPic;
  int consumed;
}
