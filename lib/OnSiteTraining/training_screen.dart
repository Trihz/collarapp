// ignore_for_file: non_constant_identifier_names, unnecessary_const, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';

import 'package:collarapp/Modes/mode_selection.dart';
import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  Color mainColor = Colors.orange;
  Color mainColor2 = Color.fromARGB(24, 255, 153, 0);

  String selectedCollar = "Old Yeller";

  int value = 0;
  bool bluetoothON = false;

  bool isLoading = false;

  /// BLE OBJECT
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  BluetoothConnection? connection;

  /// BLE VARIABLES
  List<BluetoothDevice> bluetoothDevices = [];
  String addressToConnectTo = "";

  /// connection status  boolean
  bool connectionStatus = false;

  /// ENABLE
  void enableBluetooth() {
    bluetooth.requestEnable();
  }

  /// SCAN
  Future<void> scanDevices() async {
    try {
      bluetoothDevices = await bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    for (int x = 0; x < bluetoothDevices.length; x++) {
      print(bluetoothDevices[x].address);
      print(bluetoothDevices[x].name);
      print("");
    }
  }

  /// CONNECT
  void bluetoothConnect(String addressToConnectTo) async {
    try {
      connection = await BluetoothConnection.toAddress(addressToConnectTo);
      print('Connected to the device');
    } catch (exception) {
      print('Cannot connect, exception occured');
    }
  }

  /// SEND
  void sendData() async {
    connection?.output.add(ascii.encode('Hello!'));
  }

  // TOP CONTAINER
  Widget topContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.41,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Stack(
        children: [EnableBluetooth(), scanAndConnnect()],
      ),
    );
  }

  /// ENABLE
  Widget EnableBluetooth() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 1,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.02),
      decoration: BoxDecoration(
          color: mainColor, borderRadius: BorderRadius.circular(0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.width * 1,
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.03),
              decoration: BoxDecoration(color: Colors.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ModeSelection())));
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 27,
                    ),
                  ),
                  Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 40,
                  ),
                ],
              )),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35,
            child: Icon(
              Icons.bluetooth,
              color: mainColor,
              size: 30,
            ),
          )
        ],
      ),
    );
  }

  /// SCAN AND CONNECT
  Widget scanAndConnnect() {
    return Positioned(
      bottom: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.05,
            left: MediaQuery.of(context).size.width * 0.05),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bluetooth",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        "Connection",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  AnimatedToggleSwitch<bool>.dual(
                    current: bluetoothON,
                    first: false,
                    second: true,
                    style: const ToggleStyle(
                      borderColor: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(66, 159, 159, 159),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    borderWidth: 5.0,
                    height: 30,
                    spacing: 0,
                    onChanged: ((value) {
                      setState(() {
                        bluetoothON = value;
                      });
                      if (bluetoothON == true) {}
                      print(bluetoothON);
                    }),
                    styleBuilder: (b) =>
                        ToggleStyle(indicatorColor: b ? mainColor : mainColor),
                    textBuilder: (value) => value
                        ? Center(child: Text('ON'))
                        : Center(child: Text('OFF')),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 142, 142, 142).withOpacity(0.3),
                        offset: const Offset(0, 2),
                        blurRadius: 3,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        "SCAN",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(Icons.cast_connected, color: Colors.orange),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 142, 142, 142).withOpacity(0.3),
                        offset: const Offset(0, 2),
                        blurRadius: 3,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        "CONNECT",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(Icons.bluetooth_connected, color: Colors.orange)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// CONNECTED
  Widget connectedDog() {
    return DropdownButtonHideUnderline(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.7,
            padding: const EdgeInsets.only(left: 20, right: 20),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  offset: const Offset(0, 2),
                  blurRadius: 3,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: DropdownButton<String>(
              value: selectedCollar,
              hint: Text("Select an Option"),
              iconEnabledColor: Colors.black,
              iconSize: 50,
              dropdownColor: Colors.white,
              items: <String>['Old Yeller', 'Old Yeller 2'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedCollar = newValue!;
                });
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              editCollarName(context);
            },
            child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.1,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: const Offset(0, 2),
                      blurRadius: 3,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                    child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ))),
          )
        ],
      ),
    );
  }

  /// TRAINING CONTAINER
  Widget trainingContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.17,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 1,
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Text(
              "Controls",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.11,
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(
                  color: mainColor2,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Shock",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.flash_on,
                      size: 35,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.11,
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(
                  color: mainColor2,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Vibration",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.vibration,
                      size: 35,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.11,
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(
                  color: mainColor2,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Beep",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.volume_up_outlined,
                      size: 35,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// CONNECT NEW COLLAR
  Widget connectNewCollar() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.7,
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.05,
          left: MediaQuery.of(context).size.width * 0.05),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.all(Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "NEW COLLAR",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
          Icon(
            Icons.add,
            color: Colors.white,
            size: 25,
          )
        ],
      ),
    );
  }

  /// SIGNAL STRENGTH
  Widget signalStrength() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 1,
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.05,
          left: MediaQuery.of(context).size.width * 0.05),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Text(
                "Signal Strength",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.03,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: LinearProgressIndicator(
                  value: 0.3,
                  color: Color.fromARGB(118, 255, 153, 0),
                  backgroundColor: Color.fromARGB(76, 255, 153, 0),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              Text("10%",
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 14,
                      fontWeight: FontWeight.w700))
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainColor,
      child: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: isLoading
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: const BoxDecoration(color: Colors.white),
                  child:
                      Center(child: SpinKitCircle(color: mainColor, size: 70)))
              : Column(
                  children: [
                    topContainer(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    connectedDog(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    trainingContainer(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    signalStrength(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    connectNewCollar(),
                  ],
                ),
        ),
      )),
    );
  }

  void editCollarName(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 1,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Text(
                          "Old name",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: TextField(
                          enabled: false,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: selectedCollar,
                            contentPadding: EdgeInsets.all(10.0),
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 145, 145, 145),
                                fontWeight: FontWeight.w300),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 145, 145, 145),
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 145, 145, 145),
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 145, 145, 145),
                                width: 1.0,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 145, 145, 145),
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Text(
                          "New name",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: const InputDecoration(
                            hintText: "",
                            contentPadding: EdgeInsets.all(10.0),
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 145, 145, 145),
                                fontWeight: FontWeight.w300),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 145, 145, 145),
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 145, 145, 145),
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 145, 145, 145),
                                width: 1.0,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 145, 145, 145),
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  ElevatedButton(
                      onPressed: (() {
                        Navigator.pop(context);
                        setState(() {
                          isLoading = true;
                        });
                        Future.delayed(Duration(seconds: 3), () {
                          setState(() {
                            isLoading = false;
                          });
                          showSnackBar("Successfully changed the collar name");
                        });
                      }),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white),
                      child: Text("CHANGE"))
                ],
              )),
        );
      },
    );
  }

  void showSnackBar(String snackbarMessage) {
    final snackBar = SnackBar(
      backgroundColor: mainColor,
      padding: const EdgeInsets.all(0),
      duration: const Duration(milliseconds: 1500),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 1,
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Center(
          child: Text(
            snackbarMessage,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15),
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
