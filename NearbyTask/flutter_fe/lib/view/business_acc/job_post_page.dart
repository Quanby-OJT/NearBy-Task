import 'package:flutter/material.dart';

class JobPostPage extends StatefulWidget {
  const JobPostPage({super.key});

  @override
  State<JobPostPage> createState() => _JobPostPageState();
}

class _JobPostPageState extends State<JobPostPage> {
  String? selectedValue; // Stores selected dropdown value
  String? selectedUrgency; // Stores selected dropdown value
  String? selectedSpecialization;
  List<String> items = ['Day', 'Week', 'Month'];
  List<String> urgency = ['Non-Urgent', 'Urgent'];
  List<String> specializtion = ['Tech Support', 'Cleaning', 'Plumbing'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Create a new task',
            style: TextStyle(
                color: Color(0xFF0272B1), fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
              child: TextField(
                cursorColor: Color(0xFF0272B1),
                decoration: InputDecoration(
                    label: Text('Job Title'),
                    labelStyle: TextStyle(color: Color(0xFF0272B1)),
                    filled: true,
                    fillColor: Color(0xFFF1F4FF),
                    hintText: 'Enter title',
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
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
              child: DropdownButtonFormField<String>(
                value: selectedSpecialization,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF1F4FF),
                    //labelText: 'Select an option',
                    hintText: 'Specialization...',
                    hintStyle: TextStyle(color: Color(0xFF0272B1)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xFF0272B1), width: 2),
                    )),
                items: specializtion.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedSpecialization = newValue;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
              child: TextField(
                maxLines: 5,
                cursorColor: Color(0xFF0272B1),
                decoration: InputDecoration(
                    label: Text('Job Description'),
                    labelStyle: TextStyle(color: Color(0xFF0272B1)),
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: Color(0xFFF1F4FF),
                    hintText: 'Enter description...',
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
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
              child: TextField(
                cursorColor: Color(0xFF0272B1),
                decoration: InputDecoration(
                    label: Text('Location'),
                    labelStyle: TextStyle(color: Color(0xFF0272B1)),
                    filled: true,
                    fillColor: Color(0xFFF1F4FF),
                    hintText: 'Enter location',
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
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
              child: DropdownButtonFormField<String>(
                value: selectedValue,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF1F4FF),
                    //labelText: 'Select an option',
                    hintText: 'Duration...',
                    hintStyle: TextStyle(color: Color(0xFF0272B1)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xFF0272B1), width: 2),
                    )),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
              child: TextField(
                cursorColor: Color(0xFF0272B1),
                decoration: InputDecoration(
                    label: Text('Number of days'),
                    labelStyle: TextStyle(color: Color(0xFF0272B1)),
                    filled: true,
                    fillColor: Color(0xFFF1F4FF),
                    hintText: 'Enter title',
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 20, bottom: 30),
              child: DropdownButtonFormField<String>(
                value: selectedUrgency,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF1F4FF),
                    //labelText: 'Select an option',
                    hintText: 'Urgency...',
                    hintStyle: TextStyle(color: Color(0xFF0272B1)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xFF0272B1), width: 2),
                    )),
                items: urgency.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedUrgency = newValue;
                  });
                },
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0272B1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    'Post Job',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ),
            TextButton(
                onPressed: () {
                  showModalList(context);
                },
                child: Text(
                  'Task list',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }

  void showModalList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (context) {
        List<String> items = ['items1', 'items2', 'items3', 'items4'];

        return Container(
          padding: EdgeInsets.all(16.0),
          height: 600, // Set height for modal
          child: Column(
            children: [
              Text('List of tasks',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(items[index]),
                      onTap: () {
                        Navigator.pop(
                            context, items[index]); // Close modal on selection
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
