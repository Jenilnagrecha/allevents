class Categories {
  String? category;
  String? data;

  Categories({this.category, this.data});

  Categories.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['data'] = this.data;
    return data;
  }
}
