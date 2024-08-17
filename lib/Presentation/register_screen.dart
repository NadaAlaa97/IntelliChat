import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/My_theme.dart';
import 'package:task/Presentation/cutom_textfields/textFields.dart';
import 'package:task/Presentation/login_screen.dart';

import 'home_page.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.lightPink,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 30,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      height: 170,
                      width: 150,
                      decoration: BoxDecoration(
                        color: MyTheme.lightCircle.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Center(
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      height: 190,
                      width: 180,
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  'Let\'s Get Started',
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: 'Cera Pro',
                    fontWeight: FontWeight.bold,
                    color: MyTheme.bgAppBar,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'Join intelliChat for smart conversations and personalized help.',
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Cera Pro',
                      color: MyTheme.bgAppBar,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        'Email',
                        style: TextStyle(color: MyTheme.bgAppBar, fontSize: 20),
                      ),
                    ),
                    CustomTextFields(
                      icon: Icons.email_outlined,
                      hintText: 'example@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                        passwordVisibile: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Password',
                        style: TextStyle(color: MyTheme.bgAppBar, fontSize: 20),
                      ),
                    ),
                    CustomTextFields(
                      icon: Icons.lock_outline,
                      hintText: '******',
                      keyboardType: TextInputType.number,
                      controller: passwordController,
                      iconPassword: Icons.visibility_off,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter password';
                        }
                        if (text.length < 6) {
                          return 'password cannot be less than 6 characters';
                        }
                        return null;
                      },
                      passwordVisibile: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Confirm Password',
                        style: TextStyle(color: MyTheme.bgAppBar, fontSize: 20),
                      ),
                    ),
                    CustomTextFields(
                      icon: Icons.lock_outline,
                      iconPassword: Icons.visibility_off,
                      hintText: '******',
                      keyboardType: TextInputType.number,
                      controller: confirmPasswordController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (text != passwordController.text) {
                          return 'Password is not correct';
                        }
                        return null;
                      },
                      passwordVisibile: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                      child: FloatingActionButton(
                        onPressed: () {
                          register();
                        },
                        child: Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: MyTheme.bgAppBar,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        backgroundColor: MyTheme.lightCircle.withOpacity(0.8),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already Have an Account?', style: TextStyle(
                            fontSize: 18,
                            color: MyTheme.bgAppBar,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cera Pro'
                          ),),
                          TextButton(onPressed: (){
                            Navigator.of(context).pushNamed(LoginScreen.routeName);
                          },
                              child: Text('Sign in', style: TextStyle(
                                color: MyTheme.lightCircle,
                                fontSize: 18
                              ),)
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() async{
    if (formKey.currentState?.validate() == true) {
      // try {
      //   final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //     email: emailController.text,
      //     password: passwordController.text,
      //   );
      //   print('register success');
      //   print(credential.user?.uid??'');
      // } on FirebaseAuthException catch (e) {
      //   if (e.code == 'weak-password') {
      //     print('The password provided is too weak.');
      //   } else if (e.code == 'email-already-in-use') {
      //     print('The account already exists for that email.');
      //   }
      // } catch (e) {
      //   print(e);
      // }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));

    }
  }
}
