

// ignore_for_file: avoid_print

class MyClass {
  final double _d;

  MyClass(double d) : _d = d;

  void exec() {
    _privateMethod();
  }

  void _privateMethod() {
    print('MyClass _privateMethod $_d');
  }
}

class MySubClass extends MyClass {
  MySubClass(double d) : super(d);

  @override
  void _privateMethod() {
    print('MySubClass _privateMethod');
  }
}

// class MyViewModel extends ChangeNotifier {
//   late MyClass _myClass;

//   MyClass get myClass => _myClass;

//   void execute() {
//     double d = _complexButFastMethod();

//     _verySlowMethod(d);
//     notifyListeners();
//   }

//   double _complexButFastMethod() {
//     return 0.1;
//   }

//   // method to be implemented by mockito class
//   void _verySlowMethod(double d) {
//     _myClass = MyClass(d);
//   }
// }

void main(List<String> args) {
  MySubClass sub = MySubClass(5.7);

  sub.exec();
}
