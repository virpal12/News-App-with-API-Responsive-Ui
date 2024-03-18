import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as httpClient;
import 'package:intl/intl.dart';
import 'package:news2/Screens/NEWS_VIEW.dart';
import '../Model/News_Model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final format = DateFormat('MMMM dd, yyyy');

  Future<NewsModel> fetchNews() async {
    var url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=d9e677489a0b40939a0f640154c66cf9";
    var response = await httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log(response.body);

      var result = jsonDecode(response.body);

      return NewsModel.fromJson(result);
    } else {
      log('error');
      return NewsModel();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
    format;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.more_vert),
          )
        ],
        leading: IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/category_icon.png',
              height: 30,
              width: 30,
            )),
        title: Text(
          'News',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(children: [
        SizedBox(
          height: height * .6,
          width: width,
          child: FutureBuilder(
            future: fetchNews(),
            builder: (context, snapshot) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    DateTime dateTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString());
                    return SizedBox(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => News_View(
                                      author: snapshot
                                          .data!.articles![index].author!,
                                      desc: snapshot
                                          .data!.articles![index].description!,
                                      title: snapshot
                                          .data!.articles![index].title!,
                                      imgUrl: snapshot
                                          .data!.articles![index].urlToImage!),
                                ),
                              );
                            },
                            child: Container(
                              height: height * .5,
                              width: width * .9,
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * .02),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                          child: spinkit2,
                                        ),
                                    errorWidget: (context, url, error) => Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        )),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => News_View(
                                        author: snapshot
                                            .data!.articles![index].author!,
                                        desc: snapshot.data!.articles![index]
                                            .description!,
                                        title: snapshot
                                            .data!.articles![index].title!,
                                        imgUrl: snapshot.data!.articles![index]
                                            .urlToImage!),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 7,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  height: height * 0.25,
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width * 0.7,
                                        height: height * 0.2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          format.format(dateTime).toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        ),
      ]),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
