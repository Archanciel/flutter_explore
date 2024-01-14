import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/second':
            return PageTransition(
              child: const SecondPage(),
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
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Page Transition'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Fade Second Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const SecondPage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Left To Right Slide Second Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: const SecondPage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Right To Left Slide Second Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const SecondPage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Size Slide Second Page'),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        alignment: Alignment.bottomCenter,
                        curve: Curves.bounceOut,
                        type: PageTransitionType.size,
                        child: const SecondPage()));
              },
            ),
            ElevatedButton(
              child: const Text('Rotate Slide Second Page'),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        curve: Curves.bounceOut,
                        type: PageTransitionType.rotate,
                        alignment: Alignment.topCenter,
                        child: const SecondPage()));
              },
            ),
            ElevatedButton(
              child: const Text('Scale Slide Second Page'),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        curve: Curves.linear,
                        type: PageTransitionType.scale,
                        alignment: Alignment.topCenter,
                        child: const SecondPage()));
              },
            ),
            ElevatedButton(
              child: const Text('Up to Down Second Page'),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        curve: Curves.linear,
                        type: PageTransitionType.topToBottom,
                        child: const SecondPage()));
              },
            ),
            ElevatedButton(
              child: const Text('Down to Up Second Page'),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        curve: Curves.linear,
                        type: PageTransitionType.bottomToTop,
                        child: const SecondPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page Transition Plugin"),
      ),
      body: const Center(
        child: Text('Second Page'),
      ),
    );
  }
}