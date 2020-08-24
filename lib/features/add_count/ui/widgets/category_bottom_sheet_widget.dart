import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/features/add_count/logic/add_transaction_provider.dart';
import 'package:fluttermiwallet/features/home/logic/home_provider.dart';
import 'package:fluttermiwallet/repository/db/entity/category.dart';
import 'package:fluttermiwallet/repository/db/entity/subcategory.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/widgets/bottom_sheet_widget.dart';
import 'package:provider/provider.dart';

class ChooseCategoryBottomSheetWidget extends StatefulWidget {
  bool isCategory;
  final Function(dynamic) onTap;

  ChooseCategoryBottomSheetWidget({Key key, this.isCategory,this.onTap}) : super(key: key);
  @override
  _ChooseCategoryBottomSheetWidgetState createState() => _ChooseCategoryBottomSheetWidgetState();
}

class _ChooseCategoryBottomSheetWidgetState extends State<ChooseCategoryBottomSheetWidget> {
  String _hintText;
  String _addText;
  TextEditingController _nameController;
  AddTransactionProvider _provider;

  @override
  void initState() {
    _provider = Provider.of<HomeProvider>(context, listen: false).addTransactionProvider;
    _hintText =
    widget.isCategory ? Strings.chooseCategory : Strings.chooseSubCategory;
    _addText =
    widget.isCategory ? Strings.addNewCategory : Strings.chooseSubCategory;super.initState();
    _nameController = TextEditingController();
    if (widget.isCategory) {
      _provider.getAllCategory();
    } else {
      _provider.getAllSubCategory();
    }
  }
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: ScreenUtil().setHeight(550),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          categoryAppBar(_hintText, context),
          Selector<AddTransactionProvider, List<dynamic>>(
              selector: (_, provider) =>
              widget.isCategory ? provider.categories : provider.subCategories,
              builder: (_, data, __) {
                print('data : ${data.toString()}');
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length + 1,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? categoryListField(_addText, icon: Icons.add,
                          onTap: () {
                            Navigator.pop(context);
                            showModalBottomSheetWidget(
                                context, _addCategoryBtmSheet(widget.isCategory));
                          })
                          : categoryListField(
                          widget.isCategory
                              ? (data[index - 1] as Category)
                              .name
                              .toString()
                              : (data[index - 1] as Subcategory)
                              .name
                              .toString(), onTap: () {
                        widget.onTap(widget.isCategory
                            ? (data[index - 1] as Category)
                            : (data[index - 1] as Subcategory));
                        Navigator.pop(context);
                      });
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }

  _addCategoryBtmSheet(bool isCategory) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: ScreenUtil().setHeight(100),
        maxHeight: ScreenUtil().setHeight(550),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          categoryAppBar(Strings.addCategory, context,
              isBackable: true, hasDone: true, onTap: () {
                isCategory
                    ? _provider.insertCategory(
                  Category(
                    name: _nameController.text,
                    hexColor: "#ffff00",
                  ),
                )
                    : _provider.insertSubCategory(
                  Subcategory(
                    categoryId: 1,
                    name: _nameController.text,
                    hexColor: "#00ffff",
                  ),
                );
              }),
          _labelText(
              isCategory ? Strings.nameCategory : Strings.nameSubCategory,
              marginTop: 20,
              marginBottom: 6),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setHeight(36),
            ),
            child: TextField(
              controller: _nameController,
              style: TextStyle(
                color: ColorRes.hintColor,
                fontSize: ScreenUtil().setSp(12),
              ),
              maxLines: 1,
              decoration: InputDecoration(),
            ),
          ),
          _labelText(Strings.chooseAnIcon, marginTop: 15, marginBottom: 17),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setHeight(36),
              ),
              child: GridView.count(
                crossAxisCount: 6,
                children: List.generate(30, (index) => Icon(Icons.image)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _labelText(String label, {double marginTop, double marginBottom}) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(marginTop),
        bottom: ScreenUtil().setHeight(marginBottom),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setHeight(36),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: ColorRes.blueColor,
          fontSize: ScreenUtil().setSp(14),
        ),
      ),
    );
  }
}
