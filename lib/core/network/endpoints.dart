class Endpoints {
  static const String baseUrl =
      'https://food-system-backend-production.up.railway.app/api/v1'; // Replace with actual backend URL

  // Auth
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String me = '/auth/me';

  // Categories
  static const String categoriesMain = '/categories/main';
  static String subCategories(String id) => '/categories/$id/subcategories';

  // Products
  static const String products = '/products';
  static String productDetails(String id) => '/products/$id';

  // Cart
  static const String cart = '/cart';
  static const String cartAdd = '/cart/add';
  static const String cartRemove = '/cart/item';
  static const String applyCoupon = '/coupons/apply';

  // Orders
  static const String orders = '/orders';
  static const String myOrders = '/orders/my';
  static String orderDetails(String id) => '/orders/$id';
}
