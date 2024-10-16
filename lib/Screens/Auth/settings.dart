import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:video_conference_app/constants/colors.dart';
import 'package:video_conference_app/services/auth_services.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late AuthService _authService;

  @override
  void initState() {
    _authService = GetIt.instance.get<AuthService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            iconColor: primaryColor,
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              // logout functionality
              _authService.logoutDilog(context);
            },
          ),
        ),
      ],
    );
  }
}
