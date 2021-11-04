import 'package:ditonton/domain/entities/network_tv_series.dart';
import 'package:equatable/equatable.dart';

class NetworkModel extends Equatable {
  const NetworkModel({this.name, this.id, this.logoPath, this.originCountry});

  final String? name;
  final int? id;
  final String? logoPath;
  final String? originCountry;

  factory NetworkModel.fromJson(Map<String, dynamic> json) => NetworkModel(
        name: json['name'] as String?,
        id: json['id'] as int?,
        logoPath: json['logo_path'] as String?,
        originCountry: json['origin_country'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'logo_path': logoPath,
        'origin_country': originCountry,
      };

  NetworkTvSeries toEntity() {
    return NetworkTvSeries(
      id: this.id,
      name: this.name,
      logoPath: this.logoPath,
      originCountry: this.originCountry,
    );
  }

  @override
  List<Object?> get props => [name, id, logoPath, originCountry];
}
