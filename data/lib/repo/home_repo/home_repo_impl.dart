import 'dart:async';
import 'dart:convert';

import 'package:data/export.dart';

class HomeRepoImpl implements HomeRepo {
  final NetworkHelper _networkHelper;
  final EndPoints _endPoints;

  HomeRepoImpl(this._networkHelper, this._endPoints);

  @override
  Future<Either<AppError, List<LocationModel>>> getUserAddress() async {
    try {
      refreshToken();
      final response = await _networkHelper.get(
        _endPoints.getUserLocation(),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body.toString());
        return Right(AddressList.fromJson(data).list);
      }
      return Left(
        AppError(),
      );
    } catch (e) {
      return Left(
        AppError(title: e.toString()),
      );
    }
  }

  @override
  Future<Either<AppError, StoreCategories>> getAllCategories() async {
    try {
      final response = await _networkHelper.get(
        _endPoints.getAllCategories(),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body.toString());
        return Right(StoreCategories.fromJson(data));
      }
      return Left(
        AppError(),
      );
    } catch (e) {
      return Left(
        AppError(title: e.toString()),
      );
    }
  }

  @override
  Future<Either<AppError, StoresList>> getTopRatedStore() async {
    try {
      final response = await _networkHelper.get(
        _endPoints.getTopRatedStore(),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body.toString());
        return Right(StoresList.fromJson(data));
      }
      return Left(
        AppError(),
      );
    } catch (e) {
      return Left(
        AppError(title: e.toString()),
      );
    }
  }

  @override
  Future<Either<AppError, StoresList>> getNearByStore() async {
    try {
      final response = await _networkHelper.get(
        _endPoints.getNearByStore(),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body.toString());
        return Right(StoresList.fromJson(data));
      }
      return Left(
        AppError(),
      );
    } catch (e) {
      return Left(
        AppError(title: e.toString()),
      );
    }
  }

  @override
  Future<Either<AppError, TransactionList>> getTransactions() async {
    try {
      final response = await _networkHelper.get(
        _endPoints.getCustomerTransaction(),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body.toString());
        return Right(TransactionList.fromJson(data));
      }
      return Left(
        AppError(),
      );
    } catch (e) {
      return Left(
        AppError(title: e.toString()),
      );
    }
  }

  @override
  Future<Either<AppError, String>> refreshToken() {
    try {
      Timer.periodic(const Duration(seconds: 10), (Timer timer) {
        _networkHelper
            .get(
          _endPoints.refreshToken(),
        )
            .then((value){
          if (value.statusCode == 201) {
            var data = json.decode(value.body.toString());
            if (data['body']['jwt'] != null) {
              return Right(data['body']['jwt']);
            }

            print(data);
          } else {
            return Left(AppError());
          }
        });
      });
    } catch (error) {
      print(error);
    }
  }
}
