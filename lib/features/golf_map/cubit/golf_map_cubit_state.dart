import 'package:equatable/equatable.dart';
import 'package:pinlink/constant/enums.dart';

class GolfMapCubitState extends Equatable {
  final MapFilters? selectedFilter;

  const GolfMapCubitState({this.selectedFilter});

  @override
  List<Object?> get props => [selectedFilter];

  GolfMapCubitState copyWith({MapFilters? selectedFilter}) {
    return GolfMapCubitState(selectedFilter: selectedFilter ?? this.selectedFilter);
  }
}
