import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/spoken_langauge.dart';

class SpokenLanguageModel extends Equatable {
  const SpokenLanguageModel({this.englishName, this.iso6391, this.name});

  final String? englishName;
  final String? iso6391;
  final String? name;

  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) {
    return SpokenLanguageModel(
      englishName: json['english_name'] as String?,
      iso6391: json['iso_639_1'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'english_name': englishName,
        'iso_639_1': iso6391,
        'name': name,
      };

  SpokenLanguage toEntity() {
    return SpokenLanguage(
      englishName: englishName,
      iso6391: iso6391,
      name: name,
    );
  }

  @override
  List<Object?> get props => [englishName, iso6391, name];
}
