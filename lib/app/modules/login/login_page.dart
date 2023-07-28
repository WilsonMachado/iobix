import 'package:flutter/material.dart';

import 'widgets/login_body.dart';
import 'widgets/login_background.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: LoginBackground(
                child: LoginBody(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
