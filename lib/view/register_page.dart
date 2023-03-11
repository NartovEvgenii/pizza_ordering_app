import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pizza_ordering_app/service/settings_service.dart';
import '../domain/address.dart';
import '../domain/settings.dart';
import '../domain/user.dart';
import '../service/address_service.dart';
import '../service/user_servise.dart';
import '../styles/Styles.dart';
import 'intro_page.dart';
import 'main_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _userService = GetIt.I.get<UserService>();
  final _addressService = GetIt.I.get<AddressService>();
  String _name = '';
  String _surname = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  Address? _address;
  int dropDownValue = 0;

  final TextEditingController textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
            children: [
              Stack(
                children: [
                  const Image(image: AssetImage('assets/introImage.png')),
                  Container(
                      margin:  EdgeInsets.only(top: 234),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.orange[200],
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))
                      ),
                      child:Column(
                        children: [
                          const Text('Sign Up',
                              style: TextStyles.textHeader
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                                  child: TextField(
                                    onChanged: _onNameChanged,
                                    decoration: getFieldInputDecoration("Name"),
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                                  child: TextField(
                                    onChanged: _onSurnameChanged,
                                    decoration: getFieldInputDecoration("Surname"),
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                                  child: TextField(
                                    onChanged: _onEmailChanged,
                                    decoration: getFieldInputDecoration("Email"),
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                                  child: TextField(
                                    obscureText: true,
                                    onChanged: _onPasswordChanged,
                                    decoration: getFieldInputDecoration("Password"),
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                                  child: TextField(
                                    obscureText: true,
                                    onChanged: _onConfirmPasswordChanged,
                                    decoration: getFieldInputDecoration("Confirm Password"),
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(33.0),
                                      ),
                                    child: FutureBuilder<List<Address>>(
                                      future: _addressService.getAddresses(),
                                      builder: (context, snapshot) {
                                        print(snapshot.hasData);
                                        if (snapshot.hasData) {
                                          var addresses = snapshot.data!;

                                          return DropdownButtonHideUnderline(
                                            child: DropdownButton2<Address>(
                                                isExpanded: true,
                                                hint: Text('Address', style: TextStyle(color: Colors.grey[800])),
                                                items: addresses.map((item) => DropdownMenuItem(
                                                    value: item,
                                                    child: Text(
                                                      item.getTitle(),
                                                    ),
                                                  )).toList(),
                                                value: _address,
                                                onChanged: _onAddressChanged,
                                              dropdownStyleData: const DropdownStyleData(
                                              maxHeight: 350,
                                              ),
                                            dropdownSearchData: DropdownSearchData(
                                              searchController: textEditingController,
                                              searchInnerWidgetHeight: 50,
                                              searchInnerWidget: Container(
                                                height: 50,
                                                child: TextFormField(
                                                  expands: true,
                                                  maxLines: null,
                                                  controller: textEditingController,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText: 'Search address...',
                                                    hintStyle: const TextStyle(fontSize: 12),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(33.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              searchMatchFn: (item, searchValue) {
                                                return (item.value!.getTitle().contains(searchValue));
                                              },
                                              ),
                                              //This to clear the search value when you close the menu
                                              onMenuStateChange: (isOpen) {
                                                if (!isOpen) {
                                                  textEditingController.clear();
                                                }
                                            },
                                          ),
                                        );
                                        }
                                        return Container();
                                        }),
                                  ),
                              ),
                              ElevatedButton(
                                style: ButtonStyles.buttonStyle,
                                onPressed: () =>
                                    _validate(context) ? onRegisterButtonClicked(context) : null,
                                child: const Text('Next',
                                    style: TextStyles.textButton
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: ElevatedButton(
                                      style: ButtonStyles.buttonStyle,
                                      onPressed: () => goToIntroPage(context),
                                      child: const Text('Cancel',
                                          style: TextStyles.textButton
                                      )
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

  InputDecoration getFieldInputDecoration(String hintText) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(33.0),
      ),
      filled: true,
      fillColor: Colors.white,
      hintStyle: TextStyle(color: Colors.grey[800]),
      hintText: hintText,
    );
  }

  Future<dynamic> goToIntroPage(BuildContext context) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>  const IntroPage(),
    ));
  }

  _onNameChanged(text) {
    setState(() {
      _name = text;
    });
  }

  _onSurnameChanged(text) {
    setState(() {
      _surname = text;
    });
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

  _onConfirmPasswordChanged(text) {
    setState(() {
      _confirmPassword = text;
    });
  }

  _onAddressChanged(address) {
    setState(() {
      _address = address;
    });
  }

  bool _validate(BuildContext context) {
    if(_name.isEmpty || _surname.isEmpty || _email.isEmpty ||
        _password.isEmpty || _confirmPassword.isEmpty){
      showSnackBar(context, "Not all fields are filled");
      return false;
       }else if(_password !=  _confirmPassword){
      showSnackBar(context, "Password mismatch");
      return false;
    } else {
      return true;
    }
  }

  void showSnackBar(BuildContext context, String text){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: Colors.red,
        )
    );
  }

  Future<dynamic> onRegisterButtonClicked(BuildContext context) {

    User user = User( _email, _name, _surname, _password, _address);
    _userService.register(user);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User successfully created"),
          backgroundColor: Colors.green,
        )
    );

    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>  const MainPage(),
    ));
  }

}