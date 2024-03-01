class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1Y2RkZjJiMDM1OGE1ZjFlN2IwMTcwOSIsImlhdCI6MTcwODMzNTYzNywiZXhwIjoxNzEwOTI3NjM3fQ.npun1kXzNocZXi_nQa8UjHNU7T8s5ZE-DqpXYTjPq7w";
  // For Windows;
  // static const String baseUrl = "http://10.0.2.2:3000/api/v1/";
  // For MAC
  // static const String baseUrl = "http://localhost:3000/api/v1/";
  static const String baseUrl = "http://172.26.1.163:5000/api/";

  // ====================== Auth Routes ======================
  static const String login = "user/login";
  static const String register = "user/create";
  static const String getProfile = 'get_profile';
  static const String updateProfile = "update_my_profile";

  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String uploadImage = "auth/uploadImage";

  static const String getArticles = "articles/get_articles";
  static const String createArticles = "articles/create_articles";

  static const String createCategory = "category/create-category";
  static const String updateCategory = "category/update-category/:id";
  static const String getAllCategories = "category/allCategories";
  static const String getCategoryBySlug = "category/singleCategory/:slug";
  static const String deleteCategoryById = "category/delete-category/";

  static const String createProduct = "product/create_product";
  static const String getAllProducts = "product/get_products";
  static const String getSingleProduct = "product/get_product/";
  static const String updateProduct = "product/update_product/";
  static const String deleteProduct = "product/delete_product/";
  static const String allProductPagination = "product/get_pagination";
  static const String filterProduct = "product/product-filters";

  static const String createOrder = "order/create";
  static const String getOrders = "order/getOrdersByUser/";

  static String addUpdateHealth(String userId) => 'user/$userId/healthInfos';
  static String getHealthInfoById(String userId) => 'user/$userId/healthInfo';
  static String getCalendar(String userId) => 'calendar/user/$userId/calendar';

  static const String forgotPassword = "user/forgot-password";

  static const int limitPage = 3;
}
