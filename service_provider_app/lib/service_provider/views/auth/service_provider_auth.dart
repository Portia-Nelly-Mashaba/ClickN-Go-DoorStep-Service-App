import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider_app/service_provider/views/auth/service_provider_register_screen.dart';

class ServiceProviderAuth extends StatelessWidget {
  const ServiceProviderAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return SignInScreen(providerConfigs: [
            EmailProviderConfiguration(),
            GoogleProviderConfiguration(
                clientId: '1:1007793499453:android:430c33032d118bb181a954'),
            PhoneProviderConfiguration(),
          ]);
        }

        // Render your application if authenticated
        return ServiceProviderScreen();
      },
    );
  }
}
