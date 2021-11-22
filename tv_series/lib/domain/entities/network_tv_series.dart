import 'package:equatable/equatable.dart';

class NetworkTvSeries extends Equatable {
  const NetworkTvSeries({
    this.name,
    this.id,
    this.logoPath,
    this.originCountry,
  });

  final String? name;
  final int? id;
  final String? logoPath;
  final String? originCountry;

  @override
  List<Object?> get props => [name, id, logoPath, originCountry];
}
