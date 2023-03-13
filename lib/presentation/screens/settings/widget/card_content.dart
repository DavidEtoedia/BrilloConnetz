// ignore_for_file: public_member_api_docs, sort_constructors_first

class General {
  String title;

  General({
    required this.title,
  });
}

List<General> general = [
  General(
    title: "Change username",
  ),
  General(
    title: "Change password",
  ),
  // General(
  //   title: "Change email",
  // ),
];
