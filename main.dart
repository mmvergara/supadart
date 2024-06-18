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

void main() {
  print(Books.table_name);
  // "books"
  // ========================

  final insert = Books.insert(
    book_name: 'Book Name',
    book_description: 'Description',
    price: 2,
  );
  print(insert);
  // {book_description: Description, book_name: Book Name}

  final insert_many = [
    Books.insert(
      book_name: 'Book Name',
      book_description: 'Description',
      price: 2,
    ),
    Books.insert(
      book_name: 'Book Name 2',
      created_at: DateTime.now().toString(),
      price: 2,
    ),
  ];
  print(insert_many);
  // [
  //  {book_description: Description, book_name: Book Name},
  //  {book_name: Book Name 2, created_at: 2021-10-10 00:00:00.000}
  // ]

  final update = Books.update(
    book_description: 'Description',
    book_name: 'Book Name',
    created_at:
        DateTime.parse('2021-10-10').toString(), // Corrected to DateTime
    id: 1,
  );
  print(update);
  // {book_description: Description, book_name: Book Name, created_at: 2021-10-10 00:00:00.000, id: 1}
  // ========================
}
