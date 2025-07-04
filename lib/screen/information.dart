import 'package:farm_iot/screen/page1.dart';
import 'package:farm_iot/screen/page2.dart';
import 'package:farm_iot/screen/page3.dart';
import 'package:farm_iot/screen/page4.dart';
import 'package:farm_iot/screen/page5.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Informations extends StatefulWidget {
  const Informations({Key? key}) : super(key: key);

  @override
  State<Informations> createState() => _InformationsState();
}

class _InformationsState extends State<Informations> {
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  var soil_moisture = '',
      temperature = '',
      time_chick = '',
      time_fish = '',
      lux = '',
      vol = '',
      humidity = '',
      status_vegetable = '',
      status_mushroom = '',
      status_chicken = '',
      status_fish = '',
      status_light = '',
      starth = '',
      startm = '',
      stoph = '',
      stopm = '';

  bool _pump_veg = false,
      _auto_veg = false,
      _pump_mush = false,
      _auto_mush = false,
      _pump_chic = false,
      _auto_chic = false,
      _pump_fish = false,
      _auto_fish = false,
      _pump_light = false,
      _auto_light = false;

  @override
  void initState() {
    super.initState();
    getdata_soil();
    getdata_humidity();
    getdatatime_chick();
    getdatatime_fish();
    getdata_auto_vegetable();
    getdata_pump_vegetable();
    getdata_auto_mushroom();
    getdata_pump_mushroom();
    getdata_auto_chicken();
    getdata_pump_chicken();
    getdata_auto_fish();
    getdata_pump_fish();
    getdata_auto_light();
    getdata_pump_light();
    getdata_starth();
    getdata_startm();
    getdata_stoph();
    getdata_stopm();
    getdata_light();
  }

  void getdata_auto_vegetable() {
    databaseRef.child('farmapp/vegetable/auto').onValue.listen((event) {
      final Object? getdata_pump = event.snapshot.value;
      if (getdata_pump == true) {
        setState(() {
          _auto_veg = true;
          status_vegetable = "ON";
        });
      } else {
        setState(() {
          _auto_veg = false;
          status_vegetable = "OFF";
        });
      }
    });
  }

  void getdata_pump_vegetable() {
    databaseRef.child('farmapp/vegetable/pumpn').onValue.listen((event) {
      final Object? getdata_pump = event.snapshot.value;
      if (getdata_pump == true) {
        setState(() {
          _pump_veg = true;
        });
      } else {
        setState(() {
          _pump_veg = false;
        });
      }
    });
  }

  void getdata_auto_mushroom() {
    databaseRef.child('farmapp/mushroom/auto').onValue.listen((event) {
      final Object? getdata_pump = event.snapshot.value;
      if (getdata_pump == true) {
        setState(() {
          _auto_mush = true;
          status_mushroom = "ON";
        });
      } else {
        setState(() {
          _auto_mush = false;
          status_mushroom = "OFF";
        });
      }
    });
  }

  void getdata_pump_mushroom() {
    databaseRef.child('farmapp/mushroom/pumpn').onValue.listen((event) {
      final Object? getdata_pump = event.snapshot.value;
      if (getdata_pump == true) {
        setState(() {
          _pump_mush = true;
        });
      } else {
        setState(() {
          _pump_mush = false;
        });
      }
    });
  }

  void getdata_auto_chicken() {
    databaseRef.child('farmapp/chicken/auto').onValue.listen((event) {
      final Object? getdata_pump = event.snapshot.value;
      if (getdata_pump == true) {
        setState(() {
          _auto_chic = true;
          status_chicken = "ON";
        });
      } else {
        setState(() {
          _auto_chic = false;
          status_chicken = "OFF";
        });
      }
    });
  }

  void getdata_pump_chicken() {
    databaseRef.child('farmapp/chicken/pumpn').onValue.listen((event) {
      final Object? getdata_pump = event.snapshot.value;
      if (getdata_pump == true) {
        setState(() {
          _pump_chic = true;
        });
      } else {
        setState(() {
          _pump_chic = false;
        });
      }
    });
  }

