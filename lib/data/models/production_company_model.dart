import 'package:ditonton/domain/entities/production_company.dart';
import 'package:equatable/equatable.dart';

class ProductionCompanyModel extends Equatable {
  const ProductionCompanyModel({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) {
    return ProductionCompanyModel(
      id: json['id'] as int?,
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String?,
      originCountry: json['origin_country'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'logo_path': logoPath,
        'name': name,
        'origin_country': originCountry,
      };

  ProductionCompany toEntity() {
    return ProductionCompany(
      id: this.id,
      logoPath: this.logoPath,
      name: this.name,
      originCountry: this.originCountry,
    );
  }

  @override
  List<Object?> get props => [id, logoPath, name, originCountry];
}
