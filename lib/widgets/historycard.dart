// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/historymodel.dart';
import 'package:flutter_application_1/utils/colors.dart';

class HistoryCard extends StatefulWidget {
  final HistoryModel model;
  final bool showDate;
  const HistoryCard(this.model, {Key? key, this.showDate = true})
      : super(key: key);

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: mainColor.withOpacity(.3),
              blurRadius: 3,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.model.title +
                      (widget.model.parent != null
                          ? " (${widget.model.parent?.title}) "
                          : ""),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.showDate)
                      Text(
                        widget.model.date,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(.4),
                          fontSize: 13,
                        ),
                      )
                    else
                      Spacer(),
                    Text(
                      (widget.model.amount == 0
                              ? ""
                              : widget.model.isIncoming
                                  ? "+"
                                  : "-") +
                          " ${widget.model.amount}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: widget.model.isIncoming
                              ? mainColor
                              : Color.fromARGB(255, 220, 35, 22)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
