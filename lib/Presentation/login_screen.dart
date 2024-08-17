import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/My_theme.dart';
import 'package:task/Presentation/cutom_textfields/textFields.dart';
import 'package:task/Presentation/home_page.dart';
import 'package:task/Presentation/login_screen.dart';
import 'package:task/Presentation/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  'Login',
                  style: TextStyle(
                    fontSize: 55,
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
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 20,
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
                      hintText: 'Enter your email',
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
                      hintText: 'Enter your password',
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
                      padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                      child: FloatingActionButton(
                        onPressed: () {
                          register();
                        },
                        child: Center(
                          child: Text(
                            'Login',
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
                          Text('Don\'t have an account?', style: TextStyle(
                              fontSize: 18,
                              color: MyTheme.bgAppBar,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cera Pro'
                          ),),
                          TextButton(onPressed: (){
                            Navigator.of(context).pushNamed(RegisterScreen.routeName);
                          },
                              child: Text('Sign up', style: TextStyle(
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

  void register() {
    if (formKey.currentState?.validate() == true) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}
