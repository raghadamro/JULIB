import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:julib/model/studyroom_model.dart';

import '../../helper/app_colors.dart';

class TableWidget extends StatelessWidget {
  List<Tabel> studyRoom;
  int tableIndex;

  TableWidget({Key? key, required this.studyRoom, required this.tableIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: Get.height * 0.04,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            GridView.builder(
                shrinkWrap: false,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.2,
                  mainAxisSpacing: 0.2,
                ),
                itemCount: studyRoom[tableIndex].seats?.length ?? 0,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: studyRoom[tableIndex].seats![index].status ==
                                "UnAvailable"
                            ? AppColors.red
                            : studyRoom[tableIndex].seats![index].status ==
                                    "Waiting"
                                ? AppColors.lightOrange
                                : AppColors.mainColor,
                      ),
                    ),
                  );
                }),
            Align(
                alignment: Alignment.center,
                child: Container(
                  height: Get.height * 0.15,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.4),
                  child: Center(
                    child: Text(
                      "${studyRoom[tableIndex].number}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )),
          ],
        ));
  }
}
