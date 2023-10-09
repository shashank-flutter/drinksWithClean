import 'package:assignment1/features/home/domain/entity/drink.dart';
import 'package:assignment1/features/home/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/home/presentation/pages/details.dart';
import 'features/home/presentation/pages/search.dart';

main(){
  runApp(MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

