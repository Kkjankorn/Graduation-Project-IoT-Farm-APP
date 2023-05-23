import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class DataSnapshot {
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
}
