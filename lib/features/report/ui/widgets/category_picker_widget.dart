import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/dimen.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/extentions/color_extentions.dart';
import 'package:fluttermiwallet/utils/widgets/loading_widget.dart';

import '../../../../repository/db/entity/category.dart';
import '../../../../utils/widgets/bottom_sheet_widget.dart';

class CategoryPickerWidget extends StatelessWidget {
  final Future<List<Category>> categories;

  const CategoryPickerWidget(this.categories);

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
          _headerWidget(context),
          Expanded(
            child: FutureBuilder<List<Category>>(
                future: categories,
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return _buildDataList(snapshot.data);
                  } else {
                    return LoadingWidget();
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget _headerWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(60),
      alignment: Alignment.center,
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      decoration: BoxDecoration(
          color: ColorRes.blueColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(ScreenUtil().setWidth(20)),
              topLeft: Radius.circular(ScreenUtil().setWidth(20)))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(
            Strings.category,
            style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(DimenRes.normalText)),
          ),
        ],
      ),
    );
  }

  Widget _buildDataList(List<Category> categories) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return categoryListField(categories[index].name,
              icon: Icons.image,
              color: ColorExtentions.fromHex(code: categories[index].hexColor),
              onTap: () {
            Navigator.pop(context, categories[index]);
          });
        },
      ),
    );
  }
}
