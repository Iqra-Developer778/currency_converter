import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ℹ️ About")),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            Icon(Icons.currency_exchange, size: 80),

            SizedBox(height: 20),

            Text(
              "Currency Converter App",
              style: TextStyle(fontSize: 24),
            ),

            SizedBox(height: 10),

            Text(
              "This app uses live currency API to fetch real-time exchange rates. "
                  "It demonstrates Flutter navigation, API integration, and UI design.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}