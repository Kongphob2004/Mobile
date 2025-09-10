import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/config/internel_config.dart';
import 'package:flutter_application_1/pages/trip.dart';
import 'package:flutter_application_1/response/trip_get_res.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/pages/profile.dart';

class ShowtripPage extends StatefulWidget {
  int cid = 0;
  ShowtripPage({super.key, required this.cid});

  @override
  State<ShowtripPage> createState() => _ShowtripPageState();
}

class _ShowtripPageState extends State<ShowtripPage> {
  String url = '';
  List<TripGetRes> tripGetResponses = [];
  List<TripGetRes> allTrips = [];
  late Future<void> loadData;

  @override
  void initState() {
    super.initState();
    loadData = getTrips();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
      getTrips();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการทริป'),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              log(value);
              if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(idx: 0)),
                );
              } else if (value == 'logout') {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: Text('ข้อมูลส่วนตัว'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('ออกจากระบบ'),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ปลายทาง"),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        FilledButton(
                          onPressed: () {
                            setState(() {
                              tripGetResponses = allTrips;
                            });
                          },
                          child: Text("ทั้งหมด"),
                        ),
                        FilledButton(
                          onPressed: () {
                            List<TripGetRes> asiaTrips = allTrips
                                .where(
                                  (trip) => trip.destinationZone == 'เอเชีย',
                                )
                                .toList();
                            setState(() {
                              tripGetResponses = asiaTrips;
                            });
                          },
                          child: Text("เอเชีย"),
                        ),
                        FilledButton(
                          onPressed: () {
                            List<TripGetRes> euroTrips = allTrips
                                .where(
                                  (trip) => trip.destinationZone == 'ยุโรป',
                                )
                                .toList();
                            setState(() {
                              tripGetResponses = euroTrips;
                            });
                          },
                          child: Text("ยุโรป"),
                        ),
                        FilledButton(
                          onPressed: () {
                            List<TripGetRes> aseanTrips = allTrips
                                .where(
                                  (trip) =>
                                      trip.destinationZone ==
                                      'เอเชียตะวันออกเฉียงใต้',
                                )
                                .toList();
                            setState(() {
                              tripGetResponses = aseanTrips;
                            });
                          },
                          child: Text("อาเซียน"),
                        ),
                        FilledButton(
                          onPressed: () {
                            List<TripGetRes> africaTrips = allTrips
                                .where(
                                  (trip) => trip.destinationZone == 'แอฟริกา',
                                )
                                .toList();
                            setState(() {
                              tripGetResponses = africaTrips;
                            });
                          },
                          child: Text("แอฟริกา"),
                        ),
                        FilledButton(
                          onPressed: () {
                            List<TripGetRes> thaiTrips = allTrips
                                .where(
                                  (trip) => trip.destinationZone == 'ประเทศไทย',
                                )
                                .toList();
                            setState(() {
                              tripGetResponses = thaiTrips;
                            });
                          },
                          child: Text("ไทย"),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: tripGetResponses
                        .map(
                          (trip) => Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    trip.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                        child: Image.network(
                                          trip.coverimage,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Container(
                                                  width: 120,
                                                  height: 120,
                                                  color: Colors.grey[300],
                                                  child: Icon(
                                                    Icons.broken_image,
                                                    color: Colors.grey,
                                                  ),
                                                );
                                              },
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("ประเทศ ${trip.country}"),
                                            SizedBox(height: 5),
                                            Text(
                                              "ระยะเวลา ${trip.duration} วัน",
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "ราคา ${trip.price} บาท",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: FilledButton(
                                                onPressed: () => gotoTrip(
                                                  trip.idx,
                                                ), // <- ใส่ onPressed ตรงนี้
                                                style: FilledButton.styleFrom(
                                                  backgroundColor: const Color(
                                                    0xFF8A6BA6,
                                                  ), // สีปุ่ม
                                                ),
                                                child: const Text(
                                                  "รายละเอียดเพิ่มเติม",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void gotoTrip(int idx) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Trippage(idx: idx)),
    );
  }

  Future<void> getTrips() async {
    var res = await http.get(Uri.parse('$API_ENDPOINT/trips'));
    log(res.body);
    tripGetResponses = tripGetResFromJson(res.body);
    allTrips = tripGetResFromJson(res.body);
    log(tripGetResponses.length.toString());
  }

  Future<void> zone(String zone) async {
    allTrips.clear();
    for (var trip in tripGetResponses) {
      if (trip.destinationZone == zone) {
        allTrips.add(trip);
      }
    }
    setState(() {});
  }
}
