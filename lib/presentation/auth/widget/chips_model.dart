// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:brillo_connetz/presentation/utils/app_image.dart';

class ChipContent {
  String name;
  String image;
  ChipContent({
    required this.name,
    required this.image,
  });
}

List<ChipContent> chipcontentList = [
  ChipContent(
    name: "Football",
    image: AppImage.americanFb,
  ),
  ChipContent(
    name: "Baseball",
    image: AppImage.baseball,
  ),
  ChipContent(
    name: "Basketball",
    image: AppImage.basketball,
  ),
  ChipContent(
    name: "Soccer",
    image: AppImage.soccer,
  ),
  ChipContent(
    name: "Tennis",
    image: AppImage.tennis,
  ),
];
