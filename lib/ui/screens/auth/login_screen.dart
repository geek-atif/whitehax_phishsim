import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth_controller.dart';
import '../../../ui/widgets/button/dark_blue_button.dart';
import '../../../ui/widgets/text/light_text_head.dart';
import '../../styles/my_app_theme.dart';
import '../../widgets/loading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  var emailAdress = "";
  var userName = "";
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _authController.login(userName, emailAdress);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyAppTheme.whitehaxBackgroundColor,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 30, right: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: screenSize.height * 0.09,
                  ),
                  const LightTextHead(data: "Login"),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  _userName(),
                  SizedBox(
                    height: screenSize.height * 0.04,
                  ),
                  _emailAdress(),
                  SizedBox(
                    height: screenSize.height * 0.06,
                  ),
                  Obx(
                    () => _authController.isLoading.value
                        ? const Loading(
                            loadingMessage: '',
                          )
                        : InkWell(
                            onTap: () => _login(),
                            child: DarkBlueButton(buttonText: "Login"),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Material _userName() {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 10.0,
      shadowColor: Colors.white,
      child: TextFormField(
        cursorColor: Colors.white,
        decoration: InputDecoration(
          fillColor: MyAppTheme.whitehaxSubColor,
          filled: true,
          prefixIcon: const Icon(Icons.person, color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.white, style: BorderStyle.solid, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.white, style: BorderStyle.solid, width: 2),
          ),
          labelText: 'UserName',
          labelStyle: const TextStyle(color: Colors.white),
          errorStyle: const TextStyle(color: MyAppTheme.errorRed),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'enter user name';
          }
        },
        onSaved: (value) {
          userName = value!;
        },
      ),
    );
  }

  Material _emailAdress() {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 10.0,
      shadowColor: Colors.white,
      child: TextFormField(
        cursorColor: Colors.white,
        decoration: InputDecoration(
          fillColor: MyAppTheme.whitehaxSubColor,
          filled: true,
          prefixIcon: const Icon(
            Icons.email,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.white, style: BorderStyle.solid, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.white, style: BorderStyle.solid, width: 2),
          ),
          labelText: 'Email',
          labelStyle: const TextStyle(color: Colors.white),
          errorStyle: const TextStyle(color: MyAppTheme.errorRed),
        ),
        validator: (value) {
          if (value!.isEmpty ||
              !value.contains('@') ||
              !value.contains('.com')) {
            return 'Invalid Email address';
          }
        },
        onSaved: (value) {
          emailAdress = value!;
        },
      ),
    );
  }
}
