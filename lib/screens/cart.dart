import "package:e_commerce/config/path_export.dart";
import "package:e_commerce/utilities/bloc/cart_product_list/cart_product_list_bloc.dart";

/// Cart widget displays the items in the user's shopping cart and allows updating quantities or proceeding to checkout.
class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  double grandTotal = 0;

  @override
  void initState() {
    super.initState();
    // Fetch the list of cart products after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<CartProductListBloc>(context).add(GetAllCartProductList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      // Listen to CartProductListBloc for cart actions
      body: BlocConsumer<CartProductListBloc, CartProductListState>(
        listener: (context, state) {
          // Refresh cart list when an item is deleted
          if (state is CartProductDeleteSuccess) {
            BlocProvider.of<CartProductListBloc>(context).add(GetAllCartProductList());
          }
          // Navigate to checkout and refresh cart after checkout
          if (state is CheckOutProduct) {
            Navigator.pushNamed(context, PageRoutes.checkout).then((_) {
              if (context.mounted) {
                BlocProvider.of<CartProductListBloc>(context).add(GetAllCartProductList());
              }
            });
          }
        },
        builder: (context, state) {
          if (state is GetCartProductDetails) {
            grandTotal = calculateTotal(state.productList);
            return Column(
              children: [
                // Display product list in grid view
                Expanded(
                  child: GridView.builder(
                    padding: ConstWidget.paddingAll15,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 160,
                      crossAxisCount: HelperClass.getCurrentPlatform(context) != CurrentPlatform.mobile ? 2 : 1,
                      crossAxisSpacing: 2, mainAxisSpacing: 2,
                    ),
                    itemCount: state.productList.length,
                    itemBuilder: (ctx, i) {
                      ProductDetails product = state.productList[i];
                      return ECCard(
                        isBoxDecoration: true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Display product image and details
                              Row(
                                children: [
                                  Image.network(product.image.toString(), height: 80, width: 80),
                                  ConstWidget.kSizeBoxWidth10,
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              product.title ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: ECTextStyles.textStyleFontSize16,
                                            ),
                                            // Delete product from cart
                                            IconButton(
                                              icon: const Icon(Icons.close),
                                              onPressed: () => BlocProvider.of<CartProductListBloc>(context)
                                                  .add(DeleteProductFromCart(i)),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "\$${product.price.toString()}",
                                          style: ECTextStyles.textStyleFontSize16.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        // Quantity controls
                                        Row(
                                          children: [
                                            const Text("Quantity: ", style: ECTextStyles.textStyleFontSize14),
                                            ConstWidget.kSizeBoxHeight5,
                                            quantityControl(product),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              ConstWidget.kSizeBoxHeight10,
                              // Total price
                              Padding(
                                padding: ConstWidget.paddingRight15,
                                child: Text(
                                  "Total: \$${((product.price ?? 0) * (product.quantity ?? 1)).toStringAsFixed(2)}",
                                  style: ECTextStyles.textStyleFontSize14.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Display grand total and checkout button
                Padding(
                  padding: ConstWidget.paddingAll20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Order Total: \$${grandTotal.toStringAsFixed(2)}",
                          style: ECTextStyles.textStyleFontSize16.copyWith(fontWeight: FontWeight.bold)),
                      ConstWidget.kSizeBoxWidth30,
                      ECButton(
                        buttonColor: Colors.amber,
                        fontStyle: ECTextStyles.textStyleFontSize16.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                        buttonTitle: "Proceed to Buy (${state.productList.length} items)",
                        onClick: () => BlocProvider.of<CartProductListBloc>(context).add(CheckoutProduct(state.productList)),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is GetProductDetailsFailed) {
            return Center(child: Image.asset("assets/image/no_item_found.png"));
          }
          return const ECLoader(); // Show loader while fetching cart items
        },
      ),
    );
  }

  /// Helper function to calculate the total price of products in the cart
  double calculateTotal(List<ProductDetails> productList) {
    return productList.fold(0, (total, product) => total + ((product.quantity ?? 0) * (product.price ?? 0)));
  }

  /// Widget for the product quantity control buttons
  Widget quantityControl(ProductDetails product) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Decrease quantity
        InkWell(
          onTap: () {
            double quantity = (product.quantity ?? 1) - 1;
            product.quantity = quantity > 0 ? quantity : 1;
            setState(() {});
          },
          child: quantityButton(Icons.remove, Colors.red.shade800, BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft:Radius.circular(10),bottomLeft:Radius.circular(10) ),
            border: Border.all(width: 0.5),
    )),
        ),
        // Display quantity
        Container(
          alignment: Alignment.center,
          height: 35,
          width: 45,
          decoration: const BoxDecoration(
            border: Border.symmetric(horizontal: BorderSide(width: 0.5)),
          ),
          child: Text(product.quantity.toString(), style: ECTextStyles.textStyleFontSize14.copyWith(fontWeight: FontWeight.bold)),
        ),
        // Increase quantity
        InkWell(
          onTap: () {
            product.quantity = (product.quantity ?? 0) + 1;
            setState(() {});
          },
          child: quantityButton(Icons.add, Colors.blue.shade800,
               BoxDecoration(
                borderRadius: const BorderRadius.only(topRight:Radius.circular(10),bottomRight:Radius.circular(10) ),
                border: Border.all(width: 0.5),
          )),
        ),
      ],
    );
  }

  /// Helper widget for creating quantity buttons
  Widget quantityButton(IconData icon, Color color,Decoration? decoration) {
    return Container(
      alignment: Alignment.center,
      height: 35,
      width: 35,
      decoration:decoration,
      child: Icon(icon, size: 20, color: color),
    );
  }
}
