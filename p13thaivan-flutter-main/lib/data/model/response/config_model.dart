class ConfigModel {
  int? _systemDefaultCurrency;
  BaseUrls? _baseUrls;
  StaticUrls? _staticUrls;
  List<CurrencyList>? _currencyList;
  Language? _language;

  ConfigModel(
      {int? systemDefaultCurrency,
      BaseUrls? baseUrls,
      StaticUrls? staticUrls,
      List<CurrencyList>? currencyList,
      Language? language}) {
    _systemDefaultCurrency = systemDefaultCurrency;
    _baseUrls = baseUrls;
    _staticUrls = staticUrls;
    _currencyList = currencyList;
    _language = language;
  }

  int? get systemDefaultCurrency => _systemDefaultCurrency;
  BaseUrls? get baseUrls => _baseUrls;
  StaticUrls? get staticUrls => _staticUrls;
  List<CurrencyList>? get currencyList => _currencyList;
  Language? get language => _language;

  ConfigModel.fromJson(Map<String, dynamic> json) {
    _systemDefaultCurrency = int.parse(json['system_default_currency'].toString());
    _baseUrls = json['base_urls'] != null
        ? BaseUrls.fromJson(json['base_urls'] as Map<String, dynamic>)
        : null;
    _staticUrls = json['static_urls'] != null
        ? StaticUrls.fromJson(json['static_urls'] as Map<String, dynamic>)
        : null;
    if (json['currency_list'] != null) {
      _currencyList = [];
      json['currency_list'].forEach((v) {
        _currencyList!.add(CurrencyList.fromJson(v  as Map<String, dynamic>));
      });
    }
    _language = json['language'] != null
        ? Language.fromJson(json['language'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['system_default_currency'] = _systemDefaultCurrency;
    if (_baseUrls != null) {
      data['base_urls'] = _baseUrls!.toJson();
    }
    if (_staticUrls != null) {
      data['static_urls'] = _staticUrls!.toJson();
    }
    if (_currencyList != null) {
      data['currency_list'] =
          _currencyList!.map((v) => v.toJson()).toList();
    }
    if (_language != null) {
      data['language'] = _language!.toJson();
    }
    return data;
  }
}

class BaseUrls {
  String? _productImageUrl;
  String? _productThumbnailUrl;
  String? _brandImageUrl;
  String? _customerImageUrl;
  String? _bannerImageUrl;
  String? _categoryImageUrl;
  String? _reviewImageUrl;
  String? _sellerImageUrl;
  String? _shopImageUrl;
  String? _notificationImageUrl;

  BaseUrls(
      {String? productImageUrl,
      String? productThumbnailUrl,
      String? brandImageUrl,
      String? customerImageUrl,
      String? bannerImageUrl,
      String? categoryImageUrl,
      String? reviewImageUrl,
      String? sellerImageUrl,
      String? shopImageUrl,
      String? notificationImageUrl}) {
    _productImageUrl = productImageUrl;
    _productThumbnailUrl = productThumbnailUrl;
    _brandImageUrl = brandImageUrl;
    _customerImageUrl = customerImageUrl;
    _bannerImageUrl = bannerImageUrl;
    _categoryImageUrl = categoryImageUrl;
    _reviewImageUrl = reviewImageUrl;
    _sellerImageUrl = sellerImageUrl;
    _shopImageUrl = shopImageUrl;
    _notificationImageUrl = notificationImageUrl;
  }

  String? get productImageUrl => _productImageUrl;
  String? get productThumbnailUrl => _productThumbnailUrl;
  String? get brandImageUrl => _brandImageUrl;
  String? get customerImageUrl => _customerImageUrl;
  String? get bannerImageUrl => _bannerImageUrl;
  String? get categoryImageUrl => _categoryImageUrl;
  String? get reviewImageUrl => _reviewImageUrl;
  String? get sellerImageUrl => _sellerImageUrl;
  String? get shopImageUrl => _shopImageUrl;
  String? get notificationImageUrl => _notificationImageUrl;

  BaseUrls.fromJson(Map<String, dynamic> json) {
    _productImageUrl = json['product_image_url'].toString();
    _productThumbnailUrl = json['product_thumbnail_url'].toString();
    _brandImageUrl = json['brand_image_url'].toString();
    _customerImageUrl = json['customer_image_url'].toString();
    _bannerImageUrl = json['banner_image_url'].toString();
    _categoryImageUrl = json['category_image_url'].toString();
    _reviewImageUrl = json['review_image_url'].toString();
    _sellerImageUrl = json['seller_image_url'].toString();
    _shopImageUrl = json['shop_image_url'].toString();
    _notificationImageUrl = json['notification_image_url'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_image_url'] = _productImageUrl;
    data['product_thumbnail_url'] = _productThumbnailUrl;
    data['brand_image_url'] = _brandImageUrl;
    data['customer_image_url'] = _customerImageUrl;
    data['banner_image_url'] = _bannerImageUrl;
    data['category_image_url'] = _categoryImageUrl;
    data['review_image_url'] = _reviewImageUrl;
    data['seller_image_url'] = _sellerImageUrl;
    data['shop_image_url'] = _shopImageUrl;
    data['notification_image_url'] = _notificationImageUrl;
    return data;
  }
}

class StaticUrls {
  String? _aboutUs;
  String? _faq;
  String? _termsConditions;
  String? _contactUs;
  String? _brands;
  String? _categories;
  String? _customerAccount;

  StaticUrls(
      {String? aboutUs,
      String? faq,
      String? termsConditions,
      String? contactUs,
      String? brands,
      String? categories,
      String? customerAccount}) {
    _aboutUs = aboutUs;
    _faq = faq;
    _termsConditions = termsConditions;
    _contactUs = contactUs;
    _brands = brands;
    _categories = categories;
    _customerAccount = customerAccount;
  }

  String? get aboutUs => _aboutUs;
  String? get faq => _faq;
  String? get termsConditions => _termsConditions;
  String? get contactUs => _contactUs;
  String? get brands => _brands;
  String? get categories => _categories;
  String? get customerAccount => _customerAccount;

  StaticUrls.fromJson(Map<String, dynamic> json) {
    _aboutUs = json['about_us'].toString();
    _faq = json['faq'].toString();
    _termsConditions = json['terms_&_conditions'].toString();
    _contactUs = json['contact_us'].toString();
    _brands = json['brands'].toString();
    _categories = json['categories'].toString();
    _customerAccount = json['customer_account'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['about_us'] = _aboutUs;
    data['faq'] = _faq;
    data['terms_&_conditions'] = _termsConditions;
    data['contact_us'] = _contactUs;
    data['brands'] = _brands;
    data['categories'] = _categories;
    data['customer_account'] = _customerAccount;
    return data;
  }
}

class CurrencyList {
  int? _id;
  String? _name;
  String? _symbol;
  String? _code;
  double? _exchangeRate;
  int? _status;
  String? _createdAt;
  String? _updatedAt;

  CurrencyList(
      {int? id,
      String? name,
      String? symbol,
      String? code,
      double? exchangeRate,
      int? status,
      String? createdAt,
      String? updatedAt}) {
    _id = id;
    _name = name;
    _symbol = symbol;
    _code = code;
    _exchangeRate = exchangeRate;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  int? get id => _id;
  String? get name => _name;
  String? get symbol => _symbol;
  String? get code => _code;
  double? get exchangeRate => _exchangeRate;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  CurrencyList.fromJson(Map<String, dynamic> json) {
    _id = int.parse(json['id'].toString());
    _name = json['name'].toString();
    _symbol = json['symbol'].toString();
    _code = json['code'].toString();
    _exchangeRate = double.parse(json['exchange_rate'].toDouble().toString());
    _status = int.parse(json['status'].toString());
    _createdAt = json['created_at'].toString();
    _updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['symbol'] = _symbol;
    data['code'] = _code;
    data['exchange_rate'] = _exchangeRate;
    data['status'] = _status;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}

class Language {
  LanguageList? _languageList;
  Data? _data;

  Language({LanguageList? list, Data? data}) {
    _languageList = list;
    _data = data;
  }

  LanguageList? get languageList => _languageList;
  Data? get data => _data;

  Language.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      _languageList = LanguageList.fromJson(json['list'] as Map<String, dynamic>);
    } else {
      _languageList = null;
    }

    if (json['data'] != null) {
      _data = Data.fromJson(json['data'] as Map<String, dynamic>);
    } else {
      _data = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_languageList != null) {
      data['list'] = _languageList!.toJson();
    }
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    return data;
  }
}

class LanguageList {
  String? _bn;
  String? _en;

  LanguageList({String? bn, String? en}) {
    _bn = bn;
    _en = en;
  }

  String? get bn => _bn;
  String? get en => _en;

  LanguageList.fromJson(Map<String, dynamic> json) {
    _bn = json['bn'].toString();
    _en = json['en'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bn'] = _bn;
    data['en'] = _en;
    return data;
  }
}

class Data {
  Bn? _bn;
  En? _en;

  Data({Bn? bn, En? en}) {
    _bn = bn;
    _en = en;
  }

  Bn? get bn => _bn;
  En? get en => _en;

  Data.fromJson(Map<String, dynamic> json) {
    _bn = json['bn'] != null ? Bn.fromJson(json['bn'] as Map<String, dynamic>) : null;
    _en = json['en'] != null ? En.fromJson(json['en'] as Map<String, dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_bn != null) {
      data['bn'] = _bn!.toJson();
    }
    if (_en != null) {
      data['en'] = _en!.toJson();
    }
    return data;
  }
}

class Bn {
  String? _home;

  Bn({String? home}) {
    _home = home;
  }

  String? get home => _home;

  Bn.fromJson(Map<String, dynamic> json) {
    _home = json['Home'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Home'] = _home;
    return data;
  }
}

class En {
  String? _home;
  String? _signIn;
  String? _myCart;
  String? _shippingMethod;
  String? _banner;
  String? _addMainBanner;
  String? _addFooterBanner;
  String? _mainBannerForm;
  String? _bannerUrl;
  String? _bannerType;
  String? _published;
  String? _mainBannerImage;
  String? _footerBannerForm;
  String? _footerBannerImage;
  String? _bannerTable;
  String? _bannerPhoto;
  String? _categories;
  String? _allCategories;
  String? _latestProducts;
  String? _moreProducts;
  String? _brands;
  String? _brandUpdate;
  String? _viewAll;
  String? _brand;
  String? _brandForm;
  String? _name;
  String? _brandLogo;
  String? _brandTable;
  String? _sl;
  String? _image;
  String? _action;
  String? _save;
  String? _update;
  String? _category;
  String? _icon;
  String? _categoryForm;
  String? _categoryTable;
  String? _slug;
  String? _subCategory;
  String? _subCategoryForm;
  String? _subCategoryTable;
  String? _selectCategoryName;
  String? _cashOnDelivery;
  String? _sslCommerzPayment;
  String? _paypal;
  String? _stripe;
  String? _paytm;

  En({String? home,
      String? signIn,
      String? myCart,
      String? shippingMethod,
      String? banner,
      String? addMainBanner,
      String? addFooterBanner,
      String? mainBannerForm,
      String? bannerUrl,
      String? bannerType,
      String? published,
      String? mainBannerImage,
      String? footerBannerForm,
      String? footerBannerImage,
      String? bannerTable,
      String? bannerPhoto,
      String? categories,
      String? allCategories,
      String? latestProducts,
      String? moreProducts,
      String? brands,
      String? brandUpdate,
      String? viewAll,
      String? brand,
      String? brandForm,
      String? name,
      String? brandLogo,
      String? brandTable,
      String? sl,
      String? image,
      String? action,
      String? save,
      String? update,
      String? category,
      String? icon,
      String? categoryForm,
      String? categoryTable,
      String? slug,
      String? subCategory,
      String? subCategoryForm,
      String? subCategoryTable,
      String? selectCategoryName,
      String? cashOnDelivery,
      String? sslCommerzPayment,
      String? paypal,
      String? stripe,
      String? paytm}) {
    _home = home;
    _signIn = signIn;
    _myCart = myCart;
    _shippingMethod = shippingMethod;
    _banner = banner;
    _addMainBanner = addMainBanner;
    _addFooterBanner = addFooterBanner;
    _mainBannerForm = mainBannerForm;
    _bannerUrl = bannerUrl;
    _bannerType = bannerType;
    _published = published;
    _mainBannerImage = mainBannerImage;
    _footerBannerForm = footerBannerForm;
    _footerBannerImage = footerBannerImage;
    _bannerTable = bannerTable;
    _bannerPhoto = bannerPhoto;
    _categories = categories;
    _allCategories = allCategories;
    _latestProducts = latestProducts;
    _moreProducts = moreProducts;
    _brands = brands;
    _brandUpdate = brandUpdate;
    _viewAll = viewAll;
    _brand = brand;
    _brandForm = brandForm;
    _name = name;
    _brandLogo = brandLogo;
    _brandTable = brandTable;
    _sl = sl;
    _image = image;
    _action = action;
    _save = save;
    _update = update;
    _category = category;
    _icon = icon;
    _categoryForm = categoryForm;
    _categoryTable = categoryTable;
    _slug = slug;
    _subCategory = subCategory;
    _subCategoryForm = subCategoryForm;
    _subCategoryTable = subCategoryTable;
    _selectCategoryName = selectCategoryName;
    _cashOnDelivery = cashOnDelivery;
    _sslCommerzPayment = sslCommerzPayment;
    _paypal = paypal;
    _stripe = stripe;
    _paytm = paytm;
  }

  String? get home => _home;
  String? get signIn => _signIn;
  String? get myCart => _myCart;
  String? get shippingMethod => _shippingMethod;
  String? get banner => _banner;
  String? get addMainBanner => _addMainBanner;
  String? get addFooterBanner => _addFooterBanner;
  String? get mainBannerForm => _mainBannerForm;
  String? get bannerUrl => _bannerUrl;
  String? get bannerType => _bannerType;
  String? get published => _published;
  String? get mainBannerImage => _mainBannerImage;
  String? get footerBannerForm => _footerBannerForm;
  String? get footerBannerImage => _footerBannerImage;
  String? get bannerTable => _bannerTable;
  String? get bannerPhoto => _bannerPhoto;
  String? get categories => _categories;
  String? get allCategories => _allCategories;
  String? get latestProducts => _latestProducts;
  String? get moreProducts => _moreProducts;
  String? get brands => _brands;
  String? get brandUpdate => _brandUpdate;
  String? get viewAll => _viewAll;
  String? get brand => _brand;
  String? get brandForm => _brandForm;
  String? get name => _name;
  String? get brandLogo => _brandLogo;
  String? get brandTable => _brandTable;
  String? get sl => _sl;
  String? get image => _image;
  String? get action => _action;
  String? get save => _save;
  String? get update => _update;
  String? get category => _category;
  String? get icon => _icon;
  String? get categoryForm => _categoryForm;
  String? get categoryTable => _categoryTable;
  String? get slug => _slug;
  String? get subCategory => _subCategory;
  String? get subCategoryForm => _subCategoryForm;
  String? get subCategoryTable => _subCategoryTable;
  String? get selectCategoryName => _selectCategoryName;
  String? get cashOnDelivery => _cashOnDelivery;
  String? get sslCommerzPayment => _sslCommerzPayment;
  String? get paypal => _paypal;
  String? get stripe => _stripe;
  String? get paytm => _paytm;

  En.fromJson(Map<String, dynamic> json) {
    _home = json['Home'].toString();
    _signIn = json['sign_in'].toString();
    _myCart = json['my_cart'].toString();
    _shippingMethod = json['shipping_method'].toString();
    _banner = json['Banner'].toString();
    _addMainBanner = json['add_main_banner'].toString();
    _addFooterBanner = json['add_footer_banner'].toString();
    _mainBannerForm = json['main_banner _form'].toString();
    _bannerUrl = json['banner_url'].toString();
    _bannerType = json['banner_type'].toString();
    _published = json['published'].toString();
    _mainBannerImage = json['main_banner_image'].toString();
    _footerBannerForm = json['footer_banner_form'].toString();
    _footerBannerImage = json['footer_banner_image'].toString();
    _bannerTable = json['banner_table'].toString();
    _bannerPhoto = json['banner_photo'].toString();
    _categories = json['categories'].toString();
    _allCategories = json['all_categories'].toString();
    _latestProducts = json['latest_products'].toString();
    _moreProducts = json['more_products'].toString();
    _brands = json['brands'].toString();
    _brandUpdate = json['brand_update'].toString();
    _viewAll = json['view_all'].toString();
    _brand = json['brand'].toString();
    _brandForm = json['brand_form'].toString();
    _name = json['name'].toString();
    _brandLogo = json['brand_logo'].toString();
    _brandTable = json['brand_table'].toString();
    _sl = json['sl'].toString();
    _image = json['image'].toString();
    _action = json['action'].toString();
    _save = json['save'].toString();
    _update = json['update'].toString();
    _category = json['category'].toString();
    _icon = json['icon'].toString();
    _categoryForm = json['category_form'].toString();
    _categoryTable = json['category_table'].toString();
    _slug = json['slug'].toString();
    _subCategory = json['sub_category'].toString();
    _subCategoryForm = json['sub_category_form'].toString();
    _subCategoryTable = json['sub_category_table'].toString();
    _selectCategoryName = json['select_category_name'].toString();
    _cashOnDelivery = json['cash_on_delivery'].toString();
    _sslCommerzPayment = json['ssl_commerz_payment'].toString();
    _paypal = json['paypal'].toString();
    _stripe = json['stripe'].toString();
    _paytm = json['paytm'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Home'] = _home;
    data['sign_in'] = _signIn;
    data['my_cart'] = _myCart;
    data['shipping_method'] = _shippingMethod;
    data['Banner'] = _banner;
    data['add_main_banner'] = _addMainBanner;
    data['add_footer_banner'] = _addFooterBanner;
    data['main_banner _form'] = _mainBannerForm;
    data['banner_url'] = _bannerUrl;
    data['banner_type'] = _bannerType;
    data['published'] = _published;
    data['main_banner_image'] = _mainBannerImage;
    data['footer_banner_form'] = _footerBannerForm;
    data['footer_banner_image'] = _footerBannerImage;
    data['banner_table'] = _bannerTable;
    data['banner_photo'] = _bannerPhoto;
    data['categories'] = _categories;
    data['all_categories'] = _allCategories;
    data['latest_products'] = _latestProducts;
    data['more_products'] = _moreProducts;
    data['brands'] = _brands;
    data['brand_update'] = _brandUpdate;
    data['view_all'] = _viewAll;
    data['brand'] = _brand;
    data['brand_form'] = _brandForm;
    data['name'] = _name;
    data['brand_logo'] = _brandLogo;
    data['brand_table'] = _brandTable;
    data['sl'] = _sl;
    data['image'] = _image;
    data['action'] = _action;
    data['save'] = _save;
    data['update'] = _update;
    data['category'] = _category;
    data['icon'] = _icon;
    data['category_form'] = _categoryForm;
    data['category_table'] = _categoryTable;
    data['slug'] = _slug;
    data['sub_category'] = _subCategory;
    data['sub_category_form'] = _subCategoryForm;
    data['sub_category_table'] = _subCategoryTable;
    data['select_category_name'] = _selectCategoryName;
    data['cash_on_delivery'] = _cashOnDelivery;
    data['ssl_commerz_payment'] = _sslCommerzPayment;
    data['paypal'] = _paypal;
    data['stripe'] = _stripe;
    data['paytm'] = _paytm;
    return data;
  }
}
