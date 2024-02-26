import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryBoxes extends StatefulWidget {
  final  GestureTapCallback? onPressed;
  final String? text;

  const CategoryBoxes({Key? key, this.onPressed, this.text}) : super(key: key);

  @override
  State<CategoryBoxes> createState() => _CategoryBoxesState();
}

class _CategoryBoxesState extends State<CategoryBoxes> {


  @override
  Widget build(BuildContext context) {
    double screenWidth = 1;
    double screenHeight = 1;
    return Center(
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Padding(
          padding: EdgeInsets.only(right: 10 * screenWidth),
          child: Container(
            height: 48 * screenHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color:  Color(0xff1C2031),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16 * screenWidth, vertical: 13 * screenHeight),
                child: Text(
                  widget.text!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
