import 'package:allevents/api_repo/test_api_calls.dart';
import 'package:allevents/models/categores_model.dart';
import 'package:allevents/ui/screens/list_screen.dart';
import 'package:flutter/material.dart';

class CategorySheet extends StatefulWidget {
  const CategorySheet({super.key});

  @override
  State<CategorySheet> createState() => _CategorySheetState();
}

class _CategorySheetState extends State<CategorySheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
            Divider(
              color: Colors.grey[200],
              thickness: 2.0,
            ),
            // make a list of categories
            Expanded(
              child: FutureBuilder<List<Categories>>(
                future: TestApis().GetCateories(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListScreen(
                                  category: snapshot.data![index].category!,
                                  data: snapshot.data![index].data!,
                                ),
                              ),
                            );
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: InkResponse(
                              splashColor: Colors.blue[300],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![index].category!,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey[200],
                                    thickness: 2.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
