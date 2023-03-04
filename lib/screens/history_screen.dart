// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojt_timelogs/core/widget/core_loading_animation.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({
    super.key,
    required this.currentInternName,
  });

  final String currentInternName;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  bool isCellSelected = false;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> currentInterStream = FirebaseFirestore.instance
        .collection(widget.currentInternName)
        .doc('time-in-and-out-records')
        .collection('records')
        .orderBy('time-in', descending: true)
        .snapshots();

    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.7,
        child: StreamBuilder<QuerySnapshot>(
          stream: currentInterStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                  child: Text('S O M E T H I N G  W E N T  W R O N G.'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: coreLoadingAnimationWidget());
            }

            final currentUserData = snapshot.data!.docs;
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) => SingleChildScrollView(
                child: DataTable(
                  headingRowHeight: 40,
                  headingRowColor:
                      MaterialStatePropertyAll(Colors.grey.shade200),
                  columns: const [
                    DataColumn(
                      label: Expanded(
                        child: Center(
                          child: Text(
                            'Name',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Center(
                          child: Text(
                            'Time In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Center(
                          child: Text(
                            'Time Out',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                  rows: [
                    for (var loopCount = 0;
                        loopCount < currentUserData.length;
                        loopCount++)
                      DataRow(
                        cells: [
                          DataCell(
                            Center(
                              child: Text(
                                currentUserData[loopCount]['intern-name'],
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: Text(
                                currentUserData[loopCount]['time-in']
                                    .toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: Text(
                                currentUserData[loopCount]['time-out']
                                    .toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
