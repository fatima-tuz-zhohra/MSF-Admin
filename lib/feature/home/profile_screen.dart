import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_project_template/common/data/model/profile_data.dart';
import 'package:flutter_project_template/common/data/services/database.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    final theme = Theme.of(context);

    return Container(
      child: StreamBuilder<Profile>(
        stream: DatabaseService(uid: firebaseUser?.uid ?? '')
            .getUserDataStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final profile = snapshot.requireData;
            return _createProfileView(context, profile);
          } else {
            return Container();
          }
        },
      ),
    );
  }


  Widget _createProfileView (BuildContext context, Profile profile) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 120,
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              theme.colorScheme.primary,
              Color(0xff80cbc4),
            ]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('assets/images/profile.jpg'),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(profile.name),
              SizedBox(height: 2,),
              Text(profile.phoneNo),
            ],
          ),
        ],
      ),
    );
  }
}