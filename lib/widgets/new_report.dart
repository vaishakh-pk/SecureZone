// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:securezone/screens/tabs.dart';


class NewReport extends StatelessWidget {
  const NewReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),

      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'New Report',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
        
            // Enter Title
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: knavbarselected,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, labelText: 'Enter title'),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
        
            //Category
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: knavbarselected,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DropdownButton<String>(
                padding: EdgeInsets.only(left: 20),
                borderRadius: BorderRadius.zero,
                value:
                    'Choose Type', // This should match one of the DropdownMenuItem's value
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                      child: Text('Choose Type'), value: 'Choose Type'),
                  DropdownMenuItem(child: Text('Type 1'), value: 'Type 1'),
                  DropdownMenuItem(child: Text('Type 2'), value: 'Type 2'),
                  DropdownMenuItem(child: Text('Type 3'), value: 'Type 3'),
                  DropdownMenuItem(child: Text('Type 4'), value: 'Type 4'),
                ],
                onChanged: (value) {
                  // Your code to handle changes
                  print(value); // For example, print the selected value
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //Enter Body
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: knavbarselected,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, labelText: 'Enter title'),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
        
            //Enter URL
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: knavbarselected,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, labelText: 'Enter URL'),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Sharp corners
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(knavbartheme)),
                child: Text(
                  'Submit',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
