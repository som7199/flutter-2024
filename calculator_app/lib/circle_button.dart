import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  // 한 번 입력 받으면 바뀌면 안 되는 값이기 때문에 final 키워드 사용
  final String padNumber;
  final void Function() onTap;
  final Color? color; // 선택적으로 color 속성을 사용할 것이므로 nullable 타입!
  // CircleButton 위젯 생성시마다 생성자를 통해 입력 받을 수 있도록 생성자에 추가
  // 숫자는 반드시 입력받아야 하므로 required 키워드도 붙여줘야 함!
  const CircleButton({
    super.key,
    required this.padNumber,
    required this.onTap,
    this.color = const Color.fromARGB(221, 243, 76, 76),
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Ink 위젯 > 시각적인 장식을 위해 사용됨
      child: Ink(
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        // InkWell 위젯 > Tap | doubleTap 등 제스처 감지에 사용됨
        // 위젯 탭 시 시각적인 피드백 제공
        child: InkWell(
          customBorder: const CircleBorder(),
          /*
           * onPresssed 속성이나 onTap 속성은 항상 매개변수 없는 void callback 기대
           * 우리는 키패드를 누르면 그 키패드에 해당하는 숫자 출력을 위해
           * numberTapped 메서드를 생성해놓음.. (int형 매개변수 전달 받아야 함)
           * 플러터의 해결법 
           * {}를 사용한 익명함수나 람다식을 사용!!
           * 매개변수를 가진 함수를 onPressed 속성이나 onTap 속성에 전달해서
           * 이벤트 조건 충족 시 실행되게 해줄 수 있음!
           */
          onTap: onTap, // void Function 타입이기에 곧바로 전달 가능!
          child: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomCenter,
            child: Text(
              padNumber,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
