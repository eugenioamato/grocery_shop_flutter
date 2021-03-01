import 'package:grocery_shop_flutter/models/Product.dart';

class ProductsRepository{
  static List<Product> products=
  [
    Product("assets/images/spelt_noodles.png", "Biona Organic Spelt Noodles", 2.99, 250,"Pasta & Noodles",
        "Description Biona Organic Spelt Noodles", 0),
    Product("assets/images/spelt_italian.png", "Biona Organic Spelt Fusili Brown", 2.35, 500,"Pasta & Noodles",
        "Description of Biona Organic Spelt Fusili Brown", 1),
    Product("assets/images/spelt_spaghetti.png", "Biona Organic Whole Spelt Spaghetti", 2.35, 500,"Pasta & Noodles",
        "Description of Biona Organic Whole Spelt Spaghetti" , 2),
    Product("assets/images/spelt_tagliatelle.png", "Biona Organic Spelt Spinach Artisan Tagliatelle", 1.99, 250,"Pasta & Noodles",
        "Description of Biona Organic Spelt Spinach Artisan Tagliatelle",3),
    Product("assets/images/spelt_penne.png", "Biona Organic Whole Spelt Penne", 2.35, 500,"Pasta & Noodles",
        "Description of Biona Organic Whole Spelt Penne",4),
    Product("assets/images/spelt_tagliatelle.png", "Biona Organic Spelt Spinach Artisan Tagliatelle", 1.99, 250,"Pasta & Noodles",
        "Description of Biona Organic Spelt Spinach Artisan Tagliatelle", 5),
    Product("assets/images/spelt_fusilli.png", "Biona Organic Spelt Fusilli Tricolore", 1.99, 250,"Pasta & Noodles",
        "Description of Biona Organic Spelt Fusilli Tricolore",6),
    Product("assets/images/fromage_honfleur.png", "La fromagerie du Terroir de Bellechasse Stuffed Cheese", 4.85, 280,"Cheese & Milk",
        "Description of La fromagerie du Terroir de Bellechasse Stuffed Cheese", 7),
  ];

  static List<String> categories=
  [
    "All products",
    "Pasta & Noodles",
    "Cheese & Milk"
  ];

  List<Product> fetchAllProducts(String category) {
    return products;
  }

  List<String> getCategories() {
    return categories;
  }
  
}