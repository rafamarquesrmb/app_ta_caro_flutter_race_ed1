import 'package:flutter/material.dart';

import 'package:meuapp/shared/models/order_model.dart';
import 'package:meuapp/shared/theme/app_theme.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    Key? key,
    required this.order,
  }) : super(key: key);
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.colors.textEnabled,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppTheme.colors.background,
            child: Text(
              order.created.split("-").sublist(1).reversed.join("/"),
              style: AppTheme.textStyles.label,
            ),
            radius: 30,
          ),
          title: Text(order.name.toString(),
              style: AppTheme.textStyles.titleListTile),
          subtitle: Text("R\$ ${order.price.toStringAsFixed(2)}",
              style: AppTheme.textStyles.subtitleListTile),
          trailing: PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(child: Text("Excluir")),
                    PopupMenuItem(child: Text("Editar")),
                  ]),
        ),
      ),
    );
  }
}
