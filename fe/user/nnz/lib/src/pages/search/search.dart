import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/icon_data.dart';

import '../../components/search_form/no_result_search.dart';
import '../../components/search_form/popular_hash_tag.dart';
import '../../components/search_form/related_hash_tag.dart';
import '../../components/search_form/show_search_bar.dart';
import '../../controller/search_controller.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  final controller = Get.put(ShowSearchController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: iconData(
            icon: ImagePath.logo,
            size: 240,
          ),
          centerTitle: true,
        ),
        body: Obx(
          () => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.white,
                    child: const ShowSearchBar(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  controller.searchText.value.isEmpty
                      ? const PopularHashTag()
                      : Column(
                          children: [
                            RelatedHashTag(),
                            const SizedBox(
                              height: 32,
                            ),
                            // SearchShow(),
                            const SizedBox(
                              height: 10,
                            ),
                            NoResultSearch(),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
