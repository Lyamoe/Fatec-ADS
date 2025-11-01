import 'package:flutter/material.dart';

final notSeen = [
  {
    'name': 'Junhan',
    'img':
        'https://64.media.tumblr.com/e724270bd3781d7ed7a5a29ac5cd3277/eb1a3116754ac1f3-e6/s1280x1920/6c813d3cd40ffd60776732de463bfbde3986f776.jpg',
    'lastMsg': 'Im learning a new song ^^',
    'time': '19:34',
    'qtMsg': '5',
  },
  {
    'name': 'Gaon',
    'img':
        'https://64.media.tumblr.com/a2f7378230505d349aba0c78c27bfe2e/fddc145234c061b5-74/s250x400/760baffe0e5e920804c66a0c95e1f987eebc4ada.pnj',
    'lastMsg': 'Wait wait wait what',
    'time': '16:12',
    'qtMsg': '1',
  },
  {
    'name': 'Xdinary Heroes',
    'img':
        'https://64.media.tumblr.com/6ff599129f8dcdb000be0a3a05bbf9d8/a1c4c784f9631956-81/s1280x1920/1999d16cd7b94d9fcb6b341b3ad68de278f59e0f.jpg',
    'lastMsg': 'Gaon: GUYS JOOYEON BURNED THE KITCHEN',
    'time': '13:15',
    'qtMsg': '32',
  },
  {
    'name': 'Gunil',
    'img':
        'https://64.media.tumblr.com/1794a84e10c7461b83e8c4ad74c0ea64/d3f1bdfc03ea2901-b4/s100x200/cab1fab015b40ca5260926eb98f6e79162b79459.pnj',
    'lastMsg': 'How have you been?',
    'time': '13:10',
    'qtMsg': '2',
  },
  {
    'name': 'Jooyeon',
    'img':
        'https://64.media.tumblr.com/1ea89da81791128899c6b30c2f52f514/11194cec817e0593-b4/s400x600/35b529c91384b3237b2a2f57c5c1c65d00d6ce9b.jpg',
    'lastMsg': 'THEY BANNED YASUO',
    'time': '12:55',
    'qtMsg': '8',
  },
  {
    'name': 'O.de',
    'img':
        'https://64.media.tumblr.com/bf4593057dcbdba0dc38ecc6ad708a32/2b4d9c9155859dd0-fa/s250x400/55fadbb729861c66a0a8185b8a7399092bc98564.pnj',
    'lastMsg': 'Sorry I was at the gym',
    'time': '09:20',
    'qtMsg': '1',
  },
  {
    'name': 'Jungsu',
    'img':
        'https://64.media.tumblr.com/077620648bb7ed7ab67cd7c384e1eae1/ad6633d564a53f6d-ee/s250x400/c6bddbf9cbf329cf5370f6ba865564b692d64025.jpg',
    'lastMsg': '> audio 3:42',
    'time': '08:47',
    'qtMsg': '1',
  },
];

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text(
          'Lyam (Karine) 4 ADS',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0F846B),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              print('Search');
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              print('More info');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40), // height of the bottom row
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.white),
                  onPressed: () {
                    print('Search');
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Chats',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      CircleAvatar(
                        radius: 10, // circle size
                        backgroundColor: Colors.white,
                        child: Text(
                          '7',
                          style: TextStyle(
                            color: const Color(0xFF0F846B),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Status',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Calls',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),

      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: notSeen.length,
          separatorBuilder:
              (_, __) => Divider(color: const Color(0xFFF0F0F0), thickness: 1),
          itemBuilder: (_, index) {
            final entry = notSeen[index];
            return SizedBox(
              height: 50,
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      entry['img']!,
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          entry['name']!,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          entry['lastMsg']!,
                          style: TextStyle(color: Color(0xFF626262)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          entry['time']!,
                          style: TextStyle(
                            color: Color(0xFF01CD40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CircleAvatar(
                          radius: 10, // circle size
                          backgroundColor: const Color(0xFF01CD40),
                          child: Text(
                            entry['qtMsg']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ),
  ),
);
