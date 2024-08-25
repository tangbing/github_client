
import 'package:flutter/material.dart';
import 'package:github_client_app/states/counter_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('detail page'),
      ),
      body: Center(
        child: ElevatedButton(onPressed: () {
             counter.increment();
        }, child: const Icon(Icons.add)),
      ),
    );
  }
}
