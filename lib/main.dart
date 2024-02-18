import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:aura/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aura Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aura Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '$temperature°C',
                  style: const TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w300,
                    fontSize: 36.0,
                  ),
                ),
                Text(
                  '$humidity%',
                  style: const TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w300,
                    fontSize: 36.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: List.generate(4, (index) {
                  return CardWidget(
                    index: index,
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardWidget extends StatefulWidget {
  final int index;

  const CardWidget({
    super.key,
    required this.index,
  });

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool isSwitched = false;

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
      borderRadius: BorderRadius.circular(30.0),
    ),
    color: pastelColors[widget.index % pastelColors.length],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Light',
                style: TextStyle(fontSize: 18.0), 
              ),
              Switch(
                value: false,
                onChanged: null,
                activeColor: Colors.grey[900],
                activeTrackColor: Colors.grey[200],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}
