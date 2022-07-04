class LoginResponseModel {
  Root? root;

  LoginResponseModel({this.root});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    root = json['root'] != null ? new Root.fromJson(json['root']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.root != null) {
      data['root'] = this.root!.toJson();
    }
    return data;
  }
}

class Root {
  Subroot? subroot;

  Root({required this.subroot});

  Root.fromJson(Map<String, dynamic> json) {
    subroot = (json['subroot'] != null
        ? new Subroot.fromJson(json['subroot'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subroot != null) {
      data['subroot'] = this.subroot!.toJson();
    }
    return data;
  }
}

class Subroot {
  late UserInfo UserDetails;

  late String UserType;

  Subroot({
    required this.UserDetails,
    required this.UserType,
  });

  Subroot.fromJson(Map<String, dynamic> json) {
    UserDetails = UserInfo.fromJson(json['UserDetails']);
    //MenuList = List.from(json['MenuList']).map((e) => MenuList.fromJson(e)).toList();
    UserType = json['UserType'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['UserDetails'] = UserDetails.toJson();
    //_data['MenuList'] = MenuList.map((e) => e.toJson()).toList();
    _data['UserType'] = UserType;
    return _data;
  }
}

class UserInfo {
  late final String UserId;
  late final String USERNAME;
  late final String UserType;
  late final String mobileNo;
  //late final Null Remarks;
  late final String CurrentACADYear;
  late final String displayName;
  late final String contactPerson;
  late final String emailId;
  late final String ZoneCode;
  late final String CanEdit;
  late final String StateId;
  late final String FranchiseeType;
  late final String IsExternalUser;
  late final String FranchiseeId;
  late final String lastLogin;
  late final String UserTypeName;
  late final String UID;
  late final String TierType;
  late final String TierName;
  late final String Priority;
  late final String RequestedIllumeKit;
  late final String RequestedKGKit;
  late final String IsAgreementExpired;
  late final String Msg;
  late final String IsReset;
  late final String IsValid;
  late final String IsOTP;
  late final String IsAuthUser;

  UserInfo({
    required this.UserId,
    required this.USERNAME,
    required this.UserType,
    required this.mobileNo,
    //this.Remarks,
    required this.CurrentACADYear,
    required this.displayName,
    required this.contactPerson,
    required this.emailId,
    required this.ZoneCode,
    required this.CanEdit,
    required this.StateId,
    required this.FranchiseeType,
    required this.IsExternalUser,
    required this.FranchiseeId,
    required this.lastLogin,
    required this.UserTypeName,
    required this.UID,
    required this.TierType,
    required this.TierName,
    required this.Priority,
    required this.RequestedIllumeKit,
    required this.RequestedKGKit,
    required this.IsAgreementExpired,
    required this.Msg,
    required this.IsReset,
    required this.IsValid,
    required this.IsOTP,
    required this.IsAuthUser,
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    UserId = json['User_Id']==null ? '' : json['User_Id'];
    USERNAME = json['USER_NAME'] == null ? '' : json['USER_NAME'];
    UserType = json['User_Type'] == null ? '' : json['User_Type'];
    mobileNo = json['mobile_no'] == null ? '' : json['mobile_no'];
    //Remarks = null;
    CurrentACADYear = json['CurrentACADYear'] == null ? '' :json['CurrentACADYear'];
    displayName = json['display_name'] == null ? '' : json['display_name'];
    contactPerson = json['contact_person'] == null ? '' : json['contact_person'];
    emailId = json['email_id'] == null ? '' : json['email_id'];
    ZoneCode = json['Zone_Code'] == null ? '' : json['Zone_Code'];
    CanEdit = json['CanEdit'] == null ? '' : json['CanEdit'];
    StateId = json['State_id'] == null ? '' : json['State_id'];
    FranchiseeType = json['Franchisee_Type'] == null ? '' : json['Franchisee_Type'];
    IsExternalUser = json['IsExternalUser'] == null ? '' : json['IsExternalUser'];
    FranchiseeId = json['Franchisee_Id'] == null ? '' : json['Franchisee_Id'];
    lastLogin = json['last_Login'] == null ? '' : json['last_Login'];
    UserTypeName = json['User_TypeName'] == null ? '' : json['User_TypeName'];
    UID = json['UID'] == null ? '' : json['UID'];
    TierType = json['TierType'] == null ? '' : json['TierType'];
    TierName = json['TierName'] == null ? '' : json['TierName'];
    Priority = json['Priority'] == null ? '' : json['Priority'];
    RequestedIllumeKit = json['Requested_IllumeKit'] == null ? '' :  json['Requested_IllumeKit'];
    RequestedKGKit = json['Requested_KGKit'] == null ? '' : json['Requested_KGKit'];
    IsAgreementExpired = json['Is_agreement_Expired'] == null ? '' : json['Is_agreement_Expired'];
    Msg = json['Msg'];
    IsReset = json['IsReset'] == null ? '' : json['IsReset'];
    IsValid = json['IsValid'] == null ? '' : json['IsValid'];
    IsOTP = json['IsOTP'] ==null ? '' : json['IsOTP'];
    IsAuthUser = json['IsAuthUser'] == null ? '' : json['IsAuthUser'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['User_Id'] = UserId;
    _data['USER_NAME'] = USERNAME;
    _data['User_Type'] = UserType;
    _data['mobile_no'] = mobileNo;
    //_data['Remarks'] = Remarks;
    _data['CurrentACADYear'] = CurrentACADYear;
    _data['display_name'] = displayName;
    _data['contact_person'] = contactPerson;
    _data['email_id'] = emailId;
    _data['Zone_Code'] = ZoneCode;
    _data['CanEdit'] = CanEdit;
    _data['State_id'] = StateId;
    _data['Franchisee_Type'] = FranchiseeType;
    _data['IsExternalUser'] = IsExternalUser;
    _data['Franchisee_Id'] = FranchiseeId;
    _data['last_Login'] = lastLogin;
    _data['User_TypeName'] = UserTypeName;
    _data['UID'] = UID;
    _data['TierType'] = TierType;
    _data['TierName'] = TierName;
    _data['Priority'] = Priority;
    _data['Requested_IllumeKit'] = RequestedIllumeKit;
    _data['Requested_KGKit'] = RequestedKGKit;
    _data['Is_agreement_Expired'] = IsAgreementExpired;
    _data['Msg'] = Msg;
    _data['IsReset'] = IsReset;
    _data['IsValid'] = IsValid;
    _data['IsOTP'] = IsOTP;
    _data['IsAuthUser'] = IsAuthUser;
    return _data;
  }
}

class MenuList {
  String mobilemenuID = "";
  String menuName = "";
  String userType = "";

  MenuList(
      {required this.mobilemenuID,
      required this.menuName,
      required this.userType});

  MenuList.fromJson(Map<String, dynamic> json) {
    mobilemenuID = json['mobilemenuID'];
    menuName = json['MenuName'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobilemenuID'] = this.mobilemenuID;
    data['MenuName'] = this.menuName;
    data['userType'] = this.userType;
    return data;
  }
}

class BranchList {
  String? branchId;
  String? branchName;
  BatchList? batchList;

  BranchList({this.branchId, this.branchName, this.batchList});

  BranchList.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    batchList = json['batch_list'] != null
        ? new BatchList.fromJson(json['batch_list'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    if (this.batchList != null) {
      data['batch_list'] = this.batchList!.toJson();
    }
    return data;
  }
}

class BatchList {
  String? batchName;
  String? batchId;

  BatchList({this.batchName, this.batchId});

  BatchList.fromJson(Map<String, dynamic> json) {
    batchName = json['batch_name'];
    batchId = json['batch_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch_name'] = this.batchName;
    data['batch_id'] = this.batchId;
    return data;
  }
}

class LoginRequestModel {
  String User_Name;
  String User_Password;
  String Device_id;
  String Otp;

  LoginRequestModel(
      {required this.User_Name,
      required this.User_Password,
      required this.Device_id,
      required this.Otp});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'User_Name': User_Name.trim(),
      'User_Password': User_Password.trim(),
      'Device_id': User_Password.trim(),
      'Otp': User_Password.trim(),
    };

    return map;
  }
}

class TokenResponseModel {
  late final String token;
  late final String Status;

  TokenResponseModel({required this.token, required this.Status});

  factory TokenResponseModel.fromJson(Map<String, dynamic> json) {
    return TokenResponseModel(
      token: json["Message"] != null ? json["Message"] : "",
      Status: json["Status"] != null ? json["Status"] : "",
    );
  }
}
