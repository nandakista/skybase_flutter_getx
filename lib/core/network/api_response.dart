class ApiResponse<T> {
  bool success;
  String error;
  T? data;

  ApiResponse({required this.success, required this.error, this.data});

  factory ApiResponse.fromJson(Map<dynamic, dynamic> json) {
    return ApiResponse(
        success: json['success'],
        error: json['error'],
        data: json['data'],
    );
  }
}
