import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RatesPage extends StatefulWidget {
  final String apiKey;

  RatesPage({required this.apiKey});

  @override
  State<RatesPage> createState() => _RatesPageState();
}

class _RatesPageState extends State<RatesPage> {

  Map<String, dynamic> rates = {};
  bool loading = true;

  Future<void> fetchRates() async {

    String url =
        "https://v6.exchangerate-api.com/v6/${widget.apiKey}/latest/USD";

    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);

    setState(() {
      rates = data["conversion_rates"];
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("📊 Live Rates")),

      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: rates.entries.map((e) {
          return Card(
            child: ListTile(
              title: Text(e.key),
              trailing: Text(e.value.toString()),
            ),
          );
        }).toList(),
      ),
    );
  }
}