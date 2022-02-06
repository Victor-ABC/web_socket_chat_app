import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

import 'message.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'WebSocket Demo';
    return const MaterialApp(
      title: title,
      home: MyHomePage(
        title: title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String joke = "";
  String author = "";
  TextEditingController _authorcontroller =
      new TextEditingController(text: "default_name");
  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(
    Uri.parse('ws://10.0.2.2:3000/'),
  );
  List<String> chat = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            renderJoke(),
            renderSetUsernameButton(),
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                chat.add(snapshot.hasData ? '${snapshot.data}' : '');
                return Center(
                  child: Column(
                    children: [
                      Text("###Chat###"),
                      ...(chat as List<String>).map((anserText) {
                        return new Message(anserText, Colors.lightGreenAccent);
                      }).toList(),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(author + _controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }

  Widget renderSetUsernameButton() {
    return ElevatedButton(
        onPressed: () {
          showDialog(context: context, builder: (context) => AlertDialog(
            title: Text('Username auswählen'),
                    content: Column(
                      children: <Widget>[
                        new TextField(
                          controller: _authorcontroller,
                        ),
                        new RaisedButton(
                          onPressed: () {
                            _authorcontroller.clear();
                          },
                          child: new Text('CLEAR'),
                        ),
                new RaisedButton(
                  onPressed: () {
                    author = _authorcontroller.text;
                    Navigator.pop(context, true);
                          },
                          child: new Text('SAVE'),
                        ),
                      ],
                    ),
                  ));
        },
        child: Text("set Username"));
  }

  Widget renderJoke() {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2!,
      textAlign: TextAlign.center,
      child: FutureBuilder<String>(
        future: _getJoke(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return Text(this.joke);
        },
      ),
    );
  }

  Future<String> _getJoke() async {
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', '/users'));
    this.joke = response.body;
    return response.body;
  }
}
