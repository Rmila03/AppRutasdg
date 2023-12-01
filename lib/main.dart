import 'package:flutter/material.dart';
import 'package:ruta_sdg/plan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppRutasdg',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        /*colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0x004C80),
        ),*/
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
    return Scaffold(
      //appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Stack(children: <Widget>[
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
                    Container(
                      alignment: Alignment.topCenter,
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        'assets/logo-sdg.png', // Ruta de la imagen en assets
                        width: 100, // Ancho de la imagen
                        height: 100, // Alto de la imagen
                        fit: BoxFit.cover, // Modo de ajuste de la imagen
                      ),
                    ),
                    Stack(
                      children: [
                        Text(
                          'Rutas SDG',
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 5,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 10
                              ..color = Colors.black,
                          ),
                        ),
                        // The text inside
                        const Text(
                          'Rutas SDG',
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 5,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                          ),
                        ),
                      ],
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
                      //margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 30),
                      child: Column(
                        children: [
                          const Text(
                            '¡BIENVENIDO!',
                            style: TextStyle(
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
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  labelText: "Usuario",
                                  hintText: "ejemplo@gmail.com",
                                  hintStyle: (TextStyle(
                                    color: Colors.grey[400],
                                  )),
                                  labelStyle: const TextStyle(
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
                                          'Usuario o contraseña incorrecta!'),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                '¿Olvidaste tu contraseña?',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                if (showError)
                  const Text(
                    '¡Usuario o contraseña incorrectos!',
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(254, 255, 224, 1),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20), // Ajusta el radio para hacer el borde más redondeado
                        ),
                        minimumSize: const Size(180, 50),
                      ),
                      onPressed: () {
                        setState(() {
                          showError =
                              false; // Reiniciar el estado del mensaje de error
                        });
                        if (_formKey.currentState!.validate()) {
                          // Navigate the user to the Home page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        } else {
                          setState(() {
                            showError = true; // Mostrar el mensaje de error
                          });
                          /*ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Usuario o contraseña incorrecta!')),
                          );*/
                        }
                      },
                      child: const Text('INGRESAR',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
