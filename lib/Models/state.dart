class StateModel {
  String id;
  String name;
  String countryId;
  String LOGINUSER;
  String FROMINST;
  String EMAIL;
  StateModel({required this.id, required this.name, required this.countryId, required this.LOGINUSER ,required this.FROMINST,required this.EMAIL});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
        id: json['id'] as String,
        name: json['name'] as String,
        countryId: json['country_id'] as String,
        LOGINUSER: json['LOGINUSER'] as String,
        FROMINST : json['FROMINST'] as String,
            EMAIL: json['EMAIL'] as String,


    );
  }
}
