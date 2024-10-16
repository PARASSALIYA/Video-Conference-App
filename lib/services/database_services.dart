import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_conference_app/Models/user.dart';

CollectionReference<UserData> userCollection =
    FirebaseFirestore.instance.collection('users').withConverter<UserData>(
          fromFirestore: (snapshots, _) => UserData.fromJson(snapshots.data()!),
          toFirestore: (userData, _) => userData.toJson(),
        );

Future<void> createUserProfile({required UserData userProfile}) async {
  try {
    await userCollection.doc(userProfile.uid).set(userProfile);
  } catch (e) {
    print("Error creating user profile: $e");
  }
}

Future<bool> checkExistingUser(String uid) {
  CollectionReference blogsRef = FirebaseFirestore.instance.collection('users');
  return blogsRef.doc(uid).get().then((doc) {
    if (doc.exists) {
      return true;
    } else {
      return false;
    }
  });
}

Future<UserData> getUserDetailsFromUid(String uid) async {
  try {
    final docSnapshot = await userCollection.doc(uid).get();

    if (docSnapshot.exists) {
      UserData userDetails = docSnapshot.data()!;
      return userDetails;
    } else {
      return Future.error("User not found");
    }
  } catch (e) {
    return Future.error("Failed to fetch user data : $e");
  }
}

