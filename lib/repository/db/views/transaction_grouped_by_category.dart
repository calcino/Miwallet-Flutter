import 'package:floor/floor.dart';

@DatabaseView(
    'SELECT categoryId,subcategoryId,subcategoryName,isIncome,categoryName,dateTime,categoryHexColor, sum(amount) as amountSum '
    'FROM AccountTransactionView GROUP BY categoryId',
    viewName: 'TransactionGroupedByCategory')
class TransactionGroupedByCategory {
  final int categoryId;
  final int subcategoryId;
  final String subcategoryName;
  final double amountSum;
  final String dateTime;
  final String categoryHexColor;
  final bool isIncome;
  final String categoryName;

  TransactionGroupedByCategory(
      this.categoryId,
      this.amountSum,
      this.categoryHexColor,
      this.dateTime,
      this.isIncome,
      this.categoryName,
      this.subcategoryId,
      this.subcategoryName);

  @override
  String toString() {
    return 'TransactionGroupedByCategory: {categoryId: $categoryId,'
        ' amountSum: $amountSum,dateTime: $dateTime,categoryHexColor: $categoryHexColor,'
        ' subcategoryId: $subcategoryId, subcategoryName: $subcategoryName}';
  }
}
