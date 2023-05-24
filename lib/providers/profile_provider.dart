import 'package:flutter/material.dart';
import 'package:test_task/model/profile_model.dart';

class ProfileInfo with ChangeNotifier {
  ProfileModel? _profile;

  ProfileModel? get profileInfo => _profile;

  assignProfile(profileData) {
    _profile = ProfileModel(email: profileData.email, uid: profileData.uid);
    notifyListeners();
  }

  removeProfile() {
    _profile = null;
    notifyListeners();
  }
}
