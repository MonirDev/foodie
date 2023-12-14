import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/app/data/datasource_reference/datasource_reference.dart';
import 'package:foodie/app/data/models/food_model.dart';

class ProductService {
  //get food collection data
  Future<List<FoodModel>> fetchFoodCollectionData() async {
    try {
      QuerySnapshot<FoodModel> querySnapshot =
          await DataSourceReference.foodCollectionsRef.get();

      final result = querySnapshot.docs.map((doc) => doc.data()).toList();
      return result;
    } catch (e) {
      throw e.toString();
    }
  }
}
