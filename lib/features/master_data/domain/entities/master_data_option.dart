import 'package:equatable/equatable.dart';

class MasterDataOption extends Equatable {
  const MasterDataOption({
    required this.id,
    required this.code,
    required this.name,
    this.status = 1,
  });

  final int id;
  final String code;
  final String name;
  final int status;

  bool get isActive => status == 1;

  @override
  List<Object?> get props => [id, code, name, status];
}
