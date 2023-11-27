import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PhotoGallery(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PhotoGallery extends StatelessWidget {
  const PhotoGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              child: const Text(
                'Welcome to My Photo Gallery!',
                style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search for photos',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Wrap(
              spacing: 7.0,
              runSpacing: 7.0,
              children: [
                buildPhotoButton(
                    context,
                    'https://tse2.mm.bing.net/th?id=OIP.EJTOgAHqj7ltpEA1YflBAAHaFB&pid=Api&P=0&h=180',
                    'Caption'),
                buildPhotoButton(
                    context,
                    'https://tse2.mm.bing.net/th?id=OIP.hmdVngQx3t0BGjKlELVWLgHaE8&pid=Api&P=0&h=180',
                    'Caption'),
                buildPhotoButton(
                    context,
                    'https://tse1.mm.bing.net/th?id=OIP.CvtroVjjksDR7Ay96dtxFQHaFj&pid=Api&P=0&h=180',
                    'Caption'),
                buildPhotoButton(
                    context,
                    'https://tse1.mm.bing.net/th?id=OIP.FhajZI3k6j9eQ6jsKr8L5gHaE5&pid=Api&P=0&h=180',
                    'Caption'),
                buildPhotoButton(
                    context,
                    'https://tse4.mm.bing.net/th?id=OIP.M-zzNOlEtgo2e-dCl8DFJAHaFH&pid=Api&P=0&h=180',
                    'Caption'),
                buildPhotoButton(
                    context,
                    'https://tse4.mm.bing.net/th?id=OIP.M-zzNOlEtgo2e-dCl8DFJAHaFH&pid=Api&P=0&h=180',
                    'Caption'),
              ],
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Sample Photo 1'),
                  subtitle: Text('Category 1'),
                ),
                const ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Sample Photo 2'),
                  subtitle: Text('Category 2'),
                ),
                const ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Sample Photo 3'),
                  subtitle: Text('Category 3'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue, // Set the background color here
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Photos Uploaded Successfully!')),
          );
        },
        child: const Icon(Icons.cloud_upload),
      ),
    );
  }
}

Widget buildPhotoButton(BuildContext context, String imageUrl, String caption) {
  return SizedBox(
    height: 100.0,
    width: 101.0,
    child: ElevatedButton(
      onPressed: () {
        const snackBar = SnackBar(content: Text('Clicked on photo!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: 150,
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              height: 25.0,
              width: 60.0,
              color: Colors.black.withOpacity(0.6),
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              child: Text(
                caption,
                style: const TextStyle(fontSize: 12, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
