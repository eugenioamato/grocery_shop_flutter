import 'package:flutter/material.dart';
import 'package:grocery_shop_flutter/models/Product.dart';
import 'package:grocery_shop_flutter/views/ProductView.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  ProductWidget({Key key, this.product}) : super(key: key);

  get currencyString => "€";

  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height*0.8;
    //double fontSize = (height/24).round().toDouble();

    return LayoutBuilder(builder: (context, constraints) {
      double h = constraints.maxHeight;

      return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductView(product: this.product)));
          },
          child: Container(
              constraints: constraints,
              padding: EdgeInsets.fromLTRB(h/20.0, h/20.0, h/20.0, h/100.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Flex(direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: Hero(
                                tag: "tagHero${this.product.id}",
                                child: Image.asset(this.product.urlToImage,
                                    fit: BoxFit.cover)))),
                    Expanded(
                      flex: 1,
                      child: Text("$currencyString${this.product.price}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,

                          //    fontSize: fontSize
                          )),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                            //margin: EdgeInsets.only(top: 20, bottom: 10),
                            child: Text("${this.product.title}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    //fontSize: fontSize * 0.65
                                )))),
                    Expanded(
                        flex: 1,
                        child: Text("${this.product.weight}g",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                //fontSize: fontSize * 0.48
                            )))
                  ])));
    });
  }
}
