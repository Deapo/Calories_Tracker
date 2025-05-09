import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/calorie_provider.dart';
import 'settings_screen.dart';
import 'progress_screen.dart';
import 'add_food_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final calorieProvider = Provider.of<CalorieProvider>(context);

    // Lấy username từ provider
    // final username = userProvider.username;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header: Avatar, Welcome, Icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar (bấm vào chuyển sang Settings)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ProfileScreen()),
                      );
                    },
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: userProvider.avatarUrl != null
                          ? NetworkImage(userProvider.avatarUrl!)
                          : AssetImage('assets/images/avocado.png') as ImageProvider,
                    ),
                  ),
                  SizedBox(width: 12),
                  // Welcome + Name
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chào mừng',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          userProvider.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Notification Icon
                  Stack(
                    children: [
                      PopupMenuButton<String>(
                        icon: Icon(Icons.notifications_outlined, color: Colors.black87, size: 24),
                        position: PopupMenuPosition.under,
                        offset: Offset(0, 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        itemBuilder: (context) {
                          final calo = calorieProvider.totalCaloriesToday;
                          final goal = calorieProvider.calorieGoal;
                          List<PopupMenuEntry<String>> items = [];
                          if (calo > goal) {
                            items.add(
                              PopupMenuItem<String>(
                                height: 80,
                                child: Container(
                                  width: 250,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Cảnh báo', style: TextStyle(fontWeight: FontWeight.bold)),
                                          SizedBox(width: 8),
                                          Icon(Icons.emoji_emotions, color: Colors.orange),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Hôm nay, bạn đã hấp thụ nhiều hơn bình thường, bạn cần cân bằng lại',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            items.add(
                              PopupMenuItem<String>(
                                height: 80,
                                child: Container(
                                  width: 250,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Chúc mừng!', style: TextStyle(fontWeight: FontWeight.bold)),
                                          SizedBox(width: 8),
                                          Icon(Icons.favorite, color: Colors.pink),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Tuyệt vời, hôm nay bạn đã hoàn thành nhiệm vụ rất tốt',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          // Thêm thông báo mẫu thứ 2
                          items.add(
                            PopupMenuItem<String>(
                              height: 80,
                              child: Container(
                                width: 250,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Nhắc nhở', style: TextStyle(fontWeight: FontWeight.bold)),
                                        SizedBox(width: 8),
                                        Icon(Icons.access_time, color: Colors.blue),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Đừng quên uống đủ nước mỗi ngày',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                          // Thêm thông báo mẫu thứ 3
                          items.add(
                            PopupMenuItem<String>(
                              height: 80,
                              child: Container(
                                width: 250,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Gợi ý', style: TextStyle(fontWeight: FontWeight.bold)),
                                        SizedBox(width: 8),
                                        Icon(Icons.lightbulb, color: Colors.amber),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Hãy thử thêm rau xanh vào bữa ăn của bạn',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                          return items;
                        },
                      ),
                      Positioned(
                        right: 12,
                        top: 12,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Expanded để căn giữa phần calories và macro
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Calories Progress
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          child: CustomPaint(
                            painter: CalorieProgressPainter(
                              progress: (calorieProvider.totalCaloriesToday / calorieProvider.calorieGoal).clamp(0.0, 1.0),
                              progressColor: Colors.deepOrange,
                              backgroundColor: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.local_fire_department, color: Colors.deepOrange, size: 20),
                                SizedBox(width: 4),
                                Text(
                                  '${calorieProvider.totalCaloriesToday.toInt()} Kcal',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              'of ${calorieProvider.calorieGoal.toInt()} kcal',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        // Small circle indicator on the progress ring
                        Positioned(
                          top: 20,
                          right: 60,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.deepOrange, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  // Macro Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _macroItem('Protein', calorieProvider.totalProtein, 90, Colors.deepPurple),
                      _macroItem('Fats', calorieProvider.totalFat, 70, Colors.orange),
                      _macroItem('Carbs', calorieProvider.totalCarbs, 110, Colors.red),
                    ],
                  ),
                  SizedBox(height: 32),
                  
                ],
              ),
            ),
            // Quote động lực phía dưới
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0, left: 24, right: 24),
              child: Column(
                children: [
                  Divider(thickness: 1, color: Colors.grey.shade200),
                  SizedBox(height: 16),
                  Text(
                    '“Hãy kiên trì, thành công sẽ đến với bạn!”',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                      color: Colors.deepOrange,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddFoodScreen()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Thêm bữa ăn mới',
      ),
    );
  }

  // Widget nhỏ cho macro
  Widget _macroItem(String label, double value, double goal, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 6),
        Text(
          '${value.toInt()}/${goal.toInt()}g',
          style: TextStyle(
            fontSize: 14,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Custom painter for the calorie progress circle
class CalorieProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;

  CalorieProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 15.0;

    // Background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius - strokeWidth / 2, backgroundPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final startAngle = -90 * (3.14159 / 180); // Start from top (270 degrees or -90 degrees)
    final sweepAngle = progress * 2 * 3.14159; // Full circle is 2*PI radians

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}