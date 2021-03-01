import 'package:rxdart/rxdart.dart';
import 'package:grocery_shop_flutter/models/Product.dart';
import 'package:grocery_shop_flutter/models/Order.dart';
import 'package:grocery_shop_flutter/models/Cart.dart';

class CartBloc{

  static int _orderId = 0;
  static CartBloc _cartBloc;
  Cart _currentCart;
  Order _lastOrder;
  PublishSubject<Cart> _publishSubjectCart;
  PublishSubject<Order> _publishSubjectOrder;

  factory CartBloc(){
    if(_cartBloc == null)
      _cartBloc =  CartBloc._();

    return _cartBloc;
  }

  CartBloc._(){
    _currentCart =  Cart();
    _publishSubjectCart =  PublishSubject<Cart>();
    _publishSubjectOrder =  PublishSubject<Order>();
  }

  Observable<Cart> get observableCart => _publishSubjectCart.stream;
  Observable<Order> get observableLastOrder => _publishSubjectOrder.stream;

  void _updateCart(){
    _publishSubjectCart.sink.add(_currentCart);
  }

  void _updateLastOrder(){
    _publishSubjectOrder.sink.add(_lastOrder);
  }

  void addOrderToCart(Product product, int quantity){
    _lastOrder =  Order(product, quantity, _orderId++);
    int index=-1;
    int i=0;
    for (Order o in _currentCart.orders) {
      if (o.product.id == product.id) {
        index = i;
        break;
      }
      i++;
    }

    if (index==-1) {
      _currentCart.addOrder(_lastOrder);
    }
    else
      {
        if (quantity>0) {
          _currentCart.orders[index].setQuantity(
              quantity);
        }
        else
          {
            _currentCart.removeOrder(_currentCart.orders[index]);
          }
      }
    _updateLastOrder();
    _updateCart();
  }

  void removerOrderOfCart(Order order){
    _currentCart.removeOrder(order);
    _updateCart();
  }

  Cart get currentCart => _currentCart;

  Order get lastOrder => _lastOrder;

  dispose(){
    _cartBloc = null;
    _publishSubjectCart.close();
    _publishSubjectOrder.close();
  }

}