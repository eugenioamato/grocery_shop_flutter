import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grocery_shop_flutter/models/CategoryHelper.dart';
import 'package:grocery_shop_flutter/models/Product.dart';
import 'package:grocery_shop_flutter/components/CategoryDropMenu.dart';
import 'package:grocery_shop_flutter/components/ProductWidget.dart';
import 'package:grocery_shop_flutter/components/MinimalCart.dart';

class GridShop extends StatefulWidget {

  final CategoryHelper categoryHelper;
  final List<String> categories;
  final List<Product> products;
  final double safeAreaHeight;

  const GridShop( this.categoryHelper, this.products,this.categories, this.safeAreaHeight,);
 @override
  _GridShop createState() =>  _GridShop();
}

class _GridShop extends State<GridShop> {

  List<Product> selectedProducts=[];

  @override
  void initState() {
    getFilteredProducts();
    super.initState();
  }

  Future<void> getFilteredProducts() async
  {
    selectedProducts=await filterProducts();
    if (mounted)
      setState(() {
      });
  }

  void refreshElements() async{
    if (mounted)
    setState(() {
      selectedProducts=[];
    });

    getFilteredProducts();


  }

  Future<List<Product>> filterProducts() async{
    String cat=widget.categoryHelper.getCategory();
    await Future.delayed(Duration(seconds: 1));
    if (cat=="All products")
      return widget.products;
    else
      return
        widget.products.where((e)=>e.category==cat)
            .toList();
  }

  @override
  Widget build(BuildContext context){

    double _gridSize = (MediaQuery.of(context).size.height
        -widget.safeAreaHeight)
        *0.88; //88% of screen
    double step= MediaQuery.of(context).size.width/150.0;
    int colCount=((MediaQuery.of(context).size.width-step*2)/(300.0)).ceil();
    if (colCount==2)
      {
        step= step*4.0;

      }
    return  Column(children: <Widget>[
       Container(height: _gridSize, decoration: BoxDecoration(color: const Color(0xFFeeeeee), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(_gridSize/10), bottomRight: Radius.circular(_gridSize/10))), padding: EdgeInsets.only(left: step, right: step), child:
         Column(children: <Widget>[
           Container(margin: EdgeInsets.only(top: step*2), child:
           Column(children: <Widget>[
             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
               CategoryDropMenu(widget.categoryHelper,refreshElements,widget.categories),
               FlatButton.icon(onPressed: (){}, icon:  Icon(Icons.filter_list), label:  Text(""))
            ]),
             Container(height: _gridSize - 88, child:
               PhysicalModel(
                  color: Colors.transparent,
                  borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(_gridSize/10 - step), bottomRight: Radius.circular(_gridSize/10 - step)),
                  clipBehavior: Clip.antiAlias,
                  child:
                  selectedProducts.isEmpty?loadingAnimation:
                  GridView.builder(
                      itemCount: selectedProducts.length,
                      gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 300.0, //childAspectRatio: childAspectRatio
                           ),
                      itemBuilder: (BuildContext context, int index) {
                        return  Padding(
                            padding: EdgeInsets.only(
                                top: (index%colCount)*step,
                                right: step,
                                left: step,
                                //right: index%colCount==0 ? 5 : 0,
                                //left: index%colCount==1 ? 5 : 0,
                                bottom: colCount*step-(index%colCount)*step),
                            child: ProductWidget(product: selectedProducts[index],
                            ),
                        );
                      }
                  )
              )
            )
          ])
          )
        ])
      ),
       MinimalCart(_gridSize)
    ]);
  }

  Widget get loadingAnimation =>
      Container(
          margin: EdgeInsets.all(4.0*sqrt(MediaQuery.of(context).size.width)),
          child: FittedBox(
        fit:BoxFit.fitWidth,
          child:
          CircularProgressIndicator()
      ));



}