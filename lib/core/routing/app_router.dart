import 'package:car_care/features/fuel_provider/provider_order/presentation/pages/provider_order_page.dart';
import 'package:car_care/features/user_fuel_orders/presentation/pages/user_fuel_orders_page.dart';
import 'package:car_care/features/userfuel_orders/presentation/pages/userfuel_orders_page.dart';
import 'package:car_care/features/fuel_provider/provider_available_orders/presentation/pages/provider_available_orders_page.dart';
import 'package:car_care/features/fuel_provider/share_location_fuel/presentation/pages/share_location_fuel_page.dart';
import 'package:car_care/features/fuel_provider/share_location/presentation/pages/share_location_page.dart';
import 'package:car_care/features/available_orders/presentation/pages/available_orders_page.dart';
import 'package:car_care/features/fuel_provider/provider_statistics/presentation/pages/provider_statistics_page.dart';
import 'package:car_care/features/fuel_provider/provider_prices/presentation/pages/provider_prices_page.dart';
import 'package:car_care/features/fuel_provider/provider_profile/presentation/pages/provider_profile_page.dart';
import 'package:car_care/features/fuel_orders/presentation/pages/fuel_orders_page.dart';
import 'package:car_care/core/widgets/main_shell.dart';
import 'package:car_care/features/sos/presentation/pages/Create_sos_page_wrapper.dart';
import 'package:car_care/features/technician/technician_profile/domain/entities/technician_profile_entity.dart';
import 'package:car_care/features/technician/technician_profile/presentation/pages/insert_technician_profile/insert_technician_profile.dart';
import 'package:car_care/features/technician_sos/presentation/pages/all_technician_sos_requests.dart';
import 'package:car_care/features/technician_sos/presentation/pages/sos_details_page.dart';
import 'package:car_care/features/technician_sos/presentation/technician_sos_request_type.dart';
import 'package:car_care/features/technician_sos/presentation/widgets/sos_requests_list/technician_sos_requests_list_page.dart';
import 'package:car_care/features/technician_sos/presentation/widgets/sos_requests_list/technician_sos_map_page.dart';
import 'package:car_care/features/tracking/presentation/pages/tracking_page.dart';
import 'package:car_care/features/sos/presentation/pages/all_user_sos_requests.dart';
import 'package:car_care/features/sos/presentation/pages/sos_details_page.dart';
import 'package:car_care/features/car_washer/bookings/domain/entities/bookings_entity.dart';
import 'package:car_care/features/car_washer/bookings/presentation/pages/booking_details_page.dart';
import 'package:car_care/features/car_washer/bookings/presentation/pages/bookings_page.dart';
import 'package:car_care/features/car_washer/bookings/presentation/pages/washer_bookings_details.dart';
import 'package:car_care/features/car_washer/bookings/presentation/pages/washer_bookings_page.dart';
import 'package:car_care/features/car_washer/profile_washer/presentation/pages/edit_profile_washer_page.dart';
import 'package:car_care/features/car_washer/profile_washer/presentation/pages/profile_washer_page.dart';
import 'package:car_care/features/car_washer/availability/presentation/pages/availability_page.dart';
import 'package:car_care/features/car_washer/ratings/presentation/pages/ratings_page.dart';
import 'package:car_care/features/car_washer/statistics/presentation/pages/statistics_page.dart';
import 'package:car_care/features/car_washer/washers/domain/entities/washers_entity.dart';
import 'package:car_care/features/car_washer/washers/presentation/pages/washer_details_page.dart';
import 'package:car_care/features/car_washer/washers/presentation/pages/washer_reservation_page.dart';
import 'package:car_care/features/car_washer/washers/presentation/pages/washers_page.dart';
import 'package:car_care/features/maintenance/user_requests/presentation/pages/show_requests/all_requests_stats_page.dart';
import 'package:car_care/features/technician/technician_order/presentation/pages/order_details_page.dart';
import 'package:car_care/features/technician/technician_order/presentation/pages/orders_page.dart';
import 'package:car_care/features/technician/technician_profile/presentation/pages/tetechnician_profile_view/technician_profile_view_page.dart';
import 'package:car_care/features/technician/technician_profile/presentation/pages/update_technician_profile/update_technician_profile.dart';
import 'package:car_care/features/technician/technician_statistics/presentation/pages/technician_statistics_page.dart';
import 'package:car_care/features/technician/technician_jobs/presentation/pages/technician_jobs_page.dart';
import 'package:car_care/features/technician/technician_quotations/presentation/pages/technician_quotations_page.dart';
import 'package:car_care/features/maintenance/user_rate_job/presentation/pages/rate_job_page.dart';
import 'package:car_care/features/maintenance/user_requests/presentation/pages/add_requests_page.dart';
import 'package:car_care/features/maintenance/user_statistics/presentation/pages/statistics_page.dart';
import 'package:car_care/features/maintenance/user_quotations/presentation/pages/quotations_page.dart';
import 'package:car_care/features/user_profile/presentation/pages/profile_page.dart';
import 'package:car_care/features/user_profile/presentation/widgets/delete_confirmation_dialog.dart';
import 'package:car_care/features/vehicle/presentation/pages/maintenance_history_page.dart';
import 'package:car_care/features/user_profile/presentation/pages/change_password_page.dart';
import 'package:car_care/features/vehicle/presentation/pages/vehicle_details_page.dart';
import 'package:car_care/features/vehicle/presentation/pages/add_vehicle_page.dart';
import 'package:car_care/features/vehicle/presentation/pages/my_vehicles_page_page.dart';
import 'package:car_care/features/auth/presentation/pages/login_page.dart';
import 'package:car_care/core/routing/routes.dart';
import 'package:car_care/core/widgets/custom_appbar.dart';
import 'package:car_care/core/widgets/technician_entry_sheet.dart';
import 'package:car_care/features/auth/presentation/pages/register_page.dart';
import 'package:car_care/features/home/presentation/pages/home_page.dart';
import 'package:car_care/features/home/presentation/pages/notifications_page.dart';
import 'package:car_care/features/home/presentation/widgets/home_bottom_nav_bar.dart';
import 'package:car_care/features/user_profile/presentation/pages/profile_setup_page.dart';
import 'package:car_care/features/vehicle/presentation/widgets/UpdateVehicle/UpdateVehiclePage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.technician_sos_requests,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Routes.login,
        name: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.signup,
        name: '/signup',
        builder: (context, state) => const RegisterPage(),
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          final location = state.matchedLocation;
          final bottomNavIndex = switch (location) {
            Routes.notifications => 1,
            Routes.all_requests => 2,
            Routes.home => 0,
            _ => -1,
          };
          return MainAppShell(
            bottomNavigationBar: HomeBottomNavBar(
              activeIndex: bottomNavIndex,
              onItemSelected: (index) {
                switch (index) {
                  case 0:
                    context.go(Routes.home);
                    break;
                  case 1:
                    context.go(Routes.notifications);
                    break;
                  case 2:
                    context.go(Routes.all_requests);
                    break;
                  case 3:
                    showTechnicianEntrySheet(context);
                    break;
                  default:
                    break;
                }
              },
            ),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: Routes.home,
            name: '/home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: Routes.allUserSosRequests,
            name: '/sos',
            builder: (context, state) => const AllUserSosRequests(),
          ),
          GoRoute(
            path: '/userSosDetailss/:id',
            name: 'sosDetails',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return SosDetailsPage(id: id);
            },
          ),
             GoRoute(
            path: '/technicianSosDetails/:id',
            name: 'SosTechnicianDetailsPage',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return SosTechnicianDetailsPage(id: id);
            },
          ),
          GoRoute(
            path: Routes.notifications,
            name: '/notifications',
            builder: (context, state) => const NotificationsPage(),
          ),
          GoRoute(
            path: Routes.all_requests,
            name: '/all_requests_stats_page',
            builder: (context, state) => const AllRequestsStatsPage(),
          ),
          GoRoute(
            path: Routes.washers,
            name: '/washers',
            builder: (context, state) => const WashersPage(),
          ),
          GoRoute(
            path: Routes.washerDetails,
            name: 'washerDetails',
            builder: (context, state) {
              final washer = state.extra as WasherEntity;
              return WasherDetailsPage(washer: washer);
            },
          ),

          GoRoute(
            path: Routes.washerReservation,
            name: 'washerReservation',
            builder: (context, state) {
              final extra = state.extra;
              final washer = extra is WasherEntity ? extra : null;
              if (washer == null) return const SizedBox.shrink();
              return WasherReservationPage(washer: washer);
            },
          ),
          GoRoute(
            path: Routes.bookings,
            name: '/bookings',
            builder: (context, state) => const CustomerBookingsPage(),
          ),
          GoRoute(
            path: Routes.washerBookings,
            name: '/washer_bookings',
            builder: (context, state) => const WasherBookingsPage(),
          ),
          GoRoute(
            path: Routes.washerBookingsDetails,
            name: 'washerBookingsDetails',
            builder: (context, state) {
              final extra = state.extra;
              if (extra is BookingsEntity) {
                return WasherBookingsDetails(booking: extra);
              }
              return const SizedBox.shrink();
            },
          ),
          GoRoute(
            path: Routes.bookingDetails,
            builder: (context, state) {
              final booking = state.extra as BookingsEntity;
              return BookingDetailsPage(booking: booking);
            },
          ),
          GoRoute(
            path: Routes.ratings,
            name: 'ratings',
            builder: (context, state) {
              final booking = state.extra as BookingsEntity;
              return RatingsPage(booking: booking);
            },
          ),
          GoRoute(
            path: Routes.availability,
            name: '/availability',
            builder: (context, state) => const AvailabilityPage(),
          ),
          GoRoute(
            path: Routes.profile_washer,
            name: '/profile_washer',
            builder: (context, state) => const ProfileWasherPage(),
          ),
