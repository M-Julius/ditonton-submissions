import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/created_by.dart';

class CreatedByModel extends Equatable {
  const CreatedByModel({
    this.id,
    this.creditId,
    this.name,
    this.gender,
    this.profilePath,
  });

  final int? id;
  final String? creditId;
  final String? name;
  final int? gender;
  final String? profilePath;

  factory CreatedByModel.fromJson(Map<String, dynamic> json) => CreatedByModel(
        id: json['id'] as int?,
        creditId: json['credit_id'] as String?,
        name: json['name'] as String?,
        gender: json['gender'] as int?,
        profilePath: json['profile_path'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'credit_id': creditId,
        'name': name,
        'gender': gender,
        'profile_path': profilePath,
      };

  CreatedBy toEntity() {
    return CreatedBy(
      id: id,
      creditId: creditId,
      name: name,
      gender: gender,
      profilePath: profilePath,
    );
  }

  @override
  List<Object?> get props => [id, creditId, name, gender, profilePath];
}
