import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';

import 'google_sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    String userText = '';

    if (user.email != null) {
      userText = user.email!;
    } else if (user.displayName != null) {
      userText = user.displayName!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenido',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 9),
            Text(
              userText,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () async {
                // final provider =
                //     Provider.of<GoogleSigninProvider>(context, listen: false);
                // provider.googleLogout();

                await FacebookAuth.instance.logOut();
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.arrow_back, size: 32),
              label: const Text('Salir', style: TextStyle(fontSize: 24)),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
