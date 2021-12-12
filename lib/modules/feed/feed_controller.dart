import 'package:flutter/cupertino.dart';
import 'package:meuapp/modules/create/repositories/create_repository.dart';
import 'package:meuapp/modules/feed/repositories/feed_repository.dart';
import 'package:meuapp/shared/models/order_model.dart';
import 'package:meuapp/shared/models/product_model.dart';
import 'package:meuapp/shared/utils/app_state.dart';

class FeedController extends ChangeNotifier {
  final IFeedRepository repository;
  AppState state = AppState.empty();
  final formKey = GlobalKey<FormState>();
  String _name = "";
  String _price = "";
  String _date = "";

  FeedController({required this.repository});

  void update(AppState state) {
    this.state = state;
    notifyListeners();
  }

  List<OrderModel> get orders => state.when(
        orElse: () => [],
        success: (value) => value,
      );
  double get SumTotal {
    double sum = 0;
    for (var item in orders) {
      sum += item.price;
    }
    return sum;
  }

  List<ProductModel> get products {
    final products = <ProductModel>[];
    for (var item in orders) {
      final product =
          ProductModel(name: item.name, lastPrice: 0, currentPrice: item.price);
      final index =
          products.indexWhere((element) => element.name == product.name);
      if (index != -1) {
        final currentProduct = products[index];
        products[index] = currentProduct.copyWith(lastPrice: item.price);
      } else {
        products.add(product);
      }
    }
    return products;
  }

  double calcChart(List<ProductModel> products) {
    if (products.isEmpty) {
      return 1;
    }
    double up = 0;
    for (var item in products) {
      if (item.currentPrice < item.lastPrice) {
        up++;
      }
    }

    return 1 - (up / (products.length));
  }

  Future<void> getData() async {
    try {
      update(AppState.loading());
      final response = await repository.getAll();
      update(AppState.success<List<OrderModel>>(response));
    } catch (e) {
      update(AppState.error(e.toString()));
    }
  }
}
