class CHomeModel {
  String image;

  CHomeModel(this.image);
}

List<CHomeModel> listavailable =
    listavailableData.map((item) => CHomeModel(item['cust_view'])).toList();

var listavailableData = [
  {"cust_view": "assets/cust_page/fandb.jpg"},
  {"cust_view": "assets/cust_page/groc.jpeg"},
  {"cust_view": "assets/cust_page/on.jpeg"},
];
