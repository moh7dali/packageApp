import 'package:equatable/equatable.dart';

import 'advertising.dart';

class AdvertisingList extends Equatable {
  final List<Advertising> advertisingList;

  const AdvertisingList({
    required this.advertisingList,
  });

  @override
  List<Object?> get props => [advertisingList];
}
