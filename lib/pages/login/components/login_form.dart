import 'package:ekidzee/api/request/change_password.dart';
import 'package:ekidzee/api/response/change_password_response.dart';
import 'package:ekidzee/helper/KidzeePref.dart';
import 'package:ekidzee/helper/LocalConstant.dart';
import 'package:ekidzee/pages/about/about_screen.dart';
import 'package:ekidzee/pages/home/home_screen.dart';
import 'package:ekidzee/pages/login/components/password_bloc.dart';
import 'package:ekidzee/pages/login/components/password_event.dart';
import 'package:ekidzee/pages/login/components/password_repository.dart';
import 'package:ekidzee/pages/login/components/password_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api/APIService.dart';
import '../../../api/request/login_model.dart';
import '../../../constants.dart';
import '../../../helper/utils.dart';
import '../../../ui/theme.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/input_field.dart';
import '../PrivacyPolicyScreen.dart';
import 'dart:convert';

class LoginForm extends StatefulWidget  {

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> implements changePasswordInterface{
  //_LoginFormState({Key? key}) : super(key: key);

  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _repeatPasswordController;


  bool isChecked = false;
  bool isApiCallProcess = false;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  @override
  void initState() {
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  // void setState(Null Function() param0) {}

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            controller: userNameController,
            decoration: const InputDecoration(
              hintText: "Your User Name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              controller: userPasswordController,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          Hero(
            tag: "login_btn",
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Material(
                  child: Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      //isChecked = value!;
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                ),GestureDetector(
                  onTap: () {
                    if (kIsWeb) {
                      _launchURL();
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              PrivacyPolicyScreen()));
                    }
                  },
                  child: Text(
                    'I have read and accept terms \nand conditions',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          // Row(
          //   children: [
          //     Material(
          //       child: Checkbox(
          //         value: isChecked,
          //         onChanged: (value) {
          //           //isChecked = value!;
          //           setState(() {
          //             isChecked = value!;
          //           });
          //         },
          //       ),
          //     ),GestureDetector(
          //       onTap: () {
          //         if (kIsWeb) {
          //           _launchURL();
          //         } else {
          //           Navigator.of(context).push(MaterialPageRoute(
          //               builder: (BuildContext context) =>
          //                   PrivacyPolicyScreen()));
          //         }
          //       },
          //       child: const Expanded(
          //       child: SizedBox(
          //           child: Text(
          //           'I have read and accept terms \nand conditions',
          //           maxLines: 2,
          //           overflow: TextOverflow.ellipsis,
          //         ),
          //       ),
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                validate(context);
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          /*Hero(
            tag: "forgot_password",
            child: ElevatedButton(
              onPressed: () {
                _showChangePasswordBottomSheet(context);
              },
              child: Text(
                "Forgot Password".toUpperCase(),
              ),
            ),
          ),*/
          // AlreadyHaveAnAccountCheck(
          //   press: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) {
          //           return SignUpScreen();
          //         },
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  _launchURL() async {
    const url = 'https://www.kidzee.com/Home/PrivacyPolicy';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void validate(BuildContext context) async {
    //userNameController.text='T192335';
    //userPasswordController.text ='Teach@12344';
    //Utility.showMessage(context, "user Name : "+ userNameController.text.toString());
    //Utility.showMessage(context, "user Password : "+ userPasswordController.text.toString());
    final prefs = await SharedPreferences.getInstance();
    if(!isChecked){
      Utility.showMessage(context, "Please accept the Terms and Conditions");
    }else if (userNameController.text.toString() != "" &&
        userPasswordController.text.toString() != "") {
      Utility.showLoaderDialog(context);
      LoginRequestModel loginRequestModel = LoginRequestModel(
        User_Name: userNameController.text.toString(),
        User_Password: userPasswordController.text.toString(),
        Device_id: '',
        Otp: '',
      );
      //loginRequestModel.User_Name = 'F2354';
      //loginRequestModel.User_Password = 'Niharika#123';
      APIService apiService = APIService();
      apiService.login(loginRequestModel).then((value) {
        if (value != null) {
          //print("value found ${value.root?.toJson()}");
          //print("subroot -- ${value.root?.subroot?.toJson()}");
          print("UserDetails -- ${value.root?.subroot?.UserDetails.toJson()}");
          setState(() {
            isApiCallProcess = false;
          });
          UserInfo? info = value.root?.subroot?.UserDetails;

           String userId= info?.UID as String;
          // // Save an integer value to 'counter' key.
          prefs.setString('userid', userId);
          prefs.setString(LocalConstant.KEY_DISPLAY_NAME, info?.displayName as String);
          prefs.setString(LocalConstant.KEY_USER_ID, info?.UID as String);
          prefs.setString(LocalConstant.KEY_USER_TYPE, info?.UserType as String);
          prefs.setString(LocalConstant.KEY_MOBILENO, info?.mobileNo as String);
          prefs.setString(LocalConstant.KEY_ACADEMICYEAR, info?.CurrentACADYear as String);
          prefs.setString(LocalConstant.KEY_GUARDIAN_CONTACT, info?.contactPerson as String);
          prefs.setString(LocalConstant.KEY_CONE_CODE, info?.ZoneCode as String);
          prefs.setString(LocalConstant.KEY_STATE_ID, info?.StateId as String);
          prefs.setString(LocalConstant.KEY_FRANCHISEE_TYPE, info?.FranchiseeType as String);
          prefs.setString(LocalConstant.KEY_IS_EXTERNAL_USER, info?.IsExternalUser as String);
          prefs.setString(LocalConstant.KEY_FRANCHISEE_ID, info?.FranchiseeId as String);
          prefs.setString(LocalConstant.KEY_USER_TYPE_NAME, info?.UserTypeName as String);
          prefs.setString(LocalConstant.KEY_IS_ILLUM_KIT, info?.RequestedIllumeKit as String);
          prefs.setString(LocalConstant.KEY_IS_KG_KIT, info?.RequestedKGKit as String);
          prefs.setString(LocalConstant.KEY_USER_PASSWORD, userPasswordController.text.toString() as String);

          String userIds = prefs.getString('userid') as String;


          print("USER ID ----------- "+userIds);


          KidzeePref().setString(LocalConstant.KEY_USER_ID, info?.UID as String);
          KidzeePref().setString(LocalConstant.KEY_USER_NAME, info?.USERNAME as String);
          KidzeePref().setString(LocalConstant.KEY_DISPLAY_NAME, info?.displayName as String);
          KidzeePref().setString(LocalConstant.KEY_EMAILID, info?.emailId as String);
          KidzeePref().setString(LocalConstant.KEY_MOBILENO, info?.mobileNo as String);
          KidzeePref().setString(LocalConstant.KEY_FRANCHISEE_ID, info?.FranchiseeId as String);
          KidzeePref().setString(LocalConstant.KEY_GUARDIAN_CONTACT, info?.contactPerson as String);
          KidzeePref().setString(LocalConstant.KEY_USER_NAME, userNameController.text.toString());
          KidzeePref().setString(LocalConstant.KEY_USER_PASSWORD,userPasswordController.text.toString());
          KidzeePref().setString(LocalConstant.KEY_DISPLAY_NAME,info?.displayName as String);
          KidzeePref().setString(LocalConstant.KEY_EMAILID,info?.emailId as String);
          KidzeePref().setString(LocalConstant.KEY_MOBILENO,info?.mobileNo as String);

          Navigator.pop(context);
          if(info?.Msg =='ChangePassword'){
            _showChangePasswordBottomSheet(context);
          }else if(info?.Msg =='Login successful'){
            if(info?.IsReset == '1'){
              _showChangePasswordBottomSheet(context);
            }else {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyHomePage(
                            name: info?.USERNAME as String,
                            title: info?.displayName as String)),
              );
            }
          }else{
            Utility.showMessage(context, "Invalid User Name and Password");
          }

        } else {
          Navigator.pop(context);
          Utility.showMessage(context, "Invalid User Name and Password");
          print("null value");
        }
      });
    } else {
      userNameController.text='';
      userPasswordController.text='';
      Utility.showMessage(context, "Invalid User Name and Password");
    }
  }

  // void callLogin(BuildContext context) {
  //   LoginRequestModel loginRequestModel = LoginRequestModel(
  //     User_Name: userNameController.text.toString(),
  //     User_Password: userPasswordController.text.toString(),
  //     Device_id: '',
  //     Otp: '',
  //   );
  //   print("Response");
  //   APIService apiService = APIService();
  //   apiService.login(loginRequestModel).then((value) async {
  //     if (value != null) {
  //       setState(() {
  //         isApiCallProcess = false;
  //       });
  //       print("Response");
  //       if (value.root != null && value.root?.subroot != null) {
  //         print(value.root);
  //         // Utility.showMessages(
  //         //     context, value.root?.subroot?.userDetails?.displayName);
  //         var userInfo = value.root?.subroot;
  //         // Obtain shared preferences.
  //         final prefs = await SharedPreferences.getInstance();
  //         String userId= userInfo?.UserDetails.UserId as String;
  //       // Save an integer value to 'counter' key.
  //         await prefs.setString('userid', userId);
  //         print("USER ID ----------- "+userId);
  //         //KidzeePref().setString(LocalConstant.KEY_USER_ID, userInfo?.UserDetails.UserId as String);
  //         KidzeePref().setString(LocalConstant.KEY_USER_NAME, userInfo?.UserDetails.USERNAME as String);
  //         KidzeePref().setString(LocalConstant.KEY_DISPLAY_NAME, userInfo?.UserDetails.displayName as String);
  //         KidzeePref().setString(LocalConstant.KEY_EMAILID, userInfo?.UserDetails.emailId as String);
  //         KidzeePref().setString(LocalConstant.KEY_MOBILENO, userInfo?.UserDetails.mobileNo as String);
  //         KidzeePref().setString(LocalConstant.KEY_FRANCHISEE_ID, userInfo?.UserDetails.FranchiseeId as String);
  //         KidzeePref().setString(LocalConstant.KEY_GUARDIAN_CONTACT, userInfo?.UserDetails.contactPerson as String);
  //         // SharedPrefrenceHelper().setDisplayName(userInfo?.userName);
  //         // SharedPrefrenceHelper().setUserId(userInfo?.userId.toString());
  //         // SharedPrefrenceHelper().setUserMail(userInfo?.emailId.toString());
  //         // SharedPrefrenceHelper().setUserAvtar(userInfo?.photopath.toString());
  //         // SharedPrefrenceHelper().setGaurdianContactNo(userInfo?.guardianContact.toString());
  //         // SharedPrefrenceHelper().setUserType(userInfo?.userType.toString());
  //         // SharedPrefrenceHelper().setUserType(userInfo?.userType.toString());
  //         // SharedPrefrenceHelper().setUID(userInfo?.uid.toString());
  //         // SharedPrefrenceHelper().setAYId(userInfo?.acdYear.toString());
  //         // SharedPrefrenceHelper().saveUserBranch(userInfo?.branchList);
  //         // KidzeePref().setString(LocalConstant.KEY_DISPLAY_NAME,
  //         //     userInfo?.userDetails?.displayName as String);
  //         // KidzeePref().setString(LocalConstant.KEY_USER_ID,
  //         //     userInfo?.userDetails?.userId as String);
  //         // KidzeePref().setString(LocalConstant.KEY_EMAILID,
  //         //     userInfo?.userDetails?.emailId as String);
  //         // KidzeePref().setString(LocalConstant.KEY_USER_AVTAR,
  //         //     userInfo?.userDetails?.photopath as String);
  //         // KidzeePref().setString(LocalConstant.KEY_GUARDIAN_CONTACT,
  //         //     userInfo?.userDetails?.guardianContact as String);
  //         // KidzeePref().setString(LocalConstant.KEY_USER_TYPE,
  //         //     userInfo?.userDetails?.userType as String);
  //         // KidzeePref().setString(
  //         //     LocalConstant.KEY_UID, userInfo?.userDetails?.uid as String);
  //         // KidzeePref().setString(LocalConstant.KEY_ACADEMICYEAR,
  //         //     userInfo?.userDetails?.acdYear as String);
  //         // KidzeePref().setString(LocalConstant.KEY_BRANCH_NAME,
  //         //     userInfo?.userDetails?.menulist?.MenuName as String);
  //
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => AboutUs(
  //                   name: userInfo?.UserDetails.USERNAME as String,
  //                   title: userInfo?.UserDetails.displayName as String)),
  //         );
  //       } else {
  //         Utility.showMessage(context, "Unable to get Token");
  //       }
  //     } else {
  //       print("Value is null");
  //     }
  //   });
  // }

  void changePassword(BuildContext context) async {
    if(_newPasswordController.text == _repeatPasswordController.text) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String userType = pref.getString(LocalConstant.KEY_USER_TYPE) as String;
      String userName = pref.getString(LocalConstant.KEY_USER_NAME) as String;
      String userPassword = pref.getString(
          LocalConstant.KEY_USER_PASSWORD) as String;
      ChangePasswordRequest loginRequestModel = ChangePasswordRequest(
        Username: userName,
        OldPassword: userPassword,
        newPassword: _newPasswordController.text.toString(),
        userType: userType,
      );
      print("Response");
      APIService apiService = APIService();
      apiService.changePassword(loginRequestModel).then((value) async {
        if (value != null) {
          setState(() {
            isApiCallProcess = false;
          });
          print("Response");
          if (value != null) {
            //ChangePasswordResponse response = ChangePasswordResponse.fromJson(jsonDecode(value.MSG));
            print(value.MSG);
            if (value.MSG == 'Password changed successfully') {
              //_showAlertDialog(context, "SUCCESS", value.MSG);
              Navigator.pop(context);
              userPasswordController.text = _newPasswordController.text;
              validate(context);
            } else {
              _showAlertDialog(context, "Alert", value.MSG);
            }
          }
        } else {
          print("Value is null");
        }
      });
    }else{
      _showAlertDialog(context, "Alert", 'Password and Repete password doesent match');
    }
  }

  void _showResetPasswordBottomSheet(BuildContext context) {
    var passwordBloc = PasswordBloc(passwordRepository: PasswordRepository());

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(34), topRight: Radius.circular(34)),
        ),
        builder: (BuildContext context) => BlocProvider<PasswordBloc>(
          create: (context) => passwordBloc,
          child: BlocBuilder<PasswordBloc, PasswordState>(
              bloc: passwordBloc,
              builder: (context, state) {
                if (state is PasswordChangedState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    // close bottom sheet
                    Navigator.pop(context);

                    _showAlertDialog(context, 'Success', 'Password changed successfully');

                    clearPasswordFields();
                  });
                } else if (state is ChangePasswordErrorState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _showAlertDialog(context, 'Error', state.errorMessage);
                  });
                }

