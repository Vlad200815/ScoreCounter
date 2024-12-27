import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({super.key});

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  @override
  Widget build(BuildContext context) {
    Color _currentColor = Colors.blue; // Default color

    // Function to change color
    void _changeColor(Color color) {
      setState(() {
        _currentColor = color;
      });
    }

    return MaterialButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Pick a color'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: _currentColor,
                  onColorChanged: _changeColor,
                  pickerAreaHeightPercent: 0.8,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: _currentColor,
          borderRadius: BorderRadius.circular(60),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
    );
  }
}
