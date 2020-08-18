import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/strings.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 360,height: 640);
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        backgroundColor: Colors.white,
        body: _body(),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        Strings.aboutUs,
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenUtil().setSp(20),
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Column(
      children: [
        _logoAboutUs(),
        _descriptionAboutUs()
      ],
    );
  }

  Widget _logoAboutUs(){
    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(24),
      ),
      height: ScreenUtil().setHeight(116),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: ColorRes.blueColor,
              height: ScreenUtil().setHeight(72),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image(
              image: AssetImage("assets/images/logo_about.png"),
              width: ScreenUtil().setHeight(88),
              height: ScreenUtil().setHeight(88),
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }

  Widget _descriptionAboutUs(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(27),),
        child: Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Egestas purus viverra accumsan in nisl nisi. Arcu cursus vitae congue mauris rhoncus aenean vel elit scelerisque. In egestas erat imperdiet sed euismod nisi porta lorem mollis. Morbi tristique senectus et netus. Mattis pellentesque id nibh tortor id aliquet lectus proin. Sapien faucibus et molestie ac feugiat sed lectus vestibulum. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa eget. Dictum varius duis at consectetur lorem. Nisi vitae suscipit tellus mauris a diam maecenas sed enim. Velit ut tortor pretium viverra suspendisse potenti nullam. Et molestie ac feugiat sed lectus. Non nisi est sit amet facilisis magna. Dignissim diam quis enim lobortis scelerisque fermentum. Odio ut enim blandit volutpat maecenas volutpat. Ornare lectus sit amet est placerat in egestas erat. Nisi vitae suscipit tellus mauris a diam maecenas sed. Placerat duis ultricies lacus sed turpis tincidunt id aliquet.",
          textAlign: TextAlign.start,
          style: TextStyle(
            color: ColorRes.textColor,
            fontSize: ScreenUtil().setSp(14),
          ),
        ),
      ),
    );
  }
}
