import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
@JsonSerializable()
class AppUser with _$AppUser {
  @override
  final String username;
  @override
  final String? email;
  @override
  final int id;
  @override
  final String role;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  const AppUser({
    required this.id,
    required this.username,
    required this.role,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory AppUser.fromJson(Map<String, Object?> json) =>
      _$AppUserFromJson(json);
  Map<String, Object?> toJson() => _$AppUserToJson(this);
}
