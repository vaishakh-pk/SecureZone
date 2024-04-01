import 'package:flutter/material.dart';
import 'package:securezone/screens/tabs.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({super.key, required this.buttonContent, required this.buttonFunc});

  final String buttonContent;
  final Function() buttonFunc;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                onPressed: (){buttonFunc;},
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Sharp corners
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(knavbartheme)),
                child: Text(
                  buttonContent,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ));
  }
}