  void getdata_auto_fish() {
    databaseRef.child('farmapp/fish/auto').onValue.listen((event) {
      final Object? getdata_pump = event.snapshot.value;
      if (getdata_pump == true) {
        setState(() {
          _auto_fish = true;
          status_fish = "ON";
        });
      } else {
        setState(() {
          _auto_fish = false;
          status_fish = "OFF";
        });
      }
    });
  }

  void getdata_pump_fish() {
    databaseRef.child('farmapp/fish/pumpn').onValue.listen((event) {
      final Object? getdata_pump = event.snapshot.value;
      if (getdata_pump == true) {
        setState(() {
          _pump_fish = true;
        });
      } else {
        setState(() {
          _pump_fish = false;
        });
      }
    });
  }

  void getdata_auto_light() {
    databaseRef.child('farmapp/light/auto').onValue.listen((event) {
      final Object? getdata_pump = event.snapshot.value;
      if (getdata_pump == true) {
        setState(() {
          _auto_light = true;
          status_light = "ON";
        });
      } else {
        setState(() {
          _auto_light = false;
          status_light = "OFF";
        });
      }
    });
  }

  void getdata_pump_light() {
    databaseRef.child('farmapp/light/pumpn').onValue.listen((event) {
      final Object? getdata_pump = event.snapshot.value;
      if (getdata_pump == true) {
        setState(() {
          _pump_light = true;
        });
      } else {
        setState(() {
          _pump_light = false;
        });
      }
    });
  }

  void getdata_starth() {
    databaseRef.child('farmapp/vegetable/starth').onValue.listen((event) {
      final Object? getdata_soil = event.snapshot.value;
      setState(() {
        starth = '$getdata_soil';
      });
    });
  }

  void getdata_startm() {
    databaseRef.child('farmapp/vegetable/startm').onValue.listen((event) {
      final Object? getdata_soil = event.snapshot.value;
      setState(() {
        startm = '$getdata_soil';
      });
    });
  }

  void getdata_stoph() {
    databaseRef.child('farmapp/vegetable/stoph').onValue.listen((event) {
      final Object? getdata_soil = event.snapshot.value;
      setState(() {
        stoph = '$getdata_soil';
      });
    });
  }

  void getdata_stopm() {
    databaseRef.child('farmapp/vegetable/stopm').onValue.listen((event) {
      final Object? getdata_soil = event.snapshot.value;
      setState(() {
        stopm = '$getdata_soil';
      });
    });
  }

  void getdata_soil() {
    databaseRef.child('farmapp/vegetable/setsoil').onValue.listen((event) {
      final Object? getdata_soil = event.snapshot.value;
      setState(() {
        soil_moisture = '$getdata_soil';
      });
    });
  }

  void getdata_humidity() {
    databaseRef.child('farmapp/mushroom/sethum').onValue.listen((event) {
      final Object? getdata_humidity = event.snapshot.value;
      setState(() {
        humidity = '$getdata_humidity';
      });
    });
  }

  void getdatatime_chick() {
    databaseRef.child('farmapp/chicken/times').onValue.listen((event) {
      final Object? getdata = event.snapshot.value;
      setState(() {
        time_chick = '$getdata';
      });
    });
  }

  void getdatatime_fish() {
    databaseRef.child('farmapp/fish/times').onValue.listen((event) {
      final Object? getdata = event.snapshot.value;
      setState(() {
        time_fish = '$getdata';
      });
    });
  }

