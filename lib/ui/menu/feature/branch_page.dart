import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibank_emoney/core/constants/constants.dart';
import 'package:ibank_emoney/core/constants/size.dart';
import 'package:ibank_emoney/core/constants/space.dart';
import 'package:ibank_emoney/core/theme/color.dart';
import 'package:ibank_emoney/core/theme/style.dart';
import 'package:ibank_emoney/ui/widgets/app_bar.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final DraggableScrollableController _sheetController = DraggableScrollableController();
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  bool isExpanded = false;

  final LatLng currentLoc = LatLng(-6.200000, 106.816666);

  final List<Map<String, dynamic>> dummyMarkers = [
    {"name": "Monas", "point": LatLng(-6.175392, 106.827153)},
    {"name": "Kota Tua", "point": LatLng(-6.135200, 106.813301)},
    {"name": "Ragunan Zoo", "point": LatLng(-6.303500, 106.820300)},
    {"name": "Taman Mini", "point": LatLng(-6.302000, 106.895000)},
    {"name": "Senayan City", "point": LatLng(-6.225014, 106.799116)},
  ];

  void _toggleSheet() {
    if (isExpanded) {
      _sheetController.animateTo(0.2, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      _sheetController.animateTo(0.6, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
    setState(() => isExpanded = !isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppBar(title: "Branch", primaryTheme: false, showBack: true),
      body: SafeArea(child: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    return Stack(children: [_map(context), _bottomSheet(context)]);
  }

  Widget _map(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.8,
      child: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: currentLoc, // Jakarta
              initialZoom: 12,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: "com.example.ibank_emoney",
              ),
              // marker current location
              MarkerLayer(
                markers: [
                  Marker(
                    point: currentLoc,
                    child: SvgPicture.asset("$iconPath/current_location.svg", width: iconSmall, height: iconSmall),
                  ),
                ],
              ),
              // marker location
              MarkerLayer(
                markers: dummyMarkers.map((data) {
                  return Marker(
                    point: data["point"] as LatLng,
                    child: Icon(Icons.location_on, size: iconSmall, color: VColor.primary1),
                  );
                }).toList(),
              ),
            ],
          ),
          // Custom attribution
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              color: VColor.neutral6,
              child: const Text("© OpenStreetMap contributors", style: TextStyle(fontSize: 11, color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomSheet(BuildContext context) {
    final latlng.Distance distance = latlng.Distance();
    return DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: 0.2,
      minChildSize: 0.2,
      maxChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginSuperSmall),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, -2))],
          ),
          child: Column(
            children: [
              // clickable drag handle
              GestureDetector(
                onTap: _toggleSheet,
                child: Container(
                  width: 40,
                  height: 6,
                  margin: const EdgeInsets.only(bottom: marginLarge - 6),
                  decoration: BoxDecoration(color: VColor.grey4Opacity, borderRadius: BorderRadius.circular(12)),
                ),
              ),

              _searchBar(),
              spaceVerticalMedium,

              // list scrollable
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(vertical: marginSmall),
                  separatorBuilder: (context, index) => Divider(thickness: 1, color: VColor.grey3, height: 0),
                  itemCount: dummyMarkers.length,
                  itemBuilder: (context, index) {
                    final marker = dummyMarkers[index];
                    final double meter = distance(currentLoc, marker["point"] as LatLng);

                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          final LatLng point = marker["point"] as LatLng;

                          _mapController.move(point, 14);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: marginSmall),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on, size: iconSmall, color: VColor.primary1),
                              spaceHorizontalSmall,
                              Expanded(child: Text(marker["name"], style: textBody1)),
                              spaceHorizontalSuperSmall,
                              Text(formatDistance(meter), style: caption1.copyWith(color: VColor.grey2)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _searchBar() {
    return TextField(
      controller: _searchController,
      style: textBody3,
      decoration: InputDecoration(
        hintText: "Search branch",
        hintStyle: textBody3.copyWith(color: VColor.neutral4),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(
            "$iconPath/search.svg",
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(VColor.neutral1, BlendMode.srcIn),
          ),
        ),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close, color: VColor.grey5),
                onPressed: () {
                  _searchController.clear();
                  setState(() {});
                },
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(radiusLarge))),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: VColor.neutral4), // ✅ border color normal
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: VColor.neutral4, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      onChanged: (value) {
        setState(() {}); // supaya suffixIcon update
      },
    );
  }

  String formatDistance(double meter) {
    if (meter >= 1000) {
      return "${(meter / 1000).toStringAsFixed(1)} km";
    } else {
      return "${meter.round()} m";
    }
  }
}
