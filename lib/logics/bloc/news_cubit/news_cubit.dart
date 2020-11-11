import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_bloc/logics/bloc/internet_cupit/internet_cubit.dart';
import 'package:news_app_bloc/logics/constant/enums.dart';
import 'package:news_app_bloc/logics/models/news_model.dart';
import 'package:news_app_bloc/logics/services/news_services.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsServices newsServices;

  final InternetCubit internetCubit;

  StreamSubscription internetStreamSubcription;

  NewsModel newsModel;

  NewsCubit({this.newsServices, this.internetCubit}) : super(NewsInitial()) {
    internetStreamSubcription = internetCubit.listen((connectionState) async {
      if (connectionState is InternetConnection &&
          connectionState.netWorkConnection ==
              NetWorkConnection.IsConnectionAvailable) {
        _getNews();
      } else if (connectionState is InternetConnection &&
          connectionState.netWorkConnection ==
              NetWorkConnection.IsConnectionNotAvailable) {
        _noNetWorkConnection();
      }
    });
  }


  _getNews() async {
    try {
      emit(NewsLoading());
      newsModel = await newsServices.getNewsList();
      emit(NewsLoaded(newsModel: newsModel));
    } catch (e) {
      emit(
        NewsError(
           error: 'Internet is not available'),
      );
    }

  }

  _noNetWorkConnection() {
    emit(NewsListError(error: 'No Internet Connection'));
  }

  Future<void> refresh() async{
    _getNews();
  }

  @override
  Future<void> close() {

    internetStreamSubcription.cancel();
    return super.close();
  }
}
