import 'package:dummyjson_ecommerce/core/config/utils/constants.dart';
import 'package:dummyjson_ecommerce/features/details/presentation/details_screen.dart';
import 'package:dummyjson_ecommerce/features/home/models/product_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final double rating;
  final String category;
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.rating,
    required this.category,
    required this.product,
  });
  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(product: product),
          ),
        );
      },

      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                height: 120,
                width: double.infinity,
                color: AppColors.productImgBg,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                ),
              ),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.nativeBlack,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Price
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.blueBg,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Rating
                  RatingBarIndicator(
                    rating: rating,
                    itemBuilder:
                        (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 16,
                    direction: Axis.horizontal,
                  ),
                  const Spacer(),

                  // Category
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.blueBg),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.blueBg,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
