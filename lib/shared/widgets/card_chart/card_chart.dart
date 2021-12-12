import 'package:flutter/material.dart';

import 'package:meuapp/shared/theme/app_theme.dart';
import 'package:meuapp/shared/widgets/chart_horizontal/chart_horizontal.dart';

class CardChart extends StatelessWidget {
  const CardChart({
    Key? key,
    required this.value,
    required this.percent,
  }) : super(key: key);
  final double value;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      // height: 210,
      decoration: BoxDecoration(
        color: AppTheme.colors.textEnabled,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Gasto Mensal").label,
            SizedBox(
              height: 18,
            ),
            Text.rich(
              TextSpan(
                text: 'R\$ ',
                style: AppTheme.textStyles.label,
                children: [
                  TextSpan(
                    text: value.toStringAsFixed(2).replaceAll(".", ","),
                    style: AppTheme.textStyles.title.copyWith(fontSize: 36),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ChartHorizontal(
              percent: percent,
            ),
          ],
        ),
      ),
    );
  }
}
