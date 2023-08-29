import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/district_model.dart';
import 'package:template/data/model/body/province_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/provider/district_provider.dart';
import 'package:template/provider/province_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class AddressController extends GetxController {
  GetIt sl = GetIt.instance;

  ProvinceProvider provinceProvider = GetIt.I.get<ProvinceProvider>();
  DistrictProvider districtProvider = GetIt.I.get<DistrictProvider>();
  UserProvider userProvider = GetIt.I.get<UserProvider>();

  final addressTextController = TextEditingController();

  String? province;
  String? district;

  List<ProvinceModel> provinceModelList = [];
  List<DistrictModel> districtModelList = [];

  List<String> provinceList = [];
  List<String> districtList = [];

  UserModel userModel = UserModel();

  bool isLoading = true;

  @override
  void onClose() {
    super.onClose();
    addressTextController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  ///
  ///get user info
  ///
  void getUserInfo() {
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userProvider.find(
          id: value!,
          onSuccess: (value) {
            userModel = value;
            //get province
            getProvince();
            if (value.address != "") {
              addressTextController.text = value.addressOrder.toString();
            }
          },
          onError: (error) {
            print(error);
          });
    });
  }

  ///
  ///get province
  ///
  void getProvince() {
    provinceProvider.all(onSuccess: (value) {
      provinceModelList = value;
      value.map((item) {
        if (item.id == userModel.provinceOrder) {
          print("111");
          province = item.name;
          getDistrict();
        } else {
          isLoading = false;
        }
        provinceList.add(item.name!);
      }).toList();

      update();
    }, onError: (error) {
      print(error);
    });
  }

  ///
  ///
  ///
  void setSelectedProvince(String? value) {
    district = null;
    districtList.clear();
    province = value;
    userModel.provinceOrder = provinceModelList[
            provinceModelList.indexWhere((element) => element.name == value)]
        .id;
    getDistrict();
    update();
  }

  ///
  ///get district
  ///
  void getDistrict() {
    districtProvider.paginate(
        page: 1,
        limit: 100,
        filter: "idProvince=${userModel.provinceOrder}",
        onSuccess: (value) {
          districtModelList = value;
          value.map((item) {
            if (item.id == userModel.districtOrder) {
              district = item.name;
            }
            districtList.add(item.name!);
          }).toList();
          isLoading = false;
          update();
        },
        onError: (error) {
          print(error);
        });
  }

  ///
  ///set selected district
  ///
  void setSelectedDistrict(String? value) {
    district = value;
    userModel.districtOrder = districtModelList[districtModelList
            .indexWhere((element) => element.name!.trim() == value!.trim())]
        .id;
    update();
  }

  ///
  ///save address
  ///
  void changeAddress() {
    if (userModel.provinceOrder!.isEmpty ||
        userModel.districtOrder!.isEmpty ||
        addressTextController.text.isEmpty) {
      Get.snackbar("Thất bại!", "Vui lòng nhập đủ các trường");
    } else {
      print("addressController.text: ${addressTextController.text}");

      // update address

      userProvider.addressOrderUpdate(
          data: UserModel(
            id: userModel.id,
            address: userModel.address,
            avatar: userModel.avatar,
            born: userModel.born,
            citizenIdentification: userModel.citizenIdentification,
            email: userModel.email,
            phone: userModel.phone,
            fullname: userModel.fullname,
            idOptionalRole: userModel.idOptionalRole,
            idRole: userModel.idRole,
            idUser: userModel.idUser,
            imageCitizenIdentification1: userModel.imageCitizenIdentification1,
            imageCitizenIdentification: userModel.imageCitizenIdentification,
            paymentProofImage: userModel.paymentProofImage,
            sex: userModel.sex,
            status: userModel.status,
            username: userModel.username,
            addressCurrent: userModel.addressCurrent,
            addressOrder: addressTextController.text,
            districtOrder: userModel.districtOrder,
            provinceOrder: userModel.provinceOrder,
          ),
          onSuccess: (value) {},
          onError: (error) {
            print(error);
          });
      //back to cart
      Get.back(result: true);
      update();
    }
  }
}
