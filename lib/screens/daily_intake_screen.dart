import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calorie_provider.dart';

class DailyIntakeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final calorieProvider = Provider.of<CalorieProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Tiêu thụ hàng ngày')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_fire_department, color: Colors.deepOrange, size: 60),
            SizedBox(height: 16),
            Text(
              'Lượng calorie tiêu thụ hôm nay:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              '${calorieProvider.totalCaloriesToday.toStringAsFixed(0)} kcal',
              style: TextStyle(fontSize: 32, color: Colors.deepOrange, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
