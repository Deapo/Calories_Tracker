import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calorie_provider.dart';
import 'add_food_screen.dart';

class NutritionReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final calorieProvider = Provider.of<CalorieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrition Report'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Thêm món ăn',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => AddFoodScreen()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: calorieProvider.logEntries.length,
        itemBuilder: (context, index) {
          final entry = calorieProvider.logEntries[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Colors.orange.shade100,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Có thể thay bằng ảnh món ăn nếu có
                      Icon(Icons.restaurant_menu, color: Colors.orange, size: 28),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          entry.foodName,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      // ... nếu muốn thêm nút more ...
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.local_fire_department, color: Colors.deepOrange, size: 16),
                      SizedBox(width: 4),
                      Text('${entry.calories.toStringAsFixed(0)} kcal - ${entry.quantity.toStringAsFixed(0)}${entry.unit}'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _macroColumn('Protein', entry.protein ?? 0, Colors.green),
                      _macroColumn('Fats', entry.fat ?? 0, Colors.red),
                      _macroColumn('Carbs', entry.carbs ?? 0, Colors.amber),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _macroColumn(String label, double value, Color color) {
    return Column(
      children: [
        Text('${value.toStringAsFixed(0)}g', style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
      ],
    );
  }
}
