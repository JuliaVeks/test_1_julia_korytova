
import 'package:flutter/material.dart';
import 'api_service.dart';

class ExchangeRateScreen extends StatefulWidget {
  const ExchangeRateScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ExchangeRateScreenState createState() => _ExchangeRateScreenState();
}

class _ExchangeRateScreenState extends State<ExchangeRateScreen> {
  Map<String, dynamic> exchangeData = {};
  final TextEditingController _currencyPairController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchExchangeRates();
  }

  Future<void> _fetchExchangeRates() async {
    try {
      var data = await ApiService.fetchExchangeRates();
      setState(() {
        exchangeData = data['rates'];
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _fetchCustomExchangeRate(String currencyPair) async {
    try {
      var data = await ApiService.fetchCustomExchangeRates(currencyPair);
      setState(() {
        exchangeData = data['rates'];
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exchange Rates'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchExchangeRates,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _currencyPairController,
              decoration: const InputDecoration(
                labelText: "Enter currency pair (e.g., USD-EUR)",
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _fetchCustomExchangeRate(_currencyPairController.text);
              },
              child: const Text('Get Exchange Rate'),
            ),
            const SizedBox(height: 20),
            Text(
              'Current EUR to USD exchange rate: ${exchangeData['USD']}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Current USD to EUR exchange rate: ${1 / exchangeData['USD']}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
