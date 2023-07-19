import 'package:farm_iot/colors/colors.dart';
import 'package:farm_iot/screen/information.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get Key => null;
  get titel => null;
  int currentIndex = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.backgoundColor,
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Image.asset(
              'image/app_image/homepage.png',
              height: 300,
              //take image assets
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'ระบบเกษตรอัจฉริยะ',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromARGB(164, 34, 15, 204), fontSize: 30),
          ),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
            height: 50,
            color: Color.fromARGB(255, 52, 123, 214),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Informations();
                },
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('เข้าสู่แอพพลิเคชัน ',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
