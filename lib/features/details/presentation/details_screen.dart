import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dummyjson_ecommerce/core/config/utils/constants.dart';
import 'package:dummyjson_ecommerce/features/home/models/product_models.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nativeWhite,
      appBar: AppBar(
        leadingWidth: 15,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Iconsax.arrow_left_2, color: AppColors.blueBg,)),
        title: Text(
          product.title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.blueBg,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Iconsax.category, color: AppColors.blueBg),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.images != null && product.images!.isNotEmpty)
              CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  autoPlay: true,
                ),
                items:
                    product.images!.map((imageUrl) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    }).toList(),
              ),
            const SizedBox(height: 20),
            Text(
              product.title,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.blueBg,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${product.price}',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
           
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: product.rating.toDouble(),
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                      const SizedBox(width: 8),
                      Text('${product.rating}', style: TextStyle(color: Colors.grey)),
                    ],
                  ),

                  const SizedBox(height: 16),
            Text(
              product.description,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${product.title} added to cart!"),
                  backgroundColor: AppColors.blueBg,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blueBg,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Add to Cart',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
