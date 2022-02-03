import 'package:cloud_firestore/cloud_firestore.dart';

class NewsList {
  late List<News> newsList;

  NewsList({
    required this.newsList,
  });

  factory NewsList.fromDocument(QuerySnapshot snapshot) {
    List<News> newsList = [];

    for (var news in snapshot.docs) {
      Map getDocs = news.data() as Map;
      newsList.add(News.fromDocument(getDocs));
    }

    return NewsList(newsList: newsList);
  }
}

class News {
  late String date;
  late String url;
  late String title;
  late String pubCompany;
  late String reporter;

  News({
    required this.date,
    required this.url,
    required this.title,
    required this.pubCompany,
    required this.reporter,
  });

  factory News.fromDocument(Map doc) {
    return News(
      date: doc['date'],
      url: doc['url'],
      title: doc['title'],
      pubCompany: doc['publishing_company'],
      reporter: doc['reporter'],
    );
  }
}
