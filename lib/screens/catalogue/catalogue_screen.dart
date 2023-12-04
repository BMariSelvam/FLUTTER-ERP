import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/extension.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/Model/GetAllCustomerModel.dart';
import 'package:erp/Model/GetAllProductModel.dart';
import 'package:erp/screens/catalogue/cart/sales_order_cart_screen.dart';
import 'package:erp/screens/catalogue/catalogue_controller.dart';
import 'package:erp/widgets/search_dropdown_textfield2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Helper/assets.dart';
import '../../Helper/colors.dart';
import '../../Helper/fonts.dart';
import '../../Helper/preferenceHelper.dart';

class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({Key? key}) : super(key: key);

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  final ScrollController _scrollController = ScrollController();

  late CatalogueController controller;
  late GetAllProductModel productModel1;

  int currentIndex = 0;

  String? cateogryId = '';
  String? subCateogryId = '';
  double totalcost = 0;
  double totalcount = 0;
  double totalunitcount = 0;
  double totalboxcost = 0;
  double totalboxcount = 0;
  double totalunitcost = 0;
  double boxTotal = 0;
  double unitTotal = 0;
  bool isLoading = false;
  final _scrollThreshold = 200.0;
  List<String> savedProduct = [];
  String code = "";

  @override
  void initState() {
    super.initState();
    // Listen to changes in the cart and refresh the state
    controller = Get.put(CatalogueController());
    controller.cartService.catalogueProductListChangeStream.listen((_) {
      setState(() {});
    });
    initData();
  }

  late final List<GetAllProductModel> localData;

  Future<void> initData() async {
    productModel1 = Get.put(GetAllProductModel());
    await controller.getAllCustomerList();
    await controller.getCategoryList();
    await controller.getSubCategoryList(categoryId: "");
    controller.currentPage = 1;
    await controller.getProductByCategoryId(
        categoryId: cateogryId ?? '',
        subCategoryId: subCateogryId ?? '',
        isPagination: false);
    _scrollController.addListener(_scrollListener);
    localData = await PreferenceHelper.getCartData();
    if (localData != null) {
      for (int i = 0; i < localData.length; i++) {
        savedProduct.add(localData[i].productCode!);
      }
      controller.cartAddedProduct.clear();
      controller.cartAddedProduct.addAll(localData);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollListener() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      if (controller.currentPage <= controller.totalPages &&
          !controller.status.isLoadingMore) {
        await controller.getProductByCategoryId(
            categoryId: cateogryId ?? '',
            subCategoryId: subCateogryId ?? '',
            isPagination: true);
      }
    }
  }

  final ScrollController _scrollGridController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    controller.updateProductCount();
    return GetBuilder<CatalogueController>(
        init: controller,
        builder: (state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              toolbarHeight: 80,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    MyColors.gradient1,
                    MyColors.gradient2,
                    MyColors.gradient3,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Get.offAndToNamed(AppRoutes.bottomNavBarScreen);
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              title: Text('Catalogue',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: MyFont.myFont,
                      color: MyColors.white)),
              centerTitle: false,
              actions: [
                buildAppBarCartButton() // Replace with your desired widget
              ],
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                  child: Column(
                    children: [
                      Obx(() {
                        return SearchDropdownTextField2<GetCustomerModel>(
                            labelText: 'Select Customer',
                            suffixIcon: const CustomGradient(
                              child: Icon(
                                Icons.expand_circle_down_outlined,
                                color: MyColors.black,
                              ),
                            ),
                            items: controller.getCustomerList.value,
                            color: Colors.black54,
                            selectedItem: controller.getCustomerModel,
                            isValidator: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: 'Please select Customer Name');
                                return 'Please select Customer Name';
                              }
                              return null;
                            },
                            onAddPressed: () {
                              setState(() {
                                controller.customer = "";
                                controller.getCustomerModel = null;
                              });
                            },
                            onChanged: (value) async {
                              FocusScope.of(context).unfocus();
                              controller.getCustomerModel = value;
                              controller.customer = value.name!;
                              // controller.isCusSelected = true;
                              controller
                                  .cartService.catalogueProductSelectedListItems
                                  .clear();
                              setState(() {
                                code = value.code ?? "";
                                controller.getAllCustomerByCodeList(code);
                              });
                              await PreferenceHelper.saveEmail(
                                  key: "my_key", value: controller.customer);
                            });
                      }),
                      const SizedBox(
                        height: 5,
                      ),
                      // banner list
                      // Categroy and Sub category Listview
                      Column(
                        children: [
                          if (controller.categoryList.value?.isNotEmpty ??
                              false)
                            buildCategoryListView(context),
                          buildSubCategoryListView(),
                        ],
                      ),
                      // Product List Vie
                      _productListView()
                    ],
                  ),
                ),
                // if (controller.status.isLoading)
                //   const Center(
                //     child: CircularProgressIndicator(),
                //   )
              ],
            ),
          );
        });
  }

  Widget buildCategoryListView(BuildContext context) {
    return Obx(() {
      return SizedBox(
        height: 55,
        child: ListView.builder(
            controller: _horizontalScrollController,
            shrinkWrap: true,
            itemCount: controller.categoryList.value?.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  controller.category.value = index;
                  controller.currentPage = 1;
                  controller.totalPages = 1;
                  controller.productList.clear();
                  if (index == 0) {
                    cateogryId = "";
                    subCateogryId = "";
                    controller.subCategoryList.value = null;
                    await controller.getProductByCategoryId(
                        categoryId: '', subCategoryId: '', isPagination: false);
                  } else {
                    cateogryId = controller.categoryList.value?[index].code;
                    await controller.getSubCategoryList(
                        categoryId: cateogryId ?? '');
                    await controller.getProductByCategoryId(
                        categoryId: cateogryId ?? '',
                        subCategoryId: '',
                        isPagination: false);
                  }
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    gradient: controller.category.value == index
                        ? const LinearGradient(
                            colors: [
                                MyColors.gradient1,
                                MyColors.gradient2,
                                MyColors.gradient3,
                              ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)
                        : const LinearGradient(
                            colors: [Colors.transparent, Colors.transparent]),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: MyColors.greyIcon),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      controller.categoryList.value?[index].name ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: MyFont.myFont,
                        letterSpacing: 0.5,
                        fontSize: 13,
                        color: controller.category.value == index
                            ? MyColors.white
                            : MyColors.black,
                      ),
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }

  Widget buildSubCategoryListView() {
    return Obx(() {
      return (controller.subCategoryList.value != null)
          ? Container(
              padding: const EdgeInsets.only(bottom: 5, right: 5, left: 5),
              height: 55,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.subCategoryList.value?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        controller.subcategory.value = index;
                        controller.currentPage = 1;
                        controller.totalPages = 1;
                        controller.productList.clear();
                        if (index == 0) {
                          await controller.getProductByCategoryId(
                              categoryId: cateogryId ?? '',
                              subCategoryId: "",
                              isPagination: false);
                        } else {
                          subCateogryId =
                              controller.subCategoryList.value?[index].code;

                          await controller.getProductByCategoryId(
                              categoryId: cateogryId ?? '',
                              subCategoryId: subCateogryId ?? '',
                              isPagination: false);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          gradient: controller.subcategory.value == index
                              ? const LinearGradient(
                                  colors: [
                                      MyColors.gradient1,
                                      MyColors.gradient2,
                                      MyColors.gradient3,
                                    ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)
                              : const LinearGradient(colors: [
                                  Colors.transparent,
                                  Colors.transparent
                                ]),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: MyColors.greyIcon),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            controller.subCategoryList.value?[index].name ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: MyFont.myFont,
                              letterSpacing: 0.5,
                              fontSize: 13,
                              color: controller.subcategory.value == index
                                  ? MyColors.white
                                  : MyColors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }))
          : Container();
    });
  }

  Widget buildAppBarCartButton() {
    return Obx(() {
      return GestureDetector(
        onTap: () async {
          if (controller.getCustomerModel != null &&
              controller.customer.isNotEmpty) {
            if (controller.cartAddedProduct.isNotEmpty) {
              print("::::::::::::::::::::");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SalesOrderCartScreen(),
                  ));
              Get.toNamed(AppRoutes.cartScreen,
                      arguments: controller.cartAddedProduct)
                  ?.then((value) {
                if (value == true) {
                  initData();
                }
              });
            } else {
              Get.showSnackbar(
                const GetSnackBar(
                  margin: EdgeInsets.all(10),
                  borderRadius: 10,
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.TOP,
                  message: "Please select atleast one product",
                  icon: Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                  duration: Duration(seconds: 1),
                ),
              );
            }
          } else {
            Get.showSnackbar(
              const GetSnackBar(
                margin: EdgeInsets.all(10),
                borderRadius: 10,
                backgroundColor: Colors.red,
                snackPosition: SnackPosition.TOP,
                message: "Please select Customer",
                icon: Icon(
                  Icons.error,
                  color: Colors.white,
                ),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 11.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 11.0),
                child: Icon(
                  Icons.shopping_cart,
                  color: MyColors.white,
                  size: 30,
                ),
              ),
              if (controller.cartAddedProduct.isNotEmpty)
                Positioned(
                  top: 12,
                  right: 5,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffc32c37),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: Center(
                      child: Text(
                        controller.cartAddedProduct.length.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  _productListView() {
    if ((controller.productList.isNotEmpty)) {
      return Column(
        children: [
          GridView.builder(
              controller: _scrollGridController,
              shrinkWrap: true,
              itemCount: controller.productList.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .68,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              itemBuilder: (context, index) {
                boxTotal = controller.productList[index].sellingBoxCost!;
                unitTotal = controller.productList[index].sellingCost!;
                // boxTotal = controller
                //         .product.value[index].sellingBoxCost! *
                //     controller.product.value[index].boxcount
                //         .toDouble();
                // unitTotal = controller
                //         .product.value[index].sellingCost! *
                //     controller.product.value[index].unitcount
                //         .toDouble();
                return Container(
                  padding: const EdgeInsets.only(
                    top: 2,
                    left: 2,
                    right: 2,
                  ),
                  child: Column(children: [
                    GestureDetector(
                      onTap: () {
                        controller.selectedIndex.value = index;
                        Get.toNamed(AppRoutes.aboutProductScreen,
                            arguments: controller.productList[index]);
                      },
                      child: Container(
                        width: 200,
                        height: 150,
                        padding: const EdgeInsets.fromLTRB(
                          15,
                          15,
                          15,
                          15,
                        ),
                        decoration: const BoxDecoration(
                          color: MyColors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.grey,
                              blurRadius: 2,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: (controller
                                    .productList[index].productImagePath !=
                                null)
                            ? ("${controller.productList[index].productImagePath}"
                                    .isNotEmpty)
                                ? Image.network(
                                    '${controller.productList[index].productImagePath}',
                                    fit: BoxFit.contain)
                                : Image.asset(Assets.noImg)
                            : const Icon(Icons.error),
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 15,
                        right: 5,
                        left: 5,
                      ),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              MyColors.gradient1,
                              MyColors.gradient2,
                              MyColors.gradient3,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.grey,
                            blurRadius: 2,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.selectedIndex.value = index;
                              Get.toNamed(AppRoutes.aboutProductScreen,
                                  arguments: controller.productList[index]);
                            },
                            child: SizedBox(
                              height: height(context) / 50,
                              width: width(context) / 2.2,
                              child: Text(
                                controller.productList[index].name ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: MyFont.myFont,
                                    fontSize: 10,
                                    color: MyColors.white),
                              ),
                            ),
                          ),
                          (controller.productList[index].pcsPerCarton == 1)
                              ? Container(height: 9)
                              : Row(
                                  children: [
                                    Text(
                                      "BoxCount :  ",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: MyFont.myFont,
                                          fontSize: 8,
                                          color: MyColors.white),
                                    ),
                                    Text(
                                      controller.productList[index].pcsPerCarton
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: MyFont.myFont,
                                          fontSize: 8,
                                          color: MyColors.white),
                                    ),
                                  ],
                                ),
                          const SizedBox(
                            height: 5,
                          ),
                          if (controller.productList[index].pcsPerCarton == 1)
                            Container(
                              height: 25,
                            )
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: MyColors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        "Box",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8,
                                            color: MyColors.mainTheme),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: 25,
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    GetAllProductModel?
                                                        selectedProduct =
                                                        controller
                                                            .productList[index];

                                                    setState(() {
                                                      controller.cartService
                                                          .removeFromCart(
                                                              productList:
                                                                  selectedProduct,
                                                              isBox: true);

                                                      controller
                                                          .updateProductCount();
                                                    });

                                                    controller
                                                            .productList[index]
                                                            .boxcountController
                                                            .text =
                                                        controller
                                                            .productList[index]
                                                            .boxcount
                                                            .toInt()
                                                            .toString();

                                                    if (selectedProduct
                                                                .unitcount ==
                                                            0 &&
                                                        selectedProduct
                                                                .boxcount ==
                                                            0) {
                                                      if (controller
                                                          .cartAddedProduct
                                                          .any((element) =>
                                                              element
                                                                  .productCode ==
                                                              selectedProduct
                                                                  .productCode)) {
                                                        var selectedIndex = controller
                                                            .cartAddedProduct
                                                            .indexWhere((element) =>
                                                                element
                                                                    .productCode ==
                                                                selectedProduct
                                                                    .productCode);

                                                        controller
                                                            .cartAddedProduct
                                                            .removeAt(
                                                                selectedIndex);
                                                        if (controller
                                                            .cartAddedProduct
                                                            .isEmpty) {
                                                          controller
                                                              .cartAddedProduct
                                                              .clear();
                                                        }
                                                      }
                                                    }
                                                    if (controller
                                                            .productList[index]
                                                            .boxcountController
                                                            .text ==
                                                        "0") {
                                                      controller
                                                          .cartAddedProduct
                                                          .length = 0;
                                                    }
                                                    await PreferenceHelper
                                                        .saveCartData(controller
                                                            .cartAddedProduct);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 1,
                                                      bottom: 1,
                                                      right: 6,
                                                      left: 6,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: MyColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: const Icon(
                                                        Icons.remove,
                                                        size: 12,
                                                        color:
                                                            MyColors.mainTheme),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                SizedBox(
                                                  width: width(context) / 15,
                                                  child: TextField(
                                                    onChanged: (String) {
                                                      controller
                                                              .productList[index]
                                                              .boxcountController
                                                              .text =
                                                          controller
                                                              .productList[
                                                                  index]
                                                              .boxcount
                                                              .toInt()
                                                              .toString();
                                                    },
                                                    maxLines: 1,
                                                    maxLength: 3,
                                                    readOnly: true,
                                                    maxLengthEnforcement:
                                                        MaxLengthEnforcement
                                                            .enforced,
                                                    textAlign: TextAlign.center,
                                                    showCursor: false,
                                                    inputFormatters: [
                                                      NumericInputFormatter(),
                                                    ],
                                                    decoration:
                                                        const InputDecoration(
                                                      border: InputBorder.none,
                                                      counterText: '',
                                                      hintStyle: TextStyle(
                                                          color:
                                                              MyColors.white),
                                                      hintText: "0",
                                                    ),
                                                    controller: controller
                                                        .productList[index]
                                                        .boxcountController,
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        color: MyColors.white),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    // controller
                                                    //         .product[index]
                                                    //         .boxcountController
                                                    //         .text =
                                                    //     controller
                                                    //         .product[
                                                    //             index]
                                                    //         .boxcount
                                                    //         .toInt()
                                                    //         .toString();
                                                    GetAllProductModel?
                                                        selectedProduct =
                                                        controller
                                                            .productList[index];

                                                    if (savedProduct.contains(
                                                        selectedProduct
                                                            .productCode)) {
                                                      var selectedIndex = controller
                                                          .cartAddedProduct
                                                          .indexWhere((element) =>
                                                              element
                                                                  .productCode ==
                                                              selectedProduct
                                                                  .productCode);

                                                      controller
                                                          .cartAddedProduct
                                                          .removeAt(
                                                              selectedIndex);
                                                      savedProduct.remove(
                                                          selectedProduct
                                                              .productCode);
                                                    }
                                                    // selectedProduct
                                                    //     .boxcountincrement();

                                                    if (selectedProduct
                                                                .unitcount !=
                                                            0 ||
                                                        selectedProduct
                                                                .boxCount !=
                                                            0) {
                                                      setState(() {
                                                        controller.cartService
                                                            .addToProductList(
                                                          isBox: true,
                                                          productList:
                                                              selectedProduct,
                                                        );

                                                        controller
                                                            .updateProductCount();
                                                      });
                                                      bool isAlreadyAdded = controller
                                                          .cartAddedProduct
                                                          .any((element) =>
                                                              element
                                                                  .productCode ==
                                                              selectedProduct
                                                                  .productCode);

                                                      if (!isAlreadyAdded) {
                                                        controller
                                                            .cartAddedProduct
                                                            .add(
                                                                selectedProduct);
                                                      }
                                                    }
                                                    await PreferenceHelper
                                                        .saveCartData(controller
                                                            .cartAddedProduct);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 1,
                                                      bottom: 1,
                                                      right: 6,
                                                      left: 6,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: MyColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: const Icon(Icons.add,
                                                        size: 12,
                                                        color:
                                                            MyColors.mainTheme),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      "\$ ${boxTotal.toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: MyFont.myFont,
                                          fontSize: 10,
                                          // decoration: TextDecoration.lineThrough,
                                          color: MyColors.white)),
                                ),
                              ],
                            ),
                          SizedBox(
                            height: height(context) / 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: MyColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      "Unit",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8,
                                          color: MyColors.mainTheme),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 25,
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                          .productList[index]
                                                          .unitcountController
                                                          .text =
                                                      controller
                                                          .productList[index]
                                                          .unitcount
                                                          .toInt()
                                                          .toString();
                                                  GetAllProductModel?
                                                      selectedProduct =
                                                      controller
                                                          .productList[index];

                                                  // selectedProduct.unitdecrement();

                                                  setState(() {
                                                    controller.cartService
                                                        .removeFromCart(
                                                            productList:
                                                                selectedProduct,
                                                            isBox: false);

                                                    controller
                                                        .updateProductCount();
                                                  });

                                                  if (selectedProduct
                                                              .unitcount ==
                                                          0 &&
                                                      selectedProduct
                                                              .boxcount ==
                                                          0) {
                                                    if (controller
                                                        .cartAddedProduct
                                                        .any((element) =>
                                                            element
                                                                .productCode ==
                                                            selectedProduct
                                                                .productCode)) {
                                                      var selectedIndex = controller
                                                          .cartAddedProduct
                                                          .indexWhere((element) =>
                                                              element
                                                                  .productCode ==
                                                              selectedProduct
                                                                  .productCode);

                                                      controller
                                                          .cartAddedProduct
                                                          .removeAt(
                                                              selectedIndex);
                                                      if (controller
                                                          .cartAddedProduct
                                                          .isEmpty) {
                                                        controller
                                                            .cartAddedProduct
                                                            .clear();
                                                      }
                                                    }
                                                  }
                                                  if (controller
                                                          .productList[index]
                                                          .boxcountController
                                                          .text ==
                                                      "0") {
                                                    controller.cartAddedProduct
                                                        .length = 0;
                                                  }
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 1,
                                                    bottom: 1,
                                                    right: 6,
                                                    left: 6,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: MyColors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: const Icon(
                                                      Icons.remove,
                                                      size: 12,
                                                      color:
                                                          MyColors.mainTheme),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              SizedBox(
                                                width: width(context) / 15,
                                                child: TextField(
                                                  onChanged: (String) {
                                                    controller
                                                            .productList[index]
                                                            .unitcountController
                                                            .text =
                                                        controller
                                                            .productList[index]
                                                            .unitcount
                                                            .toInt()
                                                            .toString();
                                                  },
                                                  maxLines: 1,
                                                  maxLength: 3,
                                                  readOnly: true,
                                                  maxLengthEnforcement:
                                                      MaxLengthEnforcement
                                                          .enforced,
                                                  textAlign: TextAlign.center,
                                                  showCursor: false,
                                                  inputFormatters: [
                                                    NumericInputFormatter(),
                                                  ],
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          counterText: '',
                                                          hintStyle: TextStyle(
                                                              color: MyColors
                                                                  .white),
                                                          hintText: "0"),
                                                  controller: controller
                                                      .productList[index]
                                                      .unitcountController,
                                                  style: const TextStyle(
                                                      fontSize: 11,
                                                      color: MyColors.white),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  controller
                                                          .productList[index]
                                                          .unitcountController
                                                          .text =
                                                      controller
                                                          .productList[index]
                                                          .unitcount
                                                          .toInt()
                                                          .toString();
                                                  GetAllProductModel?
                                                      selectedProduct =
                                                      controller
                                                          .productList[index];
                                                  if (savedProduct.contains(
                                                      selectedProduct
                                                          .productCode)) {
                                                    var selectedIndex = controller
                                                        .cartAddedProduct
                                                        .indexWhere((element) =>
                                                            element
                                                                .productCode ==
                                                            selectedProduct
                                                                .productCode);

                                                    controller.cartAddedProduct
                                                        .removeAt(
                                                            selectedIndex);
                                                    savedProduct.remove(
                                                        selectedProduct
                                                            .productCode);
                                                  }
                                                  // selectedProduct.unitincrement();

                                                  if (selectedProduct
                                                              .unitcount !=
                                                          0 ||
                                                      selectedProduct
                                                              .boxCount !=
                                                          0) {
                                                    setState(() {
                                                      controller.cartService
                                                          .addToProductList(
                                                        isBox: false,
                                                        productList:
                                                            selectedProduct,
                                                      );
                                                      controller
                                                          .updateProductCount();
                                                    });
                                                    bool isAlreadyAdded = controller
                                                        .cartAddedProduct
                                                        .any((element) =>
                                                            element
                                                                .productCode ==
                                                            selectedProduct
                                                                .productCode);

                                                    if (!isAlreadyAdded) {
                                                      controller
                                                          .cartAddedProduct
                                                          .add(selectedProduct);
                                                    }
                                                  }
                                                  await PreferenceHelper
                                                      .saveCartData(controller
                                                          .cartAddedProduct);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 1,
                                                    bottom: 1,
                                                    right: 6,
                                                    left: 6,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: MyColors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: const Icon(Icons.add,
                                                      size: 12,
                                                      color:
                                                          MyColors.mainTheme),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    "\$ ${unitTotal.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: MyFont.myFont,
                                        fontSize: 10,
                                        // decoration: TextDecoration.lineThrough,
                                        color: MyColors.white)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                );
              }),
          if (controller.status.isLoadingMore)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      );
    } else {
      if (controller.status.isLoadingMore || controller.status.isLoading) {
        return Container();
      }
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 150),
          child: Text("No product Found"),
        ),
      );
    }
  }
}
