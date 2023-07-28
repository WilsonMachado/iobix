import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './iskra_mt174_tab_controller.dart';
import '../../../../widgets/default_card.dart';

class IskraMt174TabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<IskraMt174TabController>(
        builder: (_) => RefreshIndicator(
              onRefresh: _.bleApiDataReport,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    DefaultCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
