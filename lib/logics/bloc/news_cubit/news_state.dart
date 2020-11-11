part of 'news_cubit.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsLoading extends NewsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
 }

class NewsLoaded extends NewsState {
  final NewsModel newsModel;
  NewsLoaded({this.newsModel});

  @override
  List<Object> get props => newsModel.articles;
}

class NewsError extends NewsState{
  final error;
  NewsError({this.error});
  @override
  List<Object> get props =>  [ ];

}
class NewsListError extends NewsState{
  final error;
  NewsListError({this.error});

  @override
  List<Object> get props => [error];
}
