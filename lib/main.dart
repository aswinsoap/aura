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
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Switch Sample')),
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
        SwitchListTile(
          title: const Text('Light 1'),
          value: light1,
          onChanged: (bool value) {
            setState(() {
              light1 = value;
            });
            updateLight1State(value);
          },
        ),
        SwitchListTile(
          title: const Text('Light 2'),
          value: light2,
          onChanged: (bool value) {
            setState(() {
              light2 = value;
            });
            updateLight2State(value);
          },
        ),
        
        SwitchListTile(
          title: const Text('Fan'),
          value: fan,
          onChanged: (bool value) {
            setState(() {
              fan = value;
            });
            updateFanState(value);
          },
        ),
      ],
    );
  }
}