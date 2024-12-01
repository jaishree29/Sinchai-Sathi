import 'package:flutter/material.dart';
import 'package:sinchai_sathi/widgets/list_item.dart';

class CropDetail extends StatelessWidget {
  const CropDetail({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Optimal Conditions
                Text(
                  "Optimal Conditions",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ListItem(
                  leadingIcon: Icons.thermostat,
                  boldText: 'Temperature',
                  trailingText: '',
                ),
                SizedBox(height: 10),

                ListItem(
                  leadingIcon: Icons.water_drop_rounded,
                  boldText: 'Watering',
                  trailingText: '',
                ),
                SizedBox(height: 10),

                ListItem(
                  leadingIcon: Icons.sunny,
                  boldText: 'Sunlight',
                  trailingText: '',
                ),
                SizedBox(height: 16),
            
            
                //Cultivation Techniques
                Text(
                  "Cultivation Techniques",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                ListItem(
                  leadingIcon: Icons.spa_outlined,
                  boldText: 'Soil',
                  trailingText: '',
                ),
                SizedBox(height: 10),

                ListItem(
                  leadingIcon: Icons.space_bar_rounded,
                  boldText: 'Spacing',
                  trailingText: '',
                ),
                SizedBox(height: 10),

                ListItem(
                  leadingIcon: Icons.data_saver_on_sharp,
                  boldText: 'Department',
                  trailingText: '',
                ),
                SizedBox(height: 16),
            
            
                //Pesticide Information
                Text(
                  "Pesticide Information",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                ListItem(
                  leadingIcon: Icons.thermostat,
                  boldText: 'Temperature',
                  trailingText: '',
                ),
                SizedBox(height: 10),

                ListItem(
                  leadingIcon: Icons.thermostat,
                  boldText: 'Temperature',
                  trailingText: '',
                ),
                // SizedBox(height: 10),
                // ListItem(
                //   leadingIcon: Icons.thermostat,
                //   boldText: 'Temperature',
                //   trailingText: '',
                // ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
