// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BluetoothConnection extends StatefulWidget {
  const BluetoothConnection({super.key});

  @override
  State<BluetoothConnection> createState() => _BluetoothConnectionState();
}

class _BluetoothConnectionState extends State<BluetoothConnection> {
  /// Enable Bluetooth Container
  Widget EnableBluetooth() {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: const Offset(0, 2),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  "Bluetooth Connection",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Icon(
                  Icons.bluetooth,
                  size: 25,
                )
              ],
            ),
            ElevatedButton(
                onPressed: (() {}),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black),
                child: const Text("ENABLE",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w700)))
          ],
        ),
      ),
    );
  }

  /// Scan and Connect
  Widget scanAndConnnect() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                "SCAN",
                style: TextStyle(color: Colors.black, fontSize: 11),
              ),
            ),
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                "CONNECT",
                style: TextStyle(color: Colors.black, fontSize: 11),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EnableBluetooth(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            scanAndConnnect()
          ],
        ),
      )),
    );
  }
}
