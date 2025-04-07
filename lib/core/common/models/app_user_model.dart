import 'package:bookstore_management_system/core/common/entities/app_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user_model.g.dart';

@JsonSerializable()
class AppUserModel extends AppUser {
  AppUserModel({
    required super.id,
    required super.username,
    super.email,
    required super.role,
  });

  factory AppUserModel.fromJson(Map<String, dynamic> json) =>
      _$AppUserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AppUserModelToJson(this);
}
