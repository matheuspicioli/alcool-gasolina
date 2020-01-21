import 'package:alcool_gasolina/widgets/success.dart';
import 'package:flutter/material.dart';
import 'package:alcool_gasolina/widgets/logo.dart';
import 'package:alcool_gasolina/widgets/submit-form.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _color = Colors.deepPurple;
  var _gasCtrl = new MoneyMaskedTextController();
  var _alcCtrl = new MoneyMaskedTextController();
  var _busy = false;
  var _completed = false;
  var _resultText = "Compensa utilizar álcool";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AnimatedContainer(
        duration: Duration(
          milliseconds: 1200,
        ),
        color: _color,
        child: ListView(
          children: <Widget>[
            Logo(),
            _completed
                ? Success(
                    reset: reset,
                    result: _resultText,
                  )
                : SubmitForm(
                    alcCtrl: _alcCtrl,
                    gasCtrl: _gasCtrl,
                    submitFunc: calculate,
                    busy: _busy,
                  ),
          ],
        ),
      ),
    );
  }

  Future calculate() {
    double alc =
        double.parse(_alcCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) / 100;
    double gas =
        double.parse(_gasCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) / 100;

    if (alc == 0.0 || gas == 0.0)
      return new Future.delayed(new Duration(seconds: 0));
    double result = alc / gas;

    print("Álcool: ${alc}");
    print("Gasolina: ${gas}");
    print("Resultado: ${result}");

    setState(() {
      _color = Colors.deepPurpleAccent;
      _completed = false;
      _busy = true;
    });

    return new Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (result >= 0.7) {
          _resultText = "Compensa utilizar gasolina!";
        } else {
          _resultText = "Compensa utilizar gasolina!";
        }

        _busy = false;
        _completed = true;
      });
    });
  }

  reset() {
    setState(() {
      _alcCtrl = new MoneyMaskedTextController();
      _gasCtrl = new MoneyMaskedTextController();
      _completed = false;
      _busy = false;
      _color = Theme.of(context).primaryColor;
    });
  }
}
