import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(25, 20, 20, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(25, 20, 20, 1),
          title: Text('Good Night', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_outlined, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.schedule_outlined, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings_outlined, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 50, 40, 40),
                      ),
                      child: Text("All"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 50, 40, 40),
                      ),
                      child: Text("Musics"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 50, 40, 40),
                      ),
                      child: Text("Podcasts"),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        color: const Color.fromARGB(255, 50, 40, 40),
                        width: 235.0,
                        height: 70.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Image(
                              image: NetworkImage(
                                'https://cdn-images.dzcdn.net/images/cover/93e3ca81a8ad1433c8022da040ded565/0x1900-000000-80-0-0.jpg',
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "TTYL",
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        color: const Color.fromARGB(255, 50, 40, 40),
                        width: 235.0,
                        height: 70.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Image(
                              image: NetworkImage(
                                'https://i.scdn.co/image/ab67616d0000b273063b24418879e9ae9c833471',
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "LIVE and FALL",
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        color: const Color.fromARGB(255, 50, 40, 40),
                        width: 235.0,
                        height: 70.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Image(
                              image: NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/en/0/03/Olivia_Rodrigo_-_Guts.png',
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "GUTS",
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        color: const Color.fromARGB(255, 50, 40, 40),
                        width: 235.0,
                        height: 70.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Image(
                              image: NetworkImage(
                                'https://i.scdn.co/image/ab67616d0000b27345aa9482be54a027b1a0b992',
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Soft Error",
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        color: const Color.fromARGB(255, 50, 40, 40),
                        width: 235.0,
                        height: 70.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Image(
                              image: NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/en/4/4b/The_Jaws_of_Life.jpg',
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "The Jaws Of Life",
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        color: const Color.fromARGB(255, 50, 40, 40),
                        width: 235.0,
                        height: 70.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Image(
                              image: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzJsYdB7DbWUPywC5dq_GoSAnSClvPsRLiYA&s',
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "AMNEZIA",
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jump back in",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Image.network(
                            "https://akamai.sscdn.co/letras/360x360/albuns/3/4/3/b/3134001746619480.jpg",
                            width: 180,
                            height: 180,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Image.network(
                            "https://cdn-images.dzcdn.net/images/cover/71486ce8b24f612c4887efa0f79a9f66/500x500.jpg",
                            width: 180,
                            height: 180,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New releases for you",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Image.network(
                            "https://upload.wikimedia.org/wikipedia/en/1/14/Three_cheers_clean.jpg",
                            width: 180,
                            height: 180,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Image.network(
                            "https://upload.wikimedia.org/wikipedia/en/e/ee/NewJeans_-_Get_Up.png",
                            width: 180,
                            height: 180,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          backgroundColor: const Color.fromRGBO(25, 20, 20, 1),
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music_outlined),
              label: 'Your Library',
            ),
          ],
        ),
      ),
    );
  }
}
