import 'dart:convert';
import 'package:flutter/material.dart';

class jsonparse extends StatefulWidget {
  @override
  _jsonparseState createState() => _jsonparseState();
}

class _jsonparseState extends State<jsonparse> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        builder: (context, snapshot) {
          var showData = json.decode(snapshot.data.toString());
          return ListView.builder(
            physics: ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(showData[index]['displayName'],
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87)),
                trailing: Icon(Icons.favorite_border),
              );
            },
            itemCount: showData.length,
          );
        },
        future: DefaultAssetBundle.of(context).loadString("assets/names.json"),
      ),
    );
  }
}
