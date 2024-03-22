import 'package:flutter/material.dart';
//import 'package:ruta_sdg/conexcion_api.dart';
import 'package:ruta_sdg/supervisor/views/homeSupervisor.dart';
import 'package:ruta_sdg/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppRutasdg',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SafeArea(
        child: Login(
          title: '',
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  color: const Color.fromARGB(255, 0, 76, 128),
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            Text(
                              'RUTASDG',
                              style: TextStyle(
                                  fontFamily: 'Helvetica Condensed',
                                  fontSize: 20,
                                  letterSpacing: 3,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1
                                    ..color = Colors.white),
                            ),
                            const Text(
                              'RUTASDG',
                              style: TextStyle(
                                fontFamily: 'Helvetica Condensed',
                                fontSize: 20,
                                letterSpacing: 3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          width: 400,
                          height: 100,
                          child: Image.asset(
                            'assets/NuevoLogo.png',
                            width: 200,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 175,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PhysicalModel(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                      elevation: 5.0,
                      shadowColor: Colors.black,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 350),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 40),
                        child: Column(
                          children: [
                            const Text(
                              '¡BIENVENIDO!',
                              style: TextStyle(
                                fontFamily: 'HelveticaCondensed',
                                fontSize: 17,
                                color: Color.fromARGB(255, 236, 130, 45),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                              height: 20.0,
                            ),
                            PhysicalModel(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              elevation: 5.0,
                              shadowColor: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    labelText: "Usuario",
                                    hintText: "ejemplo@gmail.com",
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontFamily: "HelveticaCondensed"),
                                    labelStyle: TextStyle(
                                      fontFamily: "HelveticaCondensed",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingresa tu email';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                              height: 30.0,
                            ),
                            PhysicalModel(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              elevation: 5.0,
                              shadowColor: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    labelText: "Contraseña",
                                    labelStyle: const TextStyle(
                                      fontFamily: "HelveticaCondensed",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: const Icon(
                                          Icons.remove_red_eye_outlined),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingresa tu contraseña';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Navigate the user to the Home page
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Usuario o contraseña incorrecta!',
                                          style: TextStyle(
                                              fontFamily: "HelveticaCondensed"),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  '¿Olvidaste tu contraseña?',
                                  style: TextStyle(
                                    fontFamily: "HelveticaCondensed",
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (showError)
                      const Text(
                        '¡Usuario o contraseña incorrectos!',
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: "HelveticaCondensed"),
                        textAlign: TextAlign.center,
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16.0),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 220, 0),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(180, 50),
                          ),
                          onPressed: () {
                            setState(() {
                              showError = false;
                            });
                            if (_formKey.currentState!.validate()) {
                              if (emailController.text.trim() ==
                                  "analista@gmail.com") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const HomeSupervisorPage(),
                                  ),
                                );
                              }
                            } else {
                              setState(() {
                                showError = true;
                              });
                            }
                          },
                          child: const Text(
                            'Ingresar',
                            style: TextStyle(
                                fontFamily: "HelveticaCondensed",
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
