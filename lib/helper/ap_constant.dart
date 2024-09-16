class ApiConstant {
  //http://192.168.29.43/Medilabs_new/
  static String HOST_URL="https://tsetvedqyp.in/";

  static String BASE_URL=HOST_URL+"assetmanagement/api/v1/assetapi.php?method=";
  static String CATEGORIES=BASE_URL+"category";
  static String PACKAGES=BASE_URL+"package";
  static String ALL_TEST=BASE_URL+"";
  static String CHECK_OTP_USER=BASE_URL+"checkotp&userid=";
  static String OTP="&otp=";
  static String SPLASHAPI = BASE_URL+"welcome";
  static String IMAGE_ADDRESS =HOST_URL+"admin/mobile/v1/";
  static String SIGNIN = BASE_URL+"usersignin&mobile=";
  static String GET_PROFILE = BASE_URL+"getuserdata&userid=";
  static String MEDICAL_FORM=BASE_URL+"getorderformdata";
  static String UPDATE_PROFILE=BASE_URL+"updateuserprofile";
  static String UPDATE_Prescription=BASE_URL+"";
  static String UPDATE_OREDER_Prescription=BASE_URL+"";
  static String CHECK_COUPON_CODE=BASE_URL+"";
  static String GET_TEST_BY_CATEGORY=BASE_URL+"categorywisetest&catid=";
  static String BOOK_TEST=BASE_URL+"createorder";
  static String CASHFREE_TOKEN=BASE_URL+"getcashfreetoken";
  static String SET_RATING=BASE_URL+"setrating";
  static String GET_ALL_BOOK_TEST=BASE_URL+"getallorder&userid=";
  static String SKYCALL="https://skycalls.in/click_to_call/?code=SKY2204";



  //new api for asset

  static String USER_REGISTRATION = "${BASE_URL}userregistration&email=";
  static String HOMEAPI = "${BASE_URL}home";
  static String COMPLETE_PROFILE=BASE_URL+"completeprofile";
  static String GETASSETITEMS= "${BASE_URL}getitem&subcategoty=";
  static String ADD_ASSET=BASE_URL+"addasset";
  static String GET_MY_ASSET=BASE_URL+"getmyasset&userid=";
  static String getMyOldAsset=BASE_URL+"getmyoldasset&userid=";

  static String GETALLASSETITEMS= "${BASE_URL}getallitem&userid=";
  static String GETALLMYFREEASSET= "${BASE_URL}getfreeassetitemss&userid=";

  static String GET_MY_LINK_ASSET=BASE_URL+"getmylinkasset&userid=";
  static String ASSET_BY_CATEGORY=BASE_URL+"getassetbycategory&userid=";

  static String LINKMYASSET= "${BASE_URL}linkmyasset&userid=";

  static String UNLINK_ASSET=BASE_URL+"unlinkmyasset&userid=";
  static String SET_REMINDER=BASE_URL+"setreminder&date=";
}