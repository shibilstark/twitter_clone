import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_clone/config/config.dart';
import 'package:twitter_clone/presentation/bloc/auth/auth_bloc.dart';
import 'package:twitter_clone/presentation/router/router.dart';
import 'package:twitter_clone/presentation/widgets/asset_image.dart';
import 'package:twitter_clone/presentation/widgets/auth_textfield.dart';
import 'package:twitter_clone/presentation/widgets/rounded_button.dart';
import 'package:twitter_clone/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final ValueNotifier<String?> errorStatus;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController conformPasswordController;
  late final FocusNode emailNode;
  late final FocusNode passwordNode;
  late final FocusNode conformPasswordNode;

  @override
  void initState() {
    errorStatus = ValueNotifier(null);
    emailController = TextEditingController();
    passwordController = TextEditingController();
    conformPasswordController = TextEditingController();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    conformPasswordNode = FocusNode();
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
    final confPassword = conformPasswordController.text.trim();
    final isEmailValid = email.isNotEmpty && email.isValidEmail();
    final isPasswordValid = password.isValidPassword();
    final isConfPasswordValid = password == confPassword;

    if (isEmailValid && isPasswordValid) {
      if (isConfPasswordValid) {
        errorStatus.value = null;
        errorStatus.notifyListeners();
        return true;
      }

      errorStatus.value = "Make sure entered passwords are same";
      errorStatus.notifyListeners();
      return false;
    }
    errorStatus.value = "Credentials format is incorrect";
    errorStatus.notifyListeners();
    return false;
  }

  void onTapDone() {
    if (checkIfValid()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      context.read<AuthBloc>().add(SignUpUser(
            email: email,
            password: password,
            context: context,
          ));
    }
  }

  void onTapLogin() {
    AppNavigator.pop(context);
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
              label: "Email ",
              controller: emailController,
              focusNode: emailNode,
            ),
            WhiteSpace.gapH25,
            CommonAuthTextFieldWidget(
              label: "Password",
              controller: passwordController,
              focusNode: passwordNode,
            ),
            WhiteSpace.gapH25,
            CommonAuthTextFieldWidget(
              label: "Conform Password",
              controller: conformPasswordController,
              focusNode: conformPasswordNode,
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
              onTap: onTapLogin,
              child: Text.rich(
                TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(
                      color: Palette.whiteColor,
                      fontSize: AppFontSize.bodySmall,
                    ),
                    children: [
                      TextSpan(
                        text: "Login",
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
