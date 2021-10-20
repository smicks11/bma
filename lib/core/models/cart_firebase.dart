class FirebaseCart{
  final List<ModelCart> cartModel;

  FirebaseCart({this.cartModel});
}

class ModelCart{
  final String image;
  final String name;
  final String location;

  ModelCart({this.image, this.name, this.location});
}