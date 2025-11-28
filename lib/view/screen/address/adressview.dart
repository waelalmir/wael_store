import 'package:ecommerce/controller/address/addressviewcontroller.dart';
import 'package:ecommerce/core/class/handlingdataview.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/shared/customappbar.dart';
import 'package:ecommerce/data/model/addressmodel.dart';
import 'package:ecommerce/view/screen/address/fluttermap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Adress extends StatelessWidget {
  const Adress({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Addressviewcontroller());
    return Scaffold(
      appBar: Customappbar(title: "Address"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => FlutterMapPage());
        },
        child: Icon(
          Icons.add,
          color: AppColor.textcolor,
        ),
      ),
      body: GetBuilder<Addressviewcontroller>(
        builder: (controller) {
          return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: ListView(
              children: [
                ...List.generate(
                  controller.data.length,
                  (index) => CardAddress(
                    addressModel: controller.data[index],
                    delete: () => controller.deleteAddress(
                      controller.data[index].addressId.toString(),
                    ),
                    text: "${controller.data[index].addressName}",
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CardAddress extends StatelessWidget {
  final AddressModel addressModel;

  final void Function()? delete;
  final String text;
  const CardAddress(
      {super.key, required this.text, this.delete, required this.addressModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(text),
            ),
          ),
          IconButton(onPressed: delete, icon: Icon(Icons.delete_outline))
        ],
      ),
    );
  }
}
