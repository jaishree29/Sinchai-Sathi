import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sinchai_sathi/services/api_service.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/utils/local_storage.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<Map<String, dynamic>> notifications = [];
  bool isLoading = true;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    try {
      final token = await SLocalStorage().getToken();
      if (token == null) {
        throw Exception('No token found');
      }
      final alerts = await _apiService.getAlerts(token);
      setState(() {
        notifications = alerts;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching notifications: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  IconData _getIconForAlert(String title, String priority) {
    if (priority == 'high') return Icons.warning;
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('weather') || lowerTitle.contains('rain')) {
      return Icons.cloud;
    } else if (lowerTitle.contains('irrigation') ||
        lowerTitle.contains('water')) {
      return Icons.water_drop;
    } else if (lowerTitle.contains('soil')) {
      return Icons.spa;
    } else if (lowerTitle.contains('pest') || lowerTitle.contains('bug')) {
      return Icons.bug_report;
    } else if (lowerTitle.contains('harvest')) {
      return Icons.calendar_today;
    } else if (lowerTitle.contains('sun')) {
      return Icons.light_mode;
    }
    return Icons.notifications;
  }

  String _formatTime(String? timeString) {
    if (timeString == null) return '';
    try {
      final dateTime = DateTime.parse(timeString);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays == 0) {
        return DateFormat('hh:mm a').format(dateTime);
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        return DateFormat('dd MMM').format(dateTime);
      }
    } catch (e) {
      return timeString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: SColors.primary,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : notifications.isEmpty
              ? const Center(child: Text("No notifications"))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return _buildNotificationItem(notification);
                  },
                ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    final title = notification['title'] ?? 'Notification';
    final message = notification['message'] ?? '';
    final priority = notification['priority'] ?? 'normal';
    final time = notification['time'];

    return Card(
      color: Colors.grey[100],
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              priority == 'high' ? Colors.red : SColors.primary,
          child: Icon(
            _getIconForAlert(title, priority),
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Text(
          message,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
          ),
        ),
        trailing: Text(
          _formatTime(time),
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.grey,
          ),
        ),
        onTap: () {
          // Add navigation or action here if needed
          print("Notification tapped: $title");
        },
      ),
    );
  }
}
