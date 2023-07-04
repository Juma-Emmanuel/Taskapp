import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';



Widget donation() {
  return Container(
      margin: EdgeInsets.only(top: 12, left: 10, right: 10),
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 1, left: 16, right: 16),
              child: Text(
               ' Your contributions play a crucial'
                   ' role in sustaining and improving the app, making it even better for everyone.'
                   ' Thank you for your kind and generous'
                   ' support.',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: 19,
                ),
              ),
            ),
          ),

          SizedBox(height: 20,),
    ListTile(

         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
      ),
      // contentPadding: EdgeInsets.symmetric(horizontal:10,vertical:5,),
       tileColor: Colors.white,
       leading: FaIcon(FontAwesomeIcons.medal,
             color: Color(0xFFCD7F32),
         size: 24,
       ),
      title:Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bronze package',
          style: TextStyle(
            color: Colors.blueGrey,
          ),),
          Text('Ksh 100.00',
              style: TextStyle(
                color: Colors.pink,
              ),
          )
        ],
      )
      
    ),
          SizedBox(height: 20,),
     ListTile(
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(20),
       ),
       contentPadding: EdgeInsets.symmetric(horizontal:20,vertical:5,),
       tileColor: Colors.white,
       leading: FaIcon(FontAwesomeIcons.medal,
         color: Color(0xFF808080),
         size: 24,
       ),
         title:Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text('Silver package',
               style: TextStyle(
                 color: Colors.blueGrey,
               ),
             ),
             Text('Ksh300.00',
               style: TextStyle(
                   color: Colors.pink,
                 ),
             )
           ],
         )
     ),
          SizedBox(height: 20,),
     ListTile(
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(20),
       ),
       contentPadding: EdgeInsets.symmetric(horizontal:20,vertical:5,),
       tileColor: Colors.white,
       leading: FaIcon(FontAwesomeIcons.medal,
         color: Colors.yellow[800],
         size: 24,
       ),
         title:Column(
             crossAxisAlignment: CrossAxisAlignment.start,
               children: [
             Text('Gold package',
               style: TextStyle(
                 color: Colors.blueGrey,
               ),
             ),

             Text('Ksh500.00',
               style: TextStyle(
                 color: Colors.pink,
               ),
             ),
                 ]
         )
     ),
          SizedBox(height: 20,),


          SizedBox(height: 140,),
          copyright(),
        ],
      )
  );
}

void _launchTwitterURL() async{
  const twitterUrl ='https://www.twitter.com/Juma_Emmanuelle?t=gC1AEYsPfDDbroKZFT8tAg&s=09';
  final uri = Uri.parse(twitterUrl);
  if(await canLaunch(uri.toString())){
    await launch(uri.toString());
  }else{
    throw 'Could not launch $uri';
  }
}

Widget copyright(){
  return Container(

      margin: EdgeInsets.only(bottom: 10,),
      child: Column(
          children: [
            Text('SoftDev ',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            Text('\u00A92023',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ]
      )
  );

  }
Widget settings() {
  return Container(
      child: Column(

          children: [
            ListTile(
              leading: Icon(Icons.palette,
                color: Colors.blueGrey,
                size: 25,
              ),
              title: Text('Themes',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: (){
                },
            ),

            SizedBox(height: 560,),
            copyright(),
          ]
      ),
  );
}

https://github.com/Juma-Emmanuel/Taskapp.git


class DetailScreen extends StatelessWidget {
 // const DetailScreen({Key? key}) : super(key: key);

  final Widget Function()  widgetFunction;
 // final Widget Function()  copyrightFunction;




DetailScreen({required this.widgetFunction});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text(''),

        backgroundColor: Colors.pink[100],
      ),

      body: Column(
       // color: Colors.pink[100],
        children: [

    widgetFunction!(),

        ],
      ),

    );
  }
}



class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child:  Container(

            color: Colors.pink[100],
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            //child: SizedBox(height: 40.0,),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/To_do_list.jpg'),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
              color: Colors.blueGrey,
            ),
            child: Text(''),
          ),
          ListTile(
            leading: Icon(Icons.monetization_on,
            color: Colors.blueGrey,
              size: 25,
            ),
            title: Text('Donate',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 18,
             fontWeight: FontWeight.bold,
            ),
            ),
            onTap: (){
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context)=> DetailScreen(
                      widgetFunction: donation
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20.0,),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.twitter,
              color: Colors.blueGrey,
              size: 25,),
            title: Text('Follow us',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: (){
              _launchTwitterURL();
            },
          ),
          SizedBox(height: 20.0,),
          ListTile(
            leading: Icon(Icons.share,
              color: Colors.blueGrey,
              size: 25,
            ),
            title: Text('Share',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: (){
            },
          ),
          SizedBox(height: 20.0,),
          ListTile(
            leading: Icon(Icons.settings,
              color: Colors.blueGrey,
              size: 25,
            ),
            title: Text('Settings',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),
            onTap: (){
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context)=> DetailScreen(
                      widgetFunction: settings
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20.0,),
          ListTile(
            leading: Icon(Icons.info,
              color: Colors.blueGrey,
              size: 25,
            ),
            title: Text('About',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: (){


            },
          ),

          SizedBox(height: 180,),
          copyright()

        ],
      ),
        )
    );
  }
}
