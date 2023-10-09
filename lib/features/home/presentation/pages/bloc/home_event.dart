part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetDrinkFromBloc extends HomeEvent{}
class GetAllDrinksFromBloc extends HomeEvent{}
