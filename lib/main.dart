// main.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  double? _bmi;

  String _message = 'Introduceti înălțimea și masa';

  void _calculate() {
    final double? height = double.tryParse(_heightController.value.text);
    final double? weight = double.tryParse(_weightController.value.text);

    // Check if the inputs are valid
    if (height == null || height <= 0 || weight == null || weight <= 0) {
      setState(() {
        _message = "Introduceti înălțimea și masa";
      });
      return;
    }

    setState(() {
      _bmi = weight / (height * height);
      if (_bmi! < 18.5) {
        _message = "Esti SLAB";
      } else if (_bmi! < 25) {
        _message = 'Esti OK';
      } else if (_bmi! < 30) {
        _message = 'Esti GRAS';
      } else {
        _message = 'Esti SUPER GRAS';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.indigoAccent, Colors.purple],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 320,
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  gradient: LinearGradient(
                    colors: [Colors.white24, Colors.white24],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        maxLength: 4,
                        keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                        textAlign: TextAlign.center,
                        decoration:
                        const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Înălțimea (m)'
                        ),
                        controller: _heightController,
                      ),
                      TextField(
                        maxLength: 3,
                        keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Masa (kg)',
                        ),
                        controller: _weightController,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                  )
                              )
                          ),
                          onPressed: _calculate,
                          child: const Text('Calculare'),
                        ),
                      ),
                      Text(
                        _bmi == null ? 'Rezultat:' : _bmi!.toStringAsFixed(2),
                        style: const TextStyle(fontSize: 50),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        _message,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
