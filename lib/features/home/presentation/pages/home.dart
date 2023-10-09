import 'package:assignment1/features/home/data/repository_impl/drink_repo_impl.dart';
import 'package:assignment1/features/home/domain/usecase/get_all_Drinks.dart';
import 'package:assignment1/features/home/presentation/pages/details.dart';
import 'package:assignment1/features/home/presentation/pages/search.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entity/drink.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> list = [
    "Harvey Wallbenger",
    "Harvey Wallbenger",
    "Harvey Wallbenger",
    "Harvey Wallbenger",

  ];

  @override
  void initState() {
    // TODO: implement initState
    getDrinks();
    super.initState();
  }

  List<Drink> drinks = [];

  getDrinks() async {
    isLoading=true;
    final drinksTemp = await GetAllDrinks(
        drinkRepository: DrinkRepoImplementation()).execute();
    setState(() {
      drinks = drinksTemp!;
    });
    isLoading=false;
  }


  List a = ["1", "2", "3", "4"];
  List names = ["Harley\nWalbenger", "Darky\nIceberg", "Walbenger\nMargrett", "Bright\nKen"];


  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedIconTheme: IconThemeData(color: Colors.white),
        unselectedIconTheme:  IconThemeData(color: Colors.white70),
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.fireplace_outlined,color: Colors.white,),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: IconButton(icon: Icon(Icons.search,color: Colors.white),onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },),
            label: 'Search',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle,color: Colors.white),
            label: 'User',
          ),
        ],
      ),
      backgroundColor: const Color(0xff040404),
      body: isLoading?Center(child: CircularProgressIndicator(color: Colors.white,),):Container(child:
      SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        CarouselSlider(
        options: CarouselOptions(
        height: 400.0,
          autoPlay: true,
          viewportFraction: 1,

        ),
        items: [1, 2, 3, 4].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  height: 400,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  //margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/$i.jpeg"),
                        fit: BoxFit.cover
                    ),

                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 70.0,
                      left: 20.0),

                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Opacity(

                          opacity: .7,
                          child: Text("Featured Recipes",

                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white

                              ),
                            ),


                          ),
                        ),

                          Text(names[i-1],

                            style: GoogleFonts.lora(
                              textStyle: const TextStyle(
                                  fontSize: 60.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white

                              ),
                            ),


                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,

                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 10,
                              //itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.white,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            Opacity(
                              opacity: 0.7,
                              child: Text("Cocktail",
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white

                                  ),
                                ),),
                            )
                          ],
                        )

                      ],
                    ),
                  )
              );
            },
          );
        }).toList(),

      ),
        const SizedBox(height: 30,),
            Row(
              children: [
                SizedBox(width: 10,),
                Text("Today\'s Recipies".toString(),
          style: GoogleFonts.lora(
                textStyle: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white

                ),

          ),


        ),
      Spacer(),
      Opacity(
        opacity: 0.7,
        child: Text("View All".toString(),
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white

            ),)),
      ),
                SizedBox(width: 10,)
              ],
            ),
        const SizedBox(height: 30,),


            GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: drinks.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Details(id:drinks[index].idDrink??"")),
                      );
                    },
                    child: Flexible(
                      child: Column(
                        children: [
                          Container(
                            height: 280,

                            //margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              //color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(drinks[index].strDrinkThumb.toString()),
                                  fit: BoxFit.cover
                              ),


                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.heart_broken,color: Colors.white,),
                                    Text("850",
                                      style: GoogleFonts.lora(
                                        textStyle: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white

                                        ),
                                      ),

                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ),
                          SizedBox(height: 20,),
                          Text(drinks[index].strDrink.toString(),
                            style: GoogleFonts.lora(
                              textStyle: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white

                              ),
                            ),

                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,

                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 10,
                                //itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.white,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              Text(drinks[index].strCategory.toString(),
                                style: GoogleFonts.lora(
                                  textStyle: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white

                                  ),
                                ),)
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),

            const SizedBox(height: 30,),



      ],
    ),)
    ,
    )
    ,


    );
  }
}
