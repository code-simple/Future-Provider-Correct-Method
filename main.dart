import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //!   Correct method of Using
    //!   FutureProvider through ChangeNotifierProvider

    return ChangeNotifierProvider<MyModel>(
        create: (_) => MyModel(someValue: 'new data'),
        child: Consumer<MyModel>(builder: (context, foo, child) {
          return FutureProvider.value(
            value: someAsyncFunctionToGetMyModel(),
            child: MaterialApp(
              home: Scaffold(
                appBar: AppBar(title: Text('My App')),
                body: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 100,
                      color: Colors.blue,
                      child: Text(foo.someValue),
                    ),
                    Container(
                      child: RaisedButton(
                        onPressed: () => foo.doSomething(),
                        child: Text('Press'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}

Future<MyModel> someAsyncFunctionToGetMyModel() async {
  //  <--- async function
  await Future.delayed(Duration(seconds: 3));
  return MyModel(someValue: '');
}

class MyModel with ChangeNotifier {
  //                                               <--- MyModel
  MyModel({this.someValue});
  String someValue;
  Future<void> doSomething() async {
    await Future.delayed(Duration(seconds: 2));
    someValue = 'Goodbye';
    notifyListeners();                    // Important to alert Notifiier of changes.
  }
}
