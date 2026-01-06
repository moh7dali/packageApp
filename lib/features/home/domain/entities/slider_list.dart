import 'package:equatable/equatable.dart';
import 'package:my_custom_widget/features/home/domain/entities/slider.dart';

class SliderList extends Equatable {
  final List<Slider>? sliders;
  final int? totalNumberOfResult;

  const SliderList({this.sliders, this.totalNumberOfResult});

  @override
  List<Object?> get props => [sliders, totalNumberOfResult];
}
