import 'package:flutter/material.dart';
import 'package:linkable/linkable.dart';

class ShowAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        height: 350,
        decoration: BoxDecoration(
            color: Colors.blueGrey,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      child: Image.asset(
                        'images/M.jpg',
                        height: 120,
                        width: 120,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      child: Image.asset(
                        'images/Moaaz.png',
                        height: 120,
                        width: 120,
                      ),
                    ),
                  ),
                ],
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "MOAAZ HASAN",
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontFamily: "Orbitron",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: ListTile(
                  leading: Icon(Icons.email),
                  title: Column(
                    children: <Widget>[
                      Linkable(
                          text: "mo2222ath@gmail.com",
                          linkColor: Colors.lightBlue[200],
                          textColor: Colors.white),
                      Linkable(
                          text: "mhr411@stud.fci-cu.edu.eg",
                          linkColor: Colors.lightBlue[200],
                          textColor: Colors.white),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: ListTile(
                  leading: Icon(Icons.link),
                  title: Column(
                    children: <Widget>[
                      Linkable(
                          text: "github.com/mo2222ath",
                          linkColor: Colors.lightBlue[200],
                          textColor: Colors.white),
                      Linkable(
                          text: "linkedin.com/in/mo2222ath",
                          linkColor: Colors.lightBlue[200],
                          textColor: Colors.white),
                      Linkable(
                          text: "hackerrank.com/mo2222ath",
                          linkColor: Colors.lightBlue[200],
                          textColor: Colors.white),
                    ],
                  )),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
}
