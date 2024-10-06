import "package:e_commerce/config/path_export.dart";

/// ProductDetail widget shows product details and provides options to add the product to cart or go back to the shop
class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late ProductDetails productDetails;

  @override
  void initState() {
    super.initState();
    // Fetch product details from storage
    var storageService = GetIt.I<BaseStorage>();
    productDetails = storageService.getProductDetails(Constant.selectedProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E - Commerce App'),
      ),
      // BlocListener to handle add to cart success or failure
      body: BlocListener<AddCartBloc, AddCartState>(
        listener: (context, state) {
          if (state is AddedCartSuccess) {
            // Show success dialog
            ECAlertDialog.showAlertDialog(
              context,
              "Product Added to Your Cart",
              "",
              [ECButton(buttonTitle: "OK", onClick: () => Navigator.pop(context))],
            );
          }
          if (state is AddCartFailed) {
            // Show failure dialog
            ECAlertDialog.showAlertDialog(
              context,
              "Failed to Add Product to Cart",
              "",
              [ECButton(buttonTitle: "OK", onClick: () => Navigator.pop(context))],
            );
          }
        },
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.5,
            padding: ConstWidget.paddingAll10,
            // Grid layout to display product image and details
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: HelperClass.getCurrentPlatform(context) != CurrentPlatform.web
                    ? MediaQuery.of(context).size.height / 1.5
                    : MediaQuery.of(context).size.height / 2,
                crossAxisCount: HelperClass.getCurrentPlatform(context) != CurrentPlatform.mobile ? 2 : 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: [
                // Product image section
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  child: Image.network(productDetails.image ?? ""),
                ),
                // Product details section
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display product title, price, and description
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: ConstWidget.paddingAll8,
                            child: Text(
                              productDetails.title ?? "",
                              style: ECTextStyles.textStyleFontSize20Bold.copyWith(color: Colors.brown.shade900),
                            ),
                          ),
                          Padding(
                            padding: ConstWidget.paddingAll8,
                            child: Text(
                              "\$ ${productDetails.price}",
                              style: ECTextStyles.textStyleFontSize20Bold,
                            ),
                          ),
                          Padding(
                            padding: ConstWidget.paddingAll8,
                            child: Text(
                              productDetails.description ?? "",
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style: ECTextStyles.textStyleFontSize16,
                            ),
                          ),
                        ],
                      ),
                      // Buttons for adding to cart and navigating back to shop
                      Column(
                        children: [
                          ConstWidget.kSizeBoxHeight10,
                          ECButton(
                            width: HelperClass.getCurrentPlatform(context) != CurrentPlatform.mobile
                                ? MediaQuery.of(context).size.width / 2
                                : MediaQuery.of(context).size.width,
                            buttonTitle: 'Add to Cart',
                            onClick: () => BlocProvider.of<AddCartBloc>(context).add(AddCart(productDetails)),
                          ),
                          ConstWidget.kSizeBoxHeight10,
                          ECButton(
                            width: HelperClass.getCurrentPlatform(context) != CurrentPlatform.mobile
                                ? MediaQuery.of(context).size.width / 2
                                : MediaQuery.of(context).size.width,
                            buttonTitle: 'Back To Shop',
                            onClick: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
