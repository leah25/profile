class LoginResponseDTO {
  String xref;
  Data data;
  String txntimestamp;

  LoginResponseDTO({this.xref, this.data, this.txntimestamp});

  LoginResponseDTO.fromJson(Map<String, dynamic> json) {
    xref = json['xref'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    txntimestamp = json['txntimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xref'] = this.xref;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['txntimestamp'] = this.txntimestamp;
    return data;
  }

  @override
  String toString() {
    return "Login response: \n ${this.toJson()} \n";
  }
}

class Data {
  ChannelDetails channelDetails;
  Response response;
  TransactionDetails transactionDetails;

  Data({this.channelDetails, this.response, this.transactionDetails});

  Data.fromJson(Map<String, dynamic> json) {
    channelDetails = json['channel_details'] != null
        ? new ChannelDetails.fromJson(json['channel_details'])
        : null;
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    transactionDetails = json['transaction_details'] != null
        ? new TransactionDetails.fromJson(json['transaction_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.channelDetails != null) {
      data['channel_details'] = this.channelDetails.toJson();
    }
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    if (this.transactionDetails != null) {
      data['transaction_details'] = this.transactionDetails.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return "Data: \n ${this.toJson()} \n";
  }
}

class ChannelDetails {
  String userAgentVersion;
  String host;
  String channel;
  String userAgent;
  String clientId;
  String channelKey;
  String geolocation;

  ChannelDetails(
      {this.userAgentVersion,
      this.host,
      this.channel,
      this.userAgent,
      this.clientId,
      this.channelKey,
      this.geolocation});

  ChannelDetails.fromJson(Map<String, dynamic> json) {
    userAgentVersion = json['user_agent_version'];
    host = json['host'];
    channel = json['channel'];
    userAgent = json['user_agent'];
    clientId = json['client_id'];
    channelKey = json['channel_key'];
    geolocation = json['geolocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_agent_version'] = this.userAgentVersion;
    data['host'] = this.host;
    data['channel'] = this.channel;
    data['user_agent'] = this.userAgent;
    data['client_id'] = this.clientId;
    data['channel_key'] = this.channelKey;
    data['geolocation'] = this.geolocation;
    return data;
  }

  @override
  String toString() {
    return "Channel details \n ${this.toJson()} \n";
  }
}

class Response {
  int partialRegistration;
  String country;
  String firstname;
  String responseCode;
  String gender;
  String phonenumber;
  int registered;
  String registrationdate;
  String imsi;
  int approved;
  String pin;
  String accountname;
  int pinchange;
  String createdby;
  int kycverified;
  String modeofidentification;
  int closeaccount;
  int id;
  String lang;
  String customername;
  String customerno;
  String dateofbirth;
  String localbranch;
  int firstlogin;
  String approvedby;
  int verified;
  int active;
  String createdon;
  String lastname;
  String secondname;
  int trials;
  String response;
  int closed;
  String reset;
  int actualbal;
  int closeaccount1;
  String mwalletaccount;
  String identificationid;

  Response(
      {this.partialRegistration,
      this.country,
      this.firstname,
      this.responseCode,
      this.gender,
      this.phonenumber,
      this.registered,
      this.registrationdate,
      this.imsi,
      this.approved,
      this.pin,
      this.accountname,
      this.pinchange,
      this.createdby,
      this.kycverified,
      this.modeofidentification,
      this.closeaccount,
      this.id,
      this.lang,
      this.customername,
      this.customerno,
      this.dateofbirth,
      this.localbranch,
      this.firstlogin,
      this.approvedby,
      this.verified,
      this.active,
      this.createdon,
      this.lastname,
      this.secondname,
      this.trials,
      this.response,
      this.closed,
      this.reset,
      this.actualbal,
      this.closeaccount1,
      this.mwalletaccount,
      this.identificationid});

  Response.fromJson(Map<String, dynamic> json) {
    partialRegistration = json['partial_registration'];
    country = json['country'];
    firstname = json['firstname'];
    responseCode = json['response_code'];
    gender = json['gender'];
    phonenumber = json['phonenumber'];
    registered = json['registered'];
    registrationdate = json['registrationdate'];
    imsi = json['imsi'];
    approved = json['approved'];
    pin = json['pin'];
    accountname = json['accountname'];
    pinchange = json['pinchange'];
    createdby = json['createdby'];
    kycverified = json['kycverified'];
    modeofidentification = json['modeofidentification'];
    closeaccount = json['closeaccount'];
    id = json['id'];
    lang = json['lang'];
    customername = json['customername'];
    customerno = json['customerno'];
    dateofbirth = json['dateofbirth'];
    localbranch = json['localbranch'];
    firstlogin = json['firstlogin'];
    approvedby = json['approvedby'];
    verified = json['verified'];
    active = json['active'];
    createdon = json['createdon'];
    lastname = json['lastname'];
    secondname = json['secondname'];
    trials = json['trials'];
    response = json['response'];
    closed = json['closed'];
    reset = json['reset'];
    actualbal = json['actualbal'];
    closeaccount1 = json['closeaccount1'];
    mwalletaccount = json['mwalletaccount'];
    identificationid = json['identificationid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partial_registration'] = this.partialRegistration;
    data['country'] = this.country;
    data['firstname'] = this.firstname;
    data['response_code'] = this.responseCode;
    data['gender'] = this.gender;
    data['phonenumber'] = this.phonenumber;
    data['registered'] = this.registered;
    data['registrationdate'] = this.registrationdate;
    data['imsi'] = this.imsi;
    data['approved'] = this.approved;
    data['pin'] = this.pin;
    data['accountname'] = this.accountname;
    data['pinchange'] = this.pinchange;
    data['createdby'] = this.createdby;
    data['kycverified'] = this.kycverified;
    data['modeofidentification'] = this.modeofidentification;
    data['closeaccount'] = this.closeaccount;
    data['id'] = this.id;
    data['lang'] = this.lang;
    data['customername'] = this.customername;
    data['customerno'] = this.customerno;
    data['dateofbirth'] = this.dateofbirth;
    data['localbranch'] = this.localbranch;
    data['firstlogin'] = this.firstlogin;
    data['approvedby'] = this.approvedby;
    data['verified'] = this.verified;
    data['active'] = this.active;
    data['createdon'] = this.createdon;
    data['lastname'] = this.lastname;
    data['secondname'] = this.secondname;
    data['trials'] = this.trials;
    data['response'] = this.response;
    data['closed'] = this.closed;
    data['reset'] = this.reset;
    data['actualbal'] = this.actualbal;
    data['closeaccount1'] = this.closeaccount1;
    data['mwalletaccount'] = this.mwalletaccount;
    data['identificationid'] = this.identificationid;
    return data;
  }

  @override
  String toString() {
    return "Response \n ${this.toJson()} \n";
  }
}

class TransactionDetails {
  String transactionCode;
  int amount;
  String hostCode;
  String phoneNumber;
  String currency;
  String transactionType;
  String debitAccount;
  String direction;

  TransactionDetails(
      {this.transactionCode,
      this.amount,
      this.hostCode,
      this.phoneNumber,
      this.currency,
      this.transactionType,
      this.debitAccount,
      this.direction});

  TransactionDetails.fromJson(Map<String, dynamic> json) {
    transactionCode = json['transaction_code'];
    amount = json['amount'];
    hostCode = json['host_code'];
    phoneNumber = json['phone_number'];
    currency = json['currency'];
    transactionType = json['transaction_type'];
    debitAccount = json['debit_account'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_code'] = this.transactionCode;
    data['amount'] = this.amount;
    data['host_code'] = this.hostCode;
    data['phone_number'] = this.phoneNumber;
    data['currency'] = this.currency;
    data['transaction_type'] = this.transactionType;
    data['debit_account'] = this.debitAccount;
    data['direction'] = this.direction;
    return data;
  }

  @override
  String toString() {
    return "Transaction details \n ${this.toJson()} \n";
  }
}
