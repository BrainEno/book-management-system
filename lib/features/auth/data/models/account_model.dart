import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
sealed class AccountModel with _$AccountModel {
  const factory AccountModel({
    required int id,
    required String username,
    required String email,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String password,
    required String role,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
}
