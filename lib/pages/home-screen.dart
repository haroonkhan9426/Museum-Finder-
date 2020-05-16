import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museumapp/custom_widgets/museum-card.dart';
import 'package:museumapp/services/firestore-helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var museumsList;
  bool gotData = false;
  bool hasData = false;
  
  Stream<QuerySnapshot> stream = Firestore.instance.collection('museums').snapshots();
  

  @override
  void initState() {
    stream.listen((data){
      print('Doc lenthg at firebase: ${data.documents.length}');
    });
    _getData();
    super.initState();
  }

  _getData() async {
    final snapshot = await FireStoreHelper().getMuseumData();
    if (snapshot != null) {
      museumsList = snapshot.documents;
      setState(() {
        gotData = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: _body(),
        ),
      ),
    );
  }

  _body() {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Column(
        children: <Widget>[
          _header(),
          _searchBar(),
          _listOfMuseum(),
        ],
      ),
    );
  }

  _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.pin_drop, color: Colors.black),
              SizedBox(
                width: 10,
              ),
              Text(
                'Peshawar',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
          Icon(Icons.map),
        ],
      ),
    );
  }

  _searchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextField(
        decoration: InputDecoration(
            suffix: Icon(Icons.search),
            contentPadding: EdgeInsets.only(left: 8, right: 8),
            border: InputBorder.none),
      ),
    );
  }

  _listOfMuseum() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Top Visited',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('View All'),
            ],
          ),
        ),
        gotData
            ? _listView()
            : Container(
                child: Text('Waiting for data'),
              ),
      ],
    );
  }

  _listView() {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 15),
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: false,
        itemCount: museumsList.length,
        itemBuilder: (context, index) {
          return MuseumCard(
            name: museumsList[index]['name'],
            address: museumsList[index]['address'],
          );
        },
      ),
    );
  }
}
