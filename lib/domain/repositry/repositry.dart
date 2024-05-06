import 'package:salaa/data/network/failure/api_error_model.dart';
import 'package:salaa/data/network/request/category/category_request.dart';
import 'package:salaa/data/network/request/favo/favor_request.dart';
import 'package:salaa/data/network/request/login/login_request.dart';
import 'package:salaa/data/network/request/profile/request.dart';
import 'package:salaa/data/network/request/search/search_request.dart';
import 'package:salaa/domain/model/aboutAs/about_as_model.dart';
import 'package:salaa/domain/model/category/category_model.dart';
import 'package:salaa/domain/model/contactUs/contact_us_model.dart';
import 'package:salaa/domain/model/favor/favor_model.dart';
import 'package:salaa/domain/model/home/category.dart';
import 'package:salaa/domain/model/home/home_model.dart';
import 'package:salaa/domain/model/login/login_model.dart';
import 'package:dartz/dartz.dart';
import 'package:salaa/domain/model/register/register_model.dart';

import '../../data/network/request/addProduct/request.dart';
import '../../data/network/request/register/register_request.dart';
import '../../data/network/request/updateProduct/product.dart';
import '../model/AddProduct/model.dart';
import '../model/deleteProduct/model.dart';
import '../model/getFvor/get_favor_model.dart';
import '../model/getProduct/model.dart';
import '../model/updateProduct/model.dart';

abstract class Repository{
 Future<Either<ApiErrorModel,LoginModel>> login(LoginRequest loginRequest);
 Future<Either<ApiErrorModel,RegisterModel>> register(RegisterRequest registerRequest);
 Future<Either<ApiErrorModel,FavoriteModel>> favor(FavorRequest favorRequest);
 Future<Either<ApiErrorModel,CategoryDaTADetailsModel>> categoryData(CategoryRequest categoryRequest);
 Future<Either<ApiErrorModel,CategoryDaTADetailsModel>> search(SearchRequest request);
 Future<Either<ApiErrorModel,HomeModel>> home();
 Future<Either<ApiErrorModel,CategoryModel>> category();
 Future<Either<ApiErrorModel,GetFavoriteDataModel>> getFavor();
 Future<Either<ApiErrorModel,LoginModel>> profile(ProfileRequest profileRequest);
  Future<Either<ApiErrorModel,AboutAsModel>> getSettings();
 Future<Either<ApiErrorModel,ContactUsModel>> getContacts();
 Future<Either<ApiErrorModel,GetProductDaTaModel>> getProducts();
 Future<Either<ApiErrorModel,AddProductModel>> addProducts(ProductRequest productRequest);
 Future<Either<ApiErrorModel,DeleteProductDaTaModel>> deleteProduct(ProductRequest productRequest);
 Future<Either<ApiErrorModel,UpdateProductDaTaModel>> updateProduct(UpdateProductRequest updateProductRequest);

}