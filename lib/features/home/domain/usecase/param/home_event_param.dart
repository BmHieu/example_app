class HomeEventParam {
  final int categoryId;
  final int page;
  const HomeEventParam({
    required this.categoryId,
    required this.page,
  });

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'page': page,
    };
  }
}
