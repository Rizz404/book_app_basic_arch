import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/profile/profile_services.dart';
import 'package:book_app_basic_arch/features/profile/enum_profile_operation.dart';
import 'package:book_app_basic_arch/features/profile/model/profile_model.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileServices _userProfileServices = ProfileServices();

  UserWithProfileModel? _userProfile;
  UserWithProfileModel? get userProfile => _userProfile;

  // * Map untuk store operation state
  final Map<EnumProfileOperation, OperationState> _operationStates = {
    for (var operation in EnumProfileOperation.values)
      operation: (isLoading: false, errorMessage: null)
  };

  // * Getter untuk state
  bool isLoading(EnumProfileOperation operation) =>
      _operationStates[operation]!.isLoading;
  String? getError(EnumProfileOperation operation) =>
      _operationStates[operation]!.errorMessage;

  // Helper to update operation state
  void _updateOperationState(EnumProfileOperation operation,
      {bool? isLoading, String? errorMessage}) {
    _operationStates[operation] = (
      isLoading: isLoading ?? _operationStates[operation]!.isLoading,
      errorMessage: errorMessage
    );
    notifyListeners(); // ! sekali aja bang
  }

  Future<void> getUserProfile() async {
    try {
      _updateOperationState(
        EnumProfileOperation.getUserProfile,
        isLoading: true,
        errorMessage: null, // * Reset error message saat mulai loading
      );

      final response = await _userProfileServices.getUserProfile();
      _userProfile = response.data!;

      _updateOperationState(
        EnumProfileOperation.getUserProfile,
        isLoading: false,
        errorMessage: null, // * Clear error message on success
      );
    } catch (e) {
      _updateOperationState(
        EnumProfileOperation.getUserProfile,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching profiles: $e');
    }
  }

  Future<void> updateUserProfile(UpdateUserWithProfileModel profile) async {
    _updateOperationState(
      EnumProfileOperation.updateUserProfile,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _userProfileServices.updateUserProfile(profile);
      await getUserProfile();

      _updateOperationState(
        EnumProfileOperation.updateUserProfile,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumProfileOperation.updateUserProfile,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating profile: $e');
    }
  }
}
