import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:login_facebook_flutter/google_sign_in.dart';
import 'package:login_facebook_flutter/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  Map? _userData;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          TextField(
            controller: _emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(label: Text('Email')),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: _passwordController,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(label: Text('Contraseña')),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.black54,
              minimumSize: const Size.fromHeight(50),
            ),
            icon: const Icon(Icons.lock_open, size: 32),
            label: const Text(
              'Iniciar Sesion',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: signIn,
          ),
          ButtonBar(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // final provider =
                  //     Provider.of<GoogleSigninProvider>(context, listen: false);
                  // provider.googleLogin();
                  signInWithGoogle();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
                icon: FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.red.shade400,
                ),
                label: Text(
                  'Entra con Google',
                  style: TextStyle(color: Colors.red.shade400),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  facebookLogin();
                },
                icon: const FaIcon(FontAwesomeIcons.facebook),
                label: const Text('Entra con Facebook'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    navigatorKey.currentState!.popUntil((route) => route.isFirst);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> facebookLogin() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    navigatorKey.currentState!.popUntil((route) => route.isFirst);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
