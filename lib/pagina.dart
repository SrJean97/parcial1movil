import 'package:flutter/material.dart';
import 'package:parcial/Fecha.dart';
import 'package:parcial/componentes.dart';
import 'cliente.dart';

void main() => runApp(Pagina());

// ignore: must_be_immutable
class Pagina extends StatefulWidget {
  BuildContext principalContext;
  Cliente cliente;
  String accion;
  Pagina({this.principalContext, this.accion, this.cliente});
  Componentes componentes = Componentes();

  @override
  State<StatefulWidget> createState() {
    return new _SecongPageState();
  }
}

class _SecongPageState extends State<Pagina> {
  TextEditingController controladorfoto;
  TextEditingController controladornombre;
  TextEditingController controladorapellido;
  TextEditingController controladorprofesion;
  DataPickerField dataPickerField;

  @override
  void initState() {
    dataPickerField = DataPickerField(widget.cliente.fechaNacimiento);
    controladorfoto = (widget.accion == 'Actualizar')
        ? TextEditingController(text: widget.cliente.foto)
        : TextEditingController();
    controladornombre = (widget.accion == 'Actualizar')
        ? TextEditingController(text: widget.cliente.nombre)
        : TextEditingController();
    controladorapellido = (widget.accion == 'Actualizar')
        ? TextEditingController(text: widget.cliente.apellido)
        : TextEditingController();
    controladorprofesion = (widget.accion == 'Actualizar')
        ? TextEditingController(text: widget.cliente.profesion)
        : TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blueAccent),
      title: widget.accion + ' Cliente',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.accion + ' Cliente'),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: widget.componentes
                      .crearCajaTexto(controladorfoto, 'URL Foto'),
                ),

                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: widget.componentes
                      .crearCajaTexto(controladornombre, 'Nombres'),
                ),

                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: widget.componentes
                      .crearCajaTexto(controladorapellido, 'Apellidos'),
                ),

                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: dataPickerField,
                ),

                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: widget.componentes
                      .crearCajaTexto(controladorprofesion, 'Profesión'),
                ),
                // Boton
                ElevatedButton(
                  onPressed: () {
                    validarCampos(context);
                  },
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  validarCampos(BuildContext context) {
    if (controladorfoto.text.isNotEmpty &&
        controladornombre.text.isNotEmpty &&
        controladorapellido.text.isNotEmpty &&
        controladorprofesion.text.isNotEmpty) {
      mapearCliente();
      widget.componentes.elegirOpcion(
          context,
          () => retroceder(),
          widget.accion,
          Icons.info,
          '¿Está seguro que desea guardar los cambios?',
          'Aceptar',
          Icons.check,
          Colors.grey);
    } else {
      widget.componentes
          .alerta(context, 'Hay campos vacíos, por favor verifique');
    }
  }

  mapearCliente() {
    widget.cliente.foto = controladorfoto.text;
    widget.cliente.nombre = controladornombre.text;
    widget.cliente.apellido = controladorapellido.text;
    widget.cliente.profesion = controladorprofesion.text;
    widget.cliente.fechaNacimiento = dataPickerField.fecha;
  }

  retroceder() {
    Navigator.pop(widget.principalContext, widget.cliente);
    Navigator.pop(widget.principalContext, widget.cliente);
  }
}