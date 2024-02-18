import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Card Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Card Example'),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Number of columns in the grid
        children: List.generate(4, (index) {
          return const CardWidget();
        }),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      color: Colors.pink[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Light',
                  style: TextStyle(fontSize: 18.0),
                ),
                Switch(
                  value: false,
                  onChanged: (value) {
                    // Handle switch state changes
                  },
                ),
              ],
            ),
            // Add additional content below if needed
          ],
        ),
      ),
    );
  }
}

