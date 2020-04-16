import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Quotes extends StatefulWidget {
  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {

  int _index=0;
  List quotes = [
  "Stay Hungry. Stay Foolish. -Steve Jobs",
  "Good Artists Copy, Great Artists Steal. -Pablo Picasso",
  "Argue with idiots, and you become an idiot. -Paul Graham",
  "Be yourself; everyone else is already taken. -Oscar Wilde",
  "Simplicity is the ultimate sophistication. -Leonardo Da Vinci"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(quotes[_index%quotes.length]),

            FlatButton.icon(
                onPressed: _showQuote,
                icon: Icon(Icons.wb_sunny),
                label: Text("Inspire Me"))
          ],
        )
      ),
    );
  }

  _showQuote() {
    //increment counter by 1
    setState(() {
      _index++;
    });

  }
}

class BizCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BizCard"),
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade100,
      ),
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topCenter ,
          children: <Widget>[
            _getCard(),
            _getAvatar()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
            BottomNavigationBarItem(icon: Icon(Icons.account_circle),title: Text("Account")),
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit),title: Text("Ac Unit")),
            BottomNavigationBarItem(icon: Icon(Icons.add_comment),title: Text("Comment")),
          ],
          onTap: (int index) => debugPrint("Tapped item: $index"),
          backgroundColor: Colors.redAccent.shade100,
      ),
    );
  }

  Container _getCard() {
    return Container(
      width:350,
      height: 200,
      margin: EdgeInsets.all(50.0),
      decoration: BoxDecoration(
        color: Colors.redAccent.shade100,
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Namita Vinod",
          style: TextStyle(fontSize: 21.0,
          color: Colors.indigo,
          fontWeight: FontWeight.w500)),
          Text("jfbruhui@gkjrh.com"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.person_outline),
              Text("T: @kjfejkker")
            ],
          )
        ],
      ) ,
    );
  }

  Container _getAvatar() {
    return Container(
      width:100,
      height:100,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        border: Border.all(color: Colors.white,width: 1.2),
        image: DecorationImage(image: NetworkImage("https://picsum.photos/300/300"),
              fit: BoxFit.cover)
      ),
    );
  }
}


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
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightGreenAccent.shade700,
          child: Icon(Icons.android),
          onPressed: () => debugPrint("Developer Settings Tapped")),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.account_circle),title: Text("Account")),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit),title: Text("Ac Unit")),
        BottomNavigationBarItem(icon: Icon(Icons.add_comment),title: Text("Comment")),
      ],onTap: (int index) => debugPrint("Tapped item: $index"),) ,
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