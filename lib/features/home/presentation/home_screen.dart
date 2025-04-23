import 'package:flutter/material.dart';
import 'package:dummyjson_ecommerce/core/config/utils/constants.dart';
import 'package:dummyjson_ecommerce/core/services/api_service.dart';
import 'package:dummyjson_ecommerce/features/home/models/product_models.dart';
import 'package:dummyjson_ecommerce/features/home/models/category_models.dart';
import 'package:dummyjson_ecommerce/features/home/presentation/widgets/product_card.dart';
import 'package:dummyjson_ecommerce/features/home/presentation/widgets/title_row.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categories = [];
  bool isLoading = true;
  String errorMessage = '';
  String _searchQuery = '';
  String _selectedCategorySlug = '';

  @override
  void initState() {
    super.initState();
    _loadCategories();
    fetchProducts();
  }

  _loadCategories() async {
    try {
      List<Category> loadedCategories = await ApiService.fetchCategories();
      setState(() {
        categories = loadedCategories;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load categories: $e';
        isLoading = false;
      });
    }
  }

  //For Products
  final ApiService _apiService = ApiService();
  List<ProductModel> _products = [];
  bool _isLoading = true;

  Future<void> fetchProducts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<ProductModel> products;

      if (_searchQuery.isNotEmpty) {
        products = await _apiService.searchProducts(_searchQuery);
      } else if (_selectedCategorySlug.isNotEmpty) {
        products = await _apiService.fetchProductsByCategory(
          _selectedCategorySlug,
        );
      } else {
        final data = await _apiService.fetchProducts();
        products = data.map((item) => ProductModel.fromJson(item)).toList();
      }

      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error in fetching: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

void _showCategoryFilterModal() {
  showModalBottomSheet(
    showDragHandle: true,
    enableDrag: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Category', style: Theme.of(context).textTheme.titleLarge, selectionColor: AppColors.nativeWhite,),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: categories.map((category) {
                  final isSelected = _selectedCategorySlug == category.slug;
        
                  return ChoiceChip(
                    label: Text(category.name),
                    selected: isSelected,
                    selectedColor: AppColors.blueBg,
                    onSelected: (_) {
                      setState(() {
                        _selectedCategorySlug = category.slug;
                        _searchQuery = '';
                      });
                      fetchProducts();
                      Navigator.of(context).pop();
                    },
                  );
                }).toList(),
              ),
              if (_selectedCategorySlug.isNotEmpty)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategorySlug = '';
                      fetchProducts();
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Clear Selection', style: TextStyle(color: AppColors.blueBg),),
                ),
            ],
          ),
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nativeWhite,
      appBar: AppBar(
        backgroundColor: AppColors.nativeWhite,
        title: TextField(
          onChanged: (value) {
            _searchQuery = value;
            _selectedCategorySlug = ''; 
            fetchProducts();
          },
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Iconsax.search_normal_1,
                size: 20,
                color: AppColors.blueBg,
              ),
            ),
            hintText: 'Search products',
            hintStyle: TextStyle(color: AppColors.grey),
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () => _showCategoryFilterModal(),
            child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.grey),
              ),
              child: Icon(Iconsax.document_filter),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleRowWidget(
            titleName: AppStrings.category,
            btnName: '${categories.length.toString()} ${AppStrings.items}',
          ),
          isLoading
              ? Center(child: CircularProgressIndicator(
                color: AppColors.blueBg,
              )) 
              : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : categories.isEmpty
              ? Center(child: Text('No categories found.'))
              : SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FilterChip(
                        label: Text(category.name),
                        selected: _selectedCategorySlug == category.slug,
                        selectedColor: AppColors.blueBg,
                        checkmarkColor: Colors.white,
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedCategorySlug =
                                selected ? category.slug : '';
                            _searchQuery = ''; 
                          });
                          fetchProducts();
                        },
                      ),
                    );
                  },
                ),
              ),
          TitleRowWidget(
            titleName: AppStrings.products,
            btnName: '${_products.length} ${AppStrings.items}',
          ),
          // Products list
          Expanded(
            child:
                _isLoading
                    ? const Center(
                      child: CircularProgressIndicator(color: AppColors.blueBg),
                    )
                    : GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.58,
                      ),
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        final product = _products[index];
                        return ProductCard(
                          imageUrl: product.thumbnail,
                          title: product.title,
                          price: product.price,
                          rating: product.rating,
                          category: product.category,
                          product: product,
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
