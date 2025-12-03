import 'package:flutter/material.dart';
import 'package:workiom_test_app/features/signup/widgets/password_body_widget.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  static const routeName = 'password';
  static const routePath = '/password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: const [
            SliverFillRemaining(
              hasScrollBody: false,
              child: PasswordBodyWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
