import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class News_View extends StatefulWidget {
  String title;
  String desc;
  String imgUrl;
  String author;

  News_View(
      {
        required this.desc,
      required this.author,
      required this.title,
      required this.imgUrl});

  @override
  State<News_View> createState() => _News_ViewState();
}

class _News_ViewState extends State<News_View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Author : ${widget.author}",
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.displayLarge,
              fontSize: 20,
              color: Colors.red,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                   imageUrl: widget.imgUrl,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 27,
                      color: Colors.green.shade300),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  widget.desc,
                  style: GoogleFonts.vesperLibre(
                    textStyle: Theme.of(context).textTheme.displayMedium,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
