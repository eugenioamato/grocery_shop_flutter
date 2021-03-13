# Grocery Shop Flutter
An example of Grocery Shop App using the Bloc pattern.

### Design Details
This project is an example for a grocery shop that allows the user to select items and add it
 to his cart. The cart model uses the Bloc pattern to be responsive.  

### Files
Main.dart : It only starts the app opening the Home view  
Home.dart : It's the view containing both the item list and the cart. In its initialization it 
creates the CartBloc, and receives the categories and products from the repositories.  
The itemlist and the cart manager are stacked (one over the other) inside a neverscrollable 
listview. Clicking the floatingActionButton just scrolls it down or up by an amount of pixels 
that corresponds to the height of the window. 
ProductView.dart : The page with the description of the single item, containing also the commands
 used to add or remove quantities. In its initialization, the UI tries to find the element on 
 the actual cartBloc, and if it finds it, the quantity is shown with the correct amount.  
Otherwise, the quantity is set to 1, allowing the user to add 1 item pushing the "add" button.  

#### the models

Product.dart : It contains all the info on a specific item: Strings descriptions, price, 
weight, id, and the category whom it belongs.  
Order.dart : It is a product and quantity pair. Its id is not the same as the product id  
Cart.dart : It is a list of orders, with methods to add or remove them.  
CategoryHelper.dart : Used to render only the items selected in the dropdownlist in the homepage.  

#### The cart bloc  
CartBloc.dart : It's the bloc of the cart. It contains a single instance of the currentCart, 
and features Observable elements for the cart and the last order, and publishes all events 
following the rxdart architecture with PublishSubjects (both sink and Stream).  
This allows to rebuild only the last order widget when something is added or deleted.  

## The components  

GridShop.dart : It contains the DropDown selector for category,  the list of items, in a GridView, where all items are positioned with 
different margins to have a cascade, and the MinimalCart. On build, the items are filtered depending on the category 
selected inside the CategoryHelper. If the items are not loaded, it will show a loading animation.   
ProductWidget.dart : The single view of a product inside the GridShop. It has a Hero tag that 
animates to the ProductView when the image is clicked to see the details.  
CategoryDropDownMenu.dart : It's a normal DropDown menu created upon the provided category.  
MinimalCart.dart : It's a minimal view of the actual cart, showing only one icon for every order.    
OrderWidget.dart : The single view of an order inside the minimal cart.  
CartManager.dart : The view that is shown when the user checks the cart. It has a list of 
orders with quantities, where every element can be dismissed with a swipe gesture.  
It also contains the total sum of prices and a button to check-out.  It is connected to the 
cart Bloc though its observableCart property.   
 

### Compatibility  
This projects compiles correctly to Android, iOs, macOs (BigSur), Windows10(build 1909) and
 Web (Chrome 89.0.4389.82 and Edge 89.0.774.50).