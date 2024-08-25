

import 'package:flutter/cupertino.dart';

class CounterProvider extends ChangeNotifier {
   int _count = 0;

   int get counter => _count;

   void increment() {
     _count++;
     notifyListeners();
   }
}