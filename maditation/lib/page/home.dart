import 'package:flutter/material.dart';
import 'package:maditation/page/detail.dart';
import 'package:maditation/page/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(
      alignment: Alignment.center,
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/main.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              SizedBox(height: 280),
              InkWell(
                child: Image.asset(
                  "assets/images/card-1.png",
                  fit: BoxFit.cover,
                ),
                onTap: () => _launchURL(),
              ),
              SizedBox(height: 30),
              InkWell(
                  child: Image.asset(
                    "assets/images/card-2.png",
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailScreen()),
                    );
                  }),
              //  MyBox("assets/images/card-2.png"),
            ],
          ),
        )
      ],
    ));
  }
}

_launchURL() async {
  const url =
      'http://www.samathi.com/2016/news.php?fbclid=IwAR1ki07MjNrE9exvf4daTKI0JHlv3NpxYgUUPAR2feu4uUVmiVdwD9Fc0wE';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
