import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
//import 'package:flutter_connectivity_sample/src/connectivity_off.dart';
import 'package:sanchu5d/douga/connectivity_off.dart';

class ConnectivityOn extends StatefulWidget {
  const ConnectivityOn({
    super.key,
    required this.child
  });

  final Widget child;

  @override 
  State<ConnectivityOn> createState() => _State();
}

class _State extends State<ConnectivityOn> {
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override 
  void initState() {
    super.initState();
    initConnectivity();
    //connectivitySubscription = connectivity.onConnectivityChanged.listen(updateConnectionStatus);
      connectivitySubscription = connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  @override 
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      //result = await connectivity.checkConnectivity();
      result = await connectivity.checkConnectivity();
    } on PlatformException catch(_) {
      return;
    }

    if (!mounted) {
      return;
    }
    
    updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      connectionStatus = result;
    });
  }

  @override 
  Widget build(BuildContext context) {
    return connectionStatus == ConnectivityResult.none 
    ? const ConnectivityOff()
    : widget.child;
  }
}