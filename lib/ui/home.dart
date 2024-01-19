import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

// import 'login.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _allmovies();
  }

  List<Map<String, dynamic>> movies = [];
  //   {
  //     "id": "65896d1e169bc5936c6ff36a",
  //     "imdbId": "tt8093700",
  //     "title": "The Woman King",
  //     "releaseDate": "2022-09-15",
  //     "trailerLink": "https://www.youtube.com/watch?v=3RDaPV_rJ1Y",
  //     "genres": ["Action", "Drama", "History"],
  //     "poster":
  //         "https://image.tmdb.org/t/p/w500/5O1GLla5vNuegqNxNhKL1OKE1lO.jpg",
  //     "backdrops": [
  //       "https://image.tmdb.org/t/p/original/gkseI3CUfQtMKX41XD4AxDzhQb7.jpg",
  //       "https://image.tmdb.org/t/p/original/wSILunFEbvw00Ql2aaMHCSZf3cI.jpg",
  //       "https://image.tmdb.org/t/p/original/xTsERrOCW15OIYl5aPX7Jbj38wu.jpg",
  //       "https://image.tmdb.org/t/p/original/j06sSrtbqnZdSgG6yEduao95y48.jpg",
  //       "https://image.tmdb.org/t/p/original/v4YV4ne1nwNni35iz4WmpZRZpCD.jpg",
  //       "https://image.tmdb.org/t/p/original/6n5ln1vWGD3JyT6Ibt7ZxjSxY3v.jpg",
  //       "https://image.tmdb.org/t/p/original/gi47WUUYVQWaLE5mJraS87ycdy6.jpg",
  //       "https://image.tmdb.org/t/p/original/dTQOU5a32K3UPTIXHgipEqN41OM.jpg",
  //       "https://image.tmdb.org/t/p/original/7zQJYV02yehWrQN6NjKsBorqUUS.jpg",
  //       "https://image.tmdb.org/t/p/original/rdDL4y7BxGyXFEDJgAG4lz89bG2.jpg"
  //     ],
  //     "reviewIds": []
  //   },
  //   {
  //     "id": "65896d4d169bc5936c6ff36c",
  //     "imdbId": "tt8760708",
  //     "title": "M3GAN",
  //     "releaseDate": "2023-01-06",
  //     "trailerLink": "https://www.youtube.com/watch?v=BRb4U99OU80",
  //     "genres": ["Science Fiction", "Horror", "Comedy"],
  //     "poster":
  //         "https://image.tmdb.org/t/p/w500/xBl5AGw7HXZcv1nNXPlzGgO4Cfo.jpg",
  //     "backdrops": [
  //       "https://image.tmdb.org/t/p/original/5kAGbi9MFAobQTVfK4kWPnIfnP0.jpg",
  //       "https://image.tmdb.org/t/p/original/dlxzUj7z1MqEcFiwvvrj0bvBKDY.jpg",
  //       "https://image.tmdb.org/t/p/original/q2fY4kMXKoGv4CQf310MCxpXlRI.jpg",
  //       "https://image.tmdb.org/t/p/original/pTxwFdsdDWzpCRYuk1QbggdaOlL.jpg",
  //       "https://image.tmdb.org/t/p/original/1zuz2RgFoOjulkjjNHHFc3WiHGB.jpg",
  //       "https://image.tmdb.org/t/p/original/7HqxI1IXMloT9VTSuDC8ikaj810.jpg",
  //       "https://image.tmdb.org/t/p/original/vpK2rp3J5LiC01HoNM0j9DEHQ1T.jpg",
  //       "https://image.tmdb.org/t/p/original/cNHXdmr4amP6EPCMa0dqD8rwzDV.jpg",
  //       "https://image.tmdb.org/t/p/original/txQLFd6rfQrskQhFENkS1jElptt.jpg",
  //       "https://image.tmdb.org/t/p/original/dC4tj1ONdlZ2TWv4XD2SA1KUnJN.jpg"
  //     ],
  //     "reviewIds": []
  //   },
  //   {
  //     "id": "65896d69169bc5936c6ff36e",
  //     "imdbId": "tt11116912",
  //     "title": "Troll",
  //     "releaseDate": "2022-12-01",
  //     "trailerLink": "https://www.youtube.com/watch?v=AiohkY_XQYQ",
  //     "genres": ["Fantasy", "Action", "Adventure"],
  //     "poster":
  //         "https://image.tmdb.org/t/p/w500/9z4jRr43JdtU66P0iy8h18OyLql.jpg",
  //     "backdrops": [
  //       "https://image.tmdb.org/t/p/original/53BC9F2tpZnsGno2cLhzvGprDYS.jpg",
  //       "https://image.tmdb.org/t/p/original/e9Qb2kmBnMXHCmNMI8NX1JbWhh1.jpg",
  //       "https://image.tmdb.org/t/p/original/2WjOOOGUu6dp4r8VqR5n48DY7JG.jpg",
  //       "https://image.tmdb.org/t/p/original/duIsyybgrC4S8kcCIVaxNOttV15.jpg",
  //       "https://image.tmdb.org/t/p/original/3RS8runn9AfrYDzRVPWuGPmvXQf.jpg",
  //       "https://image.tmdb.org/t/p/original/8wLRn2VvBlCu6cqYS4ypipnwosr.jpg",
  //       "https://image.tmdb.org/t/p/original/zDqVVkmfvj47FBUE5lwE4rWnITu.jpg",
  //       "https://image.tmdb.org/t/p/original/682Ui5DwZDdbIPzKAEOR7cJlMXa.jpg",
  //       "https://image.tmdb.org/t/p/original/6jdlppcnGi3XuJamfs4Vl7HyxB.jpg",
  //       "https://image.tmdb.org/t/p/original/uIq83ogs7QBEWi1aqmUrdDIH61m.jpg"
  //     ],
  //     "reviewIds": []
  //   },
  //   {
  //     "id": "65896d84169bc5936c6ff370",
  //     "imdbId": "tt6443346",
  //     "title": "Black Adam",
  //     "releaseDate": "2022-10-19",
  //     "trailerLink": "https://www.youtube.com/watch?v=JaV7mmc9HGw",
  //     "genres": ["Fantasy", "Action", "Science Fiction"],
  //     "poster":
  //         "https://image.tmdb.org/t/p/w500/pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg",
  //     "backdrops": [
  //       "https://image.tmdb.org/t/p/original/bQXAqRx2Fgc46uCVWgoPz5L5Dtr.jpg",
  //       "https://image.tmdb.org/t/p/original/9hNtTwY8P5v2MKnUeb7iuREI7Yb.jpg",
  //       "https://image.tmdb.org/t/p/original/zplntIhzXyBiXFYWReETxh0uyFF.jpg",
  //       "https://image.tmdb.org/t/p/original/yxkhM18dYwsRRffLnd9lz2d4i0v.jpg",
  //       "https://image.tmdb.org/t/p/original/bgaBKREAfUtZgvd6zoV6RQRcIUt.jpg",
  //       "https://image.tmdb.org/t/p/original/uqYxoj4hqwocwfBs2xxGyQT88Yk.jpg",
  //       "https://image.tmdb.org/t/p/original/qBx97wytqlyPqXATHqRgIVFxJRU.jpg",
  //       "https://image.tmdb.org/t/p/original/d6MhreFdMHONqX3iZlJGCF8UkIt.jpg",
  //       "https://image.tmdb.org/t/p/original/9inNotReApz0n50WvWbrt0n1cbL.jpg",
  //       "https://image.tmdb.org/t/p/original/pSOuqtJmdh7aI1yiK7M8e0PmbPC.jpg"
  //     ],
  //     "reviewIds": []
  //   },
  //   {
  //     "id": "65896d9e169bc5936c6ff372",
  //     "imdbId": "tt0499549",
  //     "title": "Avatar",
  //     "releaseDate": "2009-12-15",
  //     "trailerLink": "https://www.youtube.com/watch?v=5PSNL1qE6VY",
  //     "genres": ["Fantasy", "Action", "Science Fiction", "Adventure"],
  //     "poster":
  //         "https://image.tmdb.org/t/p/w500/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg",
  //     "backdrops": [
  //       "https://image.tmdb.org/t/p/original/o0s4XsEDfDlvit5pDRKjzXR4pp2.jpg",
  //       "https://image.tmdb.org/t/p/original/8I37NtDffNV7AZlDa7uDvvqhovU.jpg",
  //       "https://image.tmdb.org/t/p/original/2YLOjUiczXEgVZFDSIeH3iWB3Ub.jpg",
  //       "https://image.tmdb.org/t/p/original/Yc9q6QuWrMp9nuDm5R8ExNqbEq.jpg",
  //       "https://image.tmdb.org/t/p/original/jlQJDD0L5ZojjlS0KYnApdO0n19.jpg",
  //       "https://image.tmdb.org/t/p/original/sfw4m2tOgQRzhF6VXxaXGfd1vX.jpg",
  //       "https://image.tmdb.org/t/p/original/7ABsaBkO1jA2psC8Hy4IDhkID4h.jpg",
  //       "https://image.tmdb.org/t/p/original/xMMrBziwJqrgjerqpNeQvwuwiUp.jpg",
  //       "https://image.tmdb.org/t/p/original/chauy3iJaZtrMbTr72rgNmOZwo3.jpg",
  //       "https://image.tmdb.org/t/p/original/mYJkJ7YxJsUNI1nAOOUOpRN2auC.jpg"
  //     ],
  //     "reviewIds": []
  //   },
  //   {
  //     "id": "65896dbe169bc5936c6ff374",
  //     "imdbId": "tt3447590",
  //     "title": "Roald Dahl's Matilda the Musical",
  //     "releaseDate": "2022-11-25",
  //     "trailerLink": "https://www.youtube.com/watch?v=lroAhsDr2vI",
  //     "genres": ["Fantasy", "Family", "Comedy"],
  //     "poster":
  //         "https://image.tmdb.org/t/p/w500/ga8R3OiOMMgSvZ4cOj8x7prUNYZ.jpg",
  //     "backdrops": [
  //       "https://image.tmdb.org/t/p/original/nWs0auTqn2UaFGfTKtUE5tlTeBu.jpg",
  //       "https://image.tmdb.org/t/p/original/bPftMelR4N3jUg2LTlEblFz0gWk.jpg",
  //       "https://image.tmdb.org/t/p/original/u2MLMkGEjJGQDs17Vmoej1RYFph.jpg",
  //       "https://image.tmdb.org/t/p/original/jG52tsazn04F1fe8hPZfVv7ICKt.jpg",
  //       "https://image.tmdb.org/t/p/original/4INEI7t7Vcg0cFvze7UIgwYCeSG.jpg",
  //       "https://image.tmdb.org/t/p/original/krAu6znzW8c54NdJPneNi4bem1l.jpg",
  //       "https://image.tmdb.org/t/p/original/6TUMppDMrYA4gzoaDUbbSnZFlxW.jpg",
  //       "https://image.tmdb.org/t/p/original/hacV1h1SWrPlrerF3xpetvEdqT.jpg",
  //       "https://image.tmdb.org/t/p/original/7iXsB1r9IK17ZFShqoxcHKQ7dLp.jpg",
  //       "https://image.tmdb.org/t/p/original/dwiRYDLcFyDOkgkSc1JFtTr6Kdk.jpg"
  //     ],
  //     "reviewIds": []
  //   },
  //   {
  //     "id": "65896ddf169bc5936c6ff376",
  //     "imdbId": "tt9114286",
  //     "title": "Black Panther: Wakanda Forever",
  //     "releaseDate": "2022-11-11",
  //     "trailerLink": "https://www.youtube.com/watch?v=_Z3QKkl1WyM",
  //     "genres": ["Action", "Adventure", "Science Fiction"],
  //     "poster":
  //         "https://image.tmdb.org/t/p/w500/cryEN3sWlgB2wTzcUNVtDGI8bkM.jpg",
  //     "backdrops": [
  //       "https://image.tmdb.org/t/p/original/yYrvN5WFeGYjJnRzhY0QXuo4Isw.jpg",
  //       "https://image.tmdb.org/t/p/original/xDMIl84Qo5Tsu62c9DGWhmPI67A.jpg",
  //       "https://image.tmdb.org/t/p/original/cs3LpA38BS2XDPfUzdgMB537XOo.jpg",
  //       "https://image.tmdb.org/t/p/original/6SGMzCsaU094Mt32IHGkIYtIl06.jpg",
  //       "https://image.tmdb.org/t/p/original/bty0TwJGsxMqYRptgyzn28Cxq5y.jpg",
  //       "https://image.tmdb.org/t/p/original/h2jp3CSdTPc22mUqps9I8vXDPaN.jpg",
  //       "https://image.tmdb.org/t/p/original/fSfWloWi5rmqbmC7GhO0HY2TMZW.jpg",
  //       "https://image.tmdb.org/t/p/original/vZujZnmkYB5nGUC5d5llK9DbGLk.jpg",
  //       "https://image.tmdb.org/t/p/original/8sMmAmN2x7mBiNKEX2o0aOTozEB.jpg",
  //       "https://image.tmdb.org/t/p/original/geI3Mk7nehX1kvyIY3K5ajaiNfI.jpg"
  //     ],
  //     "reviewIds": []
  //   },
  //   {
  //     "id": "65896dfd169bc5936c6ff378",
  //     "imdbId": "tt10298840",
  //     "title": "Strange World",
  //     "releaseDate": "2022-11-23",
  //     "trailerLink": "https://www.youtube.com/watch?v=bKh2G73gCCs",
  //     "genres": ["Family", "Adventure", "Science Fiction", "Animation"],
  //     "poster":
  //         "https://image.tmdb.org/t/p/w500/kgJ8bX3zDQDM2Idkleis28XSVnu.jpg",
  //     "backdrops": [
  //       "https://image.tmdb.org/t/p/original/5wDBVictj4wUYZ31gR5WzCM9dLD.jpg",
  //       "https://image.tmdb.org/t/p/original/zNIlXd7CAz0hHAInbs2nsFRc0xQ.jpg",
  //       "https://image.tmdb.org/t/p/original/1rukJHAP5p6DNHe75Oo1D0m3SnR.jpg",
  //       "https://image.tmdb.org/t/p/original/aKbe411WyjTZy1OZUVIdNDYVf21.jpg",
  //       "https://image.tmdb.org/t/p/original/9RKvxz0IryD2ofLYyGpnE7HeWlR.jpg",
  //       "https://image.tmdb.org/t/p/original/kFURsDklj7QGMMkGJVwDBaJJn05.jpg",
  //       "https://image.tmdb.org/t/p/original/v6oBDkd7ogXzTQxIU0H5SXq0hOL.jpg",
  //       "https://image.tmdb.org/t/p/original/fBshLiEJcjdfrU3qQBIINcePSsm.jpg",
  //       "https://image.tmdb.org/t/p/original/3oie0kID8SNCjkqN6Raweg5dJa.jpg",
  //       "https://image.tmdb.org/t/p/original/zgFldVKON1Nxp8ui7HVABGKDQKM.jpg"
  //     ],
  //     "reviewIds": []
  //   },
  //   {
  //     "id": "65896cb6169bc5936c6ff367",
  //     "imdbId": "tt3915174",
  //     "title": "Puss in Boots: The Last Wish",
  //     "releaseDate": "2022-12-21",
  //     "trailerLink": "https://www.youtube.com/watch?v=tHb7WlgyaUc",
  //     "genres": ["Animation", "Action", "Adventure", "Comedy", "Family"],
  //     "poster":
  //         "https://image.tmdb.org/t/p/w500/1NqwE6LP9IEdOZ57NCT51ftHtWT.jpg",
  //     "backdrops": [
  //       "https://image.tmdb.org/t/p/original/r9PkFnRUIthgBp2JZZzD380MWZy.jpg",
  //       "https://image.tmdb.org/t/p/original/faXT8V80JRhnArTAeYXz0Eutpv9.jpg",
  //       "https://image.tmdb.org/t/p/original/pdrlEaknhta2wvE2dcD8XDEbAI4.jpg",
  //       "https://image.tmdb.org/t/p/original/tGwO4xcBjhXC0p5qlkw37TrH6S6.jpg",
  //       "https://image.tmdb.org/t/p/original/cP8YNG3XUeBmO8Jk7Skzq3vwHy1.jpg",
  //       "https://image.tmdb.org/t/p/original/qLE8yuieTDN93WNJRmFSAEJChOg.jpg",
  //       "https://image.tmdb.org/t/p/original/vNuHqmOJRQXY0PBd887DklSDlBP.jpg",
  //       "https://image.tmdb.org/t/p/original/uUCc62M0I3lpZy0SiydbBmUIpNi.jpg",
  //       "https://image.tmdb.org/t/p/original/2wPJIFrBhzzAP8oHDOlShMkERH6.jpg",
  //       "https://image.tmdb.org/t/p/original/fnfirCEDIkxZnQEtEMMSgllm0KZ.jpg"
  //     ],
  //     "reviewIds": [
  //       {
  //         "id": {
  //           "timestamp": 1704031607,
  //           "date": "2023-12-31T14:06:47.000+00:00"
  //         },
  //         "body": "Excellent......",
  //         "userId": "Mythili",
  //         "imdbId": "tt3915174"
  //       },
  //       {
  //         "id": {
  //           "timestamp": 1704031630,
  //           "date": "2023-12-31T14:07:10.000+00:00"
  //         },
  //         "body": "Good one",
  //         "userId": "Manikandan",
  //         "imdbId": "tt3915174"
  //       }
  //     ]
  //   }
  // ];
  Future<void> _allmovies() async {
    String url = "https://movie-review-3gg6.onrender.com/api/movies";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    movies = responseData.map((e) => jsonDecode(e)).toList();
    print(movies[3]["title"]);
    print(movies[0]["poster"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login App"),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Login();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.logout_rounded),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: GestureDetector(
        onTap: () => setState(() {}),
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, position) {
            return GestureDetector(
              child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        ClipRRect(
                            child: Image(
                          image: NetworkImage(movies[position]["poster"]),
                          height: 300,
                          width: 200,
                          fit: BoxFit.contain,
                        )),
                        Container(
                          child: Row(
                            children: [
                              Text(movies[position]["title"]),
                              // Column(
                              //   children: [
                              //     for (String i in movies[position]["genres"])
                              //       Text(i)
                              //   ],
                              // ),
                              Text(movies[position]["reviews"].length()),
                              const Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: null,
                                    child: Text("Play Trailer"),
                                  ),
                                  ElevatedButton(
                                      onPressed: null, child: Text("Reviews"))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
