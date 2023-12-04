import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../Helper/appRoute.dart';
import '../../Helper/assets.dart';
import '../../Helper/colors.dart';
import '../../Helper/fonts.dart';
import '../../widgets/Custom_TextField_2.dart';
import '../successfully_msg_screen.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({Key? key}) : super(key: key);

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  TextEditingController gstcontroller = TextEditingController();
  TextEditingController companyNamecontroller = TextEditingController();
  TextEditingController companyAddresscontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController postCodecontroller = TextEditingController();
  TextEditingController countrycontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController websitecontroller = TextEditingController();
  TextEditingController taxcontroller = TextEditingController();
  TextEditingController logocontroller = TextEditingController();

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          leading: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.bottomNavBarScreen);
            },
            child: Image.asset(
              IconAssets.leftIcon,
              color: MyColors.white,
              scale: 1.3,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Image.asset(
                IconAssets.search,
                scale: 1.8,
              ),
            )
          ],
          titleSpacing: -15,
          title: Text(
            "Master",
            style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: MyFont.myFont2,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.5,
                color: MyColors.white),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                MyColors.gradient1,
                MyColors.gradient2,
                MyColors.gradient3,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
        ),
        backgroundColor: MyColors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Company',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          color: MyColors.heading354038),
                    ),
                    // SizedBox(width: MediaQuery.of(context).size.width * 0.42,),
                    FlutterSwitch(
                        width: 100,
                        activeText: 'Active',
                        activeColor: Colors.green,
                        activeTextColor: MyColors.white,
                        showOnOff: true,
                        inactiveText: 'Inactive',
                        inactiveTextColor: Colors.white70,
                        value: selected,
                        onToggle: (val) {
                          setState(() {
                            selected = val;
                          });
                        })
                  ],
                ),
              ),
              CustomTextField2(
                inputBorder: InputBorder.none,
                controller: gstcontroller,
                keyboardType: TextInputType.text,
                labelText: "GST No",
                suffixIcon: const Icon(Icons.search, color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: companyNamecontroller,
                keyboardType: TextInputType.datetime,
                labelText: "Company Name",
                hintText: 'AppXperts Enterprise Solutions',
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: MyColors.greyIcon,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Address 1',
                          suffixIcon: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          suffixIconColor: MyColors.greyIcon),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Address 1',
                          suffixIcon: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          suffixIconColor: MyColors.greyIcon),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Address 1',
                          suffixIcon: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          suffixIconColor: MyColors.greyIcon),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField2(
                      inputBorder: const OutlineInputBorder(),
                      controller: postCodecontroller,
                      keyboardType: TextInputType.text,
                      hintText: "State",
                      labelText: "State",
                    ),
                  ),
                  Expanded(
                    child: CustomTextField2(
                      inputBorder: const OutlineInputBorder(),
                      controller: countrycontroller,
                      keyboardType: TextInputType.number,
                      labelText: "Post Code",
                      hintText: "Post Code",
                    ),
                  ),
                ],
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: companyAddresscontroller,
                keyboardType: TextInputType.name,
                labelText: "Country",
                hintText: "India",
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: MyColors.mainTheme),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: companyAddresscontroller,
                keyboardType: TextInputType.number,
                labelText: "Phone No.",
                hintText: "32154 22226",
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: companyAddresscontroller,
                keyboardType: TextInputType.emailAddress,
                labelText: "Email",
                hintText: "mohankumar.appxperts@gmail.com",
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: MyColors.greyIcon,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Website 1',
                          suffixIcon: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          suffixIconColor: MyColors.greyIcon),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Website 2',
                          suffixIcon: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          suffixIconColor: MyColors.greyIcon),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Website 3',
                          suffixIcon: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          suffixIconColor: MyColors.greyIcon),
                    )
                  ],
                ),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: companyAddresscontroller,
                keyboardType: TextInputType.name,
                labelText: "Tax Type",
                hintText: "Inarchive",
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: MyColors.mainTheme),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: MyColors.greyText,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Image.asset(IconAssets.uploadIcon),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Click here to upload Photo/Video',
                        style: TextStyle(color: hexStringToColor('B4B4B4')),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => Get.to(SuccessfullyMsgScreen(
                  name: 'Company Saved Successfully..!',
                  filename: Get.toNamed(AppRoutes.customerList),
                )),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  // height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [
                            MyColors.gradient1,
                            MyColors.gradient2,
                            MyColors.gradient3,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Save',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: MyFont.myFont2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: MyColors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              )
            ],
          ),
        ));
  }
}
