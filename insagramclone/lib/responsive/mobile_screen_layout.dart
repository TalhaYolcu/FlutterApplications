import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insagramclone/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:insagramclone/models/user.dart' as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
  }

  void getUsername() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (documentSnapshot.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(child: Text('This is mobile, ${user?.email}')),
    );
  }
}