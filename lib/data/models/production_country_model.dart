import 'package:ditonton/domain/entities/production_country.dart';
import 'package:equatable/equatable.dart';

class ProductionCountryModel extends Equatable {
  const ProductionCountryModel({this.iso31661, this.name});

  final String? iso31661;
  final String? name;

  factory ProductionCountryModel.fromJson(Map<String, dynamic> json) {
    return ProductionCountryModel(
      iso31661: json['iso_3166_1'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'iso_3166_1': iso31661,
        'name': name,
      };

  ProductionCountry toEntity() {
    return ProductionCountry(
      iso31661: this.iso31661,
      name: this.name,
    );
  }

  @override
  List<Object?> get props => [iso31661, name];
}
