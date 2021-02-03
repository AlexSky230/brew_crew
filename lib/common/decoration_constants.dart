import 'package:flutter/material.dart';
import 'package:sky_brew_crew/common/text_constants.dart' as text;

final textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
        color: Colors.pink[400],
        width: 2
    ),
  ),
);

final backgroundImage = BoxDecoration(
    image: DecorationImage(
      image: AssetImage(text.backgroundImageUrl),
      fit: BoxFit.cover,
      colorFilter: new ColorFilter.mode(Colors.brown.withOpacity(0.2), BlendMode.multiply),
    )
);