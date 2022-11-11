import 'package:flutter/material.dart';
import 'package:insagramclone/screens/add_post_screen.dart';
import 'package:insagramclone/screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Text('search'),
  AddPost(),
  Text('notifications'),
  Text('profile'),
];
