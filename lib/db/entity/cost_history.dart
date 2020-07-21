import 'package:flutter/foundation.dart';

enum CostType { INCOME, EXPENSE }

class CostHistory {
  final int id;
  final CostType costType;
  final double amount;
  final String title;
  final String subtitle;
  final String createDate;
  final String iconPath;

  CostHistory(
      {@required this.id,
      @required this.costType,
      @required this.amount,
      @required this.title,
      @required this.subtitle,
      @required this.createDate,
      @required this.iconPath});

  static List<CostHistory> generateFakeData() {
    List<CostHistory> costHistories = [];
    costHistories.add(CostHistory(
        id: 0,
        costType: CostType.INCOME,
        amount: 25000.92,
        title: 'Salary',
        subtitle: 'company',
        createDate: DateTime(2020, 2, 10).toString(),
        iconPath: ''));
    costHistories.add(CostHistory(
        id: 1,
        costType: CostType.INCOME,
        amount: 25000.92,
        title: 'Salary',
        subtitle: 'company',
        createDate: DateTime(2020, 2, 11).toString(),
        iconPath: ''));
    costHistories.add(CostHistory(
        id: 2,
        costType: CostType.INCOME,
        amount: 25000.92,
        title: 'Salary',
        subtitle: 'company',
        createDate: DateTime(2020, 2, 10).toString(),
        iconPath: ''));
    costHistories.add(CostHistory(
        id: 3,
        costType: CostType.INCOME,
        amount: 25000.92,
        title: 'Salary',
        subtitle: 'company',
        createDate: DateTime(2020, 2, 10).toString(),
        iconPath: ''));

    costHistories.add(CostHistory(
        id: 4,
        costType: CostType.EXPENSE,
        amount: 299.12,
        title: 'Rest',
        subtitle: 'Park',
        createDate: DateTime(2020, 1, 20).toString(),
        iconPath: ''));

    costHistories.add(CostHistory(
        id: 5,
        costType: CostType.EXPENSE,
        amount: 299.12,
        title: 'Rest',
        subtitle: 'Park',
        createDate: DateTime(2020, 1, 20).toString(),
        iconPath: ''));
    costHistories.add(CostHistory(
        id: 6,
        costType: CostType.EXPENSE,
        amount: 299.12,
        title: 'Rest',
        subtitle: 'Park',
        createDate: DateTime(2020, 1, 21).toString(),
        iconPath: ''));
    costHistories.add(CostHistory(
        id: 7,
        costType: CostType.EXPENSE,
        amount: 299.12,
        title: 'Rest',
        subtitle: 'Park',
        createDate: DateTime(2020, 1, 22).toString(),
        iconPath: ''));
    costHistories.add(CostHistory(
        id: 8,
        costType: CostType.EXPENSE,
        amount: 299.12,
        title: 'Rest',
        subtitle: 'Park',
        createDate: DateTime(2020, 1, 22).toString(),
        iconPath: ''));
    costHistories.add(CostHistory(
        id: 9,
        costType: CostType.EXPENSE,
        amount: 299.12,
        title: 'Rest',
        subtitle: 'Park',
        createDate: DateTime(2020, 1, 20).toString(),
        iconPath: ''));
    costHistories.add(CostHistory(
        id: 10,
        costType: CostType.EXPENSE,
        amount: 299.12,
        title: 'Rest',
        subtitle: 'Park',
        createDate: DateTime(2020, 1, 24).toString(),
        iconPath: ''));

    return costHistories;
  }
}
