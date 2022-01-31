class Mission {
  late int point;
  late String title;
  late String info;
  late bool weekCheck;

  Mission({
    required this.point,
    required this.title,
    required this.info,
    required this.weekCheck,
  });

  factory Mission.fromDocument(Map getDocs) {
    return Mission(
      point: getDocs['point'],
      title: getDocs['title'],
      info: getDocs['info'],
      weekCheck: getDocs['week_check'],
    );
  }
}
