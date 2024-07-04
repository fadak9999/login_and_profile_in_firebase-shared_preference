import 'dart:io';
import 'package:fairbace_flutter/edit_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  //

  final myAcount = FirebaseAuth.instance.currentUser!;
  File? _selectimage;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    get_data_in_device();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 198, 202, 135),
        centerTitle: true,
        title: const Text(
          "Hello Fadak  🦉🐈 ^_^",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(255, 252, 255, 97),
                Color.fromARGB(255, 147, 147, 138)
              ])),
          child: ListView(
            children: [
              const SizedBox(
                height: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        child: _selectimage != null // الشرط
                            ? CircleAvatar(
                                radius: 100,
                                backgroundImage:
                                    FileImage(_selectimage!), // الشرط الي يتحقق
                              )
                            : Image.asset(
                                // اذا ما تحقق الشرط
                                "assets/profile2.jpg",
                                height: 200,
                              ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 30,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 70, 146, 204),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return SizedBox(
                                          height: 300,
                                          width: double.infinity,
                                          child: Expanded(
                                              child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Center(
                                                  child: Text(
                                                "Please choose from gallery or camera",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 58, 137, 183),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    getimage_in_gallery();
                                                  },
                                                  child: const Text(
                                                      "Add image in gallery",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20))),
                                              const Divider(
                                                height: 20,
                                                color: Color.fromARGB(
                                                    255, 64, 166, 224),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    getimage_in_camera();
                                                  },
                                                  child: const Text(
                                                      "Add image in camera",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20))),
                                              const Divider(
                                                height: 20,
                                                color: Color.fromARGB(
                                                    255, 64, 166, 224),
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      border: Border.all(
                                                          color: Colors.red)),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Delete_data_in_device();
                                                    },
                                                    child: const Text(
                                                      "Remove image",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red,
                                                          fontSize: 20),
                                                    ),
                                                  )),
                                            ],
                                          )),
                                        );
                                      });
                                },
                                icon: const Icon(Icons.add,
                                    size: 25, color: Colors.deepPurple)),
                          )),
                    ],
                  ),
                  Text(
                    myAcount.email!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 25),
                  ),
                  const SizedBox(height: 15),
                  ///////////////////////////////////////////////////////////
                  const edit_profile(),
                  /////////////////////////////////////////////////////////
                  const SizedBox(height: 10),
                  ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.red),
                      ),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: const Text(
                        "Sign Out ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ))
                ],
              ),
            ],
          )),
    );
  }

//*********************************************************************** */

  Future getimage_in_gallery() async {
    final retunImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (retunImage == null) {
      return;
    }
    setState(() {
      _selectimage = File(retunImage.path);
    });
    save_data_in_device(_selectimage!.path);
  }

  Future getimage_in_camera() async {
    final retunImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (retunImage == null) return;
    setState(() {
      _selectimage = File(retunImage.path);
    });
    save_data_in_device(_selectimage!.path);
  }

  void save_data_in_device(String svimg) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("save_image", svimg);
    get_data_in_device();
  }

  void get_data_in_device() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      imagePath = pref.getString("save_image");
      if (imagePath != null) {
        _selectimage = File(imagePath!);
      }
    });
  }

  void Delete_data_in_device() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove("save_image");
    setState(() {
      _selectimage = null;
      imagePath = null;
    });
  }
}
