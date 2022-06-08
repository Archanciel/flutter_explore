import 'package:flutter/material.dart';

/*
These are the sample list for demo
 */
List<ItemVO> mainList = [];
List<ItemVO> sampleMenList = [
  ItemVO("1", "Mens 1"),
  ItemVO("2", "Mens 2"),
  ItemVO("3", "Mens 3")
];
List<ItemVO> sampleWomenList = [
  ItemVO("1", "Women 1"),
  ItemVO("2", "Women 2"),
  ItemVO("3", "Women 3")
];
List<ItemVO> sampleKidsList = [
  ItemVO("1", "kids 1"),
  ItemVO("2", "kids 2"),
  ItemVO("3", "kids 3")
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title of Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TestScreen(),
    );
  }
}

class TestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestScreen();
  }
}

class _TestScreen extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
    mainList.addAll(sampleMenList);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          ListView.builder(
            itemBuilder: (BuildContext context, index) {
              return getCard(index);
            },
            itemCount: mainList.length,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    mainList.clear();
                    setState(() {
                      mainList.addAll(sampleMenList);
                    });
                  },
                  heroTag: "btn1",
                  child: Text("Mens"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    mainList.clear();
                    setState(() {
                      mainList.addAll(sampleWomenList);
                    });
                  },
                  heroTag: "btn2",
                  child: Text("Women"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    mainList.clear();
                    setState(() {
                      mainList.addAll(sampleKidsList);
                    });
                  },
                  heroTag: "btn3",
                  child: Text("Kids"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*
    Get the card item for a list
   */
  getCard(int position) {
    ItemVO model = mainList[position];
    return Card(
      child: Container(
        height: 50,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "ID:: "+model._id,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            Padding(padding: EdgeInsets.only(left: 5,right: 5)),
            Text(
              "Name:: "+model._name,
              style: TextStyle(fontSize: 18, color: Colors.black),
            )
          ],
        ),
      ),
      margin: EdgeInsets.all(10),
    );
  }
}

/*
Custom model
i.e. for itemList
 */
class ItemVO {
  String _id, _name;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }

  ItemVO(this._id, this._name);
}