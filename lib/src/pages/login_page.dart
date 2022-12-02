import 'package:flutter/material.dart';
import 'package:appim/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(children: [
        SafeArea(
            child: Container(
          height: 150.0,
        )),
        Container(
          width: size.width * 0.85,
          margin: EdgeInsets.symmetric(vertical: 30.0),
          padding: EdgeInsets.symmetric(vertical: 50.0),
          // decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(5.0),
          //     boxShadow: <BoxShadow>[
          //       BoxShadow(
          //           color: Colors.black26,
          //           blurRadius: 3.0,
          //           offset: Offset(0.0, 5.0),
          //           spreadRadius: 3.0)
          //     ]),
          child: Column(children: [
            SizedBox(
              height: 30.0,
            ),
            _crearEmail(bloc),
            SizedBox(
              height: 15.0,
            ),
            _crearPassword(bloc),
            SizedBox(
              height: 15.0,
            ),
            _crearBoton(bloc)
          ]),
        ),
        Text('¿Olvido su contraseña?'),
        SizedBox(height: 100.0)
      ]),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final _isNull = snapshot.error;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                //icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
                filled: true,
                fillColor: Colors.white,
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo electronico',
                counterText: snapshot.data,
                errorText: _isNull == null ? '' : snapshot.error.toString()),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final _isNull = snapshot.error;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                //icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
                labelText: 'Contraseña',
                filled: true,
                fillColor: Colors.white,
                counterText: snapshot.data,
                errorText: _isNull == null ? '' : snapshot.error.toString()),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    //formValidStream
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final _exitData = snapshot.hasData;
        return MaterialButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar'),
            color: Colors.black12,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          onPressed: _exitData == true ? () => _login(bloc, context) : null,
          color: Colors.deepPurple,
          textColor: Colors.white,
        );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) {
    Navigator.pushReplacementNamed(context, 'home');
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 1,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(220, 220, 220, 1.0),
        Color.fromRGBO(200, 200, 200, 1.0)
      ])),
    );

    final cuadradoP = Container(
        width: 180.0,
        height: 180.0,
        decoration: BoxDecoration(color: Color.fromRGBO(66, 85, 254, 0.2)),
        transform: Matrix4.rotationZ(0.9));

    final cuadradoG = Container(
        width: 250.0,
        height: 250.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Color.fromRGBO(66, 85, 254, 0.4)),
        transform: Matrix4.rotationZ(0.9));

    return Stack(
      children: [
        fondoMorado,
        Positioned(top: -50.0, right: -130.0, child: cuadradoP),
        Positioned(top: -160.0, right: -300.0, child: cuadradoG),
        Positioned(bottom: -60.0, left: -10.0, child: cuadradoG),
        Positioned(bottom: 25.0, left: 70.0, child: cuadradoP),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              Icon(Icons.person_pin_rounded,
                  color: Colors.blue[700], size: 150.0),
              SizedBox(height: 10.0, width: double.infinity),
            ],
          ),
        )
      ],
    );
  }
}
