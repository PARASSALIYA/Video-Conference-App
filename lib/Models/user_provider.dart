import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_conference_app/Models/user.dart';
part 'user_provider.g.dart';

//	dart run build_runner watch -d
@riverpod
class UserDataNotifier extends _$UserDataNotifier {
  CollectionReference<UserData> userCollection = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserData>(
        fromFirestore: (snapshots, _) => UserData.fromJson(snapshots.data()!),
        toFirestore: (userData, _) => userData.toJson(),
      );
  User? user;

  @override
  UserData build() {
    // Initial empty user state
    return UserData(uid: "", name: "");
  }

   Future<void> fetchCurrentUserData(String? uid) async {
    try {
      final docSnapshot = await userCollection.doc(uid ?? "").get();

      if (docSnapshot.exists) {
        state = docSnapshot.data()!;
        print("User with uid $uid found.");
      } else {
        print("User with uid $uid not found.");
        await FirebaseAuth.instance.signOut();
      }
    } catch (e) {
      print("Failed to fetch current user data: $e");
    }
  }

  void updateCurrentUserData({
    String? name,
    String? email,
    bool? isOnline,
    String? phoneNumber,
    String? profilePicUrl,
    int? noOfGroups,
    Set<String>? groupIds,
    int? noOfChats,
    Set<String>? chatIds,
    DateTime? dateOfBirth,
    String? gender,
  }) async {
    final userRef = userCollection.doc(state.uid);

    Map<String, dynamic> updatedData = {
      'name': name ?? state.name,
      'email': email ?? state.email,
      'isOnline': isOnline ?? state.isOnline,
      'phoneNumber': phoneNumber ?? state.phoneNumber,
      'pfpURL': profilePicUrl ?? state.pfpURL,
      'noOfGroups': noOfGroups ?? state.noOfGroups,
      'groupIds': groupIds ?? state.groupIds,
      'noOfChats': noOfChats ?? state.noOfChats,
      'chatIds': chatIds ?? state.chatIds,
      'dateOfBirth': dateOfBirth ?? state.chatIds,
      'gender': gender ?? state.gender,
    };

    try {
      await userRef.update(updatedData);
      state = UserData(
        uid: state.uid,
        name: name ?? state.name,
        email: email ?? state.email,
        isOnline: isOnline ?? state.isOnline,
        phoneNumber: phoneNumber ?? state.phoneNumber,
        pfpURL: profilePicUrl ?? state.pfpURL,
        noOfGroups: noOfGroups ?? state.noOfGroups,
        groupIds: groupIds ?? state.groupIds,
        noOfChats: noOfChats ?? state.noOfChats,
        chatIds: chatIds ?? state.chatIds,
        dateOfBirth: dateOfBirth ?? state.dateOfBirth,
        gender: gender ?? state.gender,
      );
      print('Document updated successfully!');
    } catch (e) {
      print('Error updating document: $e');
    }
  }

}
