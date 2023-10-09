import 'dart:convert';

import 'package:assignment1/features/home/data/models/drink_model.dart';
import 'package:assignment1/features/home/domain/entity/drink.dart';
import 'package:assignment1/features/home/domain/repository/drink_repository.dart';
import 'package:http/http.dart' as http;


class DrinkRepoImplementation implements DrinkRepository{
  @override
  Future<Drink> getDrink(String id) async{

    var url = Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i='+id);
    var response = await http.get(url);
    print('Response status: ${response.body}');

    Map decoded= jsonDecode(response.body.toString());
    print('decoded: ${decoded}');


    DrinkModel drink = DrinkModel.fromJson(decoded["drinks"][0]);
    print('drink: ${drink}');
    return drink;

    //print('Response body: ${response.body}');


    // TODO: implement getDrink
    throw UnimplementedError();
  }

  @override
  Future<List<Drink>?> getAllDrinks() async{
    // TODO: implement listAllDrinks

    var url = Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/search.php?s=s');
    var response = await http.get(url);
    print('Response status: ${response.body}');

    Map decoded= jsonDecode(response.body.toString());
    print('decoded: ${decoded["drinks"][0]}');

    List<Drink>? drinks=[];
    for(int j=0;j<decoded["drinks"].toList().length;j++){
      drinks.add(DrinkModel.fromJson(decoded["drinks"][j]));
    }
    return drinks;



  }

  @override
  Future<List<Drink>?> getSearchItems(String query)async {
    // TODO: implement getSearchItems
    var url = Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$query');
    var response = await http.get(url);
    print('Response status: ${response.body}');

    Map decoded= jsonDecode(response.body.toString());
    print('decoded: ${decoded["drinks"][0]}');

    List<Drink>? drinks=[];
    for(int j=0;j<decoded["drinks"].toList().length;j++){
      drinks.add(DrinkModel.fromJson(decoded["drinks"][j]));
    }
    return drinks;

  }

}