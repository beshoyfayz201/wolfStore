part of 'drug_cubit.dart';

@immutable
abstract class DrugState {}

class DrugInitial extends DrugState {}
class SearchLoading extends DrugState {}
class DrugLoaded extends DrugState {}
