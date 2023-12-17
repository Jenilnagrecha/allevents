import 'package:allevents/api_repo/test_api_calls.dart';
import 'package:allevents/models/Event_call.dart';
import 'package:allevents/ui/screens/event_webview.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  final String category;
  final String data;
  ListScreen({super.key, required this.category, required this.data});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  EventCall? resp;

  Future<EventCall> EventDataApiCall() async {
    if (resp != null) return resp!;
    resp = await TestApis().GetEventData(widget.data);
    setCity();
    return resp!;
  }

  void setCity() {
    setState(() {
      city = resp?.request?.cityDisplay ?? "";
    });
  }

  @override
  void initState() {
    EventDataApiCall();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isGrid = false;
  String city = "";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text((widget.category) + " events in " + (city),
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.blue,
          onPressed: () => {
            Navigator.pop(context),
          },
        ),
      ),
      body: Container(
        height: height,
        width: width,
        color: Colors.grey[300],
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5),
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
                          // open bottom sheet
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.category,
                                color: Colors.blue,
                              ),
                              Text(
                                widget.category + ' events',
                                style: TextStyle(
                                  color: Colors.blue,
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
              child: FutureBuilder(
                future: EventDataApiCall(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return isGrid
                        ? GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: width * 0.4 / height * 3,
                            ),
                            itemCount: snapshot.data!.item!.length,
                            itemBuilder: (context, index) {
                              return EventGridItem(
                                height: height,
                                width: width,
                                index: index,
                                snapshot: snapshot,
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: snapshot.data!.item!.length,
                            itemBuilder: (context, index) {
                              return EventListItem(
                                height: height,
                                width: width,
                                index: index,
                                snapshot: snapshot,
                              );
                            },
                          );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: ToggleButtons(
          borderRadius: BorderRadius.circular(20),
          selectedColor: Colors.blue[600],
          children: [
            Icon(
              Icons.list,
              size: 20,
            ),
            Icon(
              Icons.grid_on,
              size: 20,
            ),
          ],
          isSelected: [!isGrid, isGrid],
          onPressed: (index) {
            setState(() {
              isGrid = index == 1;
            });
          },
        ),
      ),
    );
  }
}

class EventListItem extends StatelessWidget {
  const EventListItem({
    super.key,
    required this.height,
    required this.width,
    required this.index,
    required this.snapshot,
  });

  final double height;
  final double width;
  final AsyncSnapshot<EventCall> snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventWebview(
                eventUrl: snapshot.data!.item![index].eventUrl!,
              ),
            ),
          );
        },
        child: Container(
          height: height * 0.2,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                height: height * 0.2,
                width: width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      snapshot.data!.item![index].bannerUrl!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      snapshot.data!.item![index].eventname!,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      snapshot.data!.item![index].startTimeDisplay!,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      snapshot.data!.item![index].venue!.city! +
                          ", " +
                          snapshot.data!.item![index].venue!.state! +
                          ", " +
                          snapshot.data!.item![index].venue!.country!,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Row(
                      children: [
                        Expanded(child: SizedBox()),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.ios_share),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.star_outline),
                        ),
                        SizedBox(width: 10),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventGridItem extends StatelessWidget {
  const EventGridItem({
    super.key,
    required this.height,
    required this.width,
    required this.index,
    required this.snapshot,
  });

  final double height;
  final double width;
  final AsyncSnapshot<EventCall> snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventWebview(
                eventUrl: snapshot.data!.item![index].eventUrl!,
              ),
            ),
          );
        },
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(height: 15),
              Container(
                height: height * 0.2,
                width: width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      snapshot.data!.item![index].bannerUrl!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                snapshot.data!.item![index].eventname!,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                snapshot.data!.item![index].startTimeDisplay!,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                snapshot.data!.item![index].venue!.city! +
                    ", " +
                    snapshot.data!.item![index].venue!.state! +
                    ", " +
                    snapshot.data!.item![index].venue!.country!,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 5),
              Expanded(child: SizedBox()),
              Row(
                children: [
                  Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.ios_share),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.star_outline),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
