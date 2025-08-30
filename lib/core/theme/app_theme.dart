import 'package:flutter/material.dart';

class AppTheme{final ThemeData light;final ThemeData dark;AppTheme(this.light,this.dark);static AppTheme build(Color brand){final light=ColorScheme.fromSeed(seedColor:brand,brightness:Brightness.light);final dark=ColorScheme.fromSeed(seedColor:brand,brightness:Brightness.dark);return AppTheme(ThemeData(colorScheme:light,useMaterial3:true),ThemeData(colorScheme:dark,useMaterial3:true));}}
