// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealgenius/src/data/data.dart';
import 'package:mealgenius/src/models/content.dart';
import 'package:mealgenius/src/screens/private/home_screen.dart';
import 'package:mealgenius/src/widget/shop_list_page_widget.dart';
import 'package:image_picker/image_picker.dart';
import '../../widget/custom_appbar.dart';

class ShoplistScreeen extends StatefulWidget {
  final Function(int) onItemtap;

  const ShoplistScreeen({required this.onItemtap, super.key});

  @override
  State<ShoplistScreeen> createState() => _ShoplistScreeenState();
}

class _ShoplistScreeenState extends State<ShoplistScreeen> {
  void _createshoplist(List<ShopListContent> shoplist) {
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            ShopListContent newShopList = ShopListContent(
                image: Image.asset('lib/img/food-app-icon-9.jpg'), product: []);
            return Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: SingleChildScrollView(
                child: AlertDialog(
                  titlePadding: const EdgeInsets.only(left: 80, top: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Text('new shoplist',
                      style: GoogleFonts.lato(
                          color: tipo, fontWeight: FontWeight.w800)),
                  content: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          newShopList.list = value;
                        },
                        decoration: InputDecoration(
                          label: Text(
                            'name',
                            style: GoogleFonts.lato(
                                color: tipo,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(primaryColor),
                          ),
                          onPressed: () async {
                            final imagePicker = ImagePicker();
                            final image = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              newShopList.image = Image.asset(image.path);
                            }
                          },
                          child: const Icon(Icons.image)),
                      TextButton(
                          onPressed: () => {
                                setState(() {
                                  shoplist.add(newShopList);
                                }),
                                Navigator.pop(context)
                              },
                          child: Text(
                            'Submit',
                            style: GoogleFonts.lato(
                                color: positive,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ))
                    ],
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: CircleAvatar(
                        backgroundColor: primaryColor,
                        child: Icon(
                          Icons.close,
                          color: backgroundColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('value'),
      resizeDuration: const Duration(milliseconds: 1),
      background: const HomeScreen(),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          widget.onItemtap(0);
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: CustomAppbar(
          title: 'Shopping lists',
          leading: IconButton(
              onPressed: () => widget.onItemtap(0),
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 530,
                      width: double.infinity,
                      color: backgroundColor,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Our recommandation',
                                style:
                                    GoogleFonts.lato(color: Colors.grey[500])),
                            ShopListWidget(
                                shoplistList: recommandationShopList),
                            Text('Rencently created',
                                style:
                                    GoogleFonts.lato(color: Colors.grey[500])),
                            ShopListWidget(
                              shoplistList: myShopList,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () => _createshoplist(myShopList),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: primaryColor),
                        child: Text(
                          'Create new shoplist',
                          style: GoogleFonts.lato(color: backgroundColor),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class ShopListWidget extends StatefulWidget {
  List<ShopListContent> shoplistList;
  ShopListWidget({required this.shoplistList, super.key});

  @override
  State<ShopListWidget> createState() => _ShopListWidgetState();
}

class _ShopListWidgetState extends State<ShopListWidget> {
  void _ShopListManagement(ShopListContent list) {
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog.fullscreen(child: ShopListPageWidget(list: list));
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.shoplistList.isEmpty
        ? const SizedBox(
            height: 80,
          )
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.shoplistList.length,
            itemBuilder: (BuildContext context, int index) {
              final ShopListContent shoplist = widget.shoplistList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Stack(children: [
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: backgroundColor),
                  ),
                  Positioned(
                      top: 15,
                      left: 20,
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircleAvatar(
                          backgroundColor: Colors.amber[100],
                          child: ClipOval(child: shoplist.image),
                        ),
                      )),
                  Positioned(
                    top: 18,
                    left: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shoplist.list,
                          style: GoogleFonts.lato(
                              color: tipo,
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          '${shoplist.product.length} products',
                          style: GoogleFonts.lato(color: tipo),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 30,
                      right: 0,
                      child: IconButton(
                          onPressed: () => _ShopListManagement(shoplist),
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.grey[400],
                            size: 20,
                          )))
                ]),
              );
            });
  }
}
