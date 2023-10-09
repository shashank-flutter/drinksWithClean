import 'package:assignment1/features/home/data/repository_impl/drink_repo_impl.dart';
import 'package:assignment1/features/home/domain/usecase/get_search_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entity/drink.dart';
import 'details.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  TextEditingController controller=TextEditingController();
  List<Drink> drinks = [];
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff040404),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Container(
                      color: Colors.white,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
                        onPressed: (){
                              Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),

                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // Add padding around the search bar
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      // Use a Material design search bar
                      child: TextFormField(

                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          filled: true,
                          fillColor: Colors.white,
                          // Add a clear button to the search bar
                          // Add a search icon or button to the search bar
                          prefixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              // Perform the search here
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                  ),),
                  ElevatedButton(

                      onPressed: ()async{
                    print(controller.text);
                    setState(() {
                      isLoading=true;
                    });
                    final List<Drink>? temp=await GetSearchItems(drinkRepository: DrinkRepoImplementation()).execute(controller.text);
                    setState(() {
                      drinks=temp!;
                      isLoading=false;
                    });
                  }, child: Icon(Icons.search))
                ]
              ),
              isLoading?Center(child: CircularProgressIndicator(color: Colors.white,),):GridView.builder(
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

            ],
          ),
        ),
      ),
    );
  }
}
