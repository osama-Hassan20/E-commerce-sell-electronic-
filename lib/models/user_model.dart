class UserModel{
  String? status;
  String? message;
  UserData? user;
  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ?  UserData.fromJson(json['user']) : null;
  }
}

class UserData{
  String? name;
  String? email;
  String? phone;
  String? nationalId;
  String? gender;
  String? token;
  String? profileImage;

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    nationalId = json['nationalId'];
    gender = json['gender'];
    token = json['token'];
    profileImage = json['profileImage'];
  }
}