import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Addressandmap extends StatelessWidget {
  final double addressLat;
  final double addressLong;
  final String addressName;
  final String addressDetails;
  final void Function()? onPressMap;
  const Addressandmap(
      {super.key,
      required this.addressLat,
      required this.addressLong,
      required this.addressName,
      required this.addressDetails,
      this.onPressMap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Shipping Address",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                //  if (model.addressLat != null && model.addressLong != null)
                InkWell(
                  onTap: onPressMap,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColor.primeColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text("View Map",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const Divider(height: 15, thickness: 1),
            Text(addressName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(addressDetails),
            // if (model.addressLat != null && model.addressLong != null)
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(addressLat, addressLong),
                  initialZoom: 14.0,
                  interactionOptions:
                      const InteractionOptions(flags: InteractiveFlag.none),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.delivery',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(addressLat, addressLong),
                        width: 60,
                        height: 60,
                        child: const Icon(Icons.location_on,
                            color: Colors.red, size: 40),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
