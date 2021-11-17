import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ErrorInfo extends StatelessWidget {
  final String message;
  const ErrorInfo({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/no-data.svg',
              width: MediaQuery.of(context).size.width * 0.80,
              height: MediaQuery.of(context).size.height * 0.50,
            ),
            Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
