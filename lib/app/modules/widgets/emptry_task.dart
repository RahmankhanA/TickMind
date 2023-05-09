import 'package:flutter/material.dart';
import 'package:ticmind/app/data/constant/assets_constant.dart';

class EmptyTaskWidget extends StatelessWidget {
  final bool isTextVisible;
  const EmptyTaskWidget({super.key, required this.isTextVisible});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5.2,
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  AssetsConstant.introFirstImage,
                  // color: Colors.white,
                  fit: BoxFit.fill,
                  // width: MediaQuery.of(context).size.width*1.5,
                  // height: MediaQuery.of(context).size.height*1.5 ,
                  scale: 1.0,
                ),
              ),
            ),
          ),
          isTextVisible
              ? const Positioned(
                  bottom: 50,
                  left: 60,
                  child: Text(
                    "Add Task For Today",
                    style: TextStyle(
                        // color: Theme.of(context).,
                        fontSize: 25),
                  ),
                )
              : const SizedBox(
                  height: 0,
                )
        ],
      ),
    );
  }
}
