import 'package:flutter/material.dart';


class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearch;

  SearchBarWidget({required this.onSearch});

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: 'Search news',
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              widget.onSearch(_searchController.text);
            },
          ),
        ),
        onSubmitted: (value) {
          widget.onSearch(value);
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
