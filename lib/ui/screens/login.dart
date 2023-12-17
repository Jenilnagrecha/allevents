import 'package:allevents/ui/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = false;

  @override
  _checkIfisLoggedIn() async {
    final accessToken = await FacebookAuth.instance.accessToken;

    setState(() {
      _checking = false;
    });

    if (accessToken != null) {
      print(accessToken.toJson());
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    } else {
      _login();
    }
  }

  _login() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
    } else {
      print(result.status);
      print(result.message);
    }
    setState(() {
      _checking = false;
    });
  }

  logout() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    print(_userData);
    return Scaffold(
      body: _checking
          ? Center(
              child: CircularProgressIndicator(),
            )
          : // if user data is not null then naviagate to home screen
          Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: width / 2,
                    height: width / 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  InkWell(
                    onTap: () async {
                      await _login();
                      if (_userData != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(
                              userData: _userData,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Login failed!!'),
                          ),
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.facebook,
                          color: Colors.blue,
                          size: 30,
                        ),
                        Text(
                          'Facebook login',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                      ],
                    ),
                  ),

                  // onPressed: _userData != null ? _logout : _login)
                ],
              ),
            ),
    );
  }
}
