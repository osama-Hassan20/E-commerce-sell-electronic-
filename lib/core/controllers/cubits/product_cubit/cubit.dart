
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_electronics/core/controllers/cubits/product_cubit/states.dart';

import '../../../../models/product_model.dart';
import '../../../network/end_point.dart';
import '../../../network/remote/dio_helper.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitState());
  static ProductCubit get(context) => BlocProvider.of(context);
  LaptopsModel? laptopsModel;
  void getHomeProducts(){
    emit(FetchProductsLoadingState());
    DioHelper.getData(url:EndPoint.homeApi).then((value){
      laptopsModel = LaptopsModel.fromJson(value.data);
      print(laptopsModel!.product!.length);
      emit(FetchProductsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(FetchProductsErrorState());
    });
  }
}