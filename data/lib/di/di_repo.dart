import 'package:data/export.dart';

class RepoDependencies {
  late FirebaseAuth _firebaseAuth;
  late NetworkHelper _networkHelper;
  late EndPoints _endPoints;
  late SharedPreferences _sharedPreferences;
  late GoogleSignIn _googleSignIn;
  late FirebaseAuthWrapper _auth;
  late FacebookLogin _facebookLogin;

  Future init() async {
    _firebaseAuth = FirebaseAuth.instance;
    _auth = FirebaseAuthWrapper(_firebaseAuth);
    _endPoints = EndPoints();
    _networkHelper = NetworkHelperImpl(_firebaseAuth);
    _sharedPreferences = await SharedPreferences.getInstance();
    _googleSignIn = GoogleSignIn();
    _facebookLogin = FacebookLogin();
  }

  initializeRepoDependencies() {
    Get.lazyPut<SharedPreferences>(
      () => _sharedPreferences,
      tag: 'sp',
      fenix: true,
    );
    Get.lazyPut<FirebaseAuthWrapper>(
      () => FirebaseAuthWrapper(_firebaseAuth),
      fenix: true,
    );

    Get.lazyPut<AuthRepo>(
      () => AuthRepoImpl(
        _googleSignIn,
        _auth,
        _facebookLogin,
        _endPoints,
        _networkHelper,
      ),
      fenix: true,
    );

    Get.lazyPut<RegisterRepo>(
      () => RegisterRepoImpl(_networkHelper, _endPoints),
      fenix: true,
    );
    Get.lazyPut<HomeRepo>(
      () => HomeRepoImpl(_networkHelper, _endPoints),
    );
    Get.lazyPut<LocationRepo>(
      () => LocationRepoImpl(_networkHelper, _endPoints),
      fenix: true,
    );

    Get.lazyPut<StoreDetailsRepo>(
      () => StoreDetailsRepoImpl(_networkHelper, _endPoints),
      fenix: true,
    );
  }
}
