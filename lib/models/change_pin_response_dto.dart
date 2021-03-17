class ChangePinDTO {
  String txntimestamp;
  Data data;
  String xref;

  ChangePinDTO({this.txntimestamp, this.data, this.xref});

  ChangePinDTO.fromJson(Map<String, dynamic> json) {
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

  Data({this.transactionDetails, this.channelDetails});

  Data.fromJson(Map<String, dynamic> json) {
    transactionDetails = json['transaction_details'] != null
        ? new TransactionDetails.fromJson(json['transaction_details'])
        : null;
    channelDetails = json['channel_details'] != null
        ? new ChannelDetails.fromJson(json['channel_details'])
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
  String pin;

  TransactionDetails(
      {this.phoneNumber,
      this.hostCode,
      this.transactionType,
      this.direction,
      this.debitAccount,
      this.transactionCode,
      this.currency,
      this.pin});

  TransactionDetails.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
    hostCode = json['host_code'];
    transactionType = json['transaction_type'];
    direction = json['direction'];
    debitAccount = json['debit_account'];
    transactionCode = json['transaction_code'];
    currency = json['currency'];
    pin = json['pin'];
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
    data['pin'] = this.pin;
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
  String channel;

  ChannelDetails(
      {this.channelKey,
      this.host,
      this.geolocation,
      this.userAgentVersion,
      this.userAgent,
      this.clientId,
      this.channel});

  ChannelDetails.fromJson(Map<String, dynamic> json) {
    channelKey = json['channel_key'];
    host = json['host'];
    geolocation = json['geolocation'];
    userAgentVersion = json['user_agent_version'];
    userAgent = json['user_agent'];
    clientId = json['client_id'];
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
    return data;
  }
}
