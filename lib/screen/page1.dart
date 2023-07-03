// ignore_for_file: deprecated_member_use
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/services.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class Page1 extends StatefulWidget {
  final bool pump_veg, auto_veg;

  Page1({
    Key? key,
    required this.pump_veg,
    required this.auto_veg,
  }) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  TextEditingController moisture_text = TextEditingController();

  @override
  void dispose() {
    moisture_text.dispose();
    super.dispose();
  }

  TimeOfDay time = TimeOfDay.now();
  bool loading = false;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  String statuspump = '';
  var soil_moisture = ' ',
      temperature = '',
      vol = '',
      hours_in_start = '',
      minutes_in_start = '',
      hours_in_stop = '',
      minutes_in_stop = '',
      setsoil = '';

  int hours_out_start = 0,
      minutes_out_start = 0,
      hours_out_stop = 0,
      minutes_out_stop = 0,
      store_soil = 0;

  bool auto_veg = false, pump_veg = false, value = false, pump_button = false;

  void autoButton() {
    setState(() {
      auto_veg = !auto_veg;
      databaseRef.child('farmapp/vegetable').update({'auto': auto_veg});
      databaseRef.child('farmapp/vegetable').update({'pump': false});
      if (pump_veg == true) {
        setState(() {
          pump_button = false;
        });
      } else {
        pump_button = false;
      }
    });
  }

  void pumpButton() {
    setState(() {
      pump_veg = !pump_veg;
      databaseRef.child('farmapp/vegetable').update({'pump': pump_veg});
      if (pump_veg == true) {
        statuspump = 'ON';
      } else {
        statuspump = 'OFF';
      }
    });
  }

  void setdata_timer() {
    setState(() {
      value = true;
      if (moisture_text.text.isNotEmpty) {
        // pass
        store_soil = int.parse(moisture_text.text);
        databaseRef.child('farmapp/vegetable').update({'setsoil': store_soil});
      } else {
        // fail
      }
      databaseRef
          .child('farmapp/vegetable')
          .update({'starth': hours_out_start});
      databaseRef
          .child('farmapp/vegetable')
          .update({'startm': minutes_out_start});
      databaseRef.child('farmapp/vegetable').update({'stoph': hours_out_stop});
      databaseRef
          .child('farmapp/vegetable')
          .update({'stopm': minutes_out_stop});
      databaseRef.child('farmapp/vegetable').update({'value': value});
      Future.delayed(Duration(seconds: 5), () {
        databaseRef.child('farmapp/vegetable').update({'value': false});
        // code to be executed after 2 seconds
      });
      moisture_text.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    getdata();
    getdata_auto();
    getdata_pump();
    time_hours_start();
    time_minutes_start();
    time_hours_stop();
    time_minutes_stop();
    getdata_setsoil();
  }

  void getdata_setsoil() {
    databaseRef.child('farmapp/vegetable/setsoil').onValue.listen((event) {
      final Object? getdata_soil = event.snapshot.value;
      setState(() {
        setsoil = '$getdata_soil';
      });
    });
  }

  void getdata_auto() async {
    databaseRef.child('farmapp/vegetable/auto').onValue.listen((event) {
      final Object? getdataPump = event.snapshot.value;
      if (getdataPump == true) {
        setState(() {
          auto_veg = true;
        });
      } else {
        setState(() {
          auto_veg = false;
        });
      }
    });
  }

  void getdata_pump() async {
    databaseRef.child('farmapp/vegetable/pump').onValue.listen((event) {
      final Object? getdataPump = event.snapshot.value;
      if (getdataPump == true) {
        setState(() {
          pump_veg = true;
          statuspump = 'ON';
        });
      } else {
        setState(() {
          pump_veg = false;
          statuspump = 'OFF';
        });
      }
    });
  }

  void getdata() {
    databaseRef.child('farmapp/vegetable/soil').onValue.listen((event) {
      final Object? getdata = event.snapshot.value;
      setState(() {
        soil_moisture = '$getdata';
      });
    });
  }

  void time_hours_start() {
    databaseRef.child('farmapp/vegetable/starth').onValue.listen((event) {
      final Object? getdata = event.snapshot.value;
      setState(() {
        hours_in_start = '$getdata';
      });
    });
  }

  void time_minutes_start() {
    databaseRef.child('farmapp/vegetable/startm').onValue.listen((event) {
      final Object? getdata = event.snapshot.value;
      setState(() {
        minutes_in_start = '$getdata';
      });
    });
  }

  void time_hours_stop() {
    databaseRef.child('farmapp/vegetable/stoph').onValue.listen((event) {
      final Object? getdata = event.snapshot.value;
      setState(() {
        hours_in_stop = '$getdata';
      });
    });
  }

  void time_minutes_stop() {
    databaseRef.child('farmapp/vegetable/stopm').onValue.listen((event) {
      final Object? getdata = event.snapshot.value;
      setState(() {
        minutes_in_stop = '$getdata';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double a = double.parse(soil_moisture);
    return Scaffold(
        appBar: AppBar(
          title: const Text('ระบบแปลงผัก'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 50),
                        LiteRollingSwitch(
                          value: widget.auto_veg,
                          textOn: "ON",
                          textOff: "OFF",
                          colorOff: Colors.red,
                          colorOn: Colors.green,
                          iconOn: Icons.done,
                          iconOff: Icons.do_disturb_off_outlined,
                          textSize: 18,
                          onChanged: (statusPump) async {},
                          onDoubleTap: (bool positon) {},
                          onTap: () {
                            setState(() {
                              autoButton();
                            });
                          },
                          onSwipe: () {},
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 10.0),
                        Text(
                          'เปิด-ปิด ระบบอัตโนมัติ',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    SfRadialGauge(axes: <RadialAxis>[
                      RadialAxis(
                          minimum: 0,
                          maximum: 100,
                          interval: 10,
                          startAngle: 150,
                          endAngle: 30,
                          showTicks: false,
                          showLabels: false,
                          axisLineStyle: AxisLineStyle(thickness: 20),
                          pointers: <GaugePointer>[
                            RangePointer(
                                value: a,
                                width: 20,
                                color: Color.fromARGB(255, 14, 158, 14),
                                enableAnimation: true,
                                cornerStyle: CornerStyle.bothCurve)
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(100),
                                      child: Text(
                                        'ค่าความชื้นในดิน $soil_moisture %',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 29),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                                angle: 300,
                                positionFactor: 0.1)
                          ])
                    ]),
                    Text(
                      'การทำงานระบบ : $statuspump',
                      style: const TextStyle(
                          fontSize: 30.0,
                          color: Color.fromARGB(255, 214, 50, 44)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: !auto_veg,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: LiteRollingSwitch(
                        value: pump_button,
                        textOn: "ON",
                        textOff: "OFF",
                        colorOff: Colors.red,
                        colorOn: Colors.green,
                        iconOn: Icons.done,
                        iconOff: Icons.do_disturb_off_outlined,
                        textSize: 18,
                        onChanged: (statusPump) async {},
                        onDoubleTap: (bool positon) {},
                        onTap: () {
                          setState(() {
                            pumpButton();
                          });
                        },
                        onSwipe: (bool positon) {},
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 200,
                      child: TextFormField(
                        controller: moisture_text,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'กรอกค่าความชื้น',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: moisture_text.clear,
                            icon: Icon(Icons.clear),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2)
                        ], // Only numbers can be entered
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('ค่าความชื้นที่ผู้ใช้ตั้งค่า ${setsoil}'),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'เริ่มรดน้ำ ${hours_in_start.toString().padLeft(2, '0')} : ${minutes_in_start.toString().padLeft(2, '0')}',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 175, 55, 18)),
                        ),
                        Text(
                          'หยุดรดน้ำ ${hours_in_stop.toString().padLeft(2, '0')} : ${minutes_in_stop.toString().padLeft(2, '0')}',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 175, 55, 18)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TimePickerSpinner(
                          is24HourMode: true,
                          normalTextStyle: TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 70, 67, 65)),
                          highlightedTextStyle: TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 11, 182, 77)),
                          spacing: 20,
                          itemHeight: 40,
                          itemWidth: 40,
                          isForce2Digits: true,
                          onTimeChange: (time) {
                            setState(() {
                              hours_out_start = time.hour;
                              minutes_out_start = time.minute;
                            });
                          },
                        ),
                        TimePickerSpinner(
                          is24HourMode: true,
                          normalTextStyle: TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 70, 67, 65)),
                          highlightedTextStyle: TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 11, 182, 77)),
                          spacing: 20,
                          itemHeight: 40,
                          itemWidth: 40,
                          isForce2Digits: true,
                          onTimeChange: (time) {
                            setState(() {
                              hours_out_stop = time.hour;
                              minutes_out_stop = time.minute;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AnimatedButton(
                      color: Color.fromARGB(255, 57, 218, 65),
                      onPressed: setdata_timer,
                      enabled: true,
                      shadowDegree: ShadowDegree.light,
                      width: 150.0,
                      height: 50.0,
                      child: const Text(
                        'ตกลง',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )));
  }
}
