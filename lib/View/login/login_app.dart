import 'package:flutter/material.dart';
import 'package:ugd_modul_2_kel1/client/auth_client.dart';
import 'package:ugd_modul_2_kel1/entity/user.dart';
import 'package:ugd_modul_2_kel1/view/login/login.dart';

class LoginApp extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  LoginApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) => Login(
              scaffoldMessengerKey: _scaffoldMessengerKey,
            ),
          ),
        );
      },
    );
  }
}

class Login extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  const Login({Key? key, required this.scaffoldMessengerKey}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController _firstInputController = TextEditingController();
  final TextEditingController _secondInputController = TextEditingController();
  String _result = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showSuccessLogin();
    });
  }

  void showSuccessLogin() {
    widget.scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(
        content: Text('Login success'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginView(
        firstInputController: _firstInputController,
        secondInputController: _secondInputController,
        result: _result,
        onLogin: testingLogin,
      ),
    );
  }

  Future<String> testingLogin(
      String inputUsername, String inputPassword, String operation) async {
    String result;

    User? response = await AuthClient.login(
      User(username: inputUsername, password: inputPassword),
    );

    // if(operation == 'loginSuccess') {
    //   if (response.id != null) {
    //     result = 'success';
    //   } else {
    //     result = 'failed';
    //   }
    // } else {
    //   if (response.id != null) {
    //     result = 'success';
    //   } else {
    //     result = 'failed';
    //   }
    // }

    if (response.id != null) {
      result = 'success';
    } else {
      result = 'failed';
    }

    // if (operation == 'add') {
    //   result = angkaPertama + angkaKedua;
    // } else if (operation == 'subtract') {
    //   result = angkaPertama - angkaKedua;
    // } else {
    //   result = 0;
    // }

    setState(() {
      _result = result;
    });

    return result;
  }
}
