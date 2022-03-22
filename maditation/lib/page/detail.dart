import 'package:flutter/material.dart';

//ข้อแนะนำในการนั่งสมาธิ
class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: Color.fromRGBO(250, 160, 161, 1),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8),//ห่างจากขอบ
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(image: AssetImage("assets/images/detail1.jpg")),
                      SizedBox(
                        height:50, // สูง
                      ),
                      
                      Image(image: AssetImage("assets/images/detail2.jpg")),
                      SizedBox(
                        height:10, // สูง
                      ),
                      Image(image: AssetImage("assets/images/detail3.jpg")),
                      SizedBox(
                        height:50, // สูง
                      ),
                      
                      Image(image: AssetImage("assets/images/detail4.jpg")),
                      SizedBox(
                        height: 10,
                      ),
                      Image(image: AssetImage("assets/images/detail5.jpg")),
                      SizedBox(
                        height:50, // สูง
                      ),
                      Image(image: AssetImage("assets/images/detail6.jpg")),
                      SizedBox(
                        height:10, // สูง
                      ),
                      Image(image: AssetImage("assets/images/detail7.jpg")),
                      SizedBox(
                        height:50, // สูง
                      ),
                      Image(image: AssetImage("assets/images/detail8.jpg")),
                      SizedBox(
                        height:10, // สูง
                      ),
                      Image(image: AssetImage("assets/images/detail9.jpg")),
                      SizedBox(
                        height:50, // สูง
                      ),
                      Image(image: AssetImage("assets/images/detail10.jpg")),
                      SizedBox(
                        height:10, // สูง
                      ),
                      Image(image: AssetImage("assets/images/detail11.jpg")),
                      SizedBox(
                        height:50, // สูง
                      ),
                      Image(image: AssetImage("assets/images/detail12.jpg")),
                      SizedBox(
                        height:10, // สูง
                      ),
                      Image(image: AssetImage("assets/images/detail13.jpg")),
                      SizedBox(
                        height:50, // สูง
                      ),
                      Image(image: AssetImage("assets/images/detail14.jpg")),
                      SizedBox(
                        height:10, // สูง
                      ),
                      Image(image: AssetImage("assets/images/detail15.jpg")),
                      SizedBox(
                        height:50, // สูง
                      ),
                      Image(image: AssetImage("assets/images/detail16.jpg")),
                      SizedBox(
                        height:10, // สูง
                      ),
                      Image(image: AssetImage("assets/images/detail17.jpg")),
                      SizedBox(
                        height:50, // สูง
                      ),
                      Image(image: AssetImage("assets/images/detail18.jpg")),
                      SizedBox(
                        height:10, // สูง
                      ),
                      Image(image: AssetImage("assets/images/detail19.jpg")),
                      SizedBox(
                        height:50, // สูง
                      ),
                      Image(image: AssetImage("assets/images/detail20.jpg")),
                      SizedBox(
                        height:10, // สูง
                      ),
                      Image(image: AssetImage("assets/images/detail21.jpg")),
                      SizedBox(
                        height:50, // สูง
                      ),
                      Text("ที่มา : สมาคมส่งเสริมความปลอดภัยและอนามัยในการทำงาน (ประเทศไทย) ในพระราชูปถัมภ์ ฯ",style: TextStyle(fontSize: 14,fontFamily: "NotoSans"),)
                ],
                        ),
                      ),
              ),
            )
      ],
    ));
  }
}
