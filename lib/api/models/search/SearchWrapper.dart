class SearchWrapper {
  SearchWrapper({
    this.fname,
    this.mname,
    this.nat,
    this.screenResult,
  });

  SearchWrapper.fromJson(dynamic json) {
    fname = json['fname'];
    mname = json['mname'];
    nat = json['nat'];
    if (json['screen_result'] != null) {
      screenResult = [];
      json['screen_result'].forEach((v) {
        screenResult?.add(ScreenResult.fromJson(v));
      });
    }
  }

  String? fname;
  String? mname;
  String? nat;
  List<ScreenResult>? screenResult;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fname'] = fname;
    map['mname'] = mname;
    map['nat'] = nat;
    if (screenResult != null) {
      map['screen_result'] = screenResult?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ScreenResult {
  ScreenResult({
    this.score,
    this.name,
    this.searchTypes,
    this.descriptions,
    this.placesOfBirth,
    this.nat
  });

  ScreenResult.fromJson(dynamic json) {
    score = json['score'];
    name = json['name'];
    nat = json['nat'];
    if (json['search_types'] != null) {
      searchTypes = [];
      json['search_types'].forEach((v) {
        searchTypes?.add(SearchTypes.fromJson(v));
      });
    }
    if (json['descriptions'] != null) {
      descriptions = [];
      json['descriptions'].forEach((v) {
        descriptions?.add(Descriptions.fromJson(v));
      });
    }
  }

  num? score;
  String? name;
  List<SearchTypes>? searchTypes;
  List<Descriptions>? descriptions;
  List<String>? placesOfBirth;
  String? nat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['name'] = name;
    map['nat'] = nat;
    if (searchTypes != null) {
      map['search_types'] = searchTypes?.map((v) => v.toJson()).toList();
    }
    if (descriptions != null) {
      map['descriptions'] = descriptions?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Descriptions {
  Descriptions({
    this.description1,
    this.description2,
    this.description3,
  });

  Descriptions.fromJson(dynamic json) {
    description1 = json['description1'];
    description2 = json['description2'];
    description3 = json['description3'];
  }

  String? description1;
  String? description2;
  String? description3;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description1'] = description1;
    map['description2'] = description2;
    map['description3'] = description3;
    return map;
  }
}

class SearchTypes {
  SearchTypes({
    this.id,
    this.name,
    this.description,
  });

  SearchTypes.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  num? id;
  String? name;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    return map;
  }
}
