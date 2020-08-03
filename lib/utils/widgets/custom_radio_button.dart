import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RadioButton<T> extends StatelessWidget {
  final String description;
  final T value;
  final T groupValue;
  final void Function(T) onChanged;

  const RadioButton({
    @required this.description,
    @required this.value,
    @required this.groupValue,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {
      if(this.onChanged != null){
        this.onChanged(value);
      }
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<T>(
          groupValue: groupValue,
          onChanged: this.onChanged,
          value: this.value,
        ),
        Text(
          this.description,
          style: TextStyle(fontSize: ScreenUtil().setSp(10),),
        ),
      ],
    ),
  );
}