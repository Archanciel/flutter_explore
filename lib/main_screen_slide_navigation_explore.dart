import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/second':
            return PageTransition(
              child: SecondPage(),
              type: PageTransitionType.scale,
              settings: settings,
            );
            break;
          default:
            return null;
        }
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Page Transition'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Fade Second Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: SecondPage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Left To Right Slide Second Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: SecondPage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Right To Left Slide Second Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: SecondPage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Size Slide Second Page'),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        alignment: Alignment.bottomCenter,
                        curve: Curves.bounceOut,
                        type: PageTransitionType.size,
                        child: SecondPage()));
              },
            ),
            ElevatedButton(
              child: Text('Rotate Slide Second Page'),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        curve: Curves.bounceOut,
                        type: PageTransitionType.rotate,
                        alignment: Alignment.topCenter,
                        child: SecondPage()));
              },
            ),
            ElevatedButton(
              child: Text('Scale Slide Second Page'),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        curve: Curves.linear,
                        type: PageTransitionType.scale,
                        alignment: Alignment.topCenter,
                        child: SecondPage()));
              },
            ),
            ElevatedButton(
              child: Text('Up to Down Second Page'),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        curve: Curves.linear,
                        type: PageTransitionType.topToBottom,
                        child: SecondPage()));
              },
            ),
            ElevatedButton(
              child: Text('Down to Up Second Page'),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        curve: Curves.linear,
                        type: PageTransitionType.bottomToTop,
                        child: SecondPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Transition Plugin"),
      ),
      body: Center(
        child: Text('Second Page'),
      ),
    );
  }
}