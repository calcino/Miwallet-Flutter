import 'package:floor/floor.dart';

@DatabaseView(
    'SELECT categoryId,isIncome,categoryName,dateTime,categoryHexColor, sum(amount) as amountSum '
    'FROM AccountTransactionView GROUP BY categoryId',
    viewName: 'TransactionGroupedByCategory')
class TransactionGroupedByCategory {
  final int categoryId;
  final double amountSum;
  final String dateTime;
  final String categoryHexColor;
  final bool isIncome;
  final String categoryName;

  TransactionGroupedByCategory(this.categoryId, this.amountSum,
      this.categoryHexColor, this.dateTime, this.isIncome, this.categoryName);

  @override
  String toString() {
    return 'TransactionGroupedByCategory: {categoryId: $categoryId,'
        ' amountSum: $amountSum,dateTime: $dateTime,categoryHexColor: $categoryHexColor}';
  }
}
