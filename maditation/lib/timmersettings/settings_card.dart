import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class SettingsCard extends StatefulWidget {
  final Widget leading;
  final Widget title;
  final Widget trailing;
  // When enabled, the top border is rounded
  // When enabled, the top border is rounded
  final bool start;
  final bool end;
  // When enabled, the bottom border is rounded
  SettingsCard(
      {required this.leading,
      required this.title,
      required this.trailing,
      this.start = false,
      this.end = false,
      Key? key})
      : super(key: key);
  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
      margin: EdgeInsets.only(bottom: 0.0, left: 21.0, right: 21.0),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(widget.start ? 20.0 : 0.0),
          bottom: Radius.circular(widget.end ? 20.0 : 0.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          this.widget.leading,
          SizedBox(
            width: 21.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              this.widget.title,
            ],
          ).expanded(),
          SizedBox(
            width: 12,
          ),
          widget.trailing,
        ],
      ),
    );
  }
}
