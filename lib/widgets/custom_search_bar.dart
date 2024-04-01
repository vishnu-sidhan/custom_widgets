import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final class CustomSearchBar extends CustomInputWidget<RxString, String> {
  const CustomSearchBar({super.key, String name = '', this.elevation})
      : super("$name custom search bar");

  final double? elevation;

  TextEditingController get _textController =>
      controller.textController ??= TextEditingController();

  void _onChange([String v = '']) {
    if (v == '') _textController.clear();
    value = v;
    editable = value != '';
  }

  @override
  Widget build(BuildContext context) {
    editable = false;
    return SearchBar(
      elevation: MaterialStatePropertyAll(elevation),
      hintText: "Search ${labelText.split("custom search bar").first}",
      leading: const Icon(Icons.search),
      controller: _textController,
      onChanged: _onChange,
      trailing: [
        RxIconButtonOnBool(controller.editable,
            onPressed: _onChange, onTrue: Icons.close)
      ],
    );
  }
}

class CustomAppBarSearch extends SearchDelegate<String?> {
  CustomAppBarSearch(this.searchterms, {Key? key});
  List<String> searchterms;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (String value in searchterms) {
      if (value.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(value);
      }
    }
    return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: matchQuery.length,
        itemBuilder: (context, index) => ListTile(
              title: Text(matchQuery[index]),
              onTap: () => close(context, matchQuery[index]),
            ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    if (query != '') {
      for (String value in searchterms) {
        if (value.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(value);
        }
      }
    }
    return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: matchQuery.length,
        itemBuilder: (context, index) => ListTile(
              title: Text(matchQuery[index]),
              onTap: () => close(context, matchQuery[index]),
            ));
  }
}
