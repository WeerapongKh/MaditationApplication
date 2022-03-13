// ignore_for_file: file_names
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:maditation/model/user.dart';
import 'package:maditation/page/editProfile.dart';
import 'package:maditation/utils/user_preferences.dart';
import 'package:maditation/widget/buttom_widget.dart';
import 'package:maditation/widget/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          //backgroundColor: Colors.pink.shade300,
          //appBar: buildAppbar(context),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 25,
              ),
              ProfileWidget(
                imagePath: user.imagePath,
                onClicked: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const EditProfileScreen()),
                  );
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 24,
              ),
              buildName(user),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: buildUpgradeButtom(),
              ),
              const SizedBox(
                height: 26,
              ),
              // Center(
              //   child: ss(),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          )
        ],
      );

  Widget buildUpgradeButtom() => ButtomWidget(
        text: 'อัปเดตโปรไฟล์',
        onClicked: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const EditProfileScreen()),
          );
          setState(() {});
        },
      );

  Widget ss() => Padding(
        padding: const EdgeInsets.all(20),
        // ignore: avoid_unnecessary_containers
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(7),
            ),
          ),
          child: Container(
            color: Colors.pink.shade50,
            child: Column(
              children: const <Widget>[
                Icon(Icons.cruelty_free_sharp),
                SizedBox(
                  child: Text(
                    'การนั่งสมาธิ',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '  เวลาที่นั้งสมาธิไปแล้ว   45 นาที  ',
                  style: TextStyle(fontSize: 20, fontFamily: 'Raleway'),
                ),
              ],
            ),
          ),
        ),
      );
}
