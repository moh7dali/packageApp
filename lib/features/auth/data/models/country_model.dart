import '../../domain/entities/country.dart';

class CountryModel extends Country {
  const CountryModel({required super.callingCode, required super.iso2, required super.id, required super.name, required super.flag});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      callingCode: json['CallingCode'],
      iso2: json['ISO2'],
      id: json['Id'],
      name: json['Name'],
      flag: json['Flag'],
    );
  }

  factory CountryModel.fromCountry(Country country) {
    return CountryModel(
      callingCode: country.callingCode,
      iso2: country.iso2,
      id: country.id,
      name: country.name,
      flag: country.flag,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CallingCode': callingCode,
      'ISO2': iso2,
      'Id': id,
      'Name': name,
      'Flag': flag,
    };
  }
}
