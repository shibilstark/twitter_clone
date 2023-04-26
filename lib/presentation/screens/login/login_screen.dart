import 'package:flutter/material.dart';
import 'package:twitter_clone/config/config.dart';
import 'package:twitter_clone/presentation/widgets/asset_image.dart';
import 'package:twitter_clone/presentation/widgets/auth_textfield.dart';
import 'package:twitter_clone/presentation/widgets/rounded_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              controller: TextEditingController(),
              focusNode: FocusNode(),
            ),
            WhiteSpace.gapH25,
            CommonAuthTextFieldWidget(
              label: "Email Address",
              controller: TextEditingController(),
              focusNode: FocusNode(),
            ),
            const SizedBox(height: 35),
            Align(
              alignment: Alignment.centerRight,
              child: RoundedButtonWidget(
                onTap: () {},
                title: "Done",
              ),
            ),
            const SizedBox(height: 35),
            Text.rich(
              TextSpan(
                  text: "Alreeady have an account? ",
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
      title: AssetImageView(
        fileName: SvgAssets.twitterLogo,
        color: Palette.blueColor,
      ),
    );
  }
}
