import 'dart:convert';

import 'package:data/export.dart';

class StoreDetailsRepoImpl implements StoreDetailsRepo {
  final NetworkHelper _networkHelper;
  final EndPoints _endPoints;

  StoreDetailsRepoImpl(this._networkHelper, this._endPoints);

  @override
  Future<Either<AppError, Store>> getStoreDetails(int id) async {
    try {
      final response = await _networkHelper.get(_endPoints.getStoreDetails(id));
      if (response.statusCode == 200) {
        var data = json.decode(response.body.toString());
        return Right(Store.fromJson(data['body']));
      } else {
        return Left(AppError());
      }
    } catch (error) {
      return Left(AppError(title: error.toString()));
    }
  }
}
