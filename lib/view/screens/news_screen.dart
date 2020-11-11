import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_bloc/logics/bloc/news_cubit/news_cubit.dart';
import 'package:news_app_bloc/logics/models/news_model.dart';
import 'package:news_app_bloc/view/widgets/news_list.dart';



class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

   Future<void> _onRefresh() async {
    BlocProvider.of<NewsCubit>(context).refresh();
  }

  @override
  Widget build(BuildContext context) {
    print('--------- Widget Tree --------');
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text('News',),
      ),
     body: SafeArea(
       child: RefreshIndicator(
         onRefresh: _onRefresh,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[

                BlocBuilder<NewsCubit,NewsState>(
                    builder: (context,state){
                      if(state is NewsError){
                        return Center(child: Text('${state.error}',style: TextStyle(fontSize: 25.0,),));
                      }
                      if(state is NewsListError){
                        return Center(child: Text('${state.error}',style: TextStyle(fontSize: 25.0,),));
                      }
                      if(state is NewsLoaded){
                        NewsModel news = state.newsModel;
                        return NewsList(news:news);
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                ),

             ],
           ),

       ),
     ),

    );
  }
}
