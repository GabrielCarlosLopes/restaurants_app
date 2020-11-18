import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:layout_teste/src/pages/forget_password.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _obscure = true;
  bool disabled = true;

  Icon icon = Icon(Icons.email, color: Colors.transparent);
  Icon iconObscure = Icon(Icons.visibility, color: Colors.black);

  final Color backgroundColor = Color(0xFF277E6D);
  final Color disabledColor = Color(0xFF11362E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _buildImageBackground(),
          _buildBlur(),
          _backButton(),
          SafeArea(
            child: _buildBody(),
          )
        ],
      ),
    );
  }

  Function onPressButton() {
    if (disabled == true) {
      return null;
    } else {
      return () {
        if (_formKey.currentState.validate()) {}
      };
    }
  }

  Widget _buildImageBackground() {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/background_login.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBlur() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.black.withOpacity(0),
        ),
      ),
    );
  }

  Widget _backButton() {
    return Container(
      margin: EdgeInsets.only(top: 60),
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: TextFormField(
                      controller: _emailController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          suffixIcon: icon),
                      onChanged: (value) {
                        setState(
                          () {
                            if (value.contains('@') && value.contains('.com')) {
                              icon = Icon(
                                Icons.check,
                                color: Colors.green,
                              );
                              disabled = false;
                            } else {
                              icon = Icon(
                                Icons.close,
                                color: Colors.red,
                              );
                              disabled = true;
                            }
                          },
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: TextFormField(
                      obscureText: _obscure,
                      controller: _passwordController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: iconObscure,
                          onPressed: () {
                            setState(() {
                              if (_obscure == true) {
                                _obscure = false;
                                iconObscure = Icon(
                                  Icons.visibility_off,
                                  color: Colors.black,
                                );
                              } else {
                                _obscure = true;
                                iconObscure = Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                );
                              }
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ForgetPassword(),
                ),
              );
            },
            child: Text(
              'Forgot your password?',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: RaisedButton(
              onPressed: onPressButton(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: backgroundColor,
              disabledColor: disabledColor,
              disabledElevation: 0,
              elevation: 5,
              child: Text(
                'Log in',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Padding(
        padding: EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome back',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            SizedBox(height: 40),
            _buildForm(),
          ],
        ),
      ),
    );
  }
}
