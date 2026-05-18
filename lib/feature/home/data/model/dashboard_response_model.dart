class DashboardResponseModel {
  final String url;

  DashboardResponseModel({required this.url});

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) {
    return DashboardResponseModel(url: json['url']?.toString() ?? '');
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'url': url,
  //   };
  // }
}
