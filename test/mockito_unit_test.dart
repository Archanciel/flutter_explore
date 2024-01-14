import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

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

class MyViewModel extends ChangeNotifier {
  late MyClass _myClass;

  MyClass get myClass => _myClass;

  void execute() {
    double d = _complexButFastMethod();

    verySlowMethod(d);
    notifyListeners();
  }

  double _complexButFastMethod() {
    return 0.1;
  }

  // method to be implemented by mockito class
  void verySlowMethod(double d) {
    _myClass = MyClass(d);
  }
}

class MockMyViewModel extends Mock implements MyViewModel {
  @override
  void verySlowMethod(double d) {
    super.noSuchMethod(
      Invocation.method(#_verySlowMethod, [d]),
      returnValue: null,
      returnValueForMissingStub: null,
    );
  }
}

void main() {
  test('Test MyViewModel with mocked _verySlowMethod', () {
    final viewModel = MockMyViewModel();

    // You can now use `when()` to specify the behavior of the mocked _verySlowMethod
    when(viewModel.verySlowMethod(1.0)).thenAnswer((_) {}); // The argument type 'Null' can't be assigned to the parameter type 'double'

    viewModel.execute();

    // Verify that the _verySlowMethod was called with the expected value
    verify(viewModel.verySlowMethod(0.1)).called(1);
  });
}