  void getdata_light() {
    databaseRef.child('farmapp/light/setlux').onValue.listen((event) {
      final Object? getdata = event.snapshot.value;
      setState(() {
        lux = '$getdata';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ข้อมูลระบบเกษตรอัจฉริยะ',
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Column(
            children: [
              Container(
                width: 500,
                height: 230,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 63, 226, 31),
                      Color.fromARGB(255, 247, 226, 110)
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onDoubleTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Page1(
                                auto_veg: _auto_veg,
                                pump_veg: _pump_veg,
                              ),
                            ));
                      },
                      splashColor: Color.fromARGB(255, 177, 202, 163),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ListTile(
                            leading: Image.asset('image/app_image/veg.png'),
                            title: Text(
                              'ระบบแปลงผัก',
                              style: TextStyle(fontSize: 30),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                          ListTile(
                            title: Text(
                              'ความชื้นในดินที่ตั้งค่า : $soil_moisture',
                              style: TextStyle(fontSize: 20),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                          ListTile(
                            title: Text(
                              'เวลาเปิด: ${starth.toString().padLeft(2, '0')} : ${startm.toString().padLeft(2, '0')} และ เวลาปิด : ${stoph.toString().padLeft(2, '0')} : ${stopm.toString().padLeft(2, '0')}',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 20),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                          ListTile(
                            title: Text(
                              'ระบบอัตโนมัติ : $status_vegetable',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 20),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 500,
                height: 230,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 5, 124, 31),
                      Color.fromARGB(255, 247, 226, 110)
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onDoubleTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Page2(
                                  pump_mush: _pump_mush, auto_mush: _auto_mush),
                            ));
                      },
                      splashColor: Color.fromARGB(255, 135, 190, 163),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ListTile(
                            leading:
                                Image.asset('image/app_image/mushroom.png'),
                            title: Text(
                              'ระบบโรงเพาะเห็ด',
                              style: TextStyle(fontSize: 30),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                          ListTile(
                            title: Text(
                              'ความชื้นที่ตั้งค่า : $humidity',
                              style: TextStyle(fontSize: 20),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                          ListTile(
                            title: Text(
                              'ระบบอัตโนมัติ : $status_mushroom',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 20),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 500,
                height: 230,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 226, 20, 20),
                      Color.fromARGB(255, 247, 226, 110)
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onDoubleTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Page3(
                                  pump_chic: _pump_chic, auto_chic: _auto_chic),
                            ));
                      },
                      splashColor: Color.fromARGB(255, 135, 190, 163),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ListTile(
                            leading: Image.asset('image/app_image/chicken.png'),
                            title: Text(
                              'ระบบโรงเลี้ยงไก่',
                              style: TextStyle(fontSize: 30),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                          ListTile(
                            title: Text(
                              'ระยะเวลาการให้อาหาร : $time_chick วินาที',
                              style: TextStyle(fontSize: 20),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                          ListTile(
                            title: Text(
                              'ระบบอัตโนมัติ : $status_chicken',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 20),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 500,
                height: 230,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 50, 53, 230),
                      Color.fromARGB(255, 247, 226, 110)
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onDoubleTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Page4(
                                  pump_fish: _pump_fish, auto_fish: _auto_fish),
                            ));
                      },
                      splashColor: Color.fromARGB(255, 135, 190, 163),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ListTile(
                            leading: Image.asset('image/app_image/fish.png'),
                            title: Text(
                              'ระบบบ่อเลี้ยงปลา',
                              style: TextStyle(fontSize: 30),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                          ListTile(
                            title: Text(
                              'ระยะเวลาการให้อาหาร : $time_fish วินาที',
                              style: TextStyle(fontSize: 20),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                          ListTile(
                            title: Text(
                              'ระบบอัตโนมัติ : $status_fish',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 20),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 500,
                height: 230,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 247, 241, 46),
                      Color.fromARGB(255, 249, 150, 101)
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onDoubleTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Page5(
                                  pump_light: _pump_light,
                                  auto_light: _auto_light),
                            ));
                      },
                      splashColor: Color.fromARGB(255, 190, 172, 135),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ListTile(
                            leading: Image.asset('image/app_image/led.png'),
                            title: Text(
                              'ระบบแสงสว่าง',
                              style: TextStyle(fontSize: 30),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                          ListTile(
                            title: Text(
                              'ค่าแสงที่ตั้งค่า : $lux Lux',
                              style: TextStyle(fontSize: 20),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                          ListTile(
                            title: Text(
                              'ระบบอัตโนมัติ : $status_light',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 20),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
