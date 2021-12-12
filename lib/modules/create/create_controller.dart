import 'package:flutter/cupertino.dart';
import 'package:meuapp/modules/create/repositories/create_repository.dart';
import 'package:meuapp/shared/utils/app_state.dart';

class CreateController extends ChangeNotifier {
  final ICreateRepository repository;
  AppState state = AppState.empty();
  final formKey = GlobalKey<FormState>();
  String _name = "";
  String _price = "";
  String _date = "";

  CreateController({required this.repository});

  void onChange({String? name, String? price, String? date}) {
    _name = name ?? _name;
    _price = price ?? _price;
    _date = date ?? _date;
  }

  bool validate() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void update(AppState state) {
    this.state = state;
    notifyListeners();
  }

  Future<void> create() async {
    if (validate()) {
      try {
        update(AppState.loading());
        final response =
            await repository.create(name: _name, price: _price, date: _date);
        if (response) {
          update(AppState.success<bool>(response));
        } else {
          throw Exception("Não foi possível registrar a compra");
        }
      } catch (e) {
        update(AppState.error(e.toString()));
      }
    }
  }
}
