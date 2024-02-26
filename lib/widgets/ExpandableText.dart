import 'package:ahafeeth_ai_app/constants/Localization.dart';
import 'package:flutter/material.dart';

import '../localization/app_localizations.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  TextStyle? style;

  ExpandableText(this.text, {this.style});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.text.length > 300) {
          setState(() {
            isExpanded = !isExpanded;
          });
        }
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              isExpanded ? widget.text : _getTrimmedText(),
              style: widget.style,
            ),
            SizedBox(height: 8.0),
            widget.text.length > 300
                ? isExpanded
                    ? Text(
                        AppLocalizations.of(context).readLess,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    : Text(
                        AppLocalizations.of(context).readMore,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  String _getTrimmedText() {
    if (widget.text.length >= 300) {
      return widget.text.substring(0, 300) + '...';
    }
    return widget.text;
  }
}
