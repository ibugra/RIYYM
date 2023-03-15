import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'music_api.dart';

class DetailMusicPage extends StatefulWidget {
  final Musics music;

  // ignore: use_key_in_widget_constructors
  const DetailMusicPage(this.music);
  @override
  _DetailMusicPageState createState() => _DetailMusicPageState();
}

class _DetailMusicPageState extends State<DetailMusicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.music.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.black87,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  widget.music.poster,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black87,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.music.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Column(children: <Widget>[
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(widget.music.singerUrl),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            widget.music.singer,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          )
                        ]),
                        const Expanded(child: Text("")),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.people,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                Text(
                                  "${widget.music.rank}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                Text(
                                  (Duration(seconds: widget.music.duration)
                                              .inMinutes +
                                          (((widget.music.duration) -
                                                  Duration(
                                                              seconds: widget
                                                                  .music
                                                                  .duration)
                                                          .inMinutes *
                                                      60) *
                                              0.01))
                                      .toStringAsFixed(2),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                              await launch(
                                  "https://www.youtube.com/results?search_query=${widget.music.singer} ${widget.music.title}",
                                  forceSafariVC: false);
                            },
                            icon: const Icon(
                              Icons.play_circle_outline_sharp,
                              size: 30,
                              color: Colors.blue,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
