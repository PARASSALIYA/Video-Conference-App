import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:video_conference_app/Models/user.dart';
import 'package:video_conference_app/Models/user_provider.dart';
import 'package:video_conference_app/Screens/Auth/signup.dart';
import 'package:video_conference_app/Screens/Home/bnb.dart';
import 'package:video_conference_app/services/database_services.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? user;

  Widget checkLogin() {
    print("checkingLogin function called");
    return Consumer(builder: (context, ref, child) {
      return StreamBuilder<User?>(
        stream: _firebaseAuth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
          if (snapshot.hasData) {
            print("User is signed in: to home screen");
            user = snapshot.data;
            ref
                .read(userDataNotifierProvider.notifier)
                .fetchCurrentUserData(user?.uid);
            print('User Firebase: ${user?.email}');

            return const Bnb();
          } else {
            print("User is not signed in: to auth screen");
            return const SignupScreen();
          }
        },
      );
    });
  }

  Future<bool> login(String email, String password, WidgetRef ref) async {
    print("login function called");
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        user = credential.user;
        ref
            .read(userDataNotifierProvider.notifier)
            .fetchCurrentUserData(user?.uid);
        return true;
      }
    } catch (e) {
      print("Error: $e");
      print("login failed");
      return false;
    }
    return false;
  }

  Future<bool> signup(
      String name, String email, String password, WidgetRef ref) async {
    print("signup function called");
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        user = credential.user;
        createUserProfile(
            userProfile: UserData(uid: user?.uid, name: name, email: email));
        ref
            .read(userDataNotifierProvider.notifier)
            .fetchCurrentUserData(user?.uid);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<bool> handleGoogleSignIn() async {
    print("handleGoogleSignIn function called");
    try {
      final userCredential = await signInWithGoogle();
      final user = userCredential?.user;
      final uid = user?.uid;
      final pfpicUrl = user?.photoURL;
      final email = user?.email;
      final name = user?.displayName;
      print("UID: $uid, \nemail: $email,");

      bool userExists = await checkExistingUser(uid!);

      if (user != null) {
        if (!userExists) {
          await createUserProfile(
              userProfile: UserData(
            uid: uid,
            name: name,
            pfpURL: pfpicUrl,
            email: email,
          ));
        }

        this.user = userCredential?.user;
        // go to HomeScreen
        print('Signed in as: ${user.displayName}');
        return true;
      } else {
        print("Gooogle signin failed");
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    print("signInWithGoogle function called");
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        return await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<bool> logout() async {
    print("logout function called");
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      user = null;
      return true;
    } catch (e) {
      print("Error: $e");
    }
    return false;
  }

  void logoutDilog(BuildContext context) {
    print("logoutDilog function called");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog.adaptive(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    logout();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                      (Route<dynamic> route) =>
                          false, // This removes all the previous routes
                    );
                  },
                  child: const Text("Yes")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No")),
            ],
          );
        });
  }

  Future<void> googleSignOut() async {
    print("googleSignOut function called");
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      print("Signed out of Google");
    } catch (e) {
      print("Error: $e");
    }
  }
}
