import 'package:flutter/material.dart';
import 'package:image_search_app_01/data/model/image_item.dart';
import 'package:image_search_app_01/data/repository/image_item_repository.dart';
import 'package:image_search_app_01/ui/widget/image_item_widget.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final searchTextEditingController = TextEditingController();

  final repository = PixabayImageItemRepository();

  List<ImageItem> imageItems = [];
  bool isLoading = true;

  Future<void> searchImage(String query) async {
    setState(() {
      isLoading = true;
    });
    imageItems = await repository.getImageItems(query);
    //강제  UI 업데이트
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              TextField(
                controller: searchTextEditingController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 2,
                      color: Color(0xFF4Fb6B2),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 2,
                      color: Color(0xFF4Fb6B2),
                    ),
                  ),
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Color(0xFF4Fb6B2),
                    ),
                    onPressed: () => searchImage(
                      searchTextEditingController.text,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              isLoading ? const Center(child: CircularProgressIndicator())
              : Expanded(
                child: GridView.builder(
                  itemCount: imageItems.length,
                  itemBuilder: (context, index) {
                    final imageItem = imageItems[index];
                    return ImageItemWidget(
                      imageItem: imageItem,
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 32,
                    mainAxisSpacing: 32,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
