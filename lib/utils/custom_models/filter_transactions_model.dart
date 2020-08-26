import '../../repository/db/entity/category.dart';
import '../../repository/db/entity/user.dart';
import '../../repository/db/entity/wallet.dart';
import 'date_range.dart';

class FilterTransactionModel {
  DateRange dateRange;
  Category category;
  Wallet wallet;
  double isIncome;
  User user;

  FilterTransactionModel(
      {this.dateRange,
      this.category,
      this.isIncome,
      this.user,
      this.wallet}){
    this.dateRange ??= DateRange();
  }

  @override
  String toString() {
    return 'FilterTransactionModel: {dateRange: $dateRange,category: $category'
        ', isIncome: $isIncome, user: $user,wallet: $wallet}';
  }
}
