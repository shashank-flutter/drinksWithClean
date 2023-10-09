import '../entity/drink.dart';

abstract class DrinkRepository{
  Future<Drink> getDrink(String id);
  Future<List<Drink>?> getAllDrinks();
  Future<List<Drink>?> getSearchItems(String query);

}