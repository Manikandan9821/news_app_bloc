part of 'internet_cubit.dart';

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnection extends InternetState{
  final NetWorkConnection netWorkConnection;

  InternetConnection({@required this.netWorkConnection});
}

class InternetDisConnection extends InternetState{
  final NetWorkConnection netWorkConnection;

  InternetDisConnection({@required this.netWorkConnection});

}
