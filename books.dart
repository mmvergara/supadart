class Books {
  int id;
  String book_name;
  String created_at;
  String? book_description;
  bool sold;
  int price;

  Books({
    required this.id,
    required this.book_name,
    required this.created_at,
    this.book_description,
    required this.sold,
    required this.price,
  });

  static String get table_name => 'books';
  static Map<String, dynamic> insert({
    int? id,
    required String book_name,
    String? created_at,
    String? book_description,
    bool? sold,
    required int price,
  }) {
    return {
      if (id != null) 'id': id,
      'book_name': book_name,
      if (created_at != null) 'created_at': created_at,
      if (book_description != null) 'book_description': book_description,
      if (sold != null) 'sold': sold,
      'price': price,
    };
  }

  static Map<String, dynamic> update({
    int? id,
    String? book_name,
    String? created_at,
    String? book_description,
    bool? sold,
    int? price,
  }) {
    return {
      if (id != null) 'id': id,
      if (book_name != null) 'book_name': book_name,
      if (created_at != null) 'created_at': created_at,
      if (book_description != null) 'book_description': book_description,
      if (sold != null) 'sold': sold,
      if (price != null) 'price': price,
    };
  }
}
