import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  final TextEditingController _searchController;
  final void Function(String) _onSearch;

  const MySearchBar({
    super.key,
    required TextEditingController searchController,
    required void Function(String) onSearch,
  })  : _searchController = searchController,
        _onSearch = onSearch;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black.withOpacity(0.8)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextField(
            controller: _searchController,
            cursorColor: Colors.black.withOpacity(0.8),
            decoration: const InputDecoration(
              hintText: 'Введите новость',
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Color(0XFF8B8B8B),
                fontSize: 16.0,
              ),
            ),
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 16.0,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            _onSearch(_searchController.text);
          },
          color: const Color(0XFF8B8B8B),
        ),
      ],
    );
  }
}
