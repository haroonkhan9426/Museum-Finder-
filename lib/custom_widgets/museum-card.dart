import 'package:flutter/material.dart';

class MuseumCard extends StatelessWidget {
  final name;
  final address;
  final image;

  MuseumCard(
      {this.name = 'Peshawar Museum, Main Peshawar city',
      this.address = 'Main Peshawar',
      this.image = 'assets/images/museum.jpg'});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 160,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/gdg-session3.appspot.com/o/Asset%201.png?alt=media&token=4453f0f7-ff36-47c1-8009-1244481417aa',
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 10, top: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.bookmark_border, color: Colors.grey)
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Icon(Icons.pin_drop),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  address,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
