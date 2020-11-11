import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';
import 'package:news_app_bloc/logics/constant/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;

  StreamSubscription networkStreamSubscriptions;

  InternetCubit({@required this.connectivity}) : super(InternetLoading()) {
    checkNetworkConnection();
  }

  StreamSubscription<ConnectivityResult> checkNetworkConnection() {
    return networkStreamSubscriptions = connectivity.onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(NetWorkConnection.IsConnectionAvailable);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisConnected(NetWorkConnection.IsConnectionNotAvailable);
      }
    });
  }

  void emitInternetConnected(NetWorkConnection isConnectionAvailable) =>
      emit(InternetConnection(netWorkConnection: isConnectionAvailable));

  void emitInternetDisConnected(NetWorkConnection isConnectionNotAvailable) =>
      emit(InternetConnection(netWorkConnection: isConnectionNotAvailable));

  @override
  Future<void> close() {
    networkStreamSubscriptions.cancel();
    return super.close();
  }
}
