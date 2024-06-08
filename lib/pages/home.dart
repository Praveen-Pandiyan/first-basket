import 'package:first_basket/models/course.dart';
import 'package:first_basket/repo/courses_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _search = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<CoursesRepo>().getCourse(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        leading: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.grey,
        ),
        centerTitle: true,
        title: Image.asset("asset/academy_icon.jpg", height: 20),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: context.watch<CoursesRepo>().list.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: _search,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          context.read<CoursesRepo>().search(value);
                        }else{
                          context.read<CoursesRepo>().resetSearch();
                        }
                      },
                      decoration: const InputDecoration(label: Text("Search")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        ' Showing ${context.watch<CoursesRepo>().list.length} Courses',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    ...(context
                        .watch<CoursesRepo>()
                        .searchList??context
                        .watch<CoursesRepo>()
                        .list)
                        .map((e) => CourseCard(e)),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            context.read<CoursesRepo>().getCourse(
                                context.read<CoursesRepo>().list.length);
                          },
                          child: const Text("Load More")),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course data;
  const CourseCard(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).dialogBackgroundColor),
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            data.image!,
            fit: BoxFit.contain,
            width: MediaQuery.sizeOf(context).width * .2,
            height: MediaQuery.sizeOf(context).width * .2,
          ),
          const SizedBox(width: 3),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${data.title}", softWrap: true),
                const SizedBox(height: 5),
                Text(
                  "${data.category}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RatingStars(
                      editable: false,
                      rating: data.rating!.rate!.toDouble(),
                      color: Colors.amber,
                      iconSize: 14,
                    ),
                    Text("(${data.rating!.rate!}) (${data.rating!.count!})"),
                    const Spacer(),
                    Text("\$${data.price}")
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
