import 'package:assignment1/features/home/data/repository_impl/drink_repo_impl.dart';
import 'package:assignment1/features/home/domain/repository/drink_repository.dart';

import '../entity/drink.dart';

class GetDrink{
  final DrinkRepository drinkRepository;
  GetDrink({required this.drinkRepository});


  Future<Drink?> execute(String id)async{

    Drink drink= await drinkRepository.getDrink(id);
    return drink;

  }

}