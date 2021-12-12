import 'package:meuapp/modules/feed/repositories/feed_repository.dart';
import 'package:meuapp/shared/models/order_model.dart';
import 'package:meuapp/shared/services/app_database.dart';

class FeedRepositoryImpl extends IFeedRepository {
  final AppDatabase database;
  FeedRepositoryImpl({
    required this.database,
  });

  @override
  Future<List<OrderModel>> getAll() async {
    final response = await database.getAll("orders");
    print(response);
    return response.map((e) => OrderModel.fromMap(e)).toList();
  }
}
