import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PusherScreen(),
    );
  }
}

class PusherScreen extends StatefulWidget {
  @override
  _PusherScreenState createState() => _PusherScreenState();
}

class _PusherScreenState extends State<PusherScreen> {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  String _log = 'output:\n';
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
      // Handle 'your-event-name' event
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Pusher Channels Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Received Data: $_receivedData'), // Display received data here
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(_log),
            ),
          ],
        ),
      ),
    );
  }
}
