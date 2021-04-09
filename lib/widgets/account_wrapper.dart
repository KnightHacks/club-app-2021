import 'package:club_app_2021/model/KnightHacksUser.dart';
import 'package:flutter/material.dart';

class AccountWrapper extends InheritedWidget{
  
  AccountWrapper({Key? key, required this.khUser, required Widget child}) : super(key: key, child: child);

  final KnightHackUser khUser;

  static AccountWrapper of (BuildContext context){

    final AccountWrapper result = context.dependOnInheritedWidgetOfExactType<AccountWrapper>()!;
    assert(result != null, 'No AccountWrapper found in context.');
    return result;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}