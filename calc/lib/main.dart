import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String expression = "";   // Shows 8*8
  String result = "0";      // Shows final result

  void pressButton(String value) {
    setState(() {
      if (value == "C") {
        expression = "";
        result = "0";
      } 
      else if (value == "=") {
        try {
          // Replace symbols if needed
          String finalExp = expression;

          // Use Dart to calculate result
          result = _calculate(finalExp).toString();
        } catch (e) {
          result = "Error";
        }
      } 
      else {
        // Add to expression
        expression += value;
      }
    });
  }

  // Simple calculator logic
  double _calculate(String exp) {
    // Replace × and ÷ if used
    exp = exp.replaceAll("×", "*").replaceAll("÷", "/");

    List<String> operators = [];
    List<double> numbers = [];

    String currentNumber = "";

    for (int i = 0; i < exp.length; i++) {
      String ch = exp[i];

      if ("+-*/".contains(ch)) {
        numbers.add(double.parse(currentNumber));
        operators.add(ch);
        currentNumber = "";
      } else {
        currentNumber += ch;
      }
    }

    numbers.add(double.parse(currentNumber));

    // Handle * and /
    for (int i = 0; i < operators.length; i++) {
      if (operators[i] == "*") {
        numbers[i] = numbers[i] * numbers[i + 1];
        numbers.removeAt(i + 1);
        operators.removeAt(i);
        i--;
      } else if (operators[i] == "/") {
        numbers[i] = numbers[i] / numbers[i + 1];
        numbers.removeAt(i + 1);
        operators.removeAt(i);
        i--;
      }
    }

    // Handle + and -
    for (int i = 0; i < operators.length; i++) {
      if (operators[i] == "+") {
        numbers[i] = numbers[i] + numbers[i + 1];
        numbers.removeAt(i + 1);
        operators.removeAt(i);
        i--;
      } else if (operators[i] == "-") {
        numbers[i] = numbers[i] - numbers[i + 1];
        numbers.removeAt(i + 1);
        operators.removeAt(i);
        i--;
      }
    }

    return numbers[0];
  }

  Widget button(String text, {Color? color}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => pressButton(text),
        child: Container(
          height: 70,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color ?? Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Expression (8*8)
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              expression,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 32,
              ),
            ),
          ),

          // Result
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20, bottom: 40),
            child: Text(
              result,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Row(
            children: [
              button("7"),
              button("8"),
              button("9"),
              button("/", color: Colors.orange),
            ],
          ),
          Row(
            children: [
              button("4"),
              button("5"),
              button("6"),
              button("*", color: Colors.orange),
            ],
          ),
          Row(
            children: [
              button("1"),
              button("2"),
              button("3"),
              button("-", color: Colors.orange),
            ],
          ),
          Row(
            children: [
              button("C", color: Colors.red),
              button("0"),
              button("=", color: Colors.green),
              button("+", color: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}
