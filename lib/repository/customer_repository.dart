import '../api/api.dart';
import '../models/models.dart';

class CustomerRepository {
  static Future<CustomerModel?> getCustomer({
    required int id,
  }) async {
    CustomerModel? customerModel = await Api.getCustomer(id);
    return customerModel;
  }
}
