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
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the GridView
        child: GridView.count(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 16.0, // Add spacing between the cards horizontally
          mainAxisSpacing: 16.0, // Add spacing between the cards vertically
          children: List.generate(4, (index) {
            return CardWidget(index: index); // Pass index to create different colors
          }),
        ),
      ),
    );
  }
}

class CardWidget extends StatefulWidget {
  final int index;

  const CardWidget({super.key, required this.index});

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool isSwitched = false;

  // Define a list of pastel colors
  final List<Color> pastelColors = [
    Colors.pink[100]!,
    Colors.blue[100]!,
    Colors.green[100]!,
    Colors.orange[100]!,
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0), // Increase the radius to make it more rounded  
      ),
      color: pastelColors[widget.index % pastelColors.length], // Assign different color based on index
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
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                    // Handle switch state changes
                    // Here you can implement the logic for switch state changes
                  },
                  activeColor: Colors.grey[900],
                  activeTrackColor: Colors.grey[200],
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