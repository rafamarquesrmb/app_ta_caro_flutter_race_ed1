import 'package:flutter/material.dart';
import 'package:meuapp/modules/feed/feed_controller.dart';
import 'package:meuapp/modules/feed/repositories/feed_repository_impl.dart';
import 'package:meuapp/shared/models/order_model.dart';
import 'package:meuapp/shared/services/app_database.dart';
import 'package:meuapp/shared/theme/app_text.dart';
import 'package:meuapp/shared/widgets/card_chart/card_chart.dart';
import 'package:meuapp/shared/widgets/card_product/card_product.dart';
import 'package:meuapp/shared/widgets/list_tile/app_list_tile.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late final FeedController controller;

  @override
  void initState() {
    controller = FeedController(
        repository: FeedRepositoryImpl(database: AppDatabase.instance));
    controller.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, __) => controller.state.when(
            error: (message, e) => Text(message),
            orElse: () => Container(),
            empty: () => Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator())),
            loading: () => Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator())),
            success: (value) {
              final orders = value as List<OrderModel>;
              final products = controller.products;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        CardChart(
                          value: controller.SumTotal,
                          percent: controller.calcChart(products),
                        ),
                        SizedBox(
                          height: 27,
                        ),
                        Text("Preço dos produtos").label,
                        SizedBox(
                          height: 14,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 126,
                    child: ListView.builder(
                      itemCount: products.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => CardProduct(
                        product: products[index],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 27,
                        ),
                        Text("Suas últimas compras").label,
                        SizedBox(
                          height: 14,
                        ),
                        for (var order in orders)
                          AppListTile(
                            order: order,
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
