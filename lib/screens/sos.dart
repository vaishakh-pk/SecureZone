import 'package:flutter/material.dart';
import 'package:securezone/screens/tabs.dart';
import 'package:securezone/widgets/styled_button.dart';

class SOSScreen extends StatelessWidget {
  const SOSScreen({super.key});

  customMessage()
  {

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: RadialGradient(center: Alignment.center, colors: [Colors.red,Colors.black]),
        backgroundColor: Color.fromARGB(255, 221, 31, 17),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('SOS',style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 100,fontWeight: FontWeight.bold, color: Colors.white),),
              Container(
                alignment: Alignment.center,
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.white)
                ),
                child: Text('06',style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.white),),
      
              ),
              SizedBox(height: 100,),
              // StyledButton(buttonContent: 'Custom Message', buttonFunc: customMessage()),
              // ElevatedButton(onPressed: (){}, child: Text('Custom Message')),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Sharp corners
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
                child: Text(
                  'Custom Message',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.black),
                )),
              SizedBox(height: 80,),
              // ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child: Text('Cancel')),
              ElevatedButton(
                
                onPressed: () {Navigator.of(context).pop();},
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Sharp corners
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
                child: Text(
                  'Cancel',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.black),
                )),
            ],
          ),
        ),
      ),
    );
  }
}