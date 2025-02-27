import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_fe/model/task_model.dart';
import 'package:flutter_fe/service/job_post_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CardSwiperController controller = CardSwiperController();
  List<TaskModel> tasks = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

//For Displaying the record (record functionality)
  Future<void> _fetchTasks() async {
    try {
      JobPostService jobPostService = JobPostService();
      List<TaskModel> fetchedTasks = await jobPostService.fetchAllJobs();

      print("Raw API Response: $fetchedTasks"); // Print entire response
      print(
          "Parsed tasks count: ${fetchedTasks.length}"); // Check if tasks are parsed

      setState(() {
        tasks = fetchedTasks;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching tasks: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          'Available Services',
          style:
              TextStyle(color: Color(0xFF0272B1), fontWeight: FontWeight.bold),
        )),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 35, top: 20),
                child: SizedBox(
                  width: 200,
                  child: TextField(
                    cursorColor: Color(0xFF0272B1),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Color(0xFFF1F4FF),
                        hintText: 'Search Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 0),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color(0xFF0272B1), width: 2))),
                  ),
                ),
              ),
            ),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : tasks.isEmpty
                    ? Center(child: Text("No available services"))
                    : SizedBox(
                        height: 450,
                        width: 350,
                        child: SizedBox(
                          height: 450,
                          width: 350,
                          child: CardSwiper(
                            allowedSwipeDirection: AllowedSwipeDirection.only(
                              left: true,
                              right: true,
                            ),
                            controller: controller,
                            cardsCount: tasks.length,
                            onSwipe:
                                (previousIndex, targetIndex, swipeDirection) {
                              if (swipeDirection == CardSwiperDirection.left) {
                                print("Swiped Left (Disliked)");
                              } else if (swipeDirection ==
                                  CardSwiperDirection.right) {
                                print("Swiped Right (Liked)");
                              }
                              return true;
                            },
                            cardBuilder: (context, index, percentThresholdX,
                                percentThresholdY) {
                              final task = tasks[index];
                              return Center(
                                child: SizedBox(
                                  height: 450,
                                  width: 350,
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            task.title ?? 'No Title',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            task.description ??
                                                'No Description',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'Location: ${task.location ?? 'No Location'}',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'Duration: ${task.duration ?? 'No Duration'}',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
