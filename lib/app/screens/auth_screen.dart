import 'package:flutter/material.dart';
import 'package:my_souq/app/services/auth_service.dart';
import 'package:my_souq/components/declarations.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

enum AuthEnum {
  signin,
  signup
}

class AuthScreen extends StatefulWidget {
  static const String routName = '/auth-screen';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthEnum _auth = AuthEnum.signup;
  final _signUpKey = GlobalKey<FormState>();
  final _signInKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  final TextEditingController _emailTxt = TextEditingController();
  final TextEditingController _passwordTxt = TextEditingController();
  final TextEditingController _nameTxt = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailTxt.dispose();
    _passwordTxt.dispose();
    _nameTxt.dispose();
  }

  void signUpUser() {
    authService.signUpUser(context: context,
        email: _emailTxt.text,
        password: _passwordTxt.text,
        name: _nameTxt.text);
  }

  void signInUser() {
    authService.signInUser(context: context,
        email: _emailTxt.text,
        password: _passwordTxt.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Declarations.greyBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ListTile(
                    tileColor: _auth == AuthEnum.signup ? Colors.blueGrey : Declarations.greyBackgroundColor,
                    title: GestureDetector(
                      onTap: () {
                        setState(() {
                          _auth = AuthEnum.signup;
                        });
                      },
                      child: Text("New Customer", style:
                      TextStyle(
                          color: _auth == AuthEnum.signup ? Colors.amber : Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                      ),
                    ),
                    leading:GestureDetector(
                      onTap: () {
                        setState(() {
                          _auth = AuthEnum.signup;
                        });
                      },
                      child: Icon (
                      Icons.fiber_new_outlined,
                      color: _auth == AuthEnum.signup ? Colors.amber : Colors.black,
                  ),
                    ),
                  ),
                  if (_auth == AuthEnum.signup)
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Declarations.backgroundColor,
                      child: Form(
                          key: _signUpKey,
                          child: Column(
                            children: [
                              CustomText(
                                controller: _nameTxt, hinTxt: 'fullName', icon: Icons.person_outline,),
                              const SizedBox(height: 10,),
                              CustomText(controller: _emailTxt, hinTxt: 'Email',icon: Icons.email_outlined),
                              const SizedBox(height: 10,),
                              CustomText(
                                controller: _passwordTxt,
                                hinTxt: 'password',
                                icon: Icons.password_outlined,
                                isPassword: true,
                              ),
                              const SizedBox(height: 10,),
                              CustomButton(text: "Sign Up", onTap: () {
                                if (_signUpKey.currentState!.validate()) {
                                  signUpUser();
                                }
                              },
                              )
                            ],
                          )
                      ),
                    ),
                  ListTile(
                    tileColor: _auth == AuthEnum.signin ? Colors.blueGrey : Declarations.greyBackgroundColor,
                    title: GestureDetector(
                      onTap: () {
                        setState(() {
                          _auth = AuthEnum.signin;
                        });
                      },
                      child: Text("Have an account ?",
                        style: TextStyle(
                          color: _auth == AuthEnum.signin ? Colors.amber : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    leading:GestureDetector(
                      onTap: () {
                        setState(() {
                          _auth = AuthEnum.signin;
                        });
                      },
                      child: Icon (
                        Icons.accessibility_new_outlined,
                        color: _auth == AuthEnum.signin ? Colors.amber : Colors.black,
                      ),
                    ),
                  ),
                  if (_auth == AuthEnum.signin)
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Declarations.backgroundColor,
                      child: Form(
                          key: _signInKey,
                          child: Column(
                            children: [
                              CustomText(controller: _emailTxt, hinTxt: 'Email', icon: Icons.email_outlined),
                              const SizedBox(height: 10,),
                              CustomText(
                                controller: _passwordTxt,
                                  hinTxt: 'password',
                                  icon: Icons.password_outlined,
                                isPassword: true,
                              ),
                              const SizedBox(height: 10,),
                              CustomButton(text: "Sign In", onTap: () {
                                if (_signInKey.currentState!.validate()) {
                                  signInUser();
                                }
                              },)
                            ],
                          )
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            child: Image.asset(
                              "assets/buttons/google.png",
                              width: 260,
                            ),
                            onTap: () {

                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            child: Image.asset(
                              "assets/buttons/fb.png",
                              width: 260,
                            ),
                            onTap: () {

                            }),
                      ],
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
