import 'package:flutter/material.dart';
import 'package:flutter_mvvm2_explore/screens/news_screen.dart';
import 'package:flutter_mvvm2_explore/viewmodels/news_article_list_view_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffFEFDFD),
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
                color: Colors.yellow, //your color
                brightness: Brightness.light,
                elevation: 0,
                textTheme: const TextTheme(
                    headline6: TextStyle(
                        color: Colors.white, //your color
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => NewsArticleListViewModel(),
            )
          ],
          child: NewsScreen(),
        ));
  }
}
