import 'malls.dart';

class MallsList extends Malls {
  final List<Malls>? malls;
  final int? totalNumberOfResult;

  const MallsList({this.malls, this.totalNumberOfResult});

  @override
  List<Object?> get props => [malls, totalNumberOfResult];
}
