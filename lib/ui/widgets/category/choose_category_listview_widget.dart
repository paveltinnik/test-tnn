import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../core/database/moor_database.dart';
import '../../../core/viewmodels/category/category_model.dart';

class ChooseCategoriesListView extends StatefulWidget {
  final List<Category> categories;
  final CategoryModel model;

  const ChooseCategoriesListView(this.categories, this.model, {Key? key})
      : super(key: key);

  @override
  _ChooseCategoriesListViewState createState() =>
      _ChooseCategoriesListViewState();
}

class _ChooseCategoriesListViewState extends State<ChooseCategoriesListView> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: ListView(
      controller: widget.model.scrollController,
      padding: const EdgeInsets.all(8),
      children: widget.categories.map((category) {
        return Card(
            child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blue.withOpacity(.1),
                        child: Icon(Icons.category),
                      ),
                      title: Text(category.name),
                      onTap: () {
                        Navigator.pop(context, category.name);
                      },
                    ),
                  ],
                )
            )
        );
      }).toList(),
    ));
  }
}
