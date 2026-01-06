class PaginationListModel<T> {
  final int totalNumberOfResult;
  final List<T> listOfObjects;

  PaginationListModel({required this.totalNumberOfResult, required this.listOfObjects});
}
