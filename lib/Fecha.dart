import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

// ignore: must_be_immutable
class DataPickerField extends StatelessWidget {
  DateTime fecha;
  DataPickerField(this.fecha);
  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    ThemeData(primaryColor: Colors.redAccent);
    return DateTimeField(
      decoration: InputDecoration(labelText: 'Fecha de nacimiento'),
      format: format,
      onChanged: (dateTime) {
        fecha = dateTime;
      },
      initialValue: fecha,
      onShowPicker: (context, fecha) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: fecha,
            lastDate: DateTime.now());
      },
    );
  }
}
