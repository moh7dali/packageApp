import '../../domain/entities/countries_list.dart';
import '../../domain/entities/country.dart';
import 'country_model.dart';

class CountriesListModel extends CountriesList {
  const CountriesListModel({required super.totalNumberOfResult, required super.countries});

  factory CountriesListModel.fromJson(Map<String, dynamic> json) {
    return CountriesListModel(
      totalNumberOfResult: json['TotalNumberOfResult'],
      countries: List<Country>.from(json['List'].map((x) => CountryModel.fromJson(x))),
    );
  }
}
