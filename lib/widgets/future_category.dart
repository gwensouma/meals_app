import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meals/model/category.dart';

class FutureCategory extends StatefulWidget {
  const FutureCategory(this.onSelectCategory, {super.key});

  final void Function(Category category) onSelectCategory;

  @override
  State<FutureCategory> createState() => _FutureCategory();
}

class _FutureCategory extends State<FutureCategory> {
  late Future<List<Category>> _futureCategory;
  bool _hasLoadedCategory = false;

  @override
  void initState() {
    super.initState();
    _futureCategory = loadCategory();
    print('fetched categorys');
  }

  FutureBuilder<List<Category>> buildCategory() {
    return FutureBuilder(
      future: _futureCategory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Text("error fetching");
        } else if (snapshot.hasData) {
          final data = snapshot.data!;

          if (!_hasLoadedCategory) {
            _hasLoadedCategory = true;
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              Category category = data[index];
              return Card(
                child: InkWell(
                  onTap: () {
                    widget.onSelectCategory(category);
                  },
                  splashColor: Theme.of(context).primaryColor,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      gradient: LinearGradient(
                        colors: [
                          data[index].color.withOpacity(0.55),
                          data[index].color.withOpacity(0.9),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        data[index].title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Text('null data');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: buildCategory());
  }
}

Future<String> _loadCategoryAsset() async {
  return await rootBundle.loadString('assets/data/dummy_data.json');
}

Future<List<Category>> loadCategory() async {
  String jsonString = await _loadCategoryAsset();
  final List<dynamic> jsonResponse = json.decode(jsonString);

  return jsonResponse.map((item) => Category.fromJson(item)).toList();
}
