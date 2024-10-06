
import "package:e_commerce/config/path_export.dart";
class BaseStorage {

   SharedPreferences? webLocalData; // Initialize for web storage

  Future<void> init() async {
    if(webLocalData == null) {
      webLocalData = await SharedPreferences.getInstance();
    }
  }

   List<ProductDetails>  getProductDetailsList(String key) {
    String? data = webLocalData!.getString(key);
    if(data != null) {
      final List<dynamic> jsonArray = json.decode(data);
      List<ProductDetails> productDetailsList =
      jsonArray.map((json) => ProductDetails.fromJson(json)).toList();
      return productDetailsList; // Decode and return
    }else{
      return [];
    }
  }


  void setProductDetailsList(String key, List<ProductDetails> productList) {
      List<Map<String, dynamic>> productDetailsList = productList.map((json) => json.toJson()).toList();
      webLocalData!.setString(key, jsonEncode(productDetailsList)); // Store in web storage
  }



   ProductDetails  getProductDetails(String key) {
     String? data = webLocalData!.getString(key);
     if(data != null) {
       final  jsonData = json.decode(data);
       return ProductDetails.fromJson(jsonData); // Decode and return
     }else{
       return ProductDetails();
     }
   }


   void setProductDetails(String key, ProductDetails productList) {
     var productDetailsList = productList.toJson();
     webLocalData!.setString(key, jsonEncode(productDetailsList)); // Store in web storage
   }

   void setOrderedProductDetailsList(String key,OrderProduct orderProduct) {
     webLocalData!.setString(key, jsonEncode(orderProduct)); // Store in web storage
   }

  /// Remove a key from the storage.
  ///
  /// - [key]: The key to remove.
  void remove(String key) {
      webLocalData!.remove(key);
  }

  /// Delete all stored keys.
  void deleteAll() {
      webLocalData!.clear();
  }
}
