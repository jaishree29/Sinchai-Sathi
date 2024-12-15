import 'package:flutter/material.dart';
import 'package:sinchai_sathi/utils/colors.dart'; // Import your app's color scheme

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: SColors.primary,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: dummyNotifications.length,
        itemBuilder: (context, index) {
          final notification = dummyNotifications[index];
          return _buildNotificationItem(notification);
        },
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    return Card(
      color: Colors.grey[100],
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: SColors.primary,
          child: Icon(
            notification['icon'],
            color: Colors.white,
          ),
        ),
        title: Text(
          notification['title'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Text(
          notification['message'],
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
          ),
        ),
        trailing: Text(
          notification['time'],
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.grey,
          ),
        ),
        onTap: () {
          // Add navigation or action here if needed
          print("Notification tapped: ${notification['title']}");
        },
      ),
    );
  }

  // Dummy notifications data
  List<Map<String, dynamic>> get dummyNotifications => [
        {
          'icon': Icons.cloud,
          'title': 'Weather Update',
          'message':
              'Rain expected tomorrow. Make sure to cover your crops to prevent waterlogging.',
          'time': '10:30 AM',
        },
        {
          'icon': Icons.water_drop,
          'title': 'Irrigation Reminder',
          'message':
              'Your crops need water. Start irrigation for 30 minutes today.',
          'time': '9:45 AM',
        },
        {
          'icon': Icons.spa,
          'title': 'Soil Health Alert',
          'message':
              'Your soil moisture is low. Consider adding organic matter to improve fertility.',
          'time': 'Yesterday',
        },
        {
          'icon': Icons.bug_report,
          'title': 'Pest Alert',
          'message':
              'Monitor your crops for pests. Use organic pesticides if needed.',
          'time': '2 days ago',
        },
        {
          'icon': Icons.lightbulb,
          'title': 'Crop Care Tip',
          'message':
              'Apply fertilizer evenly to avoid over-fertilization. Use 2 kg per acre.',
          'time': '3 days ago',
        },
        {
          'icon': Icons.calendar_today,
          'title': 'Harvest Reminder',
          'message':
              'Your wheat crops are ready for harvest. Start harvesting within the next 5 days.',
          'time': '1 week ago',
        },
        {
          'icon': Icons.warning,
          'title': 'Disease Warning',
          'message':
              'Fungal disease detected in your tomato crops. Apply fungicide immediately.',
          'time': '1 week ago',
        },
        {
          'icon': Icons.light_mode,
          'title': 'Sunlight Alert',
          'message':
              'Your crops are receiving less sunlight. Consider pruning nearby trees.',
          'time': '2 weeks ago',
        },
      ];
}
