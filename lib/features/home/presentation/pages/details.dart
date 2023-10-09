import 'package:assignment1/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../data/repository_impl/drink_repo_impl.dart';
import '../../domain/entity/drink.dart';
import '../../domain/usecase/get_drink.dart';
class Details extends StatefulWidget {

  final String id;
  const Details({super.key, required this.id});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  
  @override
  void initState() {
    // TODO: implement initState
    getDrink();
    super.initState();
  }

  bool isLoading=false;
  
  @override
  Widget build(BuildContext context) {
    return isLoading?Center(child: CircularProgressIndicator(color: Colors.white,),):Scaffold(
          backgroundColor: backgroundColor,
          body:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    //margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(individualDrink!.strDrinkThumb??'https://mybartender.com/wp-content/uploads/2023/06/different-types-of-bacardi-drinks.jpeg'),
                          fit: BoxFit.cover
                      ),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 30.0,
                          right: 20.0

                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(individualDrink!.strDrink??'',

                          style: GoogleFonts.lora(
                            textStyle: const TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white

                            ),
                          ),


                        ),
                      ),
                    )
                ),
                Padding(

                  padding: const EdgeInsets.only(top: 40.0,left:40),
                  child: Text(individualDrink!.strInstructions.toString()??"",
                    style: GoogleFonts.lora(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,


                      ),
                    ),

                  ),
                ),
                Padding(

                  padding: const EdgeInsets.only(top: 40.0,left:40),
                  child: Text("Ingredients:",
                    style: GoogleFonts.lora(
                      textStyle: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white

                      ),
                    ),

                  ),
                ),
                SizedBox(height: 40,),
                Padding(

                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(individualDrink!=null?individualDrink!.strIngredient1??'':"Harvey\nWallbenger", style: GoogleFonts.lora(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white

                    ),
                  ),),

                ),
                Padding(

                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(individualDrink!=null?individualDrink!.strIngredient2??'':"Harvey\nWallbenger", style: GoogleFonts.lora(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white

                    ),
                  ),),

                ),

                Padding(

                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(individualDrink!=null?individualDrink!.strIngredient3??'':"Harvey\nWallbenger", style: GoogleFonts.lora(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white

                    ),
                  ),),
                ),
                Padding(

                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(individualDrink!=null?individualDrink!.strIngredient4??'':"Harvey\nWallbenger", style: GoogleFonts.lora(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white

                    ),
                  ),),

                ),
            ],
            ),
          )
      );
  }
  Drink? individualDrink;
  void getDrink() async{
    isLoading=true;
    final iindividualDrink= (await GetDrink(drinkRepository: DrinkRepoImplementation()).execute(widget.id));

    setState(() {
      individualDrink= iindividualDrink;
    });
    isLoading=false;
//    print("indiiii: "+individualDrink.toString());//

    
  }
}
