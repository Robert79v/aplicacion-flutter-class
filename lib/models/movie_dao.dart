class MovieDao{
  int? idMovie;
  String? nameMovie;
  String? time;
  String? dateRelease;
  
  // Constructor con parámetros nombrados
  MovieDao({this.idMovie, this.nameMovie, this.time, this.dateRelease});

  Map<String, dynamic> toMap(){
    return {
      'idMovie': idMovie,
      'nameMovie': nameMovie,
      'time': time,
      'dateRelease': dateRelease
    };
  }

  factory MovieDao.fromMap(Map<String, dynamic> map) {
    return MovieDao(
      idMovie: map['idMovie'],
      nameMovie: map['nameMovie'],
      time: map['time'],
      dateRelease: map['dateRelease']
    );
  }
}