import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:rhino_pizzeria_challenge/services/sign_in.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: _size.height * 0.075,
            width: _size.width * 0.6,
            margin: EdgeInsets.symmetric(horizontal: _size.width * 0.2),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () async {
                final provider =
                    Provider.of<SignInProvider>(context, listen: false);
                await provider.signInGoogle();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: _size.height * 0.065,
                    width: _size.width * 0.12,
                    margin: EdgeInsets.only(right: _size.width * 0.05),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/google.png'),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: _size.width * 0.04,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
