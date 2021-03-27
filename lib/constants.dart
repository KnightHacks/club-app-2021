/// Constants used throughout the app.

import 'package:flutter/material.dart';

/// URL used for the events API
const eventsURL =
    "https://api.knighthacks.org/api/club/get_events/?rdate=NextWeek";

/// This string is used for verifying an email entered when registering with a
/// knights email.
String knightsEmail = "@knights.ucf.edu";
/// This string is used for verifying an email entered when registering with a
/// ucf.edu email.
String ucfEmail = "@ucf.edu";

/// Card title styling.
TextStyle kCardTitleStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.white
);


/// Card description styling.
TextStyle kCardDescriptionStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
);


/// Styling for the add to calendar button.
TextStyle kAddToCalStyle = TextStyle(
  color: Colors.white
);

/// General text style.
TextStyle kGeneralTextStyle = TextStyle(
  color: Colors.white
);

/// Icon color.
Color kIconColor = Colors.white;
/// Pale pink color
Color kPinkColor = Color(0xFFb7517c);
/// Dark blue color
Color kDarkBlueColor = Color(0xFF1A1843);
/// Light blue color
Color kLightBlueColor = Color(0xFF36328B);
/// Gold-amber color
Color kGoldColor = Colors.amber;