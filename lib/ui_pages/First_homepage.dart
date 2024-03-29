import 'package:aug_new_demo/controller/product_controller.dart';
import 'package:aug_new_demo/ui_pages/brand_Product_page.dart';
import 'package:aug_new_demo/ui_pages/cartpage.dart';
import 'package:aug_new_demo/ui_pages/sign_in_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/theme.dart';

// ignore: must_be_immutable, camel_case_types
class first_Homepage extends StatefulWidget {
  const first_Homepage({Key? key}) : super(key: key);

  @override
  State<first_Homepage> createState() => _first_HomepageState();
}

class _first_HomepageState extends State<first_Homepage> {
  final productController = Get.put(ProductController());

  //For Filter Brands From api
  Future<void> _pullRefresh() async {
    productController.fetchProducts();
  }

  bool isadded = false;

  final RxBool _isLightTheme = false.obs;

  final RxBool _isdarkTheme = false.obs;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  _saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', _isLightTheme.value);
  }

  _getThemeStatus() async {
    var _isLight = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') != null ? prefs.getBool('theme') : true;
    }).obs;
    _isLightTheme.value = (await _isLight.value)!;
    Get.changeThemeMode(_isLightTheme.value ? ThemeMode.light : ThemeMode.dark);
  }

  MyApp() {
    _getThemeStatus();
  }

  // ignore: non_constant_identifier_names
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white30,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.logout_rounded,
            // color: Colors.black,
          ),
          onPressed: () {
            Get.defaultDialog(
              title: 'Are You Sure ',
              middleText: '🥲 🥲 🥲 🥲 🥲',
              radius: 30,
              textConfirm: 'Yes',
              textCancel: 'No',
              titlePadding: const EdgeInsets.all(10),
              // cancel: Text('Sure'),
              // confirm: Text('No way'),
              onCancel: () {
                Navigator.pop(context);
              },
              onConfirm: () {
                Get.offAll(const LoginPage());
              },
            );

            // Get.to(const LoginPage());
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              // color: Colors.black,
            ),
            onPressed: () {
              // ignore: prefer_typing_uninitialized_variables
              // var index;
              // var product = productController.productList[index];

              Get.to(cart_page());
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.sunny,
              // color: Colors.black,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).swapTheme();
              ObxValue(
                (data) => Switch(
                  value: _isLightTheme.value,
                  onChanged: (val) {
                    _isLightTheme.value = val;
                    // _isdarkTheme.value = val;
                    Get.changeThemeMode(
                      _isLightTheme.value ? ThemeMode.light : ThemeMode.dark,
                    );
                    Get.changeThemeMode(
                      _isdarkTheme.value ? ThemeMode.dark : ThemeMode.light,
                    );

                    _saveThemeStatus();
                  },
                ),
                false.obs,
              );
              _saveThemeStatus();

              // CartPageNew();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Buyerzone Brand's",
                      style: TextStyle(
                        fontFamily: 'avenir',
                        fontSize: 30,
                      ),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        showSearch(
                            context: context, delegate: Mysearchdelegate());
                      }),
                  // IconButton(
                  //     icon: const Icon(Icons.grid_view),
                  //     onPressed: () {
                  //       // Get.to(menupage());
                  //     }),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Obx(() {
                  if (productController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return RefreshIndicator(
                      onRefresh: _pullRefresh,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SingleChildScrollView(
                          child: StaggeredGrid.count(
                            crossAxisCount: GetPlatform.isWeb ? 3 : 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children: List.generate(
                              productController.productList.length,
                              (index) {
                                var product =
                                    productController.productList[index];
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => brand_products_page(
                                        product: product,
                                        // product: product,
                                      ),
                                    ),
                                  ),
                                  child: Card(
                                    elevation: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: GetPlatform.isWeb
                                                    ? 300
                                                    : 200,
                                                width: double.infinity,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Colors.white,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://media.istockphoto.com/photos/sunset-waterfall-picture-id483822568',
                                                    // product.imageLink ?? "",
                                                    placeholder: (context,
                                                            url) =>
                                                        Image.asset(
                                                            "assets/images/placeholderimage.jpg"),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                  // Image.network(
                                                  //   product.imageLink ?? "",
                                                  //   fit: BoxFit.scaleDown,
                                                  // ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 0,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: IconButton(
                                                    icon: Icon(product
                                                            .isFavourite.value
                                                        ? Icons.favorite_rounded
                                                        : Icons
                                                            .favorite_border),
                                                    onPressed: () {
                                                      product.isFavourite
                                                          .toggle();
                                                      // Navigator.push(
                                                      //   context,
                                                      //   MaterialPageRoute(
                                                      //     builder: (context) =>
                                                      //         CartPage(
                                                      //       product: product,
                                                      //       // catalog: catalog,
                                                      //       // product: product,
                                                      //     ),
                                                      //   ),
                                                      // );

                                                      // onTap:
                                                      // () => Navigator.push(
                                                      //       context,
                                                      //       MaterialPageRoute(
                                                      //         builder:
                                                      //             (context) =>
                                                      //                 CartPageNew(
                                                      //           // catalog: catalog,
                                                      //           product: product,
                                                      //         ),
                                                      //       ),
                                                      //     );
                                                    },
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            product.brand ?? "",
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontFamily: 'avenir',
                                              // fontWeight: FontWeight.w800
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 2),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  (product.rating == null)
                                                      ? ""
                                                      : product.rating
                                                          .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     Text(
                                          //       '\$${product.price}',
                                          //       style: const TextStyle(
                                          //           fontSize: 20,
                                          //           fontFamily: 'avenir'),
                                          //     ),
                                          //     ElevatedButton(
                                          //       onPressed: () {
                                          //         final _catalog =
                                          //             productController;

                                          //         isadded = isadded.toggle();
                                          //         // setState(() {});
                                          //       },
                                          //       style: ButtonStyle(
                                          //           backgroundColor:
                                          //               MaterialStateProperty
                                          //                   .all(
                                          //                       Colors.white30),
                                          //           shape: MaterialStateProperty
                                          //               .all(
                                          //                   const StadiumBorder())),
                                          //       child: isadded
                                          //           ? Icon(Icons.done)
                                          //           : Icon(Icons.shopping_cart),
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                    // // ignore: non_constant_identifier_names
                    // var StaggeredGridView;
                    // // ignore: non_constant_identifier_names
                    // var StaggeredTile;
                    // return StaggeredGridView.countBuilder(
                    //   crossAxisCount: 2,
                    //   itemCount: controller.productList.length,
                    //   crossAxisSpacing: 16,
                    //   mainAxisSpacing: 16,
                    //   itemBuilder: (context, index) {
                    //     return ProductTile(controller.productList[index]);
                    //   },
                    //   staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    // );
                  }
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showMarkedAsDoneSnackbar(bool? isMarkedAsDone) {
    // if (isMarkedAsDone ?? false)
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text('Marked as done!'),
    //   ));
  }

  Dio() {}
}

class Mysearchdelegate extends SearchDelegate {
  final productController = Get.put(ProductController());
  // List<String> searchresult = [
  //   'apple',
  //   'bannana',
  //   'watermelon',
  //   'orange',
  //   'mango',
  //   'Kivi',
  // ];

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(
            Icons.clear,
          ),
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      );

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
          style: const TextStyle(fontSize: 50, fontWeight: FontWeight.normal),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<dynamic> cityNames =
        productController.productList.map((city) => city.name).toList();

    productController.productList.map((element) {
      return element.name;
    }).toList();

    // productController.productList.map((element) {
    //   return element.name?.startsWith('s');
    // }).toList();

    List<dynamic> suggestions = cityNames.where((searchresult) {
      final result = searchresult?.toLowerCase();
      final input = query.toLowerCase();
      return result!.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        // suggestions = suggestions[index] as List<String>;
        return ListTile(
          title: Text(suggestions[index] ?? ""),
          onTap: () {
            query = suggestions as String;
          },
        );
      },
    );
  }
}

// class _OpenContainerWrapper extends StatelessWidget {
//   const _OpenContainerWrapper({
//     required this.closedBuilder,
//     required this.transitionType,
//     required this.onClosed,
//   });

//   final CloseContainerBuilder closedBuilder;
//   final ContainerTransitionType transitionType;
//   final ClosedCallback<bool?> onClosed;

//   @override
//   Widget build(BuildContext context) {
//     return OpenContainer<bool>(
//       transitionType: transitionType,
//       openBuilder: (BuildContext context, VoidCallback _) {
//         return CartPage();
//       },
//       onClosed: onClosed,
//       tappable: false,
//       closedBuilder: closedBuilder,
//     );
//   }
// }

// class _InkWellOverlay extends StatelessWidget {
//   const _InkWellOverlay({
//     this.openContainer,
//     this.child,
//   });

//   final VoidCallback? openContainer;
//   final Widget? child;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: null,
//       child: InkWell(
//         onTap: openContainer,
//         child: child,
//       ),
//     );
//   }
// }
