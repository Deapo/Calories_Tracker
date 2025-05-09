import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/auth_provider.dart';
import 'settings_screen.dart';
import 'progress_screen.dart';
import 'daily_intake_screen.dart';
import 'nutrition_report_screen.dart';
// import các màn hình khác nếu có

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Lấy username từ email (trước dấu @) và viết hoa toàn bộ
    String displayName = '';
    if (userProvider.email != null && userProvider.email!.contains('@')) {
      displayName = userProvider.email!.split('@')[0].toUpperCase();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Hồ sơ', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.settings),
            onSelected: (value) async {
              if (value == 'logout') {
                await Provider.of<AuthProvider>(context, listen: false).signOut();
                // Sau khi signOut, chuyển về màn hình đăng nhập hoặc wrapper
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Log out'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Stack(
            children: [
              CircleAvatar(
                radius: 55,
                backgroundImage: userProvider.avatarUrl != null
                    ? NetworkImage(userProvider.avatarUrl!)
                    : AssetImage('assets/images/avocado.png') as ImageProvider,
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(displayName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 24),
          _profileItem(context, Icons.fastfood, 'Tiêu thụ hàng ngày', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => DailyIntakeScreen()));
          }),
          _profileItem(context, Icons.bar_chart, 'Báo cáo dinh dưỡng', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => NutritionReportScreen()));
          }),
          _profileItem(context, Icons.flag, 'Mục tiêu calo', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen()));
          }),
        ],
      ),
    );
  }

  Widget _profileItem(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }
}
