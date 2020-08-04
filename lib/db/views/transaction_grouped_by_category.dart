import 'package:floor/floor.dart';

@DatabaseView(
    'SELECT categoryId,dateTime,categoryHexColor, sum(amount) as amountSum '
        'FROM AccountTransactionView GROUP BY categoryId',
    viewName: 'TransactionGroupedByCategory')
class TransactionGroupedByCategory {
  final int categoryId;
  final double amountSum;
  final String dateTime;
  final String categoryHexColor;

  TransactionGroupedByCategory(
      this.categoryId, this.amountSum, this.categoryHexColor, this.dateTime);

  @override
  String toString() {
    return 'TransactionGroupedByCategory: {categoryId: $categoryId,'
        ' amountSum: $amountSum,dateTime: $dateTime,categoryHexColor: $categoryHexColor}';
  }
}
