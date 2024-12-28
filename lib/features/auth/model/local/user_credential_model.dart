import 'package:hive/hive.dart';

part 'user_credential_model.g.dart';

@HiveType(typeId: 1)
class UserCredentialModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String role;

  @HiveField(4)
  final String profilePicture;

  @HiveField(5)
  final bool isVerified;

  @HiveField(6)
  final bool isEmailVerified;

  @HiveField(7)
  final DateTime createdAt;

  @HiveField(8)
  final DateTime updatedAt;

  @HiveField(9)
  final String password;

  @HiveField(10)
  final String accessToken;

  @HiveField(11)
  final String refreshToken;

  UserCredentialModel({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.profilePicture,
    required this.isVerified,
    required this.isEmailVerified,
    required this.createdAt,
    required this.updatedAt,
    required this.password,
    required this.accessToken,
    required this.refreshToken,
  });
}
