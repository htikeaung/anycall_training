class CommonDM {
  final dynamic success;
  final dynamic message;
  final int? statusCode;

  final dynamic _data;

  CommonDM(this.success, this.statusCode, this.message, this._data);

  CommonDM.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        message = json['message'],
        statusCode= json["status_code"],
        _data = json['data'];

  dynamic get data => _data;

  @override
  String toString() {
    return 'CommonDM{success: $success, message: $message, _customRequest: $_data}';
  }
}