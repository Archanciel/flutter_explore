import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 1.1,
              fontSizeDelta: 2.0,
            ),
      ),
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: ListView(
              padding: EdgeInsets.all(12),
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Default appearance'),
                Example1(key: Key('')),
                Text('Setting minimum value -2 and maximum value 3'),
                Example2(key: Key('')),
                Divider(key: Key('')),
                Text('Using double values with incDecFactor=0.35'),
                Example3(key: Key('')),
                Text('Prefabbed widget: Squared Blue Buttons'),
                NumberInputPrefabbed.squaredButtons(
                  controller: TextEditingController(),
                  incDecBgColor: Colors.blue,
                ),
                Text('PrefabbKed widget: Leafy Icons'),
                NumberInputPrefabbed.leafyButtons(
                  controller: TextEditingController(),
                ),
                Text('Prefabbed widget: Directional Icons'),
                NumberInputPrefabbed.directionalButtons(
                  controller: TextEditingController(),
                ),
                Text('Prefabbed widget: RoundEdged Icons'),
                NumberInputPrefabbed.roundedEdgeButtons(
                  controller: TextEditingController(),
                ),
                Text('Prefabbed widget: Squared Green Icons'),
                NumberInputPrefabbed.squaredButtons(
                  controller: TextEditingController(),
                  incDecBgColor: Colors.green,
                ),
                Text('Both buttons positioned at right side'),
                NumberInputPrefabbed.roundedButtons(
                  controller: TextEditingController(),
                  incDecBgColor: Colors.amber,
                  buttonArrangement: ButtonArrangement.rightEnd,
                ),
                Text('Both buttons positioned at left side'),
                NumberInputPrefabbed.roundedButtons(
                  controller: TextEditingController(),
                  incDecBgColor: Colors.amber,
                  buttonArrangement: ButtonArrangement.leftEnd,
                ),
                Text('Increment left Decrement right'),
                NumberInputPrefabbed.roundedButtons(
                  controller: TextEditingController(),
                  incDecBgColor: Colors.blueAccent,
                  buttonArrangement: ButtonArrangement.incLeftDecRight,
                ),
                Text('Increment right Decrement left'),
                NumberInputPrefabbed.roundedButtons(
                  controller: TextEditingController(),
                  incDecBgColor: Colors.blueAccent,
                  buttonArrangement: ButtonArrangement.incRightDecLeft,
                ),
                Text('With initial Value as 5'),
                Example4(key: Key('')),
                Text('Different border decoration'),
                Example5(key: Key('')),
                Text('Different icons & form field decoration'),
                Example6(key: Key('')),
                Text('Height scaled to 0.75'),
                Example7(key: Key('')),
                Text('Width scaled to 0.75'),
                Example8(key: Key('')),
                Text('Customized Icon shape and size.'),
                Example9(key: Key('')),
                Text('Passing callbacks onIncrment and onDecrement'),
                NumberInputWithIncrementDecrement(
                  controller: TextEditingController(),
                  onIncrement: (num newlyIncrementedValue) {
                    print('Newly incrmented value is $newlyIncrementedValue');
                  },
                  onDecrement: (num newlyDecrementedValue) {
                    print(
                        'Newly decremented value is $newlyDecrementedValue');
                  },
                ),
                Text('Disable the field.'),
                NumberInputWithIncrementDecrement(
                  controller: TextEditingController(),
                  enabled: false,
                ),
                Text('Change style of editable text.'),
                NumberInputWithIncrementDecrement(
                  controller: TextEditingController(),
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 32,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Example9 extends StatelessWidget {
  const Example9({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      decIconColor: Colors.teal,
      incIconColor: Colors.teal,
      controller: TextEditingController(),
      numberFieldDecoration: InputDecoration(
        border: InputBorder.none,
      ),
      widgetContainerDecoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10)
        ),
        border: Border.all(
          color: Colors.amber,
          width: 2,
        )
      ),
      incIconDecoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
        ),
      ),
      separateIcons: true,
      decIconDecoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
        ),
      ),
      incIconSize: 28,
      decIconSize: 28,
      incIcon: Icons.plus_one,
      decIcon: Icons.exposure_neg_1,
    );
  }
}

class Example7 extends StatelessWidget {
  const Example7({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      controller: TextEditingController(),
      scaleHeight: 0.75,
      incIcon: Icons.plus_one,
      decIcon: Icons.exposure_neg_1,
    );
  }
}

class Example8 extends StatelessWidget {
  const Example8({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      controller: TextEditingController(),
      scaleWidth: 0.75,
      incIcon: Icons.plus_one,
      decIcon: Icons.exposure_neg_1,
    );
  }
}

class Example6 extends StatelessWidget {
  const Example6({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      controller: TextEditingController(),
      numberFieldDecoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.orange, width: 2.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      incIcon: Icons.plus_one,
      decIcon: Icons.exposure_neg_1,
    );
  }
}

class Example5 extends StatelessWidget {
  const Example5({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      controller: TextEditingController(),
      widgetContainerDecoration: BoxDecoration(
        border: Border.all(
          color: Colors.pink,
        ),
      ),
    );
  }
}

class Example4 extends StatelessWidget {
  const Example4({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      controller: TextEditingController(),
      initialValue: 5,
    );
  }
}

class Example3 extends StatelessWidget {
  const Example3({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      controller: TextEditingController(),
      isInt: false,
      incDecFactor: 0.35,
    );
  }
}

class Example2 extends StatelessWidget {
  const Example2({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      controller: TextEditingController(),
      min: -2,
      max: 3,
    );
  }
}

class Example1 extends StatelessWidget {
  const Example1({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberInputWithIncrementDecrement(
      decIconColor: Colors.teal,
      incIconColor: Colors.teal,
      incDecBgColor: Colors.yellow,
      controller: TextEditingController(),
    );
  }
}