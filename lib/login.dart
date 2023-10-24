import 'package:flutter/material.dart';
import 'package:kanbagisla/firebase_options.dart';
import 'package:kanbagisla/homepage.dart';
import 'package:kanbagisla/main.dart';
import 'package:kanbagisla/passwordReset.dart';
import 'package:kanbagisla/register.dart';
import 'package:localstorage/localstorage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Kan Bağışla',
      debugShowCheckedModeBanner: false,
      home: LoginPage(title: 'Kan Bağışla'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('asset/images/flutter.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                obscureText: false,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Eposta Boş Olamaz';
                  }
                  return null;
                },
                autofocus: false,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        30.0,
                      ),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.amberAccent, width: 2.0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        30.0,
                      ),
                    ),
                  ),

                  isDense: true,
                  // fillColor: kPrimaryColor,
                  filled: true,
                  errorStyle: TextStyle(fontSize: 15),
                  hintText: 'Eposta Giriniz',
                  hintStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreenAccent),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                obscureText: false,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şifre Boş Olamaz';
                  }
                  return null;
                },
                autofocus: false,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        30.0,
                      ),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.amberAccent, width: 2.0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        30.0,
                      ),
                    ),
                  ),

                  isDense: true,
                  // fillColor: kPrimaryColor,
                  filled: true,
                  errorStyle: TextStyle(fontSize: 15),
                  hintText: 'Şifre Giriniz',
                  hintStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreenAccent),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // userPasswordRecovery();
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => PasswordReset()));
              },
              child: const Text(
                'Şifremi Unuttum',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () {
                  userLogin(_emailController.text.trim().toString(),
                      _passwordController.text.trim().toString());
                  final TokenList list = TokenList();
                  final item = TokenItem(token: "token".toString());
                  list.items.add(item);
                  final LocalStorage storage = LocalStorage('todo_app.json');
                  storage.clear();
                  storage.setItem('todos', list.toJSONEncodable());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HomePage(
                                title: 'Kan Bağışla',
                              )));
                },
                child: const Text(
                  'Giriş',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsetsDirectional.all(10),
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(50)),
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (_) => const HomePage(
                  //               title: 'Kan Bağışla',
                  //             )));
                  // googleSignIn();
                  Authentication.signInWithGoogle(context: context);
                },
                child: const Text(
                  'Google Giriş',
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Register()));
              },
              child: const Text(
                'Kayıt Ol',
              ),
            ),
          ],
        ),
      ),
    );

    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
