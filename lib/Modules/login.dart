import 'package:flutter/material.dart';
import 'package:flutter_demo/Modules/home.dart';
import 'package:flutter_demo/Utils/AppColor.dart';
import 'package:flutter_demo/Utils/AppImages.dart';
import 'package:flutter_demo/Utils/CommonUtils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  var widgetSpace = 30.0;

  bool isValidPassword(String password) {
    // Regular expression to check the password
    String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*\W).+$';
    //String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const Center(
                        child: Text(
                      'G',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 80),
                    )),
                    TextFormField(
                      cursorColor: Colors.black,
                      controller: mobileController,
                      decoration: InputDecoration(
                        hintText: 'Enter Mobile number',
                        hintStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: widgetSpace,
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      controller: passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                        hintText: 'Enter Passsword',
                        hintStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: widgetSpace,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (mobileController.text.trim().isEmpty) {
                          print('Please enter mobile number');
                          CommonUtils.getIntance()
                              .toastMessage('Please enter mobile number');
                        } else if (!RegExp(r'^[0-9]+$')
                            .hasMatch(mobileController.text)) {
                          CommonUtils.getIntance().toastMessage(
                              'Please enter only numeric characters');
                        } else if (mobileController.text.length < 10) {
                          CommonUtils.getIntance()
                              .toastMessage('Please enter valid mobile number');
                        } else if (passwordController.text.trim().isEmpty) {
                          CommonUtils.getIntance()
                              .toastMessage('Please enter password');
                        } else if (!isValidPassword(
                            passwordController.text.trim())) {
                          CommonUtils.getIntance()
                              .toastMessage('Please enter valid password');
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Appcolor.primaryColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Center(
                            child: Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: widgetSpace,
                    ),
                    Center(child: Text('Forgot password?')),
                    SizedBox(
                      height: widgetSpace,
                    ),
                    const Divider(
                      height: 1,
                    ),
                    SizedBox(
                      height: widgetSpace,
                    ),
                    Text('Other option for signup/signin'),
                    SizedBox(
                      height: widgetSpace,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Appimages.email_logo,
                          height: 30,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Image.asset(
                          Appimages.fb_logo,
                          height: 30,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Image.asset(
                          Appimages.apple_logo,
                          height: 30,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
