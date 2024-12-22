import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/feature/profile/profile_services.dart';
import 'package:book_app_basic_arch/feature/profile/enum_profile_operation.dart';
import 'package:book_app_basic_arch/feature/profile/model/profile_model.dart';
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
    notifyListeners();
  }

  Future<void> getUserProfile() async {
    _updateOperationState(EnumProfileOperation.getById, isLoading: true);
    notifyListeners();
    try {
      final response = await _userProfileServices.getUserProfile();

      _userProfile = response.data!;
    } catch (e) {
      _updateOperationState(EnumProfileOperation.getById,
          errorMessage: 'Error fetching genre: $e');
      debugPrint('Error fetching profiles: $e');
    } finally {
      _updateOperationState(EnumProfileOperation.getById, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> updateUserProfile(UpdateUserWithProfileModel profile) async {
    _updateOperationState(EnumProfileOperation.update, isLoading: true);
    notifyListeners();

    try {
      await _userProfileServices.updateUserProfile(profile);

      await getUserProfile();
    } catch (e) {
      _updateOperationState(EnumProfileOperation.update,
          errorMessage: 'Error updating genre: $e');
      debugPrint('Error updating profile: $e');
    } finally {
      _updateOperationState(EnumProfileOperation.update, isLoading: false);
      notifyListeners();
    }
  }
}
