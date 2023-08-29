import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/response/static_user_response.dart';
import 'package:template/data/model/response/sub_team_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class GroupController extends GetxController {
  UserProvider userProvider = GetIt.I.get<UserProvider>();

  UserModel userModel = UserModel();
  StaticUserResponse staticUserResponse = StaticUserResponse();
  List<SubTeamResponse> subTeamsResponse = [];

  bool isLoading = true;

  @override
  void onInit() {
    // load userid from shared preference
    sl.get<SharedPreferenceHelper>().userId.then(
      (value) {
        // load data user by id
        loadDataUserById(value!);

        // load data đội nhóm
        loadDoiNhom(value);
      },
    );

    super.onInit();
  }

  ///
  /// load Data User By Id
  ///
  void loadDataUserById(String userId) {
    // load data user by id
    userProvider.find(
      id: userId,
      onSuccess: (value) {
        userModel = value;

        // load data revanue and statistical of team
        userProvider.statisUser(
            idUser: userId,
            onSuccess: (data) {
              staticUserResponse = data;
              isLoading = false;
              update();
            },
            onError: (error) {});
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// load đội nhóm
  ///
  void loadDoiNhom(String userId) {
    // load data revanue and statistical of team
    userProvider.getSubTeamUser(
        idUser: userId,
        onSuccess: (data) {
          subTeamsResponse = data;
          update();
        },
        onError: (error) {});
  }
}
