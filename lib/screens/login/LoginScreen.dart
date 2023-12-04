import 'package:erp/Helper/Custom_TextField.dart';
import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Model/GetAllBranchModel.dart';
import 'package:erp/Model/GetAllOrganizationModel.dart';
import 'package:erp/screens/ForgotPasswordScreen.dart';
import 'package:erp/widgets/search_dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper/extension.dart';
import '../../Helper/preferenceHelper.dart';
import 'LoginController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController loginController;

  // bool passwordVisible = false;
  bool checkBoxValue = false;

  int? orgId;

  @override
  void initState() {
    super.initState();
    loginController = Get.put(LoginController());
    loginController.organizationListGet();
    loadUserEmailPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginController.loginKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 35),
                child: Image.asset(
                  Assets.splash,
                  fit: BoxFit.fill,
                  scale: 3,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: CustomGradient(
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: MyFont.myFont2,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "Welcome Back!",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: MyFont.myFont2,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: MyColors.drakgreyText),
                ),
              ),
              CustomTextField(
                contentPadding: const EdgeInsets.only(top: 10, left: 10),
                inputBorder: InputBorder.none,
                controller: loginController.emailController,
                prefixIcon: const Icon(Icons.person),
                hintText: "Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Email Address';
                  }
                  return null;
                },
              ),
              CustomTextField(
                contentPadding: const EdgeInsets.only(top: 10, left: 10),
                inputBorder: InputBorder.none,
                controller: loginController.passwordController,
                prefixIcon: const Icon(Icons.lock),
                hintText: "Password",
                suffixIcon: IconButton(
                  icon: Image.asset(
                    loginController.isPasswordVisible.value
                        ? IconAssets.eye
                        : IconAssets.eyeClosed,
                    scale: 1.8,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        loginController.isPasswordVisible.value =
                            !loginController.isPasswordVisible.value;
                      },
                    );
                  },
                ),
                autoValidateMode: AutovalidateMode.onUserInteraction,
                obscureText:
                    loginController.isPasswordVisible.value ? false : true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Password';
                  } else if (!validateEmail(value)) {}
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Obx(() {
                  return SearchDropdownTextField<GetAllOrganization>(
                      controller: loginController.companyName,
                      filledColor: MyColors.greyIcon.withOpacity(0.3),
                      hintText: 'Company Name',
                      hintTextStyle: TextStyle(
                        fontFamily: MyFont.myFont2,
                        color: MyColors.black.withOpacity(0.5),
                      ),
                      textStyle: TextStyle(
                        fontFamily: MyFont.myFont2,
                        color: MyColors.black,
                      ),
                      suffixIcon: Icon(
                        Icons.expand_circle_down_outlined,
                        color: MyColors.black.withOpacity(0.7),
                      ),
                      inputBorder: BorderSide.none,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors.greyIcon.withOpacity(0.6),
                            width: 1.8),
                      ),
                      items: loginController.getOrganizationList.value,
                      color: Colors.black54,
                      selectedItem: loginController.getOrganization,
                      isValidator: true,
                      errorMessage: 'Please select Company Name',
                      onAddPressed: () {
                        setState(() {
                          loginController.companyName = "";
                          loginController.getOrganization = null;
                        });
                      },
                      onChanged: (value) async {
                        FocusScope.of(context).unfocus();
                        loginController.getOrganization = value;
                        loginController.companyName = value.name;
                        setState(() {
                          loginController.companyName = value.name;
                          orgId = value.orgId;
                        });
                        await PreferenceHelper.saveOrgString("${orgId}");
                        await loginController.branchListGet(orgId.toString());
                      });
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 8, right: 25),
                child: Obx(() {
                  return SearchDropdownTextField<GetAllBranchModel>(
                      controller: loginController.companyBranch,
                      filledColor: MyColors.greyIcon.withOpacity(0.3),
                      hintText: 'Company Branch',
                      hintTextStyle: TextStyle(
                        fontFamily: MyFont.myFont2,
                        color: MyColors.black.withOpacity(0.5),
                      ),
                      textStyle: TextStyle(
                        fontFamily: MyFont.myFont2,
                        color: MyColors.black,
                      ),
                      suffixIcon: Icon(
                        Icons.expand_circle_down_outlined,
                        color: MyColors.black.withOpacity(0.7),
                      ),
                      inputBorder: BorderSide.none,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      items: loginController.getBranchList.value,
                      color: Colors.black54,
                      selectedItem: loginController.getBranch,
                      isValidator: true,
                      errorMessage: 'Please select Company Branch',
                      onAddPressed: () {
                        setState(() {
                          loginController.companyBranch = "";
                          loginController.getBranch = null;
                        });
                      },
                      onChanged: (value) async {
                        FocusScope.of(context).unfocus();
                        loginController.getBranch = value;
                        loginController.companyBranch = value.name;
                        setState(() {
                          loginController.companyBranch = value.name!;
                          loginController.companyBranchCode = value.code;
                        });
                        await PreferenceHelper.saveBanchCodeString(
                            "${loginController.companyBranchCode}");
                        await PreferenceHelper.saveBranchNameString(
                            "${loginController.companyBranch}");
                      });
                }),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 12),
                  SizedBox(
                    height: 20,
                    child: Theme(
                      data: ThemeData(
                        unselectedWidgetColor: MyColors.primaryCustom,
                      ),
                      child: Checkbox(
                        activeColor: MyColors.primaryCustom,
                        value: checkBoxValue,
                        onChanged: (value) {
                          setState(
                            () {
                              handleRemeberme(value!);
                            },
                          );
                        },
                        shape: const CircleBorder(),
                      ),
                    ),
                  ),
                  CustomGradient(
                      child: Text(
                    'Remember Me',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: MyFont.myFont2,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ))
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                child: Row(
                  children: [
                    const SizedBox(width: 30),
                    Text(
                      'Forgot ',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: MyColors.drakgreyText),
                    ),
                    CustomGradient(
                        child: Text(
                      'Password?',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: MyFont.myFont2,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ))
                  ],
                ),
                onTap: () => Get.to(const ForgotPasswordScreen()),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            (loginController.isLoading.value == true)
                ? const CustomGradient(child: CircularProgressIndicator())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (loginController.loginKey.currentState!
                              .validate()) {
                            loginController.onLoginTapped(
                              loginController.companyBranchCode,
                              orgId,
                            );
                          } else {
                            print("Fields are Empty");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 50, right: 50),
                          margin: const EdgeInsets.only(
                            top: 5,
                            bottom: 20,
                            right: 20,
                            left: 20,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [
                                  MyColors.gradient1,
                                  MyColors.gradient2,
                                  MyColors.gradient3,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.5,
                                color: MyColors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "Don’t have an Account ? ",
            //       style: TextStyle(
            //           decoration: TextDecoration.none,
            //           fontFamily: MyFont.myFont2,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 15,
            //           color: MyColors.black),
            //     ),
            //     const SizedBox(width: 10),
            //     GestureDetector(
            //       onTap: () => Get.toNamed(AppRoutes.registrationScreen),
            //       child: Container(
            //           decoration: BoxDecoration(
            //               gradient: const LinearGradient(
            //                   colors: [
            //                     MyColors.gradient1,
            //                     MyColors.gradient2,
            //                     MyColors.gradient3,
            //                   ],
            //                   begin: Alignment.topCenter,
            //                   end: Alignment.bottomCenter),
            //               borderRadius: BorderRadius.circular(30),
            //               color: MyColors.mainTheme),
            //           padding: const EdgeInsets.only(
            //               top: 4, bottom: 4, right: 15, left: 15),
            //           child: Text(
            //             'Sign Up',
            //             style: TextStyle(
            //                 decoration: TextDecoration.none,
            //                 fontFamily: MyFont.myFont2,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 13,
            //                 letterSpacing: 0.5,
            //                 color: MyColors.white),
            //           )),
            //     )
            //   ],
            // ),
            const SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }

  //handle remember me function
  handleRemeberme(bool value) {
    checkBoxValue = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('User Name', loginController.emailController.text);
        prefs.setString('password', loginController.passwordController.text);
        prefs.setString('companyName', loginController.companyName ?? "");
        prefs.setString(
            'companyBranchName', loginController.companyBranch ?? "");
        prefs.setString('OrgNo', "${orgId}" ?? "");
      },
    );
    setState(() {
      checkBoxValue = value;
    });
  }

  //load email and password
  loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("User Name") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _companyName = _prefs.getString("companyName") ?? "";
      var _companyBranchName = _prefs.getString("companyBranchName") ?? "";
      var _orgid = _prefs.getString("OrgNo") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;
      print(_remeberMe);
      print(_email);
      print("::::::::::::::::::;;");
      print(_password);
      print(_companyName);
      print(_companyBranchName);
      if (_remeberMe) {
        setState(() {
          checkBoxValue = true;
        });
        loginController.emailController.text = _email ?? "";
        loginController.passwordController.text = _password ?? "";
        loginController.companyName = _companyName ?? "";
        loginController.companyBranch = _companyBranchName ?? "";
        orgId = int.parse(_orgid ?? "");
      }
    } catch (e) {
      print(e);
    }
  }
}
