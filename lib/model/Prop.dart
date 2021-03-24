import 'package:club_app_2021/model/KnightHacksUser.dart';

/// Wrapper class for the arguments being passed to a page

/// To access these attributes do:
/// final Prop prop = ModalRoute.of(context).settings.arguments;

class Prop{
  final KnightHackUser knightHackUser;

  Prop(this.knightHackUser);
}

// Tentative
// Right now it expects a KnightHackUser object but can modify to be like so to genericize it.

// class Prop{
//   final List<Object> props;

//   Prop(this.props);
// }