import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Componentes {
  void alerta(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: titulo('¡Info!', Icons.info, Colors.red),
              content: Text(message, style: TextStyle(color: Colors.grey)),
              actions: [
                crearBoton(() => Navigator.pop(context), '  Volver',
                    Icons.backspace_sharp, Colors.red),
              ],
            )
            );
  }

  void elegirOpcion(
      BuildContext context,
      Function function,
      String title,
      IconData iconoTitle,
      String message,
      String button,
      IconData icon,
      Color color) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: titulo(title, iconoTitle, color),
              content: Text(message, style: TextStyle(color: Colors.blueGrey)),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    crearBoton(function, ' ' + button, icon, color),
                    crearBoton(() => Navigator.pop(context), '  Cancelar',
                        Icons.cancel, Colors.blueGrey),
                  ],
                )
              ],
            ));
  }

  Widget crearBoton(
      Function function, String text, IconData icon, Color color) {
    return TextButton(
        onPressed: function,
        child: Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, color: color),
            Text(text, style: TextStyle(color: color)),
          ]),
        ));
  }

  Widget titulo(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color),
        Text(title, style: TextStyle(color: color)),
      ],
    );
  }

  Widget crearCajaTextoPassword(
      TextEditingController controller, String title, bool isObscure) {
    return TextField(
        obscureText: isObscure,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          labelText: title,
          fillColor: Colors.transparent,
          suffix: GestureDetector(
            child: Icon(Icons.close),
            onTap: () {
              controller.clear();
            },
          ),
        ));
  }

  Widget crearCajaTexto(TextEditingController controller, String title) {
    return crearCajaTextoPassword(controller, title, false);
  }
}