import 'package:flutter/material.dart';
import 'package:grocery_shop_flutter/models/Cart.dart';
import 'package:grocery_shop_flutter/bloc/CartBloc.dart';
import 'package:grocery_shop_flutter/components/OrderWidget.dart';
import 'package:grocery_shop_flutter/views/ProductView.dart';

class CartManager extends StatefulWidget {
  final double topPadding;
  CartManager(this.topPadding);

  @override
  _CartManager createState() => _CartManager();
}

class _CartManager extends State<CartManager> {
  CartBloc _cartBloc = CartBloc();

  get currencyString => "€";

  @override
  Widget build(BuildContext context) {
    double _gridSize = (MediaQuery.of(context).size.height - widget.topPadding);
    double step = MediaQuery.of(context).size.width / 20.0;
    int ratio=(MediaQuery.of(context).size.width/_gridSize).ceil();
    if (ratio>2) ratio=3;

    return Container(
      constraints: BoxConstraints.expand(height: _gridSize),
      child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: StreamBuilder(
                  initialData: _cartBloc.currentCart,
                  stream: _cartBloc.observableCart,
                  builder: (context, AsyncSnapshot<Cart> snapshot) {
                    return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                20), //height: _gridSize, width: double.infinity,
                        child: Container(
                            decoration: BoxDecoration(gradient:
                            LinearGradient(colors:[Colors.black,Color.fromARGB(255,12,0,50)],
                              begin: Alignment.topCenter,
                              end:Alignment.bottomCenter
                            )
                            ),
                            margin: EdgeInsets.only(bottom: step),
                           // height: _gridSize * 0.88,
                            child: ListView.builder(
                                itemCount: 1 + snapshot.data.orders.length,
                                itemBuilder: (context, index) {
                                  if (index == 0)
                                    return Padding(
                                      padding: EdgeInsets.only(top:step),
                                      child: Center(
                                        child: Text("Your Cart",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    );
                                  else
                                    return InkWell(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => ProductView(
                                                  product: snapshot
                                                      .data
                                                      .orders[index - 1]
                                                      .product))),
                                      child: Dismissible(
                                        background: Container(
                                            color: Colors.red),
                                        key: Key(snapshot
                                            .data.orders[index - 1].id
                                            .toString()),
                                        onDismissed: (_) {
                                          _cartBloc.removerOrderOfCart(
                                              snapshot.data.orders[index - 1]);
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: step),
                                            child: OrderWidget(
                                                snapshot.data.orders[index - 1],
                                                _gridSize)),
                                      ),
                                    );
                                })));
                  }),
            ),
            Expanded(
              flex: ratio,
              child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Total",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          SizedBox(
                            width: step * 2,
                          ),
                          Text(
                              "$currencyString${_cartBloc.currentCart.totalPrice().toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40)),
                          SizedBox(
                            width: step * 4,
                          )
                        ]),
                    Container(
                        padding: EdgeInsets.only(
                            left: 10, // bottom: step,
                            right: 120.0),
                        width: MediaQuery.of(context).size.width - 80.0,
                        child: RaisedButton(
                            color: Colors.amber,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(step * 2)),
                            padding: EdgeInsets.all(step * 1),
                            onPressed: () {
                              if (_cartBloc.currentCart.isEmpty)
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Cart is empty")));
                              else {
                                //todo go to payment
                              }
                            },
                            child: Text("Go to payment",
                                style: TextStyle(fontWeight: FontWeight.bold))))
                  ]),
            ),
          ]),
    );
  }
}
