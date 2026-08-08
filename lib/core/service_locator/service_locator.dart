import 'package:car_care/core/local_storage/secure_storage.dart';
import 'package:car_care/core/locale/locale_cubit.dart';
import 'package:car_care/core/network/api_client.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/core/theme/theme_cubit.dart';
import 'package:car_care/features/advertisement/data/data_sources/advertisement_remote_data_source.dart';
import 'package:car_care/features/advertisement/data/repositories/advertisement_repository_impl.dart';
import 'package:car_care/features/advertisement/domain/repositories/i_advertisement_repository.dart';
import 'package:car_care/features/advertisement/presentation/cubit/advertisement_cubit.dart';
import 'package:car_care/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:car_care/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:car_care/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:car_care/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:car_care/features/billing/data/data_sources/billing_remote_data_source.dart';
import 'package:car_care/features/billing/data/repositories/billing_setting_repository_impl.dart';
import 'package:car_care/features/billing/domain/repositories/i_billing_repository.dart';
import 'package:car_care/features/billing/presentation/cubit/billing_cubit.dart';
import 'package:car_care/features/carwasher_management/data/data_sources/carwasher_management_remote_data_source.dart';
import 'package:car_care/features/carwasher_management/data/repositories/carwasher_repository_impl.dart';
import 'package:car_care/features/carwasher_management/domain/repositories/i_carwasher_management_repository.dart';
import 'package:car_care/features/carwasher_management/presentation/cubit/carwasher_management_cubit.dart';
import 'package:car_care/features/dashboard/data/data_sources/dashboard_remote_data_source.dart';
import 'package:car_care/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:car_care/features/dashboard/domain/repositories/i_dashboard_repository.dart';
import 'package:car_care/features/dashboard/presentation/cubit/dashboard_cubit.dart';

import 'package:car_care/features/fuel_provider_management/data/data_sources/fuel_provider_management_remote_data_source.dart';
import 'package:car_care/features/fuel_provider_management/data/repositories/fuel_provider_repository_impl.dart';
import 'package:car_care/features/fuel_provider_management/domain/repositories/i_fuel_provider_management_repository.dart';
import 'package:car_care/features/fuel_provider_management/presentation/cubit/fuel_provider_management_cubit.dart';
import 'package:car_care/features/invoice/data/data_sources/invoice_remote_data_source.dart';
import 'package:car_care/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:car_care/features/reports/data/data_sources/reports_remote_data_source.dart';
import 'package:car_care/features/reports/data/repositories/reports_repository_impl.dart';
import 'package:car_care/features/reports/domain/repositories/i_reports_repository.dart';
import 'package:car_care/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:car_care/features/shop_management/data/data_sources/shop_management_remote_data_source.dart';
import 'package:car_care/features/shop_management/data/repositories/shop_repository_impl.dart';
import 'package:car_care/features/shop_management/domain/repositories/i_shop_management_repository.dart';
import 'package:car_care/features/shop_management/presentation/cubit/shop_management_cubit.dart';
import 'package:car_care/features/technician_management/data/data_sources/technician_remote_data_source.dart';
import 'package:car_care/features/technician_management/data/repositories/technician_repository_impl.dart';
import 'package:car_care/features/technician_management/domain/repositories/i_technician_repository.dart';
import 'package:car_care/features/technician_management/presentation/cubit/technician_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../features/invoice/data/repositories/invoice_repository_impl.dart';
import '../../features/invoice/domain/repositories/i_invoice_repository.dart';
final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt
    // Storage
    ..registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    )
    ..registerLazySingleton<SecureStorage>(
      () => SecureStorage(getIt<FlutterSecureStorage>()),
    )
    // Locale
    ..registerLazySingleton<LocaleCubit>(
      () => LocaleCubit(getIt<SecureStorage>()),
    )
    // Networking
    ..registerLazySingleton<ApiClient>(
      () => ApiClient(secureStorage: getIt<SecureStorage>()),
    )
    ..registerLazySingleton<ApiService>(() => ApiService(getIt<ApiClient>()))
    //  Auth data source
    // ..registerLazySingleton<AuthRemoteDataSource>(
    //   () => AuthRemoteDataSource(getIt<ApiService>()),
    // )
    // ..registerLazySingleton<IAuthRepository>(
    //   () => AuthRepositoryImpl(
    //     getIt<AuthRemoteDataSource>(),
    //     getIt<SecureStorage>(),
    //   ),
    // )
    ..registerLazySingleton<TechnicianRemoteDataSource>(
  () => TechnicianRemoteDataSource(getIt<ApiService>()),
)
..registerLazySingleton<ITechnicianRepository>(
  () => TechnicianRepositoryImpl(getIt<TechnicianRemoteDataSource>()),
)
..registerFactory<TechnicianCubit>(
  () => TechnicianCubit(getIt<ITechnicianRepository>()),
)..registerLazySingleton<CarwasherRemoteDataSource>(
    () => CarwasherRemoteDataSource(getIt<ApiService>()),
  )
  ..registerLazySingleton<ICarwasherRepository>(
    () => CarwasherRepositoryImpl(getIt<CarwasherRemoteDataSource>()),
  )
  ..registerFactory<CarwasherCubit>(
    () => CarwasherCubit(getIt<ICarwasherRepository>()),
  )

  ..registerLazySingleton<FuelProviderRemoteDataSource>(
    () => FuelProviderRemoteDataSource(getIt<ApiService>()),
  )
  ..registerLazySingleton<IFuelProviderRepository>(
    () => FuelProviderRepositoryImpl(getIt<FuelProviderRemoteDataSource>()),
  )
  ..registerFactory<FuelProviderCubit>(
    () => FuelProviderCubit(getIt<IFuelProviderRepository>()),
  )

  ..registerLazySingleton<ShopRemoteDataSource>(
    () => ShopRemoteDataSource(getIt<ApiService>()),
  )
  ..registerLazySingleton<IShopRepository>(
    () => ShopRepositoryImpl(getIt<ShopRemoteDataSource>()),
  )
  ..registerFactory<ShopCubit>(
    () => ShopCubit(getIt<IShopRepository>()),
  )
    ..registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<ApiService>()),
  )
  ..registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>(), getIt<SecureStorage>()),
  )
  ..registerFactory<AuthCubit>(
    () => AuthCubit(getIt<IAuthRepository>()),
  )
  ..registerLazySingleton<BillingSettingRemoteDataSource>(
  () => BillingSettingRemoteDataSource(getIt<ApiService>()),
)
..registerLazySingleton<IBillingSettingRepository>(
  () => BillingSettingRepositoryImpl(getIt<BillingSettingRemoteDataSource>()),
)
..registerFactory<BillingSettingCubit>(
  () => BillingSettingCubit(getIt<IBillingSettingRepository>()),
)
 

