import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base/base_provider.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Selector<BaseProvider, bool>(
          selector: (_, provider) => provider.isLoading,
          builder: (_, isLoading, __) =>
              isLoading ? CircularProgressIndicator() : Container()),
    );
  }
}
