import 'package:equatable/equatable.dart';
import 'address.dart';

class CustomerAddresses extends Equatable {
  final List<Address>? addresses;

  const CustomerAddresses({this.addresses});

  @override
  List<Object?> get props => [addresses];
}