                return Container(
                  height: 472,
                  padding: AppSizes.bottomSheetPadding,
                  decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(34), topRight: Radius.circular(34)),
                      boxShadow: []),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 6,
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColors.lightGray,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Password Change',
                          style: TextStyle(color: AppColors.black, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        EkidzeeInputField(
                          controller: _currentPasswordController,
                          hint: 'Old Password',
                          validator: (value) {
                            if (value == null) return null;
                            else
                              return 'Enter a Old Password';
                          },
                          error: state is EmptyCurrentPasswordState
                              ? 'field cannot be empty'
                              : state is IncorrectCurrentPasswordState
                              ? 'incorrect current password'
                              : '',
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: const <Widget>[
                        //     Text(
                        //       'Forgot Password?',
                        //       style: TextStyle(color: AppColors.lightGray),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 18,
                        ),

                        EkidzeeInputField(
                          controller: _newPasswordController,
                          hint: 'New Password',
                          validator: (value) {
                            if (value == null) return null;
                            else
                              return 'Enter a valid Password';
                          },
                          error: state is EmptyNewPasswordState
                              ? 'field cannot be empty'
                              : state is InvalidNewPasswordState
                              ? 'password should be at least 6 characters'
                              : '',
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        EkidzeeInputField(
                          controller: _repeatPasswordController,
                          hint: 'Repeat New Password',
                          validator: (value) {
                            if (value == null) return null;
                            else
                              return 'Enter a valid Password';
                          },
                          error: state is EmptyRepeatPasswordState
                              ? 'field cannot be empty'
                              : state is PasswordMismatchState
                              ? 'password mismatch'
                              : '',
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: Colors.teal,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          child: Text('Submit'),
                          onPressed: () {changePassword(context);},
                        ),
                        // EKidzeeButton(
                        //     title: 'Save Password',
                        //     height: 48,
                        //     onPressedEvent: () => passwordBloc
                        //       .add(ChangePasswordEvent(
                        //           currentPassword: _currentPasswordController.text.trim(),
                        //           newPassword: _newPasswordController.text.trim(),
                        //           repeatNewPassword: _repeatPasswordController.text.trim()))),
                        SizedBox(
                          height: 48,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }

  void _showChangePasswordBottomSheet(BuildContext context) {
    var passwordBloc = PasswordBloc(passwordRepository: PasswordRepository());

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(34), topRight: Radius.circular(34)),
        ),
        builder: (BuildContext context) => BlocProvider<PasswordBloc>(
          create: (context) => passwordBloc,
          child: BlocBuilder<PasswordBloc, PasswordState>(
              bloc: passwordBloc,
              builder: (context, state) {
                if (state is PasswordChangedState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    // close bottom sheet
                    Navigator.pop(context);

                    _showAlertDialog(context, 'Success', 'Password changed successfully');

                    clearPasswordFields();
                  });
                } else if (state is ChangePasswordErrorState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _showAlertDialog(context, 'Error', state.errorMessage);
                  });
                }

                return Container(
                  height: 472,
                  padding: AppSizes.bottomSheetPadding,
                  decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(34), topRight: Radius.circular(34)),
                      boxShadow: []),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 6,
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColors.lightGray,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Password Change',
                          style: TextStyle(color: AppColors.black, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        // EkidzeeInputField(
                        //   controller: _currentPasswordController,
                        //   hint: 'Old Password',
                        //   validator: (value) {
                        //     if (value == null) return null;
                        //     else
                        //       return 'Enter a Old Password';
                        //   },
                        //   error: state is EmptyCurrentPasswordState
                        //       ? 'field cannot be empty'
                        //       : state is IncorrectCurrentPasswordState
                        //       ? 'incorrect current password'
                        //       : '',
                        // ),
                        // const SizedBox(
                        //   height: 18,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: const <Widget>[
                        //     Text(
                        //       'Forgot Password?',
                        //       style: TextStyle(color: AppColors.lightGray),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 18,
                        ),

                        EkidzeeInputField(
                          controller: _newPasswordController,
                          hint: 'New Password',
                          validator: (value) {
                            if (value == null) return null;
                            else
                              return 'Enter a valid Password';
                          },
                          error: state is EmptyNewPasswordState
                              ? 'field cannot be empty'
                              : state is InvalidNewPasswordState
                              ? 'password should be at least 6 characters'
                              : '',
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        EkidzeeInputField(
                          controller: _repeatPasswordController,
                          hint: 'Repeat New Password',
                          validator: (value) {
                            if (value == null) return null;
                            else
                              return 'Enter a valid Password';
                          },
                          error: state is EmptyRepeatPasswordState
                              ? 'field cannot be empty'
                              : state is PasswordMismatchState
                              ? 'password mismatch'
                              : '',
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: Colors.teal,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          child: Text('Submit'),
                          onPressed: () {changePassword(context);},
                        ),
                        // EKidzeeButton(
                        //     title: 'Save Password',
                        //     height: 48,
                        //     onPressedEvent: () => passwordBloc
                        //       .add(ChangePasswordEvent(
                        //           currentPassword: _currentPasswordController.text.trim(),
                        //           newPassword: _newPasswordController.text.trim(),
                        //           repeatNewPassword: _repeatPasswordController.text.trim()))),
                        SizedBox(
                          height: 48,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }

  Future<void> _showAlertDialog(BuildContext context, String title, String content) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                //Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void clearPasswordFields() {
    _currentPasswordController.text = '';
    _newPasswordController.text = '';
    _repeatPasswordController.text = '';
  }

  @override
  onChangePassword() {
    changePassword(context);
  }
}

class changePasswordInterface {
  onChangePassword(){}
  //String flag_image_url(){}
}
