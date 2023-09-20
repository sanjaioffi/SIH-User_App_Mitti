import 'package:flutter/material.dart';

class HubInfo extends StatelessWidget {
  const HubInfo({super.key, required this.roomName});

  final String roomName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        actions: const [Icon(Icons.more_vert_rounded)],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                HubInfoHeader(
                  roomName: roomName,
                  roomCount: 7,
                  dateOfCreation: "17/2/24",
                ),
                const SizedBox(
                  height: 5,
                ),
                EmployeeListWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HubInfoHeader extends StatelessWidget {
  const HubInfoHeader(
      {super.key,
      required this.roomName,
      required this.roomCount,
      required this.dateOfCreation});
  final String roomName;
  final int roomCount;
  final String dateOfCreation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 75,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 3.0),
            child: Text(
              roomName,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Text("Group ・ $roomCount Agencies"),
          Text(
            "Created at $dateOfCreation",
            style: TextStyle(color: Colors.grey[500], fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class EmployeeListWidget extends StatelessWidget {
  EmployeeListWidget({super.key});

  final List<Map<String, String>> employees = [
    {
      'name': 'User 1',
      'imageUrl': 'assets/images/google.png',
      'subtitle': 'all is well'
    },
    {
      'name': 'User 2',
      'imageUrl': 'assets/images/google.png',
      'subtitle': 'never give up'
    },
    {
      'name': 'User 3',
      'imageUrl': 'assets/images/google.png',
      'subtitle': 'never settle'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Participants"),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ],
          ),
          Column(
            children: employees
                .map(
                  (employee) => GroupMember(
                    name: employee['name'] ?? '',
                    imageUrl: employee['imageUrl'] ?? '',
                    subtitle: employee['subtitle'] ?? '',
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class GroupMember extends StatelessWidget {
  const GroupMember(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.subtitle});

  final String name;
  final String imageUrl;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imageUrl),
        radius: 20,
      ),
      title: Text(name),
      subtitle: Text(subtitle),
    );
  }
}
