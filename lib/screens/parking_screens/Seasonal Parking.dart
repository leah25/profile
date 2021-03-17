import 'package:flutter/material.dart';

class SeasonalParking extends StatefulWidget {
  @override
  _SeasonalParkingState createState() => _SeasonalParkingState();
}

class _SeasonalParkingState extends State<SeasonalParking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            Text(
              'Seasonal Parking',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30.0, fontWeight: FontWeight.w700),
            ),

            SizedBox(height: 20),
            Text(
              'Vehicles Number Plate',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 18.0, fontWeight: FontWeight.w500),
            ),

            TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  labelText: 'Enter Vehicle Number Plate'

              ),
            ),
            SizedBox(height: 20),
            Text(
              'Vehicle Type',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  labelText: '-Select Vehicle Type-'

              ),
            ),
            // Provide Vehicle Type Details
            SizedBox(height: 20),
            Text(
              'Parking Duration',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  labelText: '-Select Parking Duration-'
//provide  Parking Duration details
              ),
            ),



            SizedBox(height: 30),
            new Center(
              child: new ElevatedButton(
                onPressed: () => print("to be implemented"),
                child: new Text("Add Vehicle"),
              ),
            ),



          ],
        ),

      ),
    );
  }
}
