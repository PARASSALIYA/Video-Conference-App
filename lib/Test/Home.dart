import 'package:flutter/material.dart';
import 'package:video_conference_app/Test/history_screen.dart';
import 'package:video_conference_app/Test/personal_screen.dart';
import 'package:video_conference_app/Test/recurring_screen.dart';

class MeetingScreen extends StatefulWidget {
  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:
            const Text("Meetings", style: const TextStyle(color: Colors.black)),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(icon: Icon(Icons.video_call), text: "Meeting"),
            Tab(icon: Icon(Icons.history), text: "History"),
            Tab(icon: Icon(Icons.repeat), text: "Recurring"),
            Tab(icon: Icon(Icons.person), text: "Personal"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MeetingTab(),
          HistoryScreen(),
          RecurringScreen(),
          PersonalScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.video_call), label: "Meeting"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: "Wallet"),
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts), label: "Contacts"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}

class MeetingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MeetingCard(
            time: "12:00",
            host: "Kim",
            description: "Project V1.0 review meeting"),
        MeetingCard(
            time: "14:00", host: "John", description: "Sprint planning"),
        MeetingCard(
            time: "16:00", host: "Alex", description: "Team retrospective"),
        MeetingCard(
            time: "18:00",
            host: "Sarah",
            description: "Marketing strategy session"),
      ],
    );
  }
}

class MeetingCard extends StatelessWidget {
  final String time;
  final String host;
  final String description;

  MeetingCard(
      {required this.time, required this.host, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.videocam, color: Colors.blue),
        title: Text("$time - $host"),
        subtitle: Text(description),
        trailing: ElevatedButton(
          onPressed: () {
            // Add your join functionality here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text("Join"),
        ),
      ),
    );
  }
}
