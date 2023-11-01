class Pagination {
  final int page;
  final int size;
  final int totalhits;
  final int totalpages;
  final String? nextPage;

  Pagination(
      {required this.page,
      required this.size,
      required this.totalhits,
      required this.totalpages,
      this.nextPage});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'] as int,
      size: json['size'] as int,
      totalhits: json['totalhits'] as int,
      totalpages: json['totalpages'] as int,
      nextPage: json['nextpage'] as String?,
    );
  }
}
