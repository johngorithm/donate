import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_state/screens/donation_screen.dart';
import 'model/donation.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<Donation>(
      model: Donation(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Scoped Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DonationScreen(),
      ),
    );
  }
}

