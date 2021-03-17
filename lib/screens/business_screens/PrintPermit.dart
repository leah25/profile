import 'package:flutter/material.dart';

class PrintPermit extends StatefulWidget {
  @override
  _PrintPermitState createState() => _PrintPermitState();
}

class _PrintPermitState extends State<PrintPermit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(

        child: Column(

          children: <Widget>[
            SizedBox(height: 30),
            Text(
              'Print Permit',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30.0, fontWeight: FontWeight.w700),
            ),

            SizedBox(height: 30),
            Text(
              'Enter the business number to continue with renewalProcess',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 30),
            Text(
              'Business Number',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.w400),
            ),

            TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  labelText: 'Enter Business Number'

              ),
            ),
            SizedBox(height: 30),
            new Center(
              child: new ElevatedButton(
                onPressed: () => print("to be implemented"),
                child: new Text("CHECK STATUS"),
              ),
            ),



          ],
        ),

      ),
    );
  }

}
