import "package:e_commerce/config/path_export.dart";


class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    // Trigger fetching of product list via Bloc
    BlocProvider.of<ProductListBloc>(context).add(GetProductList());

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Commerce App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, PageRoutes.cart),
          ),
          ConstWidget.kSizeBoxWidth20,
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner image
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/image/offer.png",
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            ConstWidget.kSizeBoxHeight5,

            // Product Grid using BlocBuilder to listen to state changes
            BlocBuilder<ProductListBloc, ProductListState>(
              builder: (context, state) {
                if (state is GetProductListSuccess) {
                  return GridView.builder(
                    shrinkWrap: true,  // Ensures the grid takes up minimal space
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 240,
                      crossAxisCount: HelperClass.getCurrentPlatform(context) == CurrentPlatform.web ? 4 : 2, // Dynamic column count
                      childAspectRatio: 0.5,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: state.productList.length,
                    itemBuilder: (ctx, i) {
                      ProductDetails product = state.productList[i];

                      return GestureDetector(
                        onTap: () async {
                          // Store selected product in local storage and navigate to product details page
                            BaseStorage baseStorage =  BaseStorage();
                            await baseStorage.init();
                            baseStorage.setProductDetails(Constant.selectedProduct, product);
                            Navigator.pushNamed(context, PageRoutes.productDetail);
                        },
                        child: ECCard(
                          isBoxDecoration: true,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product Image and Rating
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Center(child: Image.network(product.image ?? '', height: 150)),
                                    if (product.rating?.rate != null && product.rating!.rate! >= 1)
                                      SizedBox(
                                        width: 60,
                                        child: ECCard(
                                          isBoxDecoration: true,
                                          child: Row(
                                            children: [
                                              ConstWidget.kSizeBoxWidth5,
                                              Text(product.rating?.rate?.toString() ?? "", style: ECTextStyles.textStyleFontSize10.copyWith(fontWeight: FontWeight.bold)),
                                              ConstWidget.kSizeBoxWidth5,
                                              Icon(Icons.star, color: Colors.green.shade800),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                ConstWidget.kSizeBoxHeight10,

                                // Product Title and Price
                                Text(product.title ?? "", maxLines: 1, style: ECTextStyles.textStyleFontSize12, overflow: TextOverflow.ellipsis),
                                ConstWidget.kSizeBoxHeight5,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("\$ ${product.price}", style: ECTextStyles.textStyleFontSize16.copyWith(fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Icon(Icons.local_shipping_outlined, size: 18, color: Colors.blue.shade800),
                                        ConstWidget.kSizeBoxWidth5,
                                        Text("Free Delivery", style: ECTextStyles.textStyleFontSize12.copyWith(color: Colors.blue.shade800)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const ECLoader();  // Show loader while fetching data
              },
            ),
          ],
        ),
      ),
    );
  }
}
