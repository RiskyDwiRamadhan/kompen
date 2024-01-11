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
    // pilihan DropDown Dosen dan Mahasiswa
    if (nTabel == "Dosen" || nTabel == "Admin") {
      ServicesUser.getDosen(usernameInput.text, passwordInput.text).then(
        (result) {
          if (result.length < 1) {
            print("GAGAL");
            print(usernameInput.text);
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Konfirmasi Login"),
                    content:
                        Text("Data user {$usernameInput.text} tidak ada!!"),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'))
                    ],
                  );
                });
          } else {
            print("data ada" + result[0].status!);
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
            }
          }
        },
      );
    } else {
      ServicesUser.getMahasiswa(usernameInput.text, passwordInput.text).then(
        (result) {
          if (result.length < 1) {
            print("GAGAL M");
            print(usernameInput.text);
            print(passwordInput.text);
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Konfirmasi Login"),
                    content: Text("Data user tidak ada!!"),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'))
                    ],
                  );
                });
          } else {
            print("data ada" + result[0].status!);
            if (result[0].status! == "Mahasiswa") {
              ServicesUser.setdata(
                  result[0].status!, result[0].username!, result[0].password!);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => DashboardMWidget(
                          user: result[0],
                        )),
                (Route) => false,
              );
            }
          }
        },
      );
    }
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
                                child: DropdownButton<String?>(
                                  value: nTabel,
                                  onChanged: (value) {
                                    setState(() {
                                      nTabel = value;
                                    });
                                  },
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
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => const RegisterWidget())
                                  );
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
