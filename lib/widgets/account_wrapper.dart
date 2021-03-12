import 'package:club_app_2021/model/KnightHacksUser.dart';
import 'package:flutter/material.dart';

class AccountWrapper extends InheritedWidget{
  
  AccountWrapper({Key key, @required this.KhUser, @required Widget child}) : super(key: key, child: child);

  final KnightHackUser KhUser;

  static AccountWrapper of (BuildContext context){

    final AccountWrapper result = context.dependOnInheritedWidgetOfExactType<AccountWrapper>();
    assert(result != null, 'No AccountWrapper found in context.');
    return result;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}