..registerLazySingleton<ReportsRemoteDataSource>(
  () => ReportsRemoteDataSource(getIt<ApiService>()),
)
..registerLazySingleton<IReportsRepository>(
  () => ReportsRepositoryImpl(getIt<ReportsRemoteDataSource>()),
)
..registerFactory<ReportsCubit>(
  () => ReportsCubit(getIt<IReportsRepository>()),
)
..registerLazySingleton<AdvertisementRemoteDataSource>(
  () => AdvertisementRemoteDataSource(getIt<ApiService>()),
)
..registerLazySingleton<IAdvertisementRepository>(
  () => AdvertisementRepositoryImpl(getIt<AdvertisementRemoteDataSource>()),
)
..registerFactory<AdvertisementCubit>(
  () => AdvertisementCubit(getIt<IAdvertisementRepository>()),
)
..registerLazySingleton<InvoiceRemoteDataSource>(
  () => InvoiceRemoteDataSource(getIt<ApiService>()),
)
..registerLazySingleton<IInvoiceRepository>(
  () => InvoiceRepositoryImpl(getIt<InvoiceRemoteDataSource>()),
)
..registerFactory<InvoiceCubit>(
  () => InvoiceCubit(getIt<IInvoiceRepository>()),
)
..registerLazySingleton<DashboardRemoteDataSource>(
  () => DashboardRemoteDataSource(getIt<ApiService>()),
)
..registerLazySingleton<IDashboardRepository>(
  () => DashboardRepositoryImpl(getIt<DashboardRemoteDataSource>()),
)
..registerFactory<DashboardCubit>(
  () => DashboardCubit(getIt<IDashboardRepository>()),
)
..registerLazySingleton<ThemeCubit>(
  () => ThemeCubit(getIt<SecureStorage>()),
);
}
