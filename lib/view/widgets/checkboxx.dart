import 'package:flutter/material.dart';

class RectangularCheckbox extends StatefulWidget {
  @override
  _RectangularCheckboxState createState() => _RectangularCheckboxState();
}

class _RectangularCheckboxState extends State<RectangularCheckbox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
        });
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFF7E3DFF), // Border color when unchecked
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(4),
          color: _isChecked ? Color(0xFF7E3DFF) : Colors.transparent,
        ),
        child: _isChecked
            ? Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
