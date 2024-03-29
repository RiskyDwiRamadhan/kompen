import 'package:flutter/material.dart';
import 'package:kompen/Model/modelUser.dart';
import 'package:kompen/Service/serviceUser.dart';
import 'package:kompen/componen/componen.dart';
import 'package:kompen/constants.dart';
import 'package:kompen/screens/dashboard/dashboard.dart';
import 'package:kompen/screens/dashboard/dashboardD.dart';
import 'package:kompen/screens/dashboard/dashboardM.dart';
import 'package:kompen/screens/login/register.dart';

import 'package:kompen/widgets/widgets.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  List<User> dataUser = [];
  String? username, password, status, nTabel = "Mahasiswa";
  bool isObscure = true;
  final formKey = GlobalKey<FormState>();

  TextEditingController usernameInput = new TextEditingController();
  TextEditingController passwordInput = new TextEditingController();

  void prosesLogin() async {
    ServicesUser.getUser(
      usernameInput.text,
      passwordInput.text,
      nTabel!,
    ).then(
      (result) {
        if (result.length < 1) {
          print("Data login salah!!");
        } else {
          setState(() {
            print("Data login benar!!");

            if (result[0].status! == "Admin") {
              ServicesUser.setdata(
                  result[0].status!, result[0].username!, result[0].password!);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => DashboardWidget(
                          user: result[0],
                        )),
                (Route) => false,
              );
            } else if (result[0].status! == "Dosen") {
              ServicesUser.setdata(
                  result[0].status!, result[0].username!, result[0].password!);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => DashboardDWidget(user: result[0])),
                (Route) => false,
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => DashboardMWidget(
                          user: result[0],
                        )),
                (Route) => false,
              );
            }
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // testautoLogin();
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
                const PageTitleBar(title: 'Login to your account'),
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
                              TextFieldContainer(
                                child: DropdownButtonFormField<String?>(
                                  value: nTabel,
                                  onChanged: (value) {
                                    setState(() {
                                      nTabel = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Pilih Prodi';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan Email anda',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 136, 135, 135),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  items: ["Dosen", "Admin", "Mahasiswa"]
                                      .map<DropdownMenuItem<String?>>(
                                        (e) => DropdownMenuItem(
                                          child: Text(e.toString()),
                                          value: e,
                                        ),
                                      )
                                      .toList(),
                                  // isExpanded: true,
                                ),
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
                                text: 'Sign In',
                                press: () {
                                  if (formKey.currentState!.validate()) {
                                    prosesLogin();
                                  }
                                },
                                formKey: formKey,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              UnderPart(
                                title: "Don't have an account?",
                                navigatorText: "Sign Up here",
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterWidget()));
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                child: const Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        // title: Text("Informasi Box"),
                                        content: Text(
                                            "Jika password lupa silahkan menghubungi pak Kadek Suarjuna Selaku Admin Kompen"),
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
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              )
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
