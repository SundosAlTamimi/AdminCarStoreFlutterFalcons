class MyOrdersModule {
  String uSERNOSERIAL;
  String oRDERS;
  String uSERNAME;
  String uSERNO;
  String sERIAL;

  MyOrdersModule(
      {this.uSERNOSERIAL,
        this.oRDERS,
        this.uSERNAME,
        this.uSERNO,
        this.sERIAL});

  MyOrdersModule.fromJson(Map<String, dynamic> json) {
    uSERNOSERIAL = json['USER_NO_SERIAL'];
    oRDERS = json['ORDERS'];
    uSERNAME = json['USER_NAME'];
    uSERNO = json['USER_NO'];
    sERIAL = json['SERIAL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['USER_NO_SERIAL'] = this.uSERNOSERIAL;
    data['ORDERS'] = this.oRDERS;
    data['USER_NAME'] = this.uSERNAME;
    data['USER_NO'] = this.uSERNO;
    data['SERIAL'] = this.sERIAL;
    return data;
  }
}
