import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_clone/config/config.dart';
import 'package:twitter_clone/presentation/bloc/auth/auth_bloc.dart';
import 'package:twitter_clone/presentation/router/router.dart';
import 'package:twitter_clone/presentation/widgets/asset_image.dart';
import 'package:twitter_clone/presentation/widgets/auth_textfield.dart';
import 'package:twitter_clone/presentation/widgets/rounded_button.dart';
import 'package:twitter_clone/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final ValueNotifier<String?> errorStatus;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final FocusNode emailNode;
  late final FocusNode passwordNode;

  @override
  void initState() {
    errorStatus = ValueNotifier(null);
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    errorStatus.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  bool checkIfValid() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final isEmailValid = email.isNotEmpty && email.isValidEmail();
    final isPasswordValid = password.isValidPassword();

    if (isEmailValid && isPasswordValid) {
      errorStatus.value = null;
      errorStatus.notifyListeners();
      return true;
    }
    errorStatus.value = "Credentials format is incorrect";
    errorStatus.notifyListeners();
    return false;
  }

  void onTapDone() {
    log("calling function");
    if (checkIfValid()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      log("called login");
      context.read<AuthBloc>().add(LoginUser(
            email: email,
            password: password,
            context: context,
          ));
    } else {
      log(errorStatus.value.toString());
    }
  }

  void onTapSignup() {
    AppNavigator.push(
      context: context,
      screenName: AppRouter.SIGNUP_SCREEN,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: LoginAppBarWidget(),
      ),
      body: Padding(
        padding: AppPadding.largeScreenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonAuthTextFieldWidget(
              label: "Email Address",
              controller: emailController,
              focusNode: emailNode,
            ),
            WhiteSpace.gapH25,
            CommonAuthTextFieldWidget(
              label: "Email Address",
              controller: passwordController,
              focusNode: passwordNode,
            ),
            const SizedBox(height: 35),
            Align(
              alignment: Alignment.centerRight,
              child: RoundedButtonWidget(
                onTap: onTapDone,
                title: "Done",
              ),
            ),
            const SizedBox(height: 35),
            GestureDetector(
              onTap: onTapSignup,
              child: Text.rich(
                TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      color: Palette.whiteColor,
                      fontSize: AppFontSize.bodySmall,
                    ),
                    children: [
                      TextSpan(
                        text: "Signup",
                        style: TextStyle(
                          color: Palette.blueColor,
                          fontSize: AppFontSize.bodySmall,
                        ),
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginAppBarWidget extends StatelessWidget {
  const LoginAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Palette.backgroundColor,
      title: const AssetImageView(
        fileName: SvgAssets.twitterLogo,
        color: Palette.blueColor,
      ),
    );
  }
}
