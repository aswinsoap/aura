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

// Update the state of "light1" in Firebase Realtime Database
void updateLight1State(bool value) {
  DatabaseReference light1Ref = FirebaseDatabase.instance.ref().child('light1');
  light1Ref.set(value);
}

// Update the state of "light2" in Firebase Realtime Database
void updateLight2State(bool value) {
  DatabaseReference light2Ref = FirebaseDatabase.instance.ref().child('light2');
  light2Ref.set(value);
}

// Update the state of "fan" in Firebase Realtime Database
void updateFanState(bool value) {
  DatabaseReference fanRef = FirebaseDatabase.instance.ref().child('fan');
  fanRef.set(value);
}

class SwitchApp extends StatelessWidget {
  const SwitchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Aura Home',style:TextStyle(fontWeight: FontWeight.bold),)),
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
  bool light1 = true;
  bool light2 = false;
  bool fan = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildCard('Light 1', light1, (value) {
          setState(() {
            light1 = value;
          });
          updateLight1State(value);
        }),
        buildCard('Light 2', light2, (value) {
          setState(() {
            light2 = value;
          });
          updateLight2State(value);
        }),
        buildCard('Fan', fan, (value) {
          setState(() {
            fan = value;
          });
          updateFanState(value);
        }),
      ],
    );
  }
  Widget buildCard(String title, bool value, Function(bool) onChanged) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth - 24.0;
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: cardWidth,
        height: 80.0, // Adjust the height as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}