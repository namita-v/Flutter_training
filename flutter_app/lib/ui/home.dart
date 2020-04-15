import 'package:flutter/material.dart';
class ScaffoldExample extends StatelessWidget {
  tapButton(){
    debugPrint("Tapped Button");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scaffold"),
        centerTitle: true,
        backgroundColor: Colors.teal.shade500,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add_alert),
              onPressed: () => debugPrint("Alert Tapped")),
          IconButton(icon: Icon(Icons.access_alarms),
              onPressed: tapButton )
        ],
      ),
      backgroundColor: Colors.pinkAccent.shade100,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomButton()
        /*    InkWell(
              child: Text("Tap me!",
              style: TextStyle(fontSize: 23.4),
              ),
              onTap: () => debugPrint("tapped..."),
            )*/
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(content: Text("Hello Again!"),
        backgroundColor: Colors.amber.shade300,);
        Scaffold.of(context).showSnackBar(snackBar);
      },

      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(8.0)
        ),
        child: Text("Button"),
      ),
    );
  }
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Material(
        color: Colors.purple,
        child: Center(child: Text("Hello Flutter",textDirection: TextDirection.ltr,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 23.4,
              fontStyle: FontStyle.italic
          ),

        ))
    );
//    return Center(
//      child: Text ("Hello Flutter",
//        textDirection: TextDirection.ltr,)
//    );
  }
}