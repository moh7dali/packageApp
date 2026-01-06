import '../../domain/entities/top_up_list.dart';

class TopUpModel extends TopUp {
  const TopUpModel({super.id, super.title, super.description, super.price, super.value, super.image, super.isActive});

  factory TopUpModel.fromJson(Map<String, dynamic> json) {
    return TopUpModel(
      id: json['Id'],
      title: json['Title'],
      description: json['Description'],
      price: (json['Price'] as num?)?.toDouble(),
      value: (json['Value'] as num?)?.toDouble(),
      image: json['Image'],
      isActive: json['IsActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'Id': id, 'Title': title, 'Description': description, 'Price': price, 'Value': value, 'Image': image, 'IsActive': isActive};
  }
}

class TopUpListModel extends TopUpList {
  const TopUpListModel({super.topUp, super.totalNumberofResult});

  factory TopUpListModel.fromJson(Map<String, dynamic> json) => TopUpListModel(
    totalNumberofResult: json["TotalNumberofResult"],
    topUp: json["TopUpList"] == null ? [] : List<TopUp>.from(json["TopUpList"]!.map((x) => TopUpModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {"TotalNumberofResult": totalNumberofResult, "TopUpList": topUp};
}
