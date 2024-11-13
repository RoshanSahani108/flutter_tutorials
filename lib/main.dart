import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  PhotoGallery(),
    );
  }
}


class PhotoGallery extends StatelessWidget {
  final List<String> images = [
    'https://img.freepik.com/free-photo/lone-tree_181624-46361.jpg',
    'https://images.pexels.com/photos/381739/pexels-photo-381739.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://i0.wp.com/picjumbo.com/wp-content/uploads/beautiful-fall-natural-scenery-painting-cabin-by-a-lake-free-image.jpeg?w=600&quality=80',
'https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_1280.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY6JqfI5VhV__qdT7DbOmQ_JN5L42cMPU4jG4mtF75y54gFkvgjDg7v_w&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRH0hElX5FwK9ZFpiEX9FjXezhloT7FLMIUzlcgsGO3HhcZ1JYUwix8hro&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5GfuemJkFiA1ElUMRkHwsM5Q4_oGlLKw8nbc5QBxPCnWrXMb6sDbY-CA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFYbmfXOHsRT_AKOac2c30aF4z4nWNiKS_tA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQynAaN1M5gUhH_deWO9bCvozsOMo9Z52aWkQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPUhc8feStsjYKYoW8X7sEQAOzA4Yla1QmGQ&s',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Photo Gallery")),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenPhoto(imageUrl: images[index]),
              ),
            ),
            child: Hero(
              tag: images[index],
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/placeholder.jpg',
                image: images[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

class FullScreenPhoto extends StatefulWidget {
  final String imageUrl;

  FullScreenPhoto({required this.imageUrl});

  @override
  _FullScreenPhotoState createState() => _FullScreenPhotoState();
}

class _FullScreenPhotoState extends State<FullScreenPhoto> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    // Start the animation on page load
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Hero(
            tag: widget.imageUrl,
            child: AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: AnimatedScale(
                scale: _visible ? 1.0 : 0.8,
                duration: Duration(milliseconds: 500),
                child: Image.network(widget.imageUrl),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

