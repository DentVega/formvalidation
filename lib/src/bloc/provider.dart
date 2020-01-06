import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {

  final logicBloc = LoginBloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static LoginBloc of (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().logicBloc;
  }

}