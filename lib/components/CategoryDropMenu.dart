import 'package:flutter/material.dart';
import 'package:grocery_shop_flutter/models/CategoryHelper.dart';

class CategoryDropMenu extends StatefulWidget {
  final CategoryHelper categoryHelper;
  final Function refreshElements;
  final List<String> categories;

  const CategoryDropMenu(this.categoryHelper, this.refreshElements, this.categories);
  @override
  _CategoryDropMenu createState() =>  _CategoryDropMenu();
}



class _CategoryDropMenu extends State<CategoryDropMenu> {



  @override
  Widget build(BuildContext context){
    return  DropdownButtonHideUnderline(child:
       DropdownButton<String>(
        value: widget.categoryHelper.getCategory(),
        onChanged: (String newValue) {
          setState(() {
            widget.categoryHelper.setCategory(newValue);
            });
          widget.refreshElements();
        },
        items: widget.categories.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
          );
        }).toList(),
      ));
  }

}