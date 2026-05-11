import 'package:flutter/material.dart';
import 'About_Page.dart';
import 'Rates_Page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController amountController = TextEditingController();

  String from = "USD";
  String to = "PKR";
  double result = 0;

  String apiKey = "0c06867a9105d49e10d4bc64";

  Future<void> convert() async {
    double amount = double.tryParse(amountController.text) ?? 0;

    String url =
        "https://v6.exchangerate-api.com/v6/$apiKey/latest/$from";

    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);

    double rate = data["conversion_rates"][to];

    setState(() {
      result = amount * rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("💱 Currency Converter"),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RatesPage(apiKey: apiKey)),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AboutPage()),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter Amount",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: DropdownButton<String>(
                    value: from,
                    isExpanded: true,
                    items: ["USD","PKR","EUR","INR","AED"].map((e){
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (v){
                      setState(() => from = v!);
                    },
                  ),
                ),

                Icon(Icons.swap_horiz),

                Expanded(
                  child: DropdownButton<String>(
                    value: to,
                    isExpanded: true,
                    items: ["USD","PKR","EUR","INR","AED"].map((e){
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (v){
                      setState(() => to = v!);
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: convert,
              child: Text("Convert"),
            ),

            SizedBox(height: 30),

            Text(
              "Result: ${result.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 26),
            ),
          ],
        ),
      ),
    );
  }
}