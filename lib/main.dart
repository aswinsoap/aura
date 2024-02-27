import 'package:aura/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SwitchApp());
}

void updateLight1State(bool value) {
  FirebaseDatabase.instance.ref().child('light1').set(value);
}

void updateLight2State(bool value) {
  FirebaseDatabase.instance.ref().child('light2').set(value);
}

void updateFanState(bool value) {
  FirebaseDatabase.instance.ref().child('fan').set(value);
}

class SwitchApp extends StatelessWidget {
  const SwitchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Aura Home',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: const [],
        ),
        body: const Center(
          child: SwitchExample(),
        ),
      ),
    );
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light1 = false;
  bool light2 = false;
  bool fan = false;
  double temperature = 0.0;
  double humidity = 0.0;
  late DatabaseReference _temperatureRef;
  late DatabaseReference _humidityRef;

  @override
  void initState() {
    super.initState();
    _temperatureRef = FirebaseDatabase.instance.ref().child('temperature');
    _temperatureRef.onValue.listen((event) {
      setState(() {
        temperature = double.tryParse(event.snapshot.value.toString()) ?? 0.0;
      });
    });

    _humidityRef = FirebaseDatabase.instance.ref().child('humidity');
    _humidityRef.onValue.listen((event) {
      setState(() {
        humidity = double.tryParse(event.snapshot.value.toString()) ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    _temperatureRef.onDisconnect();
    _humidityRef.onDisconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 120.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                '$temperature°C',
                style: const TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w300,
                  fontSize: 56.0,
                ),
              ),
              Text(
                '$humidity%',
                style: const TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w300,
                  fontSize: 56.0,
                ),
              ),
            ],
          ),
        ),
       Padding(
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
      ],
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