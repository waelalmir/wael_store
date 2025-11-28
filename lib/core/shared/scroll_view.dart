import 'package:ecommerce/controller/scroll_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfiniteHorizontalList extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double spacing;
  final double height;
  final bool isAuto;

  const InfiniteHorizontalList(
      {super.key,
      required this.itemBuilder,
      required this.itemCount,
      this.spacing = 30,
      this.height = 120,
      this.isAuto = true});

  @override
  Widget build(BuildContext context) {
    final InfiniteScrollController controller =
        Get.put(InfiniteScrollController(), tag: UniqueKey().toString());
    controller.setAutoScroll(isAuto);

    controller.setup(itemCount);

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Listener(
            onPointerDown: (_) => controller.onUserDragStart(),
            onPointerUp: (_) => controller.onUserDragEnd(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                controller: controller.scroll,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final realIndex = index % itemCount;
                  return itemBuilder(context, realIndex);
                },
                separatorBuilder: (_, __) => SizedBox(width: spacing),
                itemCount: itemCount * 1000,
              ),
            ),
          ),
          Align(
            alignment: controller.lang == "ar"
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onTap: controller.scrollLeft,
              child: _arrowButton(Icons.arrow_back_ios),
            ),
          ),
          Align(
            alignment: controller.lang == "ar"
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: InkWell(
              onTap: controller.scrollRight,
              child: _arrowButton(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }

  Widget _arrowButton(IconData icon) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColor.thirdColor.withValues(alpha: 0.4),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
