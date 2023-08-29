import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/posts_list_item.dart';
import 'posts_controller.dart';

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: Container(
        child: GetBuilder<PostsController>(
          init: PostsController(),
          builder: (controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container();

            // return ListView.builder(
            //   itemCount: controller.regionsList.length,
            //   itemBuilder: (context, index) => PostsListItem(
            //     region: controller.regionsList[index],
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
