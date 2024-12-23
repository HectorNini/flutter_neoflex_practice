import 'package:flutter/foundation.dart';
import 'package:flutter_app/feature/color/data/data_source/file_local_color_data_source.dart';
import 'package:flutter_app/feature/color/data/data_source/local_color_data_source.dart';
import 'package:flutter_app/feature/color/data/data_source/shared_pref_local_color_data_source.dart';
import 'package:flutter_app/feature/color/data/repository/color_repository_impl.dart';
import 'package:flutter_app/feature/color/domain/repository/color_repository.dart';
import 'package:flutter_app/feature/color/domain/usecase/get_color_use_case.dart';
import 'package:flutter_app/feature/color/domain/usecase/select_color_use_case.dart';
import 'package:flutter_app/feature/color/presentation/cubit/color_cubit.dart';
import 'package:get_it/get_it.dart';

void configureDependencies()
{

  if (kIsWeb) 
  {
    GetIt.I.registerFactory<LocalColorDataSource>(()=> SharedPrefLocalColorDatasource());
  }
  else 
  {
    GetIt.I.registerFactory<LocalColorDataSource>(()=> FileColorDataSource());
  }
  
  GetIt.I.registerFactory<ColorRepository>(()=> ColorRepositoryImpl(localColorDataSource: GetIt.I()));
  GetIt.I.registerFactory(()=>GetColorUseCase(colorRepository: GetIt.I()));
  GetIt.I.registerFactory(()=>SelectColorUseCase(colorRepository: GetIt.I()));

  GetIt.I.registerLazySingleton<ColorCubit>(()=>ColorCubit(GetIt.I(), GetIt.I()));


    
}