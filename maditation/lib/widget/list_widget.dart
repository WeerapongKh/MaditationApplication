import 'package:flutter/material.dart';
import 'package:maditation/model/date.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    Key? key,
    required this.data,
    required this.edit,
    required this.index,
    required this.delete,
  }) : super(key: key);

  final DataModel data;
  final Function edit;
  final Function delete;

  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: IconButton(
              onPressed: () {
                edit(index);
              },
              icon: Icon(Icons.edit)),
        ),
        title: Text(data.day),
        subtitle: Text("เวลาที่นั่งไปคือ " + data.minute.toString() + " นาที"),
        trailing: CircleAvatar(
          backgroundColor: Colors.red,
          child: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              delete(index);
            },
          ),
        ),
      ),
    );
  }
}
