import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandListView extends StatelessWidget {
  final collapsedColor;
  final expandedColor;
  final children;
  final title;
  final iconColor;
  final leading;
  final trailing;

  ExpandListView({
    this.collapsedColor = Colors.white,
    this.title = 'ItemTitle',
    this.expandedColor = Colors.white,
    @required this.children,
    this.iconColor = Colors.blue,
    @required this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: Material(
            elevation: 10,
            child: ExpansionTile(
              iconColor: iconColor,
              backgroundColor: expandedColor,
              collapsedBackgroundColor: collapsedColor,
              title: title,
              leading: leading,
              trailing: trailing,
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}
