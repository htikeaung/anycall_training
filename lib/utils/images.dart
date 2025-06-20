class Images {
  static const String logo = 'assets/logo/logo.png';
  static const String title = 'assets/logo/title.png';
  static const String placeholder = 'assets/images/placeholder.jpg';
  static const String demoProfile = 'assets/images/demo_profile.png';
  static get contactUsLandingImage => 'contact_us_image_landing'.png;
  static get landingImageOne => 'landing_image_one'.png;
  static String get us => 'us'.png;
  static String get arabicTwo => 'arabic_two'.png;
  static String get forgotPass => 'arabic_two'.png;
  static String get update => 'update'.png;
  static String get maintenance => 'maintenance'.png;
  static String get cart => 'cart'.png;
  static String get guest => 'guest'.png;

  static String get emptyWishlistIcon => 'empty-wishlist'.png;
  static String get emptyNotification => 'empty-notification'.png;
  static String get emptySearchResult => 'empty-search-result'.png;
  static String get emptyCart => 'empty-cart'.png;
  static String get emptyCourse => 'empty_course'.png;
  static String get emptyResource => 'empty_resource'.png;
  static const String splash = 'assets/logo/splash.svg';

  static String get categoryOne => 'category_one'.svg;
  static String get categoryTwo => 'category_two'.svg;
  static String get profileDemo => 'profile_demo'.png;
  static String get demoTending => 'demo_tending'.png;
  static String get notification => 'notification'.svg;
  static String get search => 'search'.svg;
  static String get book => 'book'.svg;
  static String get heart => 'heart'.svg;
  static String get home => 'home'.svg;
  static String get myCourse => 'my_course'.svg;
  static String get explore => 'explore'.svg;
  static String get noteFile => 'note_file'.svg;
  static String get playCircle => 'play_circle'.svg;
  static String get playSmall => 'play_small'.svg;
  static String get profile => 'profile'.svg;
  static String get profileSmall => 'profile_small'.svg;
  static String get quiz => 'quiz'.svg;
  static String get share => 'share'.svg;
  static String get microPhone => 'micro_phone'.svg;
  static String get document => 'document'.svg;
  static String get polygon => 'polygon'.svg;
  static String get pdfFormat => 'pdf_format'.svg;
  static String get audioFile => 'audio_file'.svg;
  static String get starFill => 'star_fill'.svg;
  static String get chat => 'chat'.svg;
  static String get delete => 'delete'.svg;
  static String get more => 'more'.svg;
  static String get about => 'about'.svg;
  static String get bookStore => 'book_store'.svg;
  static String get helpAndSupport => 'help_and_support'.svg;
  static String get language => 'language'.svg;
  static String get policy => 'policy'.svg;
  static String get termsAndConditions => 'terms_and_conditions'.svg;
  static String get logout => 'logout'.svg;
  static String get privacyPolicy => 'policy'.svg;
  static String get menuProfile => 'menu_profile'.svg;
  static String get settingsMenu => 'settings_menu'.svg;
  static String get languageMenu => 'language_menu'.svg;
  static String get editProfile => 'edit_profile'.svg;
  static String get demoCertificate => 'demo_certificate'.png;
  static String get timer => 'timer'.svg;
  static String get cancel => 'cancel'.svg;
  static String get facebook => 'facebook'.svg;
  static String get twitter => 'twitter'.svg;
  static String get linkedin => 'linkedin'.svg;
  static String get instagram => 'instagram'.svg;
  static String get message => 'message'.svg;
  static String get follow => 'follow'.svg;
  static String get unfollow => 'unfollow'.svg;
  static String get messenger => 'messenger'.svg;
  static String get voucher => 'voucher'.svg;
  static String get profileNotification => 'profile_notification'.svg;
  static String get profileLogout => 'profile_logout'.svg;
  static String get orderHistory => 'order_history'.svg;
  static String get meeting => 'meeting'.svg;
  static String get favorite => 'favorite'.svg;
  static String get myAssignment => 'my_assignment'.svg;
  static String get changePassword => 'change_password'.svg;
  static String get books => 'books'.svg;
  static String get deleteAccount => 'delete_account'.svg;
  static String get phone => 'phone'.svg;
  static String get googlePayDemo => 'google_pay_demo'.svg;
  static String get nagadDemo => 'nagad_demo'.svg;
  static String get bkashDemo => 'bkash_demo'.svg;
  static String get successful => 'successful'.svg;
  static String get introFirst => 'assets/images/intro/intro_first.svg';
  static String get introSecond => 'assets/images/intro/intro_second.svg';
  static String get introThird => 'assets/images/intro/intro_third.svg';
  static String get user => 'user'.svg;
  static String get mail => 'mail'.svg;
  static String get lock => 'lock'.svg;
  static String get facebookAuth => 'facebook_auth'.svg;
  static String get googleAuth => 'google_auth'.svg;
  static String get appleAuth => 'apple_auth'.svg;
  static String get download => 'download'.svg;
  static String get chatWithUs => 'chat_with_us'.svg;
  static String get certificates => 'certificates'.svg;
  static String get calendar => 'calendar'.svg;
  static String get addition => 'addition'.svg;
  static String get emoji => 'emoji'.svg;
  static String get microphoneChat => 'microphone_chat'.svg;
  static String get sendMessage => 'send_message'.svg;
  static String get darkMode => 'dark_mode'.svg;
  static String get conversation => 'conversation'.svg;
  static String get theme => 'theme'.svg;
  static String get quizBackRound => 'quiz_back_round'.svg;
  static String get languageChange => 'language_change'.svg;
  static String get cartSvg => 'cart'.svg;

  //!new
  static String get rightSvg => 'right'.svg;
  static String get wrongSvg => 'wrong'.svg;

  static String get gallery => 'gallery'.svg;
  static String get camera => 'camera'.svg;
  static String get file => 'file'.svg;
  // notification
  static String acceptedNotification =
      'assets/images/notification/accepted.svg';
  static String cancelNotification = 'assets/images/notification/cancel.svg';
  static String discountNotification =
      'assets/images/notification/discount.svg';
  static String voucherNotification = 'assets/images/notification/voucher.svg';
  static String get play => 'play'.svg;
  static String get notificationWithBg => 'notification_2'.svg;
}

extension on String {
  String get png => 'assets/images/$this.png';
  String get svg => 'assets/images/$this.svg';
}
