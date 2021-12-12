import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meuapp/shared/models/product_model.dart';

import 'package:meuapp/shared/theme/app_theme.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        width: 230,
        decoration: BoxDecoration(
          color: AppTheme.colors.textEnabled,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppTheme.colors.background,
                child: product.currentPrice < product.lastPrice
                    ? Icon(
                        FontAwesomeIcons.thumbsUp,
                      )
                    : Icon(
                        FontAwesomeIcons.thumbsDown,
                        color: AppTheme.colors.badColor,
                      ),
                radius: 30,
              ),
              title:
                  Text(product.name, style: AppTheme.textStyles.titleListTile),
              subtitle: Text(
                  "Estava R\$ ${product.lastPrice.toStringAsFixed(2)}",
                  style: AppTheme.textStyles.subtitleListTile),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Text.rich(
                TextSpan(
                  text: "Agora\n",
                  style: AppTheme.textStyles.subtitleListTile,
                  children: [
                    TextSpan(
                        text: "R\$ ${product.currentPrice.toStringAsFixed(2)}",
                        style: AppTheme.textStyles.title),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
