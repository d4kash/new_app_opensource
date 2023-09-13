import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/constants/date_formatter.dart';
import 'package:news_app/constants/theme.dart';
import 'package:news_app/general_news/controller/get_news_controller.dart';
import 'package:news_app/general_news/models/news_model.dart';
import 'package:news_app/general_news/widgets/newsContainerWidget.dart';
import 'package:news_app/general_news/widgets/shimmerWIdget.dart';
import 'package:news_app/widgets/appBar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetNewsController controller = GetNewsController();

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    var data = await controller.fetchNews();
    newsCollection = newsModelFromJson(data);
    foundNews = newsCollection!
      ..sort((a, b) => b.publishedAt!.compareTo(a.publishedAt!));
    setState(() {});
  }

  RxBool isSearching = false.obs;
  List<NewsModel>? foundNews;
  List<NewsModel>? newsCollection;
  void _runFilter(String query) {
    if (query.isEmpty) {
      foundNews = newsCollection!
        ..sort((a, b) {
          return b.publishedAt!.compareTo(a.publishedAt!);
        });
    } else {
      foundNews = newsCollection!
          .where((news) =>
              news.title!.toLowerCase().contains(query.toLowerCase()) ||
              news.source!.name!
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(title: "Open News"),
        body: SafeArea(
      child: FutureBuilder(
        future: controller.fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.hasError ) {
            return const Text("Something went wrong");
          }
           

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null || foundNews==null) {
              return const ShimmerWidget();
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0, bottom: 8.0),
                      child: SizedBox(
                          height: Constant.height / 16,
                          width: Constant.width / 1.1,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller.searchController.value,
                                  // onChanged: (value) => _runFilter(value),
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    errorBorder: OutlineInputBorder(),
                                    border: OutlineInputBorder(),
                                    labelText: 'Search by Title or Source',
                                    hintText: 'Search \'Title\' or \'Source\'',
                                  ),
                                ),
                              ),
                              Obx(() => isSearching.value == true
                                  ? IconButton(
                                      onPressed: () {
                                        isSearching.value = false;
                                        controller.searchController.value
                                            .clear();
                                        _runFilter("");
                                      },
                                      icon: Icon(
                                        Icons.clear_rounded,
                                        size: Constant.height / 20,
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        isSearching.value = true;
                                        _runFilter(controller
                                            .searchController.value.text);
                                      },
                                      icon: Icon(
                                        Icons.search_rounded,
                                        size: Constant.height / 20,
                                      )))
                            ],
                          )),
                    ),
                    foundNews!.isEmpty
                        ? Center(
                            child: Text(
                              'No News for this \'${controller.searchController.value.text}\'',
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 20),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: foundNews!.length,
                                // itemExtent: 150,
                                itemBuilder: (context, index) {
                                  return NewsContainer(
                                    title: foundNews![index].title!,
                                    description: foundNews![index].description!,
                                    imageUrl:
                                        foundNews![index].urlToImage != null
                                            ? foundNews![index].urlToImage!
                                            : "",
                                    source: foundNews![index].source!.name!,
                                    timestamp: foundNews![index].publishedAt!,
                                  );
                                }),
                          ),
                  ],
                ),
              );
            }
          }

          return const ShimmerWidget();
        },
      ),
    ));
  }
}
