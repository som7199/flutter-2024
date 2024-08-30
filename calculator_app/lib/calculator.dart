import 'package:calculator_app/circle_button.dart';
import 'package:flutter/material.dart';

// 매번 사용자가 숫자를 입력하고 연산을 해야하므로
// 당연히 상태 변화가 자주 발생할 것이기 때문에
// Stateful 위젯 사용
class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
// 사용자가 버튼 클릭을 하지 않았을 경우 값을 전달 받지 않음
// 따라서 nullable 변수 사용!
  int? firstOperand;
  String? operator;
  int? secondOperand;
  dynamic result;

  void numberTapped(int tappedNumber) {
    if (firstOperand == null) {
      setState(() {
        firstOperand = tappedNumber;
      });
      return;
    }

    if (operator == null) {
      setState(() {
        // String 타입을 int형으로 바꿈
        firstOperand = int.parse("$firstOperand$tappedNumber");
      });
      return;
    }

    if (secondOperand == null) {
      setState(() {
        secondOperand = tappedNumber;
      });
      return;
    }

    // 사용자가 첫 번째 숫자와 연산 기호를 입력했으니 두 번째 숫자 입력!
    setState(() {
      secondOperand = int.parse("$secondOperand$tappedNumber");
    });
    return;
  }

  void clearNumber() {
    setState(() {
      firstOperand = null;
      operator = null;
      secondOperand = null;
      result = null;
    });
  }

  void operatorTapped(String tappedOperator) {
    setState(() {
      operator = tappedOperator;
    });
  }

  String showText() {
    if (result != null) {
      return "$result";
    }

    if (secondOperand != null) {
      return "$firstOperand$operator$secondOperand";
    }

    if (operator != null) {
      return "$firstOperand$operator";
    }

    if (firstOperand != null) {
      return "$firstOperand";
    }

    return "0";
  }

  void calculateResult() {
    if (firstOperand == null || secondOperand == null) {
      return;
    }

    if (operator == "+") {
      plusNumber();
      return;
    }

    if (operator == "-") {
      minusNumber();
      return;
    }

    if (operator == "×") {
      multiplyNumber();
      return;
    }

    if (operator == "÷") {
      divideNumber();
      return;
    }
  }

  void plusNumber() {
    // 상태 변화를 위해 setState()
    setState(() {
      // ! 붙은 이유 > 연산을 위해서는 null 값이 되면 안 되기 때문
      result = firstOperand! + secondOperand!;
    });
  }

  void minusNumber() {
    setState(() {
      result = firstOperand! - secondOperand!;
    });
  }

  void multiplyNumber() {
    setState(() {
      result = firstOperand! * secondOperand!;
    });
  }

  void divideNumber() {
    setState(() {
      result = firstOperand! / secondOperand!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // 앱바의 드롭쉐도우 효과 제거
        elevation: 0,
        title: Align(
          // 앱바 우측 상단에 입력 숫자 및 연산 기호 배치
          alignment: Alignment.bottomRight,
          child: Text(showText(), style: const TextStyle(color: Colors.white)),
        ),
      ),
      // Column 위젯은 자식 위젯을 세로로 배치
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            // 7, 8, 9는 가로로 배치 > Row 위젯 사용
            Row(children: [
              // Expanded 위젯 > Column or Row 위젯 내의
              // 자식 위젯들의 최대한의 공간 차지 가능해짐
              /*
                 * CircleButton 버튼 위젯을 불러올 때
                 * padNumber 속성에는 각 키패드에 맞는 숫자 전달
                 * onTap 속성에는 람다식을 사용해 
                 * numberTapped 메서드 or operatorTapped 메서드, 각각의 매개변수 전달
                 */
              CircleButton(padNumber: "7", onTap: () => numberTapped(7)),
              CircleButton(padNumber: "8", onTap: () => numberTapped(8)),
              CircleButton(padNumber: "9", onTap: () => numberTapped(9)),
              CircleButton(padNumber: "÷", onTap: () => operatorTapped("÷")),
            ]),
            const SizedBox(
              height: 25,
            ),
            Row(children: [
              CircleButton(padNumber: "4", onTap: () => numberTapped(4)),
              CircleButton(padNumber: "5", onTap: () => numberTapped(5)),
              CircleButton(padNumber: "6", onTap: () => numberTapped(6)),
              CircleButton(padNumber: "×", onTap: () => operatorTapped("×")),
            ]),
            const SizedBox(
              height: 25,
            ),
            Row(children: [
              CircleButton(padNumber: "1", onTap: () => numberTapped(1)),
              CircleButton(padNumber: "2", onTap: () => numberTapped(2)),
              CircleButton(padNumber: "3", onTap: () => numberTapped(3)),
              CircleButton(padNumber: "-", onTap: () => operatorTapped("-")),
            ]),
            const SizedBox(
              height: 25,
            ),
            Row(children: [
              /*
               * Clear 버튼과 Equal 버튼은
               * clearNumber 메서드, calculateResult 메서드는 매개변수를 가지지 않음
               * onTap 속성에 람다식을 사용해서 전달해도 되지만, 
               * void Function 타입이므로 메서드명만 전달해줘도 됨! 
               */
              CircleButton(
                padNumber: "C",
                onTap: clearNumber,
                color: Colors.black,
              ),
              CircleButton(padNumber: "0", onTap: () => numberTapped(0)),
              CircleButton(
                padNumber: "=",
                onTap: calculateResult,
                color: Colors.black,
              ),
              CircleButton(padNumber: "+", onTap: () => operatorTapped("+")),
            ]),
          ],
        ),
      ),
    );
  }
}
