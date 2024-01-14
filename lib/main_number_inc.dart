import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              padding: const EdgeInsets.all(12),
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Default appearance'),
                const Example1(key: Key('')),
                const Text('Setting minimum value -2 and maximum value 3'),
                const Example2(key: Key('')),
                const Divider(key: Key('')),
                const Text('Using double values with incDecFactor=0.35'),
                const Example3(key: Key('')),
                const Text('Prefabbed widget: Squared Blue Buttons'),
                NumberInputPrefabbed.squaredButtons(
                  controller: TextEditingController(),
                  incDecBgColor: Colors.blue,
                ),
                const Text('PrefabbKed widget: Leafy Icons'),
                NumberInputPrefabbed.leafyButtons(
                  controller: TextEditingController(),
                ),
                const Text('Prefabbed widget: Directional Icons'),
                NumberInputPrefabbed.directionalButtons(
                  controller: TextEditingController(),
                ),
                const Text('Prefabbed widget: RoundEdged Icons'),
                NumberInputPrefabbed.roundedEdgeButtons(
                  controller: TextEditingController(),
                ),
                const Text('Prefabbed widget: Squared Green Icons'),
                NumberInputPrefabbed.squaredButtons(
                  controller: TextEditingController(),
                  incDecBgColor: Colors.green,
                ),
                const Text('Both buttons positioned at right side'),
                NumberInputPrefabbed.roundedButtons(
                  controller: TextEditingController(),
                  incDecBgColor: Colors.amber,
                  buttonArrangement: ButtonArrangement.rightEnd,
                ),
                const Text('Both buttons positioned at left side'),
                NumberInputPrefabbed.roundedButtons(
                  controller: TextEditingController(),
                  incDecBgColor: Colors.amber,
                  buttonArrangement: ButtonArrangement.leftEnd,
                ),
                const Text('Increment left Decrement right'),
                NumberInputPrefabbed.roundedButtons(
                  controller: TextEditingController(),
                  incDecBgColor: Colors.blueAccent,
                  buttonArrangement: ButtonArrangement.incLeftDecRight,
                ),
                const Text('Increment right Decrement left'),
                NumberInputPrefabbed.roundedButtons(
                  controller: TextEditingController(),
                  incDecBgColor: Colors.blueAccent,
                  buttonArrangement: ButtonArrangement.incRightDecLeft,
                ),
                const Text('With initial Value as 5'),
                const Example4(key: Key('')),
                const Text('Different border decoration'),
                const Example5(key: Key('')),
                const Text('Different icons & form field decoration'),
                const Example6(key: Key('')),
                const Text('Height scaled to 0.75'),
                const Example7(key: Key('')),
                const Text('Width scaled to 0.75'),
                const Example8(key: Key('')),
                const Text('Customized Icon shape and size.'),
                const Example9(key: Key('')),
                const Text('Passing callbacks onIncrment and onDecrement'),
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
                const Text('Disable the field.'),
                NumberInputWithIncrementDecrement(
                  controller: TextEditingController(),
                  enabled: false,
                ),
                const Text('Change style of editable text.'),
                NumberInputWithIncrementDecrement(
                  controller: TextEditingController(),
                  style: const TextStyle(
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
      numberFieldDecoration: const InputDecoration(
        border: InputBorder.none,
      ),
      widgetContainerDecoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10)
        ),
        border: Border.all(
          color: Colors.amber,
          width: 2,
        )
      ),
      incIconDecoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
        ),
      ),
      separateIcons: true,
      decIconDecoration: const BoxDecoration(
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
          borderSide: const BorderSide(color: Colors.orange, width: 2.0),
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