// ignore_for_file: non_constant_identifier_names

class RequestHistoryList{
  final List<SubRequestHistory> sub;

  RequestHistoryList({this.sub});
}

class SubRequestHistory{
  final String clientEmail;
  final String clientName;
  final String ClientNumber;
  final DateTime timeOfRequest;
  final List<dynamic> ModelLocation;
  final List<dynamic> ModelName;
  final List<dynamic> ModelImage;

  SubRequestHistory({this.clientEmail, this.clientName, this.ClientNumber, this.timeOfRequest, this.ModelLocation, this.ModelName, this.ModelImage});
}

class SubLocation{
  final String location;

  SubLocation({this.location});
}
class SubName{
  final String name;

  SubName({this.name});
}
class SubImage{
  final String image;

  SubImage({this.image});
}