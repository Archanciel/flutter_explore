import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title of Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final Widget _myContacts = const MyContacts();
  final Widget _myEmails = const MyEmails();
  final Widget _myProfile = const MyProfile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BottomNavigationBar Example"),
      ),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: "Contacts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: "Emails",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          )
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }

  Widget getBody() {
    if (_selectedIndex == 0) {
      return _myContacts;
    } else if (_selectedIndex == 1) {
      return _myEmails;
    } else {
      return _myProfile;
    }
  }

  void onTapHandler(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class MyContacts extends StatelessWidget {
  const MyContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const Align(
        alignment: Alignment.center,
        child: Text("Contacts"),
      ),
      Positioned(
        right: 10,
        bottom: 10,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Reset')
        ),
      ),
    ]);
  }
}

class MyEmails extends StatelessWidget {
  const MyEmails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Emails"));
  }
}

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Profile"));
  }
}
