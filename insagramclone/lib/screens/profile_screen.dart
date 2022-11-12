import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insagramclone/utils/colors.dart';
import 'package:insagramclone/utils/utils.dart';
import 'package:insagramclone/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int follower_count = 0;
  int following_count = 0;
  bool isFollowing = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      userData = userSnap.data()!;

      //get post length
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLen = postSnap.docs.length;

      follower_count = userSnap.data()!['followers'].length;
      following_count = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);

      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(
            userData['username'] == null ? 'username' : userData['username']),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(userData['photoUrl'] == null
                          ? "https://petapixel.com/assets/uploads/2022/07/DALLEcopy.jpg"
                          : userData['photoUrl']),
                      radius: 40,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildStatColumn(postLen, "posts"),
                              buildStatColumn(follower_count, "followers"),
                              buildStatColumn(following_count, "following"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FirebaseAuth.instance.currentUser!.uid ==
                                      widget.uid
                                  ? FollowButton(
                                      backGroundColor: mobileBackgroundColor,
                                      borderColor: Colors.grey,
                                      text: 'Edit Profile',
                                      textColor: primaryColor,
                                      function: () {},
                                    )
                                  : isFollowing
                                      ? FollowButton(
                                          backGroundColor: Colors.white,
                                          borderColor: Colors.grey,
                                          text: 'Unfollow',
                                          textColor: Colors.black,
                                          function: () {},
                                        )
                                      : FollowButton(
                                          backGroundColor: Colors.blue,
                                          borderColor: Colors.blue,
                                          text: 'Follow',
                                          textColor: Colors.white,
                                          function: () {}),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    userData['username'] == null
                        ? 'username'
                        : userData['username'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    userData['bio'] == null ? 'bio' : userData['bio'],
                  ),
                ),
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
