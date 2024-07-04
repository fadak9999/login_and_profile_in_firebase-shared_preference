import 'package:fairbace_flutter/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  //

  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscureText = true;

  Future login() async {
    if (check_enter_user()) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(), password: _password.text.trim());
      Get.off(home());
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) {
            return const SizedBox(
              height: 300,
              width: double.infinity,
              child: Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "لم تقم باضافه البريد الالكتروني او كلمة المرور حاول مجددا ",
                    ),
                  ),
                ),
              ),
            );
          });
    }
  }

  bool check_enter_user() {
    if (_email.text.trim() != "" && _password.text.trim() != "") {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  void go_to_signUp() {
    Navigator.of(context).pushReplacementNamed("sinUp_screens");
  }

  ////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              //image
              Image.asset(
                "assets/profile2.jpg",
                height: 250,
                width: 250,
              ),
              const SizedBox(
                height: 10,
              ),
              //title
              Center(
                child: Text(
                  "Login ",
                ),
              ),
              //subtitle
              Center(
                child: Text(
                  "Welcome, nice to see you :)",
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              //email textfild
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _email,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "E-mail"),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              //password textfild
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _password,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // sign in botton
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: InkWell(
                  // مثل الانكويلي
                  onTap: login,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple[600],
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                        child: Text(
                      "Login",
                    )),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // text  to sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "If you do not have a previous account",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: go_to_signUp,
                    child: Text(
                      "Create a new account",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
