import 'package:allevents/models/event_data.dart';

class EventCall {
  Request? request;
  int? count;
  List<EventData>? item;

  EventCall({this.request, this.count, this.item});

  EventCall.fromJson(Map<String, dynamic> json) {
    request =
        json['request'] != null ? new Request.fromJson(json['request']) : null;
    count = json['count'];
    if (json['item'] != null) {
      item = <EventData>[];
      json['item'].forEach((v) {
        item!.add(new EventData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    data['count'] = this.count;
    if (this.item != null) {
      data['item'] = this.item!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Request {
  String? venue;
  String? ids;
  String? type;
  String? city;
  int? edate;
  int? page;
  String? keywords;
  int? sdate;
  String? category;
  String? cityDisplay;
  int? rows;

  Request(
      {this.venue,
      this.ids,
      this.type,
      this.city,
      this.edate,
      this.page,
      this.keywords,
      this.sdate,
      this.category,
      this.cityDisplay,
      this.rows});

  Request.fromJson(Map<String, dynamic> json) {
    venue = json['venue'];
    ids = json['ids'];
    type = json['type'];
    city = json['city'];
    edate = json['edate'];
    page = json['page'];
    keywords = json['keywords'];
    sdate = json['sdate'];
    category = json['category'];
    cityDisplay = json['city_display'];
    rows = json['rows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['venue'] = this.venue;
    data['ids'] = this.ids;
    data['type'] = this.type;
    data['city'] = this.city;
    data['edate'] = this.edate;
    data['page'] = this.page;
    data['keywords'] = this.keywords;
    data['sdate'] = this.sdate;
    data['category'] = this.category;
    data['city_display'] = this.cityDisplay;
    data['rows'] = this.rows;
    return data;
  }
}
