import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:supapet/handler/feedback.dart';

import '../data/appdata.dart';

Future<bool?> showLogin(BuildContext context) async {
  return await showModalBottomSheet<bool>(
    context: context,
    builder: (context) {
      return Login(
        onLogin: () {
          Navigator.pop(context, true);
        },
      );
    },
  );
}

class Login extends ConsumerWidget {
  const Login({super.key, required this.onLogin});
  final void Function() onLogin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SupaEmailAuth(
      onError: (error) {
        FeedbackHandler.showToast(
            msg: 'login failed, please check your email or password');
      },
      onSignInComplete: (response) async {
        ref.read(appData).loginUpdate(
            id: response.user!.id, token: response.session!.accessToken);
        FeedbackHandler.showLoading();
        await ref.read(appData).findUserPets();
        await ref.read(appData).findUserLikePost();
        FeedbackHandler.hideLoading();
        onLogin();
      },
      onSignUpComplete: (response) {
        FeedbackHandler.showToast(
            msg: 'email sent, login with psw after confirm your email');
      },
    );
  }
}
