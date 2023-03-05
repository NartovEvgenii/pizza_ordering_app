import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pizza_ordering_app/view/main_page.dart';
import '../service/user_servise.dart';
import '../styles/Styles.dart';
import 'intro_page.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userService = GetIt.I.get<UserService>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
            children: [
              Stack(
                children: [
                  const Image(image: AssetImage('assets/introImage.png')),
                  Container(
                      height: MediaQuery.of(context).size.height - 234,
                      margin:  EdgeInsets.only(top: 234),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.orange[200],
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))
                      ),
                      child:Column(
                        children: [
                          const Text('Log in',
                              style: TextStyles.textHeader
                          ),
                        const Padding(
                          padding: EdgeInsets.only(top: 50),
                        ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                                  child: TextField(
                                    onChanged: _onEmailChanged,
                                  decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(33.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(color: Colors.grey[800]),
                                    hintText: "Email",
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                                  child: TextField(
                                    onChanged: _onPasswordChanged,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(33.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintStyle: TextStyle(color: Colors.grey[800]),
                                      hintText: "Password",
                                    ),
                                  )
                              ),
                              ElevatedButton(
                                style: ButtonStyles.buttonStyle,
                                  onPressed: () =>
                                  _validate() ? onLoginButtonClicked(context) : null,
                                child: const Text('Next',
                                    style: TextStyles.textButton
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(top: 10)
                              ),
                              ElevatedButton(
                                  style: ButtonStyles.buttonStyle,
                                  onPressed: () => goToIntroPage(context),
                                  child: const Text('Cancel',
                                      style: TextStyles.textButton
                                  )
                              )
                            ],
                          )
                        ],
                      )
                  )
                ]
            )
          ]
        )
    );
  }

  _onEmailChanged(text) {
    setState(() {
      _email = text;
    });
  }

  _onPasswordChanged(text) {
    setState(() {
      _password = text;
    });
  }

  bool _validate() {
    return  _email.isNotEmpty &&  _password.isNotEmpty ;
  }

  Future<dynamic> goToIntroPage(BuildContext context) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>  const IntroPage(),
    ));
  }

  Future<dynamic> onLoginButtonClicked(BuildContext context) {
    _userService.login(_email, _password);
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>  const MainPage(),
    ));
  }

}