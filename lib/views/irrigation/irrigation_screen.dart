import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IrrigationScreen extends StatelessWidget {
  const IrrigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: Text(
          "Irrigation",
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Crop Treatment Methods",
              style: GoogleFonts.poppins(
                  fontSize: 30.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/Button_dripper.JPG/1200px-Button_dripper.JPG"),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Container(
                  width: 240,
                  height: 80.0,
                  color: Colors.transparent,
                  child: Card(
                    child: ListTile(
                      title: Text(
                        "Drip Irrigation",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "Efficient water use for rows of field",
                        style: GoogleFonts.poppins(fontSize: 12.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(
                      "https://m.media-amazon.com/images/I/91j1Q7xEgZL._AC_UF1000,1000_QL80_.jpg"),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Container(
                  width: 240,
                  height: 80.0,
                  color: Colors.transparent,
                  child: Card(
                    child: ListTile(
                      title: Text(
                        "Sprinkler Systems",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "Efficient water use for rows of field",
                        style: GoogleFonts.poppins(fontSize: 12.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(
                      "https://types.blog/wp-content/uploads/2023/12/disadvantages-of-fertigation.jpg"),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Container(
                  width: 240,
                  height: 80.0,
                  color: Colors.transparent,
                  child: Card(
                    child: ListTile(
                      title: Text(
                        "Fertigation",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "Combines Fertilization with irrigation",
                        style: GoogleFonts.poppins(fontSize: 12.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
