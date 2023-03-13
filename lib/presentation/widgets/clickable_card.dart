import 'package:brillo_connetz/presentation/utils/app_color.dart';
import 'package:brillo_connetz/presentation/utils/space.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClickableCard extends HookConsumerWidget {
  final Function()? press;
  final String title;
  final bool islogOut;

  const ClickableCard(
      {super.key,
      required this.title,
      required this.press,
      this.islogOut = false});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: InkWell(
          onTap: press,
          child: Container(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 13, bottom: 13),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10,
                      spreadRadius: 2)
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5),
                          ),
                          Space(20),
                        ],
                      ),
                      const Space(6),
                    ],
                  ),
                  if (islogOut) ...[
                    const Icon(
                      Icons.logout_outlined,
                      size: 20,
                      color: Colors.black,
                    )
                  ] else ...[
                    const Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: Colors.orange,
                    )
                  ]
                ],
              ),
            ),
          ),
        ));
  }
}
