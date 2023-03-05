import 'package:flutter/material.dart';
import 'package:pizza_ordering_app/view/register_page.dart';
import '../styles/Styles.dart';
import 'login_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [
              const Image(image: AssetImage('assets/introImage.png')),
              Container(
                  margin: const EdgeInsets.only(top: 234),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.orange[200],
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))
                  ),
                  child:Column(
                    children: [
                      const Text('My Pizza App',
                          style: TextStyles.textHeader
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            ElevatedButton(
                              style: ButtonStyles.buttonStyle,
                              onPressed: () => goToLoginPage(context),
                              child: const Text('Login',
                                  style: TextStyles.textButton
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.only(top: 10)
                            ),
                            ElevatedButton(
                                style: ButtonStyles.buttonStyle,
                                onPressed: () => goToRegisterPage(context),
                                child: const Text('Register',
                                    style: TextStyles.textButton
                                )
                            )
                          ],
                        ),
                      )
                    ],
                  )
              )
            ]
        )
    );
  }


  Future<dynamic> goToRegisterPage(BuildContext context) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>  const RegisterPage(),
    ));
  }

  Future<dynamic> goToLoginPage(BuildContext context) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>  const LoginPage(),
    ));
  }

}