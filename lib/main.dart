import 'package:flutter/material.dart';
import 'package:parcial/componentes.dart';
import 'package:parcial/principal.dart';

void main() => runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.blue),
    home: Login(),
    title: 'Login',
    debugShowCheckedModeBanner: false));

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController usuarioController;
  TextEditingController contrasenaController;
  Componentes componentes = Componentes();

  @override
  void initState() {
    usuarioController = TextEditingController();
    contrasenaController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(Icons.navigate_next),
          foregroundColor: Colors.grey,
        ),
        title: Text('Iniciar sesión'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 80,
                child: Image(
                    height: 600,
                    width: 600,
                    image: NetworkImage(
                      
                        'imagenes/Login.png')),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: componentes.crearCajaTexto(
                    usuarioController, 'Nombre de usuario'),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: componentes.crearCajaTextoPassword(
                    contrasenaController, 'Contraseña', true),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (usuarioController.text.isNotEmpty &&
                        contrasenaController.text.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              Consulta(usuarioController.text)
                            )
                          );
                    } else {
                      componentes.alerta(
                          context, 'Verificar campos vacios'
                        );
                    }
                  },
                  child: Text('Ingresar'))
            ],
          ),
        ),
      ),
    );
  }
}