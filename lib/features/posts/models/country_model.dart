// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../core/constants.dart';

class Country {
  final String name;
  final String code;
   final String flag;
  Country({
    required this.name,
    required this.code,
    required this.flag,
  });

//coutries list........................ ............................... ............... .............
  static List<Country> availableCountries = [
  Country(name: 'England',code: 'gb', flag: '${AppConstants.imgPath}england.png'),
  Country(name: 'WorldWide',code: 'worldwide', flag: '${AppConstants.imgPath}earth.png'),
  Country(name: 'Tanzania',code: 'tz', flag: '${AppConstants.imgPath}tanzania.png'),
  Country(name: 'Nigeria',code: 'ng', flag: '${AppConstants.imgPath}nigeria.png'),
  Country(name: 'South Africa',code: 'za', flag: '${AppConstants.imgPath}south-africa.png'),
  Country(name: 'Italy',code: 'it', flag: '${AppConstants.imgPath}italy.png'),
  Country(name: 'Spain',code: 'es', flag: '${AppConstants.imgPath}spain.png'),
  Country(name: 'France',code: 'fr', flag: '${AppConstants.imgPath}france.png'),
  Country(name: 'Germany',code: 'de', flag: '${AppConstants.imgPath}germany.png'),
  Country(name: 'India',code: 'in', flag: '${AppConstants.imgPath}india.png'),
  Country(name: 'Japan',code: 'jp', flag: '${AppConstants.imgPath}japan.png'),
  Country(name: 'USA',code: 'us', flag: '${AppConstants.imgPath}united-states.png'),
  Country(name: 'China', code: 'cn', flag: '${AppConstants.imgPath}china.png'),
  Country(name: 'Brazil', code: 'br', flag: '${AppConstants.imgPath}brazil.png'),
  Country(name: 'Australia',code: 'au', flag: '${AppConstants.imgPath}australia.png'),

];

  static List<Country> sortedCountries(){

     List<Country> countries = [...availableCountries];
      countries.sort((a,b)=>a.name.compareTo(b.name) );
     return countries;

  }
}


