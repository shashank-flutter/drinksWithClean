import '../entity/drink.dart';
import '../repository/drink_repository.dart';

class GetSearchItems{
  final DrinkRepository drinkRepository;
  GetSearchItems({required this.drinkRepository});

  Future<List<Drink>?> execute(query)async{
    final drinks= await drinkRepository.getSearchItems(query);
    return drinks;

  }


}