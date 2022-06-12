import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/database/moor_database.dart';
import '../../../core/viewmodels/category/category_model.dart';

class CategoriesListView extends StatefulWidget {
  final List<Category> categories;
  final CategoryModel model;

  const CategoriesListView(
      this.categories,
      this.model,
      {Key? key}
      ) : super(key: key);

  @override
  _CategoriesListViewState createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: ListView(
          controller: widget.model.scrollController,
          padding: const EdgeInsets.all(8),
          children: widget.categories.map((category) {
            return Card(
                child: Slidable(
                  // Specify a key if the Slidable is dismissible.
                  key: UniqueKey(),

                  // The start action pane is the one at the left or the top side.
                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    dismissible: DismissiblePane(onDismissed: () {
                      widget.model.deleteCategory(category);
                      widget.categories.remove(category);
                    }),

                    // All actions are defined in the children parameter.
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: (context) {
                          widget.model.deleteCategory(category);
                          widget.categories.remove(category);
                        },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Удалить',
                      ),
                    ],
                  ),

                  // The end action pane is the one at the right or the bottom side.
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.of(context).pushNamed('editcategory', arguments: category);
                        },
                        backgroundColor: const Color(0xFF0392CF),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Редактировать',
                      ),
                    ],
                  ),

                  // The child of the Slidable is what the user sees when the
                  // component is not dragged.
                  // child: ListTile(title: Text(user.name)),
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
                          ),
                        ],
                      )
                  ),
                )
            );
          }).toList(),
        ));
  }
}
