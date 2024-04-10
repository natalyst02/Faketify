import 'package:flutter/material.dart';

import 'widget/search_input.dart';
import 'widget/search_title.dart';
import 'widget/suggest.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchTitle(),
                SearchInput(),
                const Suggest(),
                const SizedBox(height: 70)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
