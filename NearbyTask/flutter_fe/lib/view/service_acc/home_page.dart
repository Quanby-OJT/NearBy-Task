import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_fe/model/task_model.dart';
import 'package:flutter_fe/service/job_post_service.dart';
import 'package:flutter_fe/view/business_acc/job_post_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CardSwiperController controller = CardSwiperController();
  List<TaskModel> tasks = [];
  bool _isLoading = true;
  void initState() {
    super.initState();
    _fetchTasks();
  }

//For Displaying the record (record functionality)
  Future<void> _fetchTasks() async {
    try {
      JobPostService jobPostService = JobPostService();
      List<TaskModel> fetchedTasks = await jobPostService.fetchAllJobs();

      print("Raw API Response: ${fetchedTasks}"); // Print entire response
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
          'Job Posts',
          style:
              TextStyle(color: Color(0xFF0272B1), fontWeight: FontWeight.bold),
        )),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
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
                          borderSide:
                              BorderSide(color: Color(0xFF0272B1), width: 2))),
                ),
              ),
            ),
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : tasks.isEmpty
                  ? Center(child: Text("No available services"))
                  : Expanded(
                      // height: 450,
                      // width: 350,
                      child: CardSwiper(
                        allowedSwipeDirection: AllowedSwipeDirection.only(
                          left: true,
                          right: true,
                        ),
                        controller: controller,
                        cardsCount: tasks.length,
                        onSwipe: (previousIndex, targetIndex, swipeDirection) {
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
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  spacing: 10,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '₱${task.contactPrice ?? "--"}',
                                      style: GoogleFonts.openSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      task.title ?? 'No Title',
                                      style: GoogleFonts.openSans(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      task.description ?? 'No Description',
                                      style: GoogleFonts.openSans(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Row(
                                      spacing: 5,
                                      children: [
                                        Icon(
                                          Icons.location_pin,
                                          size: 20,
                                        ),
                                        Text(
                                          task.location ?? "Location",
                                          style: GoogleFonts.openSans(),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
