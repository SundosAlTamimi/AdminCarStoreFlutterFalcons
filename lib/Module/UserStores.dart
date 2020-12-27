class UserStores {
  String uSERNAME;
  String uSERNO;
  String kEY;
  String nOOFACTIVE;
  String dEACTIVE;
  String sERIAL;

  UserStores(
      {this.uSERNAME,
        this.uSERNO,
        this.kEY,
        this.nOOFACTIVE,
        this.dEACTIVE,
        this.sERIAL});

  UserStores.fromJson(Map<String, dynamic> json) {
    uSERNAME = json['USER_NAME'];
    uSERNO = json['USER_NO'];
    kEY = json['KEY'];
    nOOFACTIVE = json['NO_OF_ACTIVE'];
    dEACTIVE = json['DEACTIVE'];
    sERIAL = json['SERIAL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['USER_NAME'] = this.uSERNAME;
    data['USER_NO'] = this.uSERNO;
    data['KEY'] = this.kEY;
    data['NO_OF_ACTIVE'] = this.nOOFACTIVE;
    data['DEACTIVE'] = this.dEACTIVE;
    data['SERIAL'] = this.sERIAL;
    return data;
  }
}
