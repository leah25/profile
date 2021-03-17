class AuthenticationResponseDTO {
  String xref;
  Data data;
  String txntimestamp;

  AuthenticationResponseDTO({this.xref, this.data, this.txntimestamp});

  AuthenticationResponseDTO.fromJson(Map<String, dynamic> json) {
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
    return "Authentication response \n ${this.toJson()} \n";
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
    return "Data details \n ${this.toJson()} \n";
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
  String responseCode;
  String response;
  String datecreated;

  Response({this.responseCode, this.response, this.datecreated});

  Response.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    response = json['response'];
    datecreated = json['datecreated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response'] = this.response;
    data['datecreated'] = this.datecreated;
    return data;
  }

  @override
  String toString() {
    return "Response \n ${this.toJson()} \n";
  }
}

class TransactionDetails {
  String transactionCode;
  String idNumber;
  String gender;
  String lastName;
  String imsi;
  String transactionType;
  String debitAccount;
  String hostCode;
  String dob;
  String secondName;
  String phoneNumber;
  String currency;
  String idType;
  String lang;
  String firstName;
  String direction;

  TransactionDetails(
      {this.transactionCode,
      this.idNumber,
      this.gender,
      this.lastName,
      this.imsi,
      this.transactionType,
      this.debitAccount,
      this.hostCode,
      this.dob,
      this.secondName,
      this.phoneNumber,
      this.currency,
      this.idType,
      this.lang,
      this.firstName,
      this.direction});

  TransactionDetails.fromJson(Map<String, dynamic> json) {
    transactionCode = json['transaction_code'];
    idNumber = json['id_number'];
    gender = json['gender'];
    lastName = json['last_name'];
    imsi = json['imsi'];
    transactionType = json['transaction_type'];
    debitAccount = json['debit_account'];
    hostCode = json['host_code'];
    dob = json['dob'];
    secondName = json['second_name'];
    phoneNumber = json['phone_number'];
    currency = json['currency'];
    idType = json['id_type'];
    lang = json['lang'];
    firstName = json['first_name'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_code'] = this.transactionCode;
    data['id_number'] = this.idNumber;
    data['gender'] = this.gender;
    data['last_name'] = this.lastName;
    data['imsi'] = this.imsi;
    data['transaction_type'] = this.transactionType;
    data['debit_account'] = this.debitAccount;
    data['host_code'] = this.hostCode;
    data['dob'] = this.dob;
    data['second_name'] = this.secondName;
    data['phone_number'] = this.phoneNumber;
    data['currency'] = this.currency;
    data['id_type'] = this.idType;
    data['lang'] = this.lang;
    data['first_name'] = this.firstName;
    data['direction'] = this.direction;
    return data;
  }

  @override
  String toString() {
    return "Transaction details \n ${this.toJson()} \n";
  }
}
