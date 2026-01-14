import 'package:equatable/equatable.dart';
import 'package:mozaic_loyalty_sdk/features/home/domain/entities/slider.dart';

class SliderList extends Equatable {
  final List<Slider>? sliders;
  final int? totalNumberOfResult;

  const SliderList({this.sliders, this.totalNumberOfResult});

  @override
  List<Object?> get props => [sliders, totalNumberOfResult];
}
