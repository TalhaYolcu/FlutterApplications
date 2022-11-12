import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insagramclone/screens/add_post_screen.dart';
import 'package:insagramclone/screens/feed_screen.dart';
import 'package:insagramclone/screens/profile_screen.dart';
import 'package:insagramclone/screens/search_screen.dart';

const webScreenSize = 600;

var homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPost(),
  Text('notifications'),
  ProfileScreen(
    uid: (FirebaseAuth.instance.currentUser!.uid),
  ),
];
