import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  int _notificationsCount = 0;

  getNotificationCount() => _notificationsCount;

  loadNotificationCount() async {
    try {
      final QuerySnapshot qSnap = await FirebaseFirestore.instance
          .collection('userNotification')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('notifications')
          .where('isRead', isEqualTo: 'unread')
          .get();
      final int itemsCount = qSnap.docs.length;
      _notificationsCount = itemsCount;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  clearData() {
    _notificationsCount = 0;
    notifyListeners();
  }

  markRead(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('userNotification')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('notifications')
          .doc(id)
          .update({
        'isRead': 'read',
      });
      if (_notificationsCount > 0) {
        _notificationsCount -= 1;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
