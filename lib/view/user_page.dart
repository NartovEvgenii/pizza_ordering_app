import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../domain/settings.dart';
import '../service/settings_service.dart';
import '../styles/Styles.dart';
import 'intro_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UserPageState();
  }
}

class _UserPageState extends State<UserPage> {

  final _settingsService = GetIt.I.get<SettingsService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
          title: const Text('Profile', style: TextStyles.textHeader),
          centerTitle: true,
          backgroundColor: Colors.orange[200],
        ),
        body: FutureBuilder<Settings?>(
            future: _settingsService.getSettings(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var settings = snapshot.data!;

                return Column(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(15, 15, 15, 5),
                        child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${settings.name} ${settings.surname}",
                                style: TextStyles.textHeader,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(83, 35),
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  )
                                ),
                                onPressed: () => logOutButtonClicked(context),
                                child: const Text('Log out',
                                    style: TextStyles.textButton
                                ),
                              )
                            ],
                        )
                      ),
                    ]
                );
              }
              return Container();
            })
    );
  }

  Future<dynamic> logOutButtonClicked(BuildContext context) {
    _settingsService.deleteSettings();
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>  const IntroPage(),
    ));
  }
}