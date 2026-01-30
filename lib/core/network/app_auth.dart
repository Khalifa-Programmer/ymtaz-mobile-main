import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppServices {


  Future<String?> signInWithGoogle(BuildContext context) async {
    try {
      // Initialize Google Sign In
      final GoogleSignIn googleSignIn = GoogleSignIn();
      
      // Check if a previous sign-in is available
      GoogleSignInAccount? currentUser = googleSignIn.currentUser;
      if (currentUser == null) {
        // Try silent sign-in first
        currentUser = await googleSignIn.signInSilently();
      }
      
      // If still null, prompt the user to sign in
      final GoogleSignInAccount? gUser = currentUser ?? await googleSignIn.signIn();
      if (gUser == null) {
        debugPrint('Google Sign-In was canceled by the user.');
        return null;
      }
      
      // Get authentication tokens
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      if (gAuth.idToken == null || gAuth.accessToken == null) {
        debugPrint('Failed to retrieve Google ID token or access token.');
        return null;
      }

      // Create credential for Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      try {
        // Sign in to Firebase
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        if (userCredential.user != null) {
          debugPrint('Signed in as: ${userCredential.user?.displayName}');
          debugPrint('Email: ${userCredential.user?.email}');
          debugPrint('User ID: ${userCredential.user?.uid}');
          
          // Return the ID token for backend authentication
          return gAuth.idToken;
        } else {
          debugPrint('Failed to sign in with Google.');
          return null;
        }
      } on FirebaseAuthException catch (e) {
        debugPrint('Firebase Auth error during Google Sign In: ${e.code} - ${e.message}');
        return null;
      }
    } catch (error) {
      debugPrint('Error signing in with Google: $error');
      return null;
    }
  }


  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<String?> signInWithApple(BuildContext context) async {
    try {
      // Check if Apple Sign In is available on this device
      final isAvailable = await SignInWithApple.isAvailable();
      if (!isAvailable) {
        debugPrint('Apple Sign In is not available on this device');
        return null;
      }

      final result = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      
      // Validate the identity token
      if (result.identityToken == null) {
        debugPrint('Failed to get identity token from Apple Sign In');
        return null;
      }
      
      // Return the identity token directly - this is what your backend needs
      debugPrint('Got identity token from Apple: ${result.identityToken}');
      return result.identityToken;
      
      /*
      // We're bypassing Firebase Auth since we're sending the token directly to our backend
      // Initialize Firebase Auth provider
      final provider = OAuthProvider("apple.com").credential(
        idToken: result.identityToken!,
        accessToken: result.authorizationCode,
      );
      
      // Sign in with Firebase
      try {
        final UserCredential userCredential = await _auth.signInWithCredential(provider);
        if (userCredential.user != null) {
          debugPrint('Signed in with Apple: ${userCredential.user!.displayName}');
          debugPrint('Email: ${userCredential.user!.email}');
          debugPrint('User ID: ${userCredential.user!.uid}');
          
          // Update user profile if name is provided and user's displayName is null
          if (userCredential.user!.displayName == null && 
              (result.givenName != null || result.familyName != null)) {
            await userCredential.user!.updateDisplayName(
              '${result.givenName ?? ''} ${result.familyName ?? ''}'.trim()
            );
          }
          
          return userCredential.user!.uid;
        }
        return null;
      } on FirebaseAuthException catch (e) {
        debugPrint('Firebase Auth error during Apple Sign In: ${e.code} - ${e.message}');
        return null;
      }
      */
    } catch (e) {
      debugPrint('Error signing in with Apple: $e');
      return null;
    }
  }

// Future _login(String? name, String? email, String? tokenid,
//     BuildContext context) async {
//
//
//   await DioHelper.postData(
//       url: "/auth/register/social",
//       data: {"name": name, "email": email, "device_token": tokenid})
//       .then((value) {
//     if (value.data['user']['phone'] != null && value.statusCode == 200) {
//       CacheHelper.saveData(
//           key: "token", value: "Bearer ${value.data['token']}");
//       var token = CacheHelper.getData(key: 'token');
//       print(token);
//       context.pushNamed(Routes.selectCountry);
//     } else {
//       CacheHelper.saveData(
//           key: "token", value: "Bearer ${value.data['token']}");
//       var token = CacheHelper.getData(key: 'token');
//       print("${token} =  ===============");
//
//       context.pushNamedAndRemoveUntil(Routes.selectCountry,
//           predicate: (Route<dynamic> route) => false);
//     }
//   });
// }
}
