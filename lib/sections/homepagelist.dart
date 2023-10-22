import 'package:flutter/material.dart';
import 'package:whatapp/sections/SecondPage.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class HomepageListView extends StatefulWidget {
  const HomepageListView({Key? key}) : super(key: key);

  @override
  _HomepageListViewState createState() => _HomepageListViewState();
}

class _HomepageListViewState extends State<HomepageListView> {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  String _receivedData = 'No data received yet'; // Initial message

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      await pusher.init(
        apiKey: '64d7b7733dcd250c586b',
        cluster: 'ap2',
        onEvent: onEvent,
      );
      await pusher.subscribe(channelName: 'orders');
      await pusher.connect();
    } catch (e) {
      print('Error: $e');
    }
  }

  void onEvent(PusherEvent event) {
    if (event.eventName == 'new-order') {
      setState(() {
        _receivedData = event.data ?? 'No data received';
      });
    } else if (event.eventName == 'another-event-name') {
      // Handle 'another-event-name' event
      // ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: const Icon(Icons.list),
          trailing: const Text(
            "GFG",
            style: TextStyle(color: Colors.green, fontSize: 15),
          ),
          title: Text(_receivedData),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondPage()),
            );
          },
        );
      },
    );
  }
}