// GoRoute(
//   path: '/sos-list',
//   builder: (context, state) {
//     final type = state.extra as SosRequestType;

//     return TechnicianSosRequestsListPage(type: type);
//   },
// ),
          GoRoute(
            path: Routes.technician_sos_requests,
            name: '/all_technician_sos_requests',
            builder: (context, state) => const AllTechnicianSosRequests(),
          ),
          GoRoute(
            path: Routes.tracking,
            name: '/tracking',
            builder: (context, state) => const TrackingPage(),
          ),
         

          GoRoute(
            path: Routes.editProfileWasher,
            name: 'editProfileWasher',
            builder: (context, state) {
              return const EditProfileWasherPage();
            },
          ),
              GoRoute(
        path: Routes.fuel_orders,
        name: '/fuel_orders',
        builder: (context, state) => const FuelOrdersPage(),
      ),
            GoRoute(
        path: Routes.provider_profile,
        name: '/provider_profile',
        builder: (context, state) => const ProviderProfilePage(),
      ),
            GoRoute(
        path: Routes.provider_prices,
        name: '/provider_prices',
        builder: (context, state) => const ProviderPricesPage(),
      ),
            GoRoute(
        path: Routes.provider_statistics,
        name: '/provider_statistics',
        builder: (context, state) => const ProviderStatisticsPage(),
      ),
            GoRoute(
        path: Routes.available_orders,
        name: '/available_orders',
        builder: (context, state) => const AvailableOrdersPage(),
      ),
            GoRoute(
        path: Routes.share_location,
        name: '/share_location',
        builder: (context, state) => const ShareLocationPage(),
      ),
            GoRoute(
        path: Routes.share_location_fuel,
        name: '/share_location_fuel',
        builder: (context, state) => const ShareLocationFuelPage(),
      ),
            GoRoute(
        path: Routes.provider_available_orders,
        name: '/provider_available_orders',
        builder: (context, state) => const ProviderAvailableOrdersPage(),
      ),
            GoRoute(
        path: Routes.userfuel_orders,
        name: '/userfuel_orders',
        builder: (context, state) => const UserfuelOrdersPage(),
      ),
            GoRoute(
        path: Routes.user_fuel_orders,
        name: '/user_fuel_orders',
        builder: (context, state) => const UserFuelOrdersPage(),
      ),
            GoRoute(
        path: Routes.provider_order,
        name: '/provider_order',
        builder: (context, state) => const ProviderOrderPage(),
      ),
      ],
      ),
      GoRoute(
        path: Routes.profile_setup,
        name: '/profile_setup',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => ProfileSetupPage(),
      ),
      GoRoute(
        path: Routes.user_profile,
        name: '/user_profile_page.dart',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => ProfilePage(),
      ),
      GoRoute(
        path: Routes.changepasswordpage,
        name: '/change_password',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const ChangePasswordPage(),
      ),
      GoRoute(
        path: Routes.my_vehicles_page,
        name: '/my_vehicles_page',
        builder: (context, state) => const MyVehiclesPagePage(),
      ),
      GoRoute(
        path: Routes.add_vehicle,
        name: '/add_vehicle',
        builder: (context, state) => const AddVehiclePage(),
      ),
      GoRoute(
        path: Routes.vehicle_details,
        name: '/vehicle_details',
        builder: (context, state) {
          final vehicleId = state.extra as int;
          return VehicleDetailsPage(vehicleId: vehicleId);
        },
      ),
      GoRoute(
        path: Routes.maintenanceHistory,
        name: 'maintenanceHistory',
        builder: (context, state) {
          final vehicleId = state.extra as int? ?? 0;
          return MaintenanceHistoryPage(vehicleId: vehicleId);
        },
      ),

      GoRoute(
        path: Routes.updateVehicle,
        name: Routes.updateVehicle,
        builder: (context, state) {
          final vehicleId = state.extra as int;
          return UpdateVehiclePage(vehicleId: vehicleId);
        },
      ),
      GoRoute(
        path: Routes.inserttechnicianprofile,
        name: '/insert_technician_profile',
        builder: (context, state) => const InsertTechnicianProfile(),
      ),
      GoRoute(
        path: Routes.create_sos,
        name: '/Create_sos_page_wrapper',
        builder: (context, state) => const CreateSosPageWrapper(),
      ),
      GoRoute(
        path: Routes.updateTechnicianProfile,
        name: '/update_technician_profile',
        builder: (context, state) => TechnicianProfileEditPage(
          initialData: state.extra as TechnicianDataEntity?,
        ),
      ),
      GoRoute(
        path: Routes.technicianProfileViewBody,
        name: '/technician_profile_view_page',
        builder: (context, state) => const TechnicianProfileViewPage(),
      ),

      GoRoute(
        path: Routes.quotations,
        name: '/quotations',
        builder: (context, state) => const QuotationsPage(),
      ),
      GoRoute(
        path: Routes.deleteconfirmationdialog,
        name: '/deleteconfirmationdialog',
        builder: (context, state) => const DeleteProfileDialog(),
      ),

      // GoRoute(
      //   path: Routes.ratings,
      //   name: '/ratings',
      //   parentNavigatorKey: rootNavigatorKey,
      //   builder: (context, state) => const RatingsPage(booking: null,),
      // ),
      GoRoute(
        path: Routes.statistics,
        builder: (context, state) => const UserStatisticsPage(),
      ),
      GoRoute(
        path: Routes.addRequest,
        name: '/add_requests_page.dart',

        builder: (context, state) {
          final extra = state.extra;
          final vehicleId = extra is String ? extra : null;
          return AddRequestsPage(vehicleId: vehicleId ?? '');
        },
      ),
      GoRoute(
        path: Routes.orders,
        name: '/orders_page',
        builder: (context, state) => const TechnicianOrderPage(),
      ),

      GoRoute(
        path: Routes.orderdetails,
        name: '/order_details_page',
        builder: (context, state) {
          final extra = state.extra;
          final id = extra is String ? extra : null;

          return TechnicianOrderDetailsPage(orderId: id ?? '');
        },
      ),

      GoRoute(
        path: Routes.technician_quotations,
        name: '/technician_quotations',
        builder: (context, state) {
          final extra = state.extra;
          final id = extra is String ? extra : null;

          return TechnicianQuotationsPage(requestId: id ?? '');
        },
      ),

      GoRoute(
        path: Routes.rate_job,
        name: '/rate_job',
        builder: (context, state) => const RateJobPage(),
      ),
      GoRoute(
        path: Routes.technician_jobs,
        name: '/technician_jobs',
        builder: (context, state) => const TechnicianJobsPage(),
      ),
      GoRoute(
        path: Routes.technician_statistics,
        name: '/technician_statistics',
        builder: (context, state) => const TechnicianStatisticsPage(),
      ),
      GoRoute(
  name: 'TechnicianSosMapPage',
  path: '/technician/sos/:id/map',
  builder: (context, state) {
    final extra = state.extra as Map<String, dynamic>?;
    return TechnicianSosMapPage(
      sosId: int.parse(state.pathParameters['id']!),
      clientLat: extra?['lat'],
      clientLng: extra?['lng'],
    );
  },
),
      GoRoute(
        path: Routes.washer_statistics,
        name: '/washer_statistics',
        builder: (context, state) => const CarWasherStatisticsPage(),
      ),
    ],
  );
  
}
