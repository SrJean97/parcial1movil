import 'dart:ui';
import 'package:parcial/componentes.dart';

import 'cliente.dart';
import 'pagina.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.blue),
    home: Consulta(
      '',
    ),
    debugShowCheckedModeBanner: false));

// ignore: must_be_immutable
class Consulta extends StatefulWidget {
  String nombreUsuario;

  Consulta(this.nombreUsuario);

  ConsultaState createState() {
    return ConsultaState();
  }
}

class ConsultaState extends State<Consulta> {
  Componentes componentes = Componentes();
  List<Cliente> _clientes = [
    Cliente(
        foto:
            'imagenes/Login.png',
        nombre: 'Jean',
        apellido: 'Casadiegos',
        profesion: 'Ing sistemas',
        fechaNacimiento: DateTime(1997, 4, 22))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: Text('Clientes'),
          ),
          actions: [
            Center(child: Text(widget.nombreUsuario)),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: CircleAvatar(
                  child: Icon(Icons.person),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                ))
          ],
          centerTitle: false,
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
            itemCount: _clientes.length,
            itemBuilder: (context, index) {
              return ListTile(
                  onTap: () {
                    editarCliente(context, _clientes[index], index);
                  },
                  onLongPress: () {
                    eliminarCliente(context, _clientes[index]);
                  },
                  title: Text(_clientes[index].nombre +
                      ' ' +
                      _clientes[index].apellido),
                  subtitle: Text(_clientes[index].profesion),
                  leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(_clientes[index].foto)))),
                  trailing: Text(
                    _clientes[index].mostrarFechaYEdad(),
                    textAlign: TextAlign.right,
                  ));
            }),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.only(left: 30.0),
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                adicionarCliente(context, _clientes);
              },
              tooltip: 'Registrar Cliente',
              child: Icon(Icons.add),
            ),
          ),
        ]));
  }

  eliminarCliente(context, Cliente cliente) {
    componentes.elegirOpcion(
        context,
        () => setState(() {
              this._clientes.remove(cliente);
              Navigator.pop(context);
            }),
        ' Eliminar Cliente',
        Icons.person,
        '¿Está seguro que desea eliminar a ' + cliente.nombre + '?',
        'Eliminar',
        Icons.delete,
        Colors.blue);
  }

  adicionarCliente(context, List<Cliente> clientes) async {
    final cliente = await Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (secondContext) => new Pagina(
              principalContext: context,
              accion: 'Adicionar',
              cliente: Cliente(fechaNacimiento: DateTime.now()))),
    ) as Cliente;
    setState(() {
      if (cliente != null) clientes.add(cliente);
    });
  }

  editarCliente(context, Cliente clienteOld, int index) async {
    final clienteNew = await Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (secondContext) => new Pagina(
              principalContext: context,
              accion: 'Actualizar',
              cliente: clienteOld)),
    ) as Cliente;
    setState(() {
      if (clienteNew != null) {
        this._clientes.elementAt(index).foto = clienteNew.foto;
        this._clientes.elementAt(index).nombre = clienteNew.nombre;
        this._clientes.elementAt(index).apellido = clienteNew.apellido;
        this._clientes.elementAt(index).profesion = clienteNew.profesion;
        this._clientes.elementAt(index).fechaNacimiento =
            clienteNew.fechaNacimiento;
        this._clientes.elementAt(index).edad =
            int.parse(clienteNew.calcularEdad().toString());
      }
    });
  }
}