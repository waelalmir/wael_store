import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/class/functions/responsive.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/data/model/cartmodel.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final CartModel model;
  final Responsive r;
  final String name;
  final String price;
  final String count;
  final String imagename;
  final void Function()? onAdd;
  final void Function()? onRemove;
  const CartItem(
      {super.key,
      required this.r,
      required this.name,
      required this.price,
      required this.count,
      required this.imagename,
      this.onAdd,
      this.onRemove,
      required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: r.height(8),
        horizontal: r.width(10),
      ),
      padding: EdgeInsets.all(r.padding(10)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r.width(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // ---------------- IMAGE ----------------
          ClipRRect(
            borderRadius: BorderRadius.circular(r.width(12)),
            child: CachedNetworkImage(
              imageUrl: imagename,
              height: r.height(80),
              width: r.width(80),
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: r.width(12)),

          // ---------------- TITLE + PRICE ----------------
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "cairo",
                    fontWeight: FontWeight.w600,
                    fontSize: r.font(15),
                  ),
                ),
                SizedBox(height: r.height(5)),
                Text(
                  "$price \$",
                  style: TextStyle(
                    color: AppColor.primeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: r.font(14),
                  ),
                ),
              ],
            ),
          ),

          // ---------------- + COUNT – ----------------
          Row(
            children: [
              // remove button
              GestureDetector(
                onTap: onRemove,
                child: Container(
                  padding: EdgeInsets.all(r.padding(6)),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.remove, size: r.icon(18)),
                ),
              ),

              SizedBox(width: r.width(10)),

              Text(
                count,
                style: TextStyle(
                  fontSize: r.font(16),
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(width: r.width(10)),

              // add button
              GestureDetector(
                onTap: onAdd,
                child: Container(
                  padding: EdgeInsets.all(r.padding(6)),
                  decoration: BoxDecoration(
                    color: AppColor.primeColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, size: r.icon(18), color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
