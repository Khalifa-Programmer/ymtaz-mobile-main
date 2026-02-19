import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppServices {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<Map<String, dynamic>?> signInWithGoogle(BuildContext context) async {
  try {
    await _googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    
    // هذا هو التوكن الذي يحتاجه الباك اند غالباً
    final String? idToken = googleAuth.idToken; 
    debugPrint('Google sign in info: $idToken');
    return {
      'token': idToken,
      'email': googleUser.email,
      'name': googleUser.displayName,
      'image': googleUser.photoUrl,
    };
  } catch (e) {
    return null;
  }
}

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ... rest of the file ...

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<Map<String, dynamic>?> signInWithApple(BuildContext context) async {
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

      // Return the identity token and user info
      debugPrint('Got identity token from Apple: ${result.identityToken}');
      return {
        'token': result.identityToken,
        'email': result.email,
        'name': '${result.givenName ?? ''} ${result.familyName ?? ''}'.trim(),
      };
      
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
