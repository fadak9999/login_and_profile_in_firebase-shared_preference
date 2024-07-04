import 'package:fairbace_flutter/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  //

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm_password = TextEditingController();
  Future sinIn() async {
    if (check_enter_user()) {
      if (passwordConfirn()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email.text.trim(), password: _password.text.trim());
        Get.off(home());
      } else {
        return showModalBottomSheet(
            context: context,
            builder: (context) {
              return const SizedBox(
                height: 300,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "يوجد اختلاف الرمز السري",
                  ),
                ),
              );
            });
      }
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) {
            return const SizedBox(
              height: 300,
              width: double.infinity,
              child: Center(
                child: Text(
                  "لم تقم باضافه ألبريد ألالكتروني او كلمة المرور حاول مجددا ",
                ),
              ),
            );
          });
    }
  }

  bool passwordConfirn() {
    if (_password.text.trim() == _confirm_password.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  bool check_enter_user() {
    if (_email.text.trim() != "" &&
        _password.text.trim() != "" &&
        _confirm_password.text.trim() != "") {
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
    _confirm_password.dispose();
  }

  void go_to_login() {
    Navigator.of(context).pushReplacementNamed("login_screens");
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              //image
              //  Image.asset(
              //   "images/ibtikar.JPG",
              //  height: 250,
              // ),
              const SizedBox(
                height: 10,
              ),
              //title
              Center(
                child: Text(
                  "Sign in",
                ),
              ),
              //subtitle
              Center(
                child: Text(
                  "Welcome to Fadak Learning sign in ",
                ),
              ),
              const SizedBox(
                height: 20,
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
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "password"),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // confirm password textfild
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _confirm_password,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "confirm password"),
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
                  onTap: sinIn,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple[600],
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                        child: Text(
                      "Sign in",
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
                    "I have an account",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: go_to_login,
                    child: Text(
                      "Go to login",
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
