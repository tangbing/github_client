

import 'package:flutter/cupertino.dart';

class SelectorProvider with ChangeNotifier {
   final List<Goods> _goodsList = List.generate(10, (index) => Goods(isCollection: false, goodsName: 'goods no $index'));

   get goodsList => _goodsList;
   get total  => _goodsList.length;

   void collect(int index) {
     var good =  _goodsList[index];
     _goodsList[index] = Goods(isCollection: !good.isCollection, goodsName: good.goodsName);
     notifyListeners();
   }
}

class Goods {
  bool isCollection;
  String goodsName;

  Goods({required this.isCollection, required this.goodsName});

}