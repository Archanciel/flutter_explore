import 'dart:math';

import 'package:flutter/material.dart';

class CompoundInterestCalculator extends StatefulWidget {
  @override
  _CompoundInterestCalculatorState createState() =>
      _CompoundInterestCalculatorState();
}

class _CompoundInterestCalculatorState
    extends State<CompoundInterestCalculator> {
  double _principal = 0;
  double _rate = 0;
  int _time = 0;
  double _result = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculateur d\'intérêts composés'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Principal'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer un nombre valide';
                }
                return null;
              },
              onSaved: (value) => _principal = double.parse(value!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Taux'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer un nombre valide';
                }
                return null;
              },
              onSaved: (value) => _rate = double.parse(value!) / 100,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Durée (en années)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer un nombre valide';
                }
                return null;
              },
              onSaved: (value) => _time = int.parse(value!),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  setState(() {
                    _result = _principal * pow(1 + _rate, _time);
                    _result = (_result * 100).round() / 100;
                  });
                }
              },
              child: Text('Calculer'),
            ),
            Text('Montant final : $_result'),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CompoundInterestCalculator(),
  ));
}
