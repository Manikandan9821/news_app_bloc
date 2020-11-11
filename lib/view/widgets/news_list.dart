import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:news_app_bloc/logics/constant/constant.dart';
import 'package:news_app_bloc/logics/models/news_model.dart';
import 'package:news_app_bloc/view/screens/news_web_screen.dart';

class NewsList extends StatelessWidget {
  final NewsModel news;
  NewsList({@required this.news,});

  @override
  Widget build(BuildContext context) {
    print('---------List check ---------');
    return Expanded(
      child: ListView.builder(
        itemCount:  news.articles.length,
        itemBuilder: (context, i) {
          var formattedTime = DateFormat('dd MMM - HH:mm')
               .format( news.articles[i].publishedAt);
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => NewsWebScreen(
                        title:  news.articles[i].title,
                        url:  news.articles[i].url,
                      )));
            },
            child: AnimationConfiguration.staggeredList(
              position: i,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 150.0,
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 30.0, top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: borderRadius,
                          boxShadow: boxShadow,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        top: 30.0,
                        left: 20.0,
                         width: 200.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                news.articles[i].title,
                                textAlign: TextAlign.start,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                             news.articles[i].source.name,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                                Text(
                                  formattedTime,
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          top: 30.0,
                          right: 5.0,
                          child: news.articles[i].urlToImage != null
                              ? Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: borderRadius,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                news.articles[i].urlToImage,
                                ),
                              ),
                            ),
                          )
                              : Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.broken_image,
                                  size: 50.0,
                                  color: Colors.redAccent,
                                ),
                                Text(
                                  'No Image',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
