import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BarberShopScreen(),
    );
  }
}

class BarberShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Barbershop App'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeader(),

              SizedBox(height: 20),

              // Nearest Barbershop Section
              Text(
                'Nearest Barbershop',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildNearestBarberShopList(),

              SizedBox(height: 20),

              // Most Recommended Carousel Section
              Text(
                'Most recommended',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildCarousel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXqIWWtUw60A9kaCL_B9iAXZ33Ls2yWnLnCQ&s'),
              radius: 30,
            ),
            SizedBox(width: 10),
            Text(
              'Joe Samanta',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Booking Now',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNearestBarberShopList() {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjRkeHBwbPuM9R_TPOceMRK7e7MGIwSNMT3Q&s'),
          ),
          title: Text('Alana Barbershop - Haircut & Spa'),
          subtitle: Text('4.5 ⭐ - 3 km'),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://heygoldie.com/blog/wp-content/uploads/2021/12/barbershop-terminology-1.jpg'),
          ),
          title: Text('Hercha Barbershop - Haircut & Styling'),
          subtitle: Text('5.0 ⭐ - 8 km'),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://marketplace.canva.com/EAFzl_fI3WU/1/0/1600w/canva-red-and-black-illustrative-barber-shop-logo-A5183UnPgkI.jpg'),
          ),
          title: Text('Barberking - Haircut styling & massage'),
          subtitle: Text('4.5 ⭐ - 12 km'),
        ),
        TextButton(
          onPressed: () {},
          child: Text('See All'),
        ),
      ],
    );
  }

  Widget _buildCarousel() {
    final recommendedShops = [
      'Master piece Barbershop - Haircut styling',
      'Varcity Barbershop Jogja',
      'Twinsky Monkey Barber & Man Stuff',
      'Barberman - Haircut styling & massage',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 150.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: recommendedShops.map((shop) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.omysalon.com/cdn/shop/files/image_2_6af4a6c4-a0a5-4718-bc9b-b7029ae79241_1600x.jpg?v=1724651160'),
                    radius: 30,
                  ),
                  SizedBox(height: 10),
                  Text(
                    shop,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text('4.5 ⭐'),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
