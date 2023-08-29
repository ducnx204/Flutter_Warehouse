import 'package:template/data/model/response/language_model.dart';

const String BASE_URL = 'http://103.146.23.186:4008/v1/';
// const String BASE_URL = 'http://192.168.1.5:5008/v1/';

// api url
const String region_uri = 'v1/regions';

//login
const String login_uri = 'auth/login';

// TOPIC Firebase
const String TOPIC = 'TOPIC';

const String LANG_KEY = 'lang';
const String COUNTRY_CODE = 'country_code';
const String LANGUAGE_CODE = 'language_code';
const String THEME = 'theme';

// sharePreference
const String TOKEN = 'token';

List<LanguageModel> languages = [
  LanguageModel(
      imageUrl: '',
      languageName: 'Việt Nam',
      countryCode: 'VI',
      languageCode: 'vi'),
  LanguageModel(
      imageUrl: '',
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en'),
];

const String ID_CONG_TAC_VIEN = "6143888e28cd272928bd0fa2";
