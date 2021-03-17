class AuthenticationUserDTO {
  String txntimestamp;
  Data data;
  String xref;

  AuthenticationUserDTO({this.txntimestamp, this.data, this.xref});

  AuthenticationUserDTO.fromJson(Map<String, dynamic> json) {
    txntimestamp = json['txntimestamp'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    xref = json['xref'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['txntimestamp'] = this.txntimestamp;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['xref'] = this.xref;
    return data;
  }
}

class Data {
  TransactionDetails transactionDetails;
  ChannelDetails channelDetails;
  Response response;

  Data({this.transactionDetails, this.channelDetails, this.response});

  Data.fromJson(Map<String, dynamic> json) {
    transactionDetails = json['transaction_details'] != null
        ? new TransactionDetails.fromJson(json['transaction_details'])
        : null;
    channelDetails = json['channel_details'] != null
        ? new ChannelDetails.fromJson(json['channel_details'])
        : null;

    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactionDetails != null) {
      data['transaction_details'] = this.transactionDetails.toJson();
    }
    if (this.channelDetails != null) {
      data['channel_details'] = this.channelDetails.toJson();
    }

    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    return data;
  }
}

class TransactionDetails {
  String phoneNumber;
  String hostCode;
  String transactionType;
  String direction;
  String debitAccount;
  
  String transactionCode;
  String currency;
  String firstName;
  String secondName;
  String lastName;
  String pin;
  String idType;
  String idNumber;
  String lang;
  String imsi;
  String gender;
  String dob;
  int amount;

  TransactionDetails(
      {this.phoneNumber,
      this.amount,
      this.hostCode,
      this.transactionType,
      this.direction,
      this.debitAccount,
      this.transactionCode,
      this.currency,
      this.firstName,
      this.secondName,
      this.lastName,
      this.idType,
      this.pin,
      this.idNumber,
      this.lang,
      this.imsi,
      this.gender,
      this.dob});

  TransactionDetails.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
    hostCode = json['host_code'];
    transactionType = json['transaction_type'];
    direction = json['direction'];
    debitAccount = json['debit_account'];
    transactionCode = json['transaction_code'];
    currency = json['currency'];
    firstName = json['first_name'];
    pin = json['pin'];
    amount = json['amount'];
    secondName = json['second_name'];
    lastName = json['last_name'];
    idType = json['id_type'];
    idNumber = json['id_number'];
    lang = json['lang'];
    imsi = json['imsi'];
    gender = json['gender'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone_number'] = this.phoneNumber;
    data['host_code'] = this.hostCode;
    data['transaction_type'] = this.transactionType;
    data['direction'] = this.direction;
    data['debit_account'] = this.debitAccount;
    data['transaction_code'] = this.transactionCode;
    data['currency'] = this.currency;
    data['amount'] = this.amount;
    data['first_name'] = this.firstName;
    data['second_name'] = this.secondName;
    data['last_name'] = this.lastName;
    data['pin'] = this.pin;
    data['id_type'] = this.idType;
    data['id_number'] = this.idNumber;
    data['lang'] = this.lang;
    data['imsi'] = this.imsi;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['debit_account'] = this.debitAccount;
    return data;
  }
}

class ChannelDetails {
  String channelKey;
  String host;
  String geolocation;
  String userAgentVersion;
  String userAgent;
  String clientId;
  String deviceId;

  String channel;

  ChannelDetails(
      {this.channelKey,
      this.host,
      this.geolocation,
      this.userAgentVersion,
      this.userAgent,
      this.clientId,
      this.deviceId,
      this.channel});

  ChannelDetails.fromJson(Map<String, dynamic> json) {
    channelKey = json['channel_key'];
    host = json['host'];
    geolocation = json['geolocation'];
    userAgentVersion = json['user_agent_version'];
    userAgent = json['user_agent'];
    clientId = json['client_id'];
    deviceId = json['firebase_token'];
    channel = json['channel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channel_key'] = this.channelKey;
    data['host'] = this.host;
    data['geolocation'] = this.geolocation;
    data['user_agent_version'] = this.userAgentVersion;
    data['user_agent'] = this.userAgent;
    data['client_id'] = this.clientId;
    data['channel'] = this.channel;
    data['firebase_token'] = this.deviceId;

    return data;
  }
}

class Response {
  String responseCode;
  String response;

  Response({
    this.response,
    this.responseCode,
  });

  Response.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response'] = this.response;

    return data;
  }
}
