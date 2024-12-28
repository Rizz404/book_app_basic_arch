// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_credential_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserCredentialModelAdapter extends TypeAdapter<UserCredentialModel> {
  @override
  final int typeId = 1;

  @override
  UserCredentialModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserCredentialModel(
      id: fields[0] as String,
      username: fields[1] as String,
      email: fields[2] as String,
      role: fields[3] as String,
      profilePicture: fields[4] as String,
      isVerified: fields[5] as bool,
      isEmailVerified: fields[6] as bool,
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime,
      password: fields[9] as String,
      accessToken: fields[10] as String,
      refreshToken: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserCredentialModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.profilePicture)
      ..writeByte(5)
      ..write(obj.isVerified)
      ..writeByte(6)
      ..write(obj.isEmailVerified)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.password)
      ..writeByte(10)
      ..write(obj.accessToken)
      ..writeByte(11)
      ..write(obj.refreshToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCredentialModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
