import 'package:equatable/equatable.dart';

class ApplicationVersion extends Equatable {
  final int? systemVersion;
  final bool? needsUpdating;
  final bool? isActive;
  final String? inActiveReason;

  const ApplicationVersion({required this.systemVersion, required this.needsUpdating, required this.isActive, required this.inActiveReason});

  @override
  List<Object?> get props => [
        systemVersion,
        needsUpdating,
        isActive,
        inActiveReason,
      ];
}
