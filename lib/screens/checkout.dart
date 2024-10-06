import "package:e_commerce/config/path_export.dart";


/// Checkout widget for processing the user’s orders.
class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  List<ProductDetails> productList = [];
  double total = 0;
  int itemCount = 0;
  TextEditingController customerName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<OrderBloc>(context).add(GetCartProductList());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: ConstWidget.paddingAll20,
        child: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is CartProductList) {
              total = calculateTotal(state.productList);
              itemCount = state.productList.length;
              productList = state.productList;
              setState(() {});
            }
            if (state is OrderConfirmed) {
              ECAlertDialog.showAlertDialog(
                context,
                "Your Order is Confirmed.\nContinue Shopping",
                "",
                [
                  ECButton(
                    buttonTitle: "Continue",
                    onClick: () {
                      Navigator.pop(context);
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                ],
              );
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildProductSummary(context),
                _buildPaymentSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds product summary widget.
  Widget _buildProductSummary(BuildContext context) {
    return SizedBox(
      height: HelperClass.getCurrentPlatform(context) !=
          CurrentPlatform.mobile?MediaQuery.of(context).size.height / 2.8:MediaQuery.of(context).size.height/1.4,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 265,
          crossAxisCount: HelperClass.getCurrentPlatform(context) !=
              CurrentPlatform.mobile
              ? 2
              : 1,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        children: [
          ECCard(
            isBoxDecoration: true,
            child: Column(
              children: [
                ListTile(
                  title: const Text("Price Details"),
                  titleTextStyle: ECTextStyles.textStyleFontSize16
                      .copyWith(color: Colors.brown.shade800, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  title: Text("Price ($itemCount items)"),
                  trailing: Text("\$ ${total.toStringAsFixed(2)}", style: ECTextStyles.textStyleFontSize14.copyWith(fontWeight: FontWeight.bold)),
                ),
                ListTile(
                  title: const Text("Discount"),
                  trailing: Text("0 %", style: ECTextStyles.textStyleFontSize14.copyWith(fontWeight: FontWeight.bold)),
                ),
                ListTile(
                  title: const Text("Delivery Charges"),
                  trailing: Text("FREE Delivery", style: ECTextStyles.textStyleFontSize14.copyWith(color: Colors.green)),
                ),
                ListTile(
                  title: const Text("Total Amount"),
                  trailing: Text("\$ $total", style: ECTextStyles.textStyleFontSize14.copyWith(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          _buildDeliveryDetails(),
        ],
      ),
    );
  }

  /// Builds delivery details input fields.
  Widget _buildDeliveryDetails() {
    return ECCard(
      isBoxDecoration: true,
      child: Padding(
        padding: ConstWidget.paddingAll10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Delivery Details", style: ECTextStyles.textStyleFontSize16.copyWith(fontWeight: FontWeight.bold, color: Colors.brown.shade800)),
            TextField(controller: customerName, decoration:  const InputDecoration(labelText: 'Enter Name', border: OutlineInputBorder(),)),
            TextField(controller: phoneNumber, decoration: const InputDecoration(labelText: 'Enter Phone Number',border: OutlineInputBorder(),)),
            TextField(controller: address, decoration: const InputDecoration(labelText: 'Enter Delivery Address', border: OutlineInputBorder(),)),
          ],
        ),
      ),
    );
  }

  /// Builds payment method section.
  Widget _buildPaymentSection() {
    return ECCard(
      isBoxDecoration: true,
      child: Padding(
        padding: ConstWidget.paddingAll10,
        child: Column(
          children: [
            Text("Select a payment method", style: ECTextStyles.textStyleFontSize16.copyWith(fontWeight: FontWeight.bold, color: Colors.brown.shade800)),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text("Cash on Delivery/Pay on Delivery", style: ECTextStyles.textStyleFontSize14),
              value: true,
              onChanged: (_) {},
            ),
            Text(
              "Please note: Currently, only Cash on Delivery (COD) or Pay on Delivery options are available for payment.",
              style: ECTextStyles.textStyleFontSize12.copyWith(fontWeight: FontWeight.bold, color: Colors.red),
            ),

            ConstWidget.kSizeBoxHeight20,
            ECButton(
              buttonTitle: "Confirm",
              buttonColor: Colors.amber,
              fontStyle: ECTextStyles.textStyleFontSize16
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              onClick: () {
                if (customerName.text.isNotEmpty &&
                    address.text.isNotEmpty &&
                    phoneNumber.text.isNotEmpty) {
                  BlocProvider.of<OrderBloc>(context).add(AddOrder(
                    customerName: customerName.text,
                    cardNumber: "0",
                    address: address.text,
                    phoneNumber: phoneNumber.text,
                    productList: productList,
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Enter Valid Details')),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  /// Calculates the total price of all products.
  double calculateTotal(List<ProductDetails> productList) {
    return productList.fold(0, (total, product) {
      return total + ((product.quantity ?? 0) * (product.price ?? 0));
    });
  }
}
