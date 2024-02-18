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
      ],
    );
  }
}
