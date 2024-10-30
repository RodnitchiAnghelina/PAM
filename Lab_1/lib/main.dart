import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrencyConverter(),
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  // Rata de schimb valutar între MDL și USD
  final double exchangeRate = 17.65;

  // Controlere pentru valorile introduse
  final TextEditingController mdlController = TextEditingController();
  final TextEditingController usdController = TextEditingController();

  // Funcție pentru conversia MDL în USD
  void _convertMDLtoUSD(String mdlValue) {
    if (mdlValue.isNotEmpty) {
      double mdl = double.tryParse(mdlValue) ?? 0;
      double usd = mdl / exchangeRate;
      usdController.text = usd.toStringAsFixed(2);
    } else {
      usdController.clear();
    }
  }

  // Funcție pentru conversia USD în MDL
  void _convertUSDtoMDL(String usdValue) {
    if (usdValue.isNotEmpty) {
      double usd = double.tryParse(usdValue) ?? 0;
      double mdl = usd * exchangeRate;
      mdlController.text = mdl.toStringAsFixed(2);
    } else {
      mdlController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40),
            Text(
              'Currency Converter',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            // Blocul de conversie MDL -> USD
            Row(
              children: [
                Expanded(
                  child: _buildCurrencyField(
                    controller: mdlController,
                    label: 'MDL',
                    flag: '🇲🇩',
                    onChanged: _convertMDLtoUSD,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Săgeată de schimb valutar
            Center(
              child: Icon(
                Icons.swap_vert,
                size: 40,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            // Blocul de conversie USD -> MDL
            Row(
              children: [
                Expanded(
                  child: _buildCurrencyField(
                    controller: usdController,
                    label: 'USD',
                    flag: '🇺🇸',
                    onChanged: _convertUSDtoMDL,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            // Afișarea ratei de schimb
            Center(
              child: Text(
                'Indicative Exchange Rate',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                '1 USD = $exchangeRate MDL',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget personalizat pentru câmpul valutar
  Widget _buildCurrencyField({
    required TextEditingController controller,
    required String label,
    required String flag,
    required Function(String) onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 14.0, left: 10.0),
          child: Text(
            flag,
            style: TextStyle(fontSize: 24),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      onChanged: onChanged,
    );
  }
}