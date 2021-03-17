import 'package:flutter/material.dart';

class ParkingStatus extends StatefulWidget {
  @override
  _ParkingStatusState createState() => _ParkingStatusState();
}

class _ParkingStatusState extends State<ParkingStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),
            Text(
              ' Parking Status',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30.0, fontWeight: FontWeight.w700),
            ),

            SizedBox(height: 30),
            Text(
              'Enter The Vehicle Number Plate first to check whether it has any outstanding penalties',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 30),
            Text(
              'Vehicles Number Plate',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.w500),
            ),

            TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  labelText: 'Enter Plate Number'

              ),
            ),
            SizedBox(height: 40),
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