// ignore_for_file: file_names, deprecated_member_use

import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maditation/model/user.dart';
import 'package:maditation/utils/user_preferences.dart';
import 'package:maditation/widget/buttom_widget.dart';
import 'package:maditation/widget/profile_widget.dart';
import 'package:maditation/widget/textField_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late User user;

  @override
  void initState() {
    super.initState();

    user = UserPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
        child: Builder(
          builder: (context) => Scaffold(
            //appBar: buildAppbar(context),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 40,
                ),
                ProfileWidget(
                  imagePath: user.imagePath,
                  isEdit: true,
                  onClicked: () async {
                    final image = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    if (image == null) return;

                    final directory = await getApplicationDocumentsDirectory();
                    final name = basename(image.path);
                    final imageFile = File('${directory.path}/$name');
                    final newImage =
                        await File(image.path).copy(imageFile.path);

                    setState(
                      () => user = user.copy(imagePath: newImage.path),
                    );
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldWidget(
                  label: 'กรุณากรอกชื่อผู้ใช้',
                  text: user.name,
                  onChanged: (name) => user = user.copy(name: name),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtomWidget(
                    text: 'บันทึกข้อมูล',
                    onClicked: () {
                      UserPreferences.setUser(user);
                      Navigator.of(context).pop();
                    })
              ],
            ),
          ),
        ),
      );
}
