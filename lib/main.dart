import 'package:flutter/material.dart';
import 'package:circle_wheel_scroll/circle_wheel_scroll_view.dart';

dynamic hour;
dynamic min;
dynamic dayNight;
List<String> myList = List<String>();

listPrint(int a, int b, int c) {
  if (c == 0 && b < 10) {
    String str = a.toString() + ":" + "0" + b.toString() + " " + "AM" + "\n";
    myList.add(str);
  }
  if (c == 0 && b >= 10) {
    String str = a.toString() + ":" + b.toString() + " " + "AM" + "\n";
    myList.add(str);
  }
  if (c == 1 && b < 10) {
    String str = a.toString() + ":" + "0" + b.toString() + " " + "PM" + "\n";
    myList.add(str);
  }
  if (c == 1 && b >= 10) {
    String str = a.toString() + ":" + b.toString() + " " + "PM" + "\n";
    myList.add(str);
  }
}

class Hour extends StatelessWidget {
  Widget _hour(int i) {
    return Center(
      child: Text(
        (i + 1).toString(),
        style: new TextStyle(
          fontSize: 30,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: CircleListScrollView(
              physics: CircleFixedExtentScrollPhysics(),
              axis: Axis.horizontal,
              itemExtent: 60,
              children: List.generate(12, _hour),
              radius: MediaQuery.of(context).size.width * 0.5,
              onSelectedItemChanged: (int index) => hour = (index + 1),
            ),
          ),
        ),
      ),
    );
  }
}

class Minute extends StatelessWidget {
  Widget _minute(int i) {
    if (i < 10) {
      return Center(
          child: Text(
            '0' + i.toString(),
            style: new TextStyle(
              fontSize: 27,
            ),
          ));
    } else {
      return Center(
          child: Text(
            i.toString(),
            style: new TextStyle(
              fontSize: 27,
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: CircleListScrollView(
              physics: CircleFixedExtentScrollPhysics(),
              axis: Axis.horizontal,
              itemExtent: 60,
              children: List.generate(60, _minute),
              radius: MediaQuery.of(context).size.width * 0.4,
              onSelectedItemChanged: (int index) => min = index,
            ),
          ),
        ),
      ),
    );
  }
}

class DayNight extends StatelessWidget {
  Widget _dayNight(int i) {
    if (i == 0) {
      return Center(
          child: Text(
            ('AM').toString(),
            style: new TextStyle(
              fontSize: 23,
            ),
          ));
    } else {
      return Center(
          child: Text(
            ('PM').toString(),
            style: new TextStyle(
              fontSize: 23,
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: CircleListScrollView(
              physics: CircleFixedExtentScrollPhysics(),
              axis: Axis.horizontal,
              itemExtent: 60,
              children: List.generate(2, _dayNight),
              radius: MediaQuery.of(context).size.width * 0.3,
              onSelectedItemChanged: (int index) => dayNight = index,
            ),
          ),
        ),
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 100.0,
            height: 80.0,
            child: RaisedButton(
              child: Text(
                'SAVE',
                style: new TextStyle(
                  fontSize: 25,
                ),
              ),
              onPressed: () {
                listPrint(hour, min, dayNight);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListPage()),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Times'),
      ),
      body: ListView.builder(
        itemCount: myList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            child: Center(
                child: Text(
                  myList[index],
                  style: new TextStyle(
                    fontSize: 20,
                  ),
                )),
          );
        },
      ),
    );
  }
}

class TimeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Stamp Saver'),
      ),
      body: Align(
        alignment: Alignment.topRight,
        child: RaisedButton(
          child: Text('List'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListPage()),
            ); // Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Column(
        children: <Widget>[
          Flexible(
            flex: 3,
            child: TimeList(),
          ),
          Flexible(
            flex: 5,
            child: Hour(),
          ),
          Flexible(
            flex: 5,
            child: Minute(),
          ),
          Flexible(
            flex: 2,
            child: DayNight(),
          ),
          Flexible(
            flex: 2,
            child: SaveButton(),
          )
        ],
      ),
    );
  }
}

void main() => runApp(MyApp());
