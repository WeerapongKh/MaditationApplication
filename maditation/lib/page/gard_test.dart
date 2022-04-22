import 'package:flutter/material.dart';
import 'package:maditation/database/date_db.dart';
import 'package:maditation/model/date.dart';
import 'package:maditation/widget/list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  List<DataModel> datas = [];
  bool fetching = true;
  int currentIndex = 0;

  late DB db;
  @override
  void initState() {
    super.initState();
    db = DB();
    getData2();
  }

  void getData2() async {
    datas = await db.getData();
    setState(() {
      fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink.shade100,
        title: Text("ประวัติการนั่งสมาธิ"),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showMyDilogue();
      //   },
      //   child: Icon(Icons.add),
      // ),
      body: fetching
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scrollbar(
              child: ListView.builder(
                itemCount: datas.length,
                itemBuilder: (context, index) => DataCard(
                  data: datas[index],
                  edit: edit,
                  index: index,
                  delete: delete,
                ),
              ),
            ),
    );
  }

  void showMyDilogue() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(14),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: "วัน"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: subtitleController,
                    decoration: InputDecoration(labelText: "เวลาที่นั่งไป "),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  DataModel dataLocal = DataModel(
                      day: titleController.text,
                      minute: subtitleController.text);
                  db.insertData(dataLocal);
                  dataLocal.id = datas[datas.length - 1].id! + 1;
                  setState(() {
                    datas.add(dataLocal);
                  });
                  titleController.clear();
                  subtitleController.clear();
                  Navigator.pop(context);
                },
                child: Text("บันทึก"),
              ),
            ],
          );
        });
  }

  void showMyDilogueUpdate() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(14),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: "วัน"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: subtitleController,
                    decoration: InputDecoration(labelText: "เวลาที่นั่ง"),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  DataModel newData = datas[currentIndex];
                  newData.day = titleController.text;
                  newData.minute = subtitleController.text;
                  db.update(newData, newData.id!);
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Text("บันทึกการเปลี่ยนแปลง"),
              ),
            ],
          );
        });
  }

  void edit(index) {
    currentIndex = index;
    titleController.text = datas[index].day;
    subtitleController.text = datas[index].minute;
    showMyDilogueUpdate();
  }

  void delete(int index) {
    db.delete(datas[index].id!);
    setState(() {
      datas.removeAt(index);
    });
  }
}
