// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:securezone/screens/tabs.dart';
import 'package:securezone/services/DBServices.dart';


class NewReport extends StatefulWidget {
  const NewReport({super.key});

  @override
  State<NewReport> createState() => _NewReportState();
}

String _dropdownValue = "Other";
DateTime _selectedDate = DateTime(DateTime.now().year);
TextEditingController _titleController = TextEditingController();
TextEditingController _descriptionController = TextEditingController();
TextEditingController _typeController = TextEditingController();
TextEditingController _yearController = TextEditingController();
TextEditingController _urlController = TextEditingController();
TextEditingController _locationController = TextEditingController();

class _NewReportState extends State<NewReport> {
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
                    controller: _titleController,
                    decoration: InputDecoration(
                        border: InputBorder.none, labelText: 'Enter title'),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            //Enter Description
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: knavbarselected,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Enter Description'),
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
                elevation: 0,
                value:
                    _dropdownValue, // This should match one of the DropdownMenuItem's value
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                      child: Text('Accident prone area'),
                      value: 'Accident prone area'),
                  DropdownMenuItem(
                      child: Text('Natural Disaster'),
                      value: 'Natural Disaster'),
                  DropdownMenuItem(child: Text('Theft'), value: 'Theft'),
                  DropdownMenuItem(
                      child: Text('Pickpocketing'), value: 'Pickpocketing'),
                  DropdownMenuItem(child: Text('Assault'), value: 'Assault'),
                  DropdownMenuItem(child: Text('Murder'), value: 'Murder'),
                  DropdownMenuItem(child: Text('Other'), value: 'Other'),
                ],
                onChanged: (value) {
                  // Your code to handle changes
                  _typeController.text = value.toString();
                  setState(() {
                    _dropdownValue = value.toString();
                  });
                  print(value); // For example, print the selected value
                },
              ),
            ),
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
                    controller: _urlController,
                    decoration: InputDecoration(
                        border: InputBorder.none, labelText: 'Enter URL'),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Select Year"),
                      content: Container(
                        width: 300,
                        height: 300,
                        child: YearPicker(
                          firstDate: DateTime(DateTime.now().year - 100),
                          lastDate: DateTime(DateTime.now().year),
                          selectedDate: _selectedDate,
                          onChanged: (DateTime dateTime) {
                            setState(() {
                              _selectedDate = dateTime;
                              _yearController.text =
                                  _selectedDate.year.toString();
                            });
                            Navigator.pop(context);
                            // Do something with the dateTime selected.
                            // Remember that you need to use dateTime.year to get the year
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: knavbarselected,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    'Selected year : ${_selectedDate.year.toString()}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 15, color: Theme.of(context).hintColor),
                  )),
            ),
            SizedBox(
              height: 10,
            ),


            //Location Picker
            
            ElevatedButton(
                onPressed: () async {
                  await DBFunctions.addNewReport(
                      _titleController,
                      _descriptionController,
                      _typeController,
                      _yearController,
                      _urlController,
                      _locationController);

                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Sharp corners
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
