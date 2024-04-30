class SearchSendModel {
  String? fName;
  String? mName;
  String? nat;

  SearchSendModel({this.fName, this.mName, this.nat});

  Map<String,dynamic> toMap() {
    return {"fname": fName, "mname": mName, "nat": nat};
  }
}
