import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kompen/Service/serviceAlpaku.dart';
import 'package:kompen/Service/serviceMahasiswa.dart';
import 'package:kompen/componen/componen.dart';
import 'package:kompen/constants.dart';
import 'package:kompen/screens/login/login.dart';
import 'package:kompen/widgets/widgets.dart';
import 'package:path/path.dart' as path;

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  String? username, password, prodi;
  bool isObscure = true;
  File? _image;
  final formKey = GlobalKey<FormState>();

  TextEditingController nimInput = new TextEditingController();
  TextEditingController namaInput = new TextEditingController();
  TextEditingController thMasukInput = new TextEditingController();
  TextEditingController passwordInput = new TextEditingController();
  TextEditingController usernameInput = new TextEditingController();
  TextEditingController emailInput = new TextEditingController();
  TextEditingController noTelpInput = new TextEditingController();
  TextEditingController fotoInput = new TextEditingController();

  void _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
      fotoInput.text = path.basename(_image!.path);
    });
  }

  void prosesData() async {
    ServicesMahasiswa.addMahasiswa(
            nimInput.text,
            namaInput.text,
            prodi.toString(),
            noTelpInput.text,
            usernameInput.text,
            passwordInput.text,
            emailInput.text,
            _image!,
            thMasukInput.text)
        .then(
      (result) {
        if ('success' == result) {
          ServicesAlpaku.addAlpaku(nimInput.text, '1').then(
            (value) {
              if (value == "Succes") {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Konfirmasi Data"),
                      content: Text("Data user berhasil ditambahkan!!"),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              nimInput.text = "";
                              namaInput.text = "";
                              passwordInput.text = "";
                              usernameInput.text = "";
                              fotoInput.text = "";
                              prodi = "";
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginWidget()));
                            },
                            child: Text('OK'))
                      ],
                    );
                  },
                );
              } else {
                print("alpaku gagal");
              }
            },
          );
        } else {
          setState(() {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Konfirmasi Data"),
                  content: Text("Data user sudah ada!!"),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'))
                  ],
                );
              },
            );
            print("data user sudah ada!!");
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const Upside(
                  imgUrl: "assets/images/polinema_logo.png",
                ),
                const PageTitleBar(title: 'Create an account'),
                Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              RoundedInputField(
                                controller: nimInput,
                                hintText: "Masukkan NIM anda",
                                validator: "NIM",
                                icon: Icons.adjust_sharp,
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                              ),
                              RoundedInputField(
                                controller: namaInput,
                                hintText: "Masukkan Nama Lengkap anda",
                                validator: "Nama Lengkap",
                                icon: Icons.account_circle,
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                              ),
                              RoundedInputField(
                                controller: thMasukInput,
                                hintText: "Masukkan Tahun Masuk anda",
                                validator: "Tahun Masuk",
                                icon: Icons.date_range_sharp,
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 45.0),
                                  child: ElevatedButton(
                                    onPressed: _getImage,
                                    child: Text('Select Image'),
                                  ),
                                ),
                              ),
                              RoundedInputField(
                                controller: fotoInput,
                                hintText: "Pilih File Foto Anda",
                                validator: "Foto",
                                icon: Icons.photo_camera_back_outlined,
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                              ),
                              TextFieldContainer(
                                child: DropdownButton<String?>(
                                  value: prodi,
                                  hint: Text("Program Studi"),
                                  onChanged: (value) {
                                    setState(() {
                                      prodi = value;
                                    });
                                  },
                                  items: [
                                    "D4 Sistem Informasi Bisnis",
                                    "D4 Teknik Informatika",
                                    "D2 Pengembangan Piranti Lunak Situs"
                                  ]
                                      .map<DropdownMenuItem<String?>>(
                                        (e) => DropdownMenuItem(
                                          child: Text(e.toString()),
                                          value: e,
                                        ),
                                      )
                                      .toList(),
                                  isExpanded: true,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              RoundedInputField(
                                controller: emailInput,
                                hintText: "Masukkan Email anda",
                                validator: "Email",
                                icon: Icons.email,
                                textInputType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                              ),
                              RoundedInputField(
                                controller: noTelpInput,
                                hintText: "Masukkan Nomor Telepon anda",
                                validator: "Nomor Telepon",
                                icon: Icons.phone,
                                textInputType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                              ),
                              RoundedInputField(
                                controller: usernameInput,
                                hintText: "Masukkan Username anda",
                                validator: "Username",
                                icon: Icons.people,
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                              ),
                              RoundedInputField(
                                controller: passwordInput,
                                hintText: "Masukkan Password anda",
                                validator: "Password",
                                icon: Icons.lock,
                                textInputType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                isObscure: isObscure,
                                hasSuffix: true,
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                              ),
                              RoundedButton(
                                text: 'Sign Up',
                                press: () {
                                  if (formKey.currentState!.validate()) {
                                    prosesData();
                                  }
                                },
                                formKey: formKey,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              UnderPart(
                                title: "Have an account?",
                                navigatorText: "Sign In here",
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginWidget()));
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
