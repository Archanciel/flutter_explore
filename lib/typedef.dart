
typedef FfToExec = String Function(String);

void main() {
  execFunc(printStr);
  execTypedefFunc(FfToExec);
}

void printStr(String str) {
  print('printStr: $str');
}

void execFunc(void Function(String) funcToExec) {
  funcToExec('hello world');
}

void execTypedefFunc(FfToExec func) {
  func('Coucou');
}
