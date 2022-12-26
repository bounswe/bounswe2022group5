import 'package:bounswe5_mobile/API_service.dart';
import 'package:flutter/material.dart';
import 'package:bounswe5_mobile/models/user.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
import 'package:bounswe5_mobile/models/category.dart';

ApiService apiService = ApiService();

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key, required User this.activeUser})
      : super(key: key);
  final User activeUser;
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: apiService.getAllCategories(widget.activeUser.token),
      builder: (context,snapshot) {
        if(snapshot.hasData){

          List<Category> categories = snapshot.data!;
          return Scaffold(
            appBar: myAppBar,
            body: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index){
                return CategoryItem(category: categories[index],userToken: widget.activeUser.token,);
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),

          );
        }
        else{
          return Scaffold(
            appBar: myAppBar,
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

      }
    );
  }
}


class CategoryItem extends StatefulWidget {
  const CategoryItem({Key? key, required this.category, required this.userToken}) : super(key: key);

  final Category category;
  final String userToken;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool? isFollowed;

  @override
  void initState() {
    super.initState();
    isFollowed = widget.category.isFollowed;
  }

  @override
  Widget build(BuildContext context){
    String name = widget.category.name;

    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          )
      ),
      height: 60,
      margin: const EdgeInsets.all(2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            width: MediaQuery.of(context).size.width * 0.65,
            child: Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          isFollowed! ?
          TextButton(
            onPressed: () async {
              int statusCode = await apiService.followOrUnfollowCategory(widget.userToken, widget.category.id);
              setState((){
                if(statusCode == 200){
                  isFollowed = !(isFollowed!);
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("An error occured. Error code: $statusCode"),
                    )
                  );
                }
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text("Followed"),
          ) : TextButton(
            onPressed: ()async {
              int statusCode = await apiService.followOrUnfollowCategory(widget.userToken, widget.category.id);
              setState((){
                if(statusCode == 200){
                  isFollowed = !(isFollowed!);
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("An error occured. Error code: $statusCode"),
                  )
                  );
                }
              });
            },
            child: const Text("Follow"),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}


