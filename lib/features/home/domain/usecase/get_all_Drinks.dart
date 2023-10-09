import 'package:assignment1/features/home/domain/repository/drink_repository.dart';

import '../entity/drink.dart';

class GetAllDrinks{
  final DrinkRepository drinkRepository;
  GetAllDrinks({required this.drinkRepository});

  Future<List<Drink>?> execute()async{
    final drinks= await drinkRepository.getAllDrinks();
    return drinks;

  }


}