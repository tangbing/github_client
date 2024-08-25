

import 'package:flutter/material.dart';
import 'package:github_client_app/states/selector_provider.dart';
import 'package:provider/provider.dart';

class SelectorPage extends StatelessWidget {
  const SelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SelectorProvider() ,
      child: Scaffold(
        appBar: AppBar(
          title: Text('selector Page'),
        ),
        body: Selector<SelectorProvider, SelectorProvider>(
          selector: (BuildContext  context , SelectorProvider provider) => provider,
          builder: (BuildContext context, SelectorProvider provider, Widget? child) {
            print('SelectorProvider out');
            return ListView.builder(
                itemCount: provider.total,
                itemBuilder: (context, index) {
                  print('SelectorProvider in');
                  return Selector<SelectorProvider, Goods>(
                       selector: (context , provider) => provider.goodsList[index],
                     builder: (BuildContext context, Goods goods, Widget? child) {
                         return ListTile(
                           title: Text(goods.goodsName),
                           trailing: GestureDetector(
                             onTap: ()  => provider.collect(index),
                               child: Icon(goods.isCollection ? Icons.star : Icons.star_border)),
                         );
                     },
                   );
            });
          },
        ),
      ),
    );
  }
}
