import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController contUser = TextEditingController();
  TextEditingController contPwd = TextEditingController();
  bool isValidating = false;

  @override
  Widget build(BuildContext context) {

    final txtUser = TextField(
      keyboardType: TextInputType.emailAddress,
      controller: contUser,
      decoration: InputDecoration(
        hintText: 'Correo electrónico'
      ),
    );

    final txtPwd = TextField(
      obscureText: true,
      controller: contPwd,
      decoration: InputDecoration(
        hintText: 'Contraseña'
      ),
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/starwars.jpg")
          )
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 180,
              child: Text('Star Wars', 
                style: TextStyle(color: Colors.white, fontSize: 35, fontFamily: 'Pricedown'),
              ),
            ),
            Positioned(
              bottom: 180,
              child: Container( 
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .2,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    txtUser,
                    txtPwd,
                    IconButton(
                      onPressed: () {
                        isValidating = true;
                        setState(() {});
                        Future.delayed(Duration(milliseconds: 3000)).then(
                          (value) => Navigator.pushNamed(context, '/home'),
                        );
                      },
                      icon: Icon(Icons.login, size: 20)
                    ),
                  ],
                ),
              )
            ),
            Positioned(
              bottom: 120,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  "¿No tienes cuenta? Regístrate aquí",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Positioned(
              top: 300,
              child: isValidating 
              ? Lottie.asset('assets/saber.json', height: 200)
              : Container()
            ),
          ],
        ),
      ),
    );
  }
}