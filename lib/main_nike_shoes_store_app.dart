import 'package:diegoveloper_nike_shes_store_1/nike_shoes.dart';
import 'package:diegoveloper_nike_shes_store_1/nike_shoes_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MainNikeShesStore());

class MainNikeShesStore extends StatelessWidget {
  const MainNikeShesStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: NikeShoesStoreHome(),
    );
  }
}

class NikeShoesStoreHome extends StatelessWidget {
  final ValueNotifier<bool> notifierBottomBarVisible = ValueNotifier(true);

  void _onShoesPressed(NikeShoes shoes, BuildContext context) async {
    notifierBottomBarVisible.value = false;
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return FadeTransition(
            opacity: animation1,
            child: NikeShoesDetails(),
          );
        },
      ),
    );
    notifierBottomBarVisible.value = true;
  }

  NikeShoesStoreHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    "assets/images/nike_logo.png",
                    height: 40,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: shoes.length,
                      padding: EdgeInsets.only(bottom: 20),
                      itemBuilder: (context, index) {
                        final shoesItem = shoes[index];
                        return NikeShoesItem(
                          shoesItem: shoesItem,
                          onTap: () {
                            _onShoesPressed(shoesItem, context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: notifierBottomBarVisible,
              child: Container(
                color: Colors.white.withOpacity(0.7),
                child: Row(
                  children: const [
                    Expanded(
                      child: Icon(Icons.home),
                    ),
                    Expanded(
                      child: Icon(Icons.search),
                    ),
                    Expanded(
                      child: Icon(Icons.favorite),
                    ),
                    Expanded(
                      child: Icon(Icons.shopping_cart),
                    ),
                    Expanded(
                      child: Center(
                        child: CircleAvatar(
                          radius: 15,
                          backgroundImage: AssetImage('assets/images/logo.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              builder: (context, value, child) {
                return AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  left: 0,
                  right: 0,
                  bottom: value ? 0.0 : -kToolbarHeight,
                  height: kToolbarHeight,
                  child: child!,
                
                );
                
              }
            ),
          ],
        ),
      ),
    );
  }
}

class NikeShoesItem extends StatelessWidget {
  final NikeShoes shoesItem;
  final VoidCallback onTap;

  const NikeShoesItem({
    Key? key,
    required this.shoesItem,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const itemHeight = 290.0;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: SizedBox(
          height: itemHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(shoesItem.color),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: itemHeight * 0.6,
                  child: FittedBox(
                    child: Text(
                      shoesItem.modelNumber.toString(),
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.05),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 100,
                height: itemHeight * 0.65,
                child: Image.asset(
                  shoesItem.images.first,
                  fit: BoxFit.contain,
                ),
              ),
              const Positioned(
                bottom: 20,
                left: 20,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                ),
              ),
              const Positioned(
                bottom: 20,
                right: 20,
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      shoesItem.model,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '\$${shoesItem.oldPrice.toInt().toString()}',
                      style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '\$${shoesItem.currentPrice.toInt().toString()}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
