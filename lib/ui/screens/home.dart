
import 'package:allevents/ui/Widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  Map<String, dynamic>? userData;
  Home({super.key, required this.userData});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color selectedCatColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.blue[300],
            onPressed: () => {
              Navigator.pop(context),
            },
          ),
          title: Container(
            height: height * 0.05,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                'Search not implemented.....',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                color: Colors.blue[300],
                onPressed: () => {}),
          ],
        ),
        body: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCatColor = Colors.blue;
                            });
                            showModalBottomSheet(
                              clipBehavior: Clip.antiAlias,
                              context: context,
                              isScrollControlled: true,
                              showDragHandle: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FractionallySizedBox(
                                    widthFactor: 1,
                                    heightFactor: 0.65,
                                    child: CategorySheet(),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.category,
                                  color: selectedCatColor,
                                ),
                                Text(
                                  'Categories',
                                  style: TextStyle(
                                    color: selectedCatColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.calendar_month),
                            Text('Date & Time'),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.sort),
                            Text('Sort by'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Image.asset(
                'assets/logo.png',
                width: width / 2,
                height: width / 2,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Welcome to allevents, ${widget.userData!['name']}!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.lightBlue[300], // Set text color to sky blue
                  fontSize: 24.0, // Adjust the font size as needed
                  fontWeight:
                      FontWeight.bold, // Adjust the font weight as needed
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //logout button

              Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
