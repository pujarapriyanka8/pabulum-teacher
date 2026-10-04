import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService {
  // Singleton instance
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  // Stream controller to emit connectivity status
  final StreamController<List<ConnectivityResult>> _connectivityController =
      StreamController<List<ConnectivityResult>>.broadcast();

  // Public stream to listen for connectivity changes
  Stream<List<ConnectivityResult>> get connectivityStream =>
      _connectivityController.stream;

  // Track the current connectivity state
  List<ConnectivityResult> _currentConnectivityResult = [
    ConnectivityResult.none
  ];
  List<ConnectivityResult> get currentConnectivityResult =>
      _currentConnectivityResult;

  void initialize() {
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      _currentConnectivityResult = result;
      _connectivityController.add(result);
      debugPrint('Connectivity changed: $result');
    });
    // Perform an initial check
    _checkInitialConnectivity();
  }

  Future<void> _checkInitialConnectivity() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    _currentConnectivityResult = connectivityResult;
    _connectivityController.add(connectivityResult);
    debugPrint('Initial connectivity: $connectivityResult');
  }

  Future<bool> hasInternetConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet) ||
        connectivityResult
            .contains(ConnectivityResult.vpn); // Consider VPN as connected
  }

  void dispose() {
    _connectivityController.close();
  }
}

class NoInternetException implements Exception {
  final String message;

  NoInternetException([this.message = 'No internet connection.']);

  @override
  String toString() {
    return "NoInternetException: $message";
  }
}
