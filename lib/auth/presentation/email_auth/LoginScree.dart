
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/general_news/presentation/home_page.dart';

import 'CreateAccount.dart';

import 'Methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
   _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _userId = TextEditingController();
  final TextEditingController _password = TextEditingController();
  GlobalKey<ScaffoldState>? scaffoldSate = GlobalKey<ScaffoldState>();
  RxBool isLoading = false.obs;
  RxBool _obscureText = true.obs;
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _userId.dispose();
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // body:
      body:  Obx(() => isLoading.isTrue
                ? Center(
                    child: Container(
                      height: size.height / 20,
                      width: size.height / 20,
                      child: const CircularProgressIndicator(),
                    ),
                  )
                : showWidget(size, context))
           
    );
  }

  final formGlobalKey = GlobalKey<FormState>();
  SingleChildScrollView showWidget(Size size, BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formGlobalKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            SizedBox(
            height: size.height / 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: size.width / 0.5,
            child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          SizedBox(
            height: size.height / 50,
          ),
            Container(
              width: size.width / 1.1,
              child: const Text(
                "Identify yourself!",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: size.width / 1.1,
              child: Text(
                "To get entry in your house!",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: size.height / 10,
            ),
           
            Container(
              width: size.width,
              alignment: Alignment.center,
              child: field(size, "Email", Icons.account_box, _email, false,
                  (value) {
                return GetUtils.isEmail(value!) ? null : 'Enter valid email';
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Obx(() => Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: Stack(children: [
                      field(size, "Password", Icons.lock, _password,
                          _obscureText.value, (value) {
                        return null;
                      }),
                      Positioned(
                        top: 2,
                        right: 10,
                        child: IconButton(
                            icon: Icon(
                              _obscureText.isTrue
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              // setState(() {
                              _obscureText.value = !_obscureText.value;
                              // });
                            }),
                      ),
                    ]),
                  )),
            ),
            SizedBox(
              height: size.height / 10,
            ),
            customButton(size),
            // Container(
            //     height: size.height / 14,
            //     width: size.width / 1.2,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(5),
            //         color: Colors.white38),
            //     alignment: Alignment.center,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         InkWell(
            //           onTap: null
            //         ),
            //       ],
            //     )
            //     ),
            SizedBox(
              height: size.height / 40,
            ),
            Container(
                height: size.height / 14,
                width: size.width / 1.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white38),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have account? ",
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.to(() => CreateAccount(),
                          transition: Transition.cupertino),
                      child: const Text(
                        " SIGNUP",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget customButton(Size size) {
      
      
    return GestureDetector(
      onTap: () async{
        if (_email.text.isNotEmpty && _password.text.isNotEmpty && _userId.text.isNotEmpty) {
          // setState(() {
          isLoading.value = true;
          // });

          logIn(_email.text.trim(), _password.text.trim()).then((user) {
            if (user != null) {
              //updating device token on login
              
              print("Login Sucessfull");
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("welcome!"),
              ));
              
                
              isLoading.value = false;
             
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => HomeScreen())); //HomePageNav
            } else {
              print("Login Failed");
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please try again!"),
              ));
              // setState(() {
              isLoading.value = false;
              // });
            }
          });
        } else {
          print("Please fill form correctly");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please Fill all feilds correctly!"),
          ));
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.deepOrange),
          alignment: Alignment.center,
          child: const Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget field(
      Size size,
      String hintText,
      IconData icon,
      TextEditingController cont,
      bool obsc,
      String? Function(String?)? validator) {
    return Container(
      height: size.height / 10,
      width: size.width / 1.1,
      child: TextFormField(
        controller: cont,
        obscureText: obsc,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
