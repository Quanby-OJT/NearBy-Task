import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_fe/model/user_model.dart';
import 'package:flutter_fe/service/api_service.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_fe/service/like_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CardSwiperController controller = CardSwiperController();
  List<UserModel> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

//For Displaying the record (record functionality)
  Future<void> _fetchUsers() async {
    try {
      List<UserModel> users = await ApiService.fetchAllUsers();
      setState(() {
        _users = users;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching users: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addToLikesTable(int userId) async {
    try {
      await LikeService.addLike(userId, true,
          'currentUserId'); // Replace 'currentUserId' with the actual current user ID
    } catch (e) {
      print("Error adding to likes table: $e");
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
                : SizedBox(
                    height: 450,
                    child: CardSwiper(
                      allowedSwipeDirection: AllowedSwipeDirection.only(
                        left: true,
                        right: true,
                      ),
                      controller: controller,
                      cardsCount: _users.length,
                      onSwipe: (previousIndex, targetIndex, swipeDirection) {
                        if (swipeDirection == CardSwiperDirection.left) {
                          print("Swiped Left (Disliked)");
                        } else if (swipeDirection ==
                            CardSwiperDirection.right) {
                          print("Swiped Right (Liked)");
                          _addToLikesTable(_users[previousIndex].id);
                        }
                        return true;
                      },
                      cardBuilder: (context, index, percentThresholdX,
                          percentThresholdY) {
                        final user = _users[index];
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                // Trigger a rebuild to flip the card
                              });
                            },
                            child: FlipCard(
                              direction: FlipDirection.HORIZONTAL,
                              front: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(user.image,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              back: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(
                                    user.firstName,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
