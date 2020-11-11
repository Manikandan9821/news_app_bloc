import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_bloc/logics/bloc/internet_cupit/internet_cubit.dart';
import 'package:news_app_bloc/logics/bloc/news_cubit/news_cubit.dart';
import 'package:news_app_bloc/logics/services/news_services.dart';
import 'package:news_app_bloc/view/screens/news_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News',

      home: MultiBlocProvider(
        providers: [
          BlocProvider<InternetCubit>(
            create: (context) => InternetCubit(connectivity: Connectivity())),
          BlocProvider<NewsCubit>(
            create: (context) => NewsCubit(newsServices: NewsServices(),internetCubit: BlocProvider.of<InternetCubit>(context)),
          ),
        ],
        child: NewsScreen(),
      ),
    );
  }
}
