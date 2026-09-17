import 'package:flutter/material.dart'; 
 
void main() { 
  runApp(const MyApp()); 
} 
 
class MyApp extends StatelessWidget { 
  const MyApp({super.key}); 
 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      debugShowCheckedModeBanner: false, 
      title: 'My App', 
      theme: ThemeData( 
        brightness: Brightness.dark, 
        scaffoldBackgroundColor: const Color.fromARGB(255, 60, 60, 60), 
      ), 
      home: _MyHomePageState(), 
    ); 
  } 
} 
 
class _MyHomePageState extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        backgroundColor: Colors.black, 
        title: Text( 
          'Social', 
          style: TextStyle( 
            fontFamily: 'arial', 
            fontWeight: FontWeight.bold, 
            fontSize: 45, 
          ), 
        ), 
      ), 
      body: Center( 
        child: Column( 
          mainAxisAlignment: .start, 
          children: [ 
            Card( 
              margin: EdgeInsets.zero, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), 
              color: Colors.black, 
              child: Padding( 
                padding: EdgeInsetsGeometry.all(16.0), 
                child: Row( 
                  children: [ 
                    Text( 
                      'Friends', 
                      style: TextStyle( 
                        fontSize: 18, 
                        fontWeight: FontWeight.bold, 
                        fontFamily: 'sans-serif', 
                      ), 
                    ), 
 
                    SizedBox(width: 20), 
 
                    Text( 
                      'Messages', 
                      style: TextStyle( 
                        fontSize: 18, 
                        fontFamily: 'sans-serif', 
                        color: Colors.grey, 
                      ), 
                    ), 
 
                    SizedBox(width: 20), 
 
                    Text( 
                      'Requests', 
                      style: TextStyle( 
                        fontSize: 18, 
                        fontFamily: 'sans-serif', 
                        color: Colors.grey, 
                      ), 
                    ), 
                  ], 
                ), 
              
              ), 
            ), 
 
            Card( 
              margin: EdgeInsets.only(top: 1, bottom: 0, left: 0, right: 0), 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), 
              color: Colors.black, 
              child: Padding( 
                padding: EdgeInsetsGeometry.all(16.0), 
                child: Card( 
                  shape: RoundedRectangleBorder( 
                    borderRadius: BorderRadiusGeometry.circular(15), 
                  ), 
 
                  child: Padding( 
                    padding: EdgeInsetsGeometry.all(10), 
                    child: Row( 
                      children: [ 
                        Icon(Icons.search, size: 30, color: Colors.white), 
 
                        SizedBox(width: 5), 
 
                        Text( 
                          'Search', 
                          style: TextStyle( 
                            fontSize: 20, 
                            color: Colors.white, 
                            fontFamily: 'sans-serif', 
                          ), 
                        ), 
                      ], 
                    ), 
                  ), 
                ), 
              ), 
            ), 
 
            Card( 
              color: Colors.black, 
              margin: EdgeInsets.zero, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), 
              child: Padding( 
                padding: EdgeInsetsGeometry.only( 
                  top: 0, 
                  bottom: 16, 
                  left: 25, 
                  right: 16, 
                ), 
                child: Row( 
                  children: [ 
                    Icon( 
                      Icons.circle_rounded, 
                      size: 30, 
                      color: Colors.red, 
                    ), 
                    SizedBox(width: 10), 
                    Text( 
                      'VALORANT', 
                      style: TextStyle( 
                        fontSize: 20, 
                        fontFamily: 'sans-serif', 
                        fontWeight: FontWeight.bold, 
                        color: Colors.white, 
                      ), 
                    ), 
                    SizedBox(width: 10), 
                    Text( 
                      '3', 
                      style: TextStyle( 
                        fontSize: 20, 
                        fontFamily: 'sans-serif', 
                        fontWeight: FontWeight.bold, 
                        color: Colors.white, 
                      ), 
                    ), 
                  ], 
                ), 
              ), 
            ), 
 
            Card( 
              color: Colors.black, 
              margin: EdgeInsets.zero, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), 
              child: Padding( 
                padding: EdgeInsetsGeometry.only( 
                  top: 0, 
                  bottom: 16, 
                  left: 30, 
                  right: 16, 
                ), 
                child: Row( 
                  children: [ 
                    Column( 
                      children: [ 
                        CircleAvatar( 
                          backgroundColor: Color.fromARGB(255, 60, 60, 60), 
                          radius: 25, 
                          child: Icon(Icons.person, color: Colors.red, size: 40), 
                        ), 
 
                        // SizedBox(height: -1), 
                        Row( 
                          children: [ 
                            Icon( 
                              Icons.circle, 
                              size: 15, 
                              color: Colors.black,
                            ), 
 
                            SizedBox( 
                              width: 10, 
                            ),
 
                            Icon( 
                              Icons.circle, 
                              size: 15, 
                              color: Colors.green, 
                            ), 
                          ], 
                        ), 
                      ], 
                    ), 
 
                    SizedBox(width: 10), 
 
                    Column( 
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [ 
                        Text( 
                          'ParaAsaPud', 
                          style: TextStyle( 
                            fontSize: 20, 
                            fontFamily: 'sans-serif', 
                            fontWeight: FontWeight.bold, 
                            color: Colors.white, 
                          ), 
                        ), 
 
                        SizedBox(height: 5), 
 
                        Row( 
                          children: [ 
                            Icon( 
                              Icons.monitor, 
                              size: 15, 
                              color: Colors.white60, 
                            ), 
 
                            SizedBox(width: 1), 
 
                            Text( 
                              'Online - VALORANT', 
                              style: TextStyle( 
                                fontSize: 15, 
                                fontFamily: 'sans-serif', 
                                color: Colors.white, 
                              ), 
                            ), 
                          ], 
                        ), 
                      ], 
                    ), 
                  ], 
                ), 
              ), 
            ), 
 
            Card( 
              color: Colors.black, 
              margin: EdgeInsets.zero, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), 
              child: Padding( 
                padding: EdgeInsetsGeometry.only( 
                  top: 0, 
                  bottom: 16, 
                  left: 30, 
                  right: 16, 
                ), 
                child: Row( 
                  children: [ 
                    Column( 
                      children: [ 
                        CircleAvatar( 
                          backgroundColor: Color.fromARGB(255, 60, 60, 60),
                          radius: 25, 
                          child: Icon(Icons.person, size: 40, color: Colors.red), 
                        ), 
 
                        // SizedBox(height: -1), 
                        Row( 
                          children: [ 
                            Icon( 
                              Icons.circle, 
                              size: 15, 
                              color: Colors.black,
                            ), 
 
                            SizedBox( 
                              width: 10, 
                            ), 
 
                            Icon( 
                              Icons.play_circle, 
                              size: 15, 
                              color: Colors.blue, 
                            ), 
                          ], 
                        ), 
                      ], 
                    ), 
 
                    SizedBox(width: 10), 
 
                    Column( 
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [ 
                        Text( 
                          'NeverGrowOld', 
                          style: TextStyle( 
                            fontSize: 20, 
                            fontFamily: 'sans-serif', 
                            fontWeight: FontWeight.bold, 
                            color: Colors.white, 
                          ), 
                        ), 
 
                        SizedBox(height: 5), 
 
                        Row( 
                          children: [ 
                            Icon( 
                              Icons.monitor, 
                              size: 15, 
                              color: Colors.white, 
                            ), 
 
                            SizedBox(width: 1), 
 
                            Text( 
                              'Playing - VALORANT', 
                              style: TextStyle( 
                                fontSize: 15, 
                                fontFamily: 'sans-serif', 
                                color: Colors.white, 
                              ), 
                            ), 
                          ], 
                        ), 
                      ], 
                    ), 
                  ], 
                ), 
              ), 
            ), 
 
            Card( 
              color: Colors.black, 
              margin: EdgeInsets.zero, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), 
              child: Padding( 
                padding: EdgeInsetsGeometry.only( 
                  top: 0, 
                  bottom: 16, 
                  left: 30, 
                  right: 16, 
                ), 
                child: Row( 
                  children: [ 
                    Column( 
                      children: [ 
                        CircleAvatar( 
                          backgroundColor: Color.fromARGB(255, 60, 60, 60), 
                          radius: 25, 
                          child: Icon(Icons.person, color: Colors.red, size: 40), 
                        ), 
 
                        // SizedBox(height: -1), 
                        Row( 
                          children: [ 
                            Icon( 
                              Icons.circle, 
                              size: 15, 
                              color: Colors.black,
                            ), 
 
                            SizedBox( 
                              width: 10, 
                            ),
 
                            Icon( 
                              Icons.play_circle, 
                              size: 15, 
                              color: Colors.blue, 
                            ), 
                          ], 
                        ), 
                      ], 
                    ), 
 
                    SizedBox(width: 10), 
 
                    Column( 
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [ 
                        Text( 
                          'RBReneBaterbonia', 
                          style: TextStyle( 
                            fontSize: 20, 
                            fontFamily: 'sans-serif', 
                            fontWeight: FontWeight.bold, 
                            color: Colors.white, 
                          ), 
                        ), 
 
                        SizedBox(height: 5), 
 
                        Row( 
                          crossAxisAlignment: CrossAxisAlignment.end, 
                          children: [ 
                            Icon( 
                              Icons.monitor, 
                              size: 15, 
                              color: Colors.white, 
                            ), 
 
                            SizedBox(width: 1), 
 
                            Text( 
                              'Playing - VALORANT', 
                              style: TextStyle( 
                                fontSize: 15, 
                                fontFamily: 'sans-serif', 
                                color: Colors.white, 
                              ), 
                            ), 
                          ], 
                        ), 
                      ], 
                    ), 
                  ], 
                ), 
              ), 
            ), 
 
            Card( 
              color: Colors.black, 
              margin: EdgeInsets.zero, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), 
              child: Padding( 
                padding: EdgeInsetsGeometry.only( 
                  top: 0, 
                  bottom: 16, 
                  left: 20, 
                  right: 16, 
                ), 
                child: Row( 
                  children: [ 
                    Text( 
                      'Online', 
                      style: TextStyle( 
                        fontSize: 20, 
                        fontFamily: 'sans-serif', 
                        fontWeight: FontWeight.bold, 
                        color: Colors.white, 
                      ), 
                    ), 
 
                    SizedBox(width: 10), 
 
                    Text( 
                      '4', 
                      style: TextStyle( 
                        fontSize: 20, 
                        fontWeight: FontWeight.bold, 
                        fontFamily: 'sans-serif', 
                        color: Colors.white, 
                      ), 
                    ) 
                  ], 
                ), 
              ), 
            ), 
 
            Card( 
              color: Colors.black, 
              margin: EdgeInsets.zero, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), 
              child: Padding( 
                padding: EdgeInsetsGeometry.only( 
                  top: 0, 
                  bottom: 16, 
                  left: 30, 
                  right: 16, 
                ), 
                child: Row( 
                  children: [ 
                    Column( 
                      children: [ 
                        CircleAvatar( 
                          backgroundColor: Color.fromARGB(255, 60, 60, 60), 
                          radius: 25, 
                          child: Icon(Icons.person, color: Colors.white, size: 40), 
                        ), 
 
                        // SizedBox(height: -1), 
                        Row( 
                          children: [ 
                            Icon( 
                              Icons.circle, 
                              size: 15, 
                              color: Colors.black,
                            ), 
 
                            SizedBox( 
                              width: 10, 
                            ), 
 
                            Icon( 
                              Icons.dark_mode, 
                              size: 15, 
                              color: Colors.yellow, 
                            ), 
                          ], 
                        ), 
                      ], 
                    ), 
 
                    SizedBox(width: 10), 
 
                    Column( 
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [ 
                        Text( 
                          'WakoKailaSaImongBanaOie', 
                          style: TextStyle( 
                            fontSize: 20, 
                            fontFamily: 'sans-serif', 
                            fontWeight: FontWeight.bold, 
                            color: Colors.white, 
                          ), 
                        ), 
 
                        SizedBox(height: 5), 
 
                        Row( 
                          children: [ 
 
                            SizedBox(width: 1), 
 
                            Text( 
                              'Aavisala', 
                              style: TextStyle( 
                                fontSize: 15, 
                                fontFamily: 'sans-serif', 
                                color: Colors.white, 
                              ), 
                            ), 
                          ], 
                        ), 
                      ], 
                    ), 
                  ], 
                ), 
              ), 
            ), 
 
            Card( 
              color: Colors.black, 
              margin: EdgeInsets.zero, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), 
              child: Padding( 
                padding: EdgeInsetsGeometry.only( 
                  top: 0, 
                  bottom: 16, 
                  left: 30, 
                  right: 16, 
                ), 
                child: Row( 
                  children: [ 
                    Column( 
                      children: [ 
                        CircleAvatar( 
                          backgroundColor: Color.fromARGB(255, 60, 60, 60), 
                          radius: 25, 
                          child: Icon(Icons.person, color: Colors.white, size: 40),                         
                        ), 
 
                        // SizedBox(height: -1), 
                        Row( 
                          children: [ 
                            Icon( 
                              Icons.circle, 
                              size: 15, 
                              color: Colors.black, 
                            ), 
 
                            SizedBox( 
                              width: 10, 
                            ), 
 
                            Icon( 
                              Icons.dark_mode, 
                              size: 15, 
                              color: Colors.yellow, 
                            ), 
                          ], 
                        ), 
                      ], 
                    ), 
 
                    SizedBox(width: 10), 
 
                    Column( 
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [ 
                        Text( 
                          'D1yah', 
                          style: TextStyle( 
                            fontSize: 20, 
                            fontFamily: 'sans-serif', 
                            fontWeight: FontWeight.bold, 
                            color: Colors.white, 
                          ), 
                        ), 
 
                        SizedBox(height: 5), 
 
                        Row( 
                          children: [ 
                            Icon( 
                              Icons.mobile_friendly, 
                              size: 15, 
                              color: Colors.white, 
                            ), 
 
                            SizedBox(width: 1), 
 
                            Text( 
                              'Away - Riot Mobile', 
                              style: TextStyle( 
                                fontSize: 15, 
                                fontFamily: 'sans-serif', 
                                color: Colors.white, 
                              ), 
                            ), 
                          ], 
                        ), 
                      ], 
                    ), 
                  ], 
                ), 
              ), 
            ), 
          ], 
        ), 
      )
    );
  } 
} 
 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Chats'),
        ),
        body: inbox.isEmpty
            ? const Center(
                child: Text(
                  'Inbox is Empty',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                            profile[index].image,
                          ),
                        ),
                        title: Text(
                          profile[index].name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${Leachim}\n'
                          '${james Bro}\n'
                          '${Kinnot}}\n'
                          '${Yashipakaka}\n'
                          '${Memaw}\n',
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
