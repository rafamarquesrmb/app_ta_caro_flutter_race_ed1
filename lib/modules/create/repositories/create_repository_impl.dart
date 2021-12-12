import 'package:meuapp/modules/create/repositories/create_repository.dart';
import 'package:meuapp/shared/services/app_database.dart';
import 'package:validators/sanitizers.dart';

class CreateRepositoryImpl implements ICreateRepository {
  final AppDatabase database;
  CreateRepositoryImpl({
    required this.database,
  });
  @override
  Future<bool> create({
    required String name,
    required String price,
    required String date,
  }) async {
    try {
      dynamic priceSanitize = (price.replaceAll(",", ""));
      priceSanitize = double.parse(priceSanitize.replaceAll("R\$", ""));
      // final dateSanitize = date.toDate();
      final response = await database.create(
        table: "orders",
        data: {
          "name": name,
          "price": priceSanitize,
          "created": date,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
