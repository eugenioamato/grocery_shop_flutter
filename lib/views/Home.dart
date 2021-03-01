import 'package:flutter/material.dart';
import 'package:grocery_shop_flutter/bloc/CartBloc.dart';
import 'package:grocery_shop_flutter/components/GridShop.dart';
import 'package:grocery_shop_flutter/components/CartManager.dart';
import 'package:grocery_shop_flutter/models/CategoryHelper.dart';
import 'package:grocery_shop_flutter/models/Product.dart';
import 'package:grocery_shop_flutter/repositories/ProductsRepository.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _showCart = false;
  CartBloc _cartBloc;
  List<String> categories;
  List<Product> products;
  CategoryHelper categoryHelper;


  ScrollController _scrollController =  ScrollController();

  @override
  initState(){
    _scrollController =  ScrollController();
    _cartBloc =  CartBloc();
    categoryHelper=CategoryHelper();
    categories=ProductsRepository().getCategories();
    products=ProductsRepository().fetchAllProducts(categoryHelper.getCategory());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double topPadding=MediaQuery.of(context).padding.top;
    return
      SafeArea(
        child: Scaffold(backgroundColor: Colors.black, body:
           Container(
             child:
               ListView(physics: NeverScrollableScrollPhysics(),

                   controller: _scrollController, children: <Widget>[
                 GridShop(categoryHelper,products,categories
                       ,topPadding),
                     CartManager(topPadding)
              ]),





           ),
        floatingActionButton: Align(alignment: Alignment.bottomRight, child:
            Container(margin: EdgeInsets.only(right: 10, bottom: 10),child:
            FloatingActionButton(onPressed: (){
              if(_showCart)
                _scrollController.animateTo(_scrollController.position.minScrollExtent, curve: Curves.fastOutSlowIn, duration: Duration(seconds: 1));
              else
                _scrollController.animateTo(_scrollController.position.maxScrollExtent, curve: Curves.fastOutSlowIn, duration: Duration(seconds: 1));

              setState(() {
                _showCart = !_showCart;
              });

            }, backgroundColor: Colors.amber, child:  Icon(_showCart ? Icons.close : Icons.shopping_cart))
            )
        ),

        
    ),
      );
  }


  @override
  void dispose() {
    _cartBloc.dispose();
    super.dispose();
  }
}
