import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/features/technician_management/presentation/widgets/technician_widgets.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/features/technician_management/domain/entities/technician_entity.dart';
import 'package:car_care/features/technician_management/presentation/cubit/technician_cubit.dart';
import 'package:car_care/features/technician_management/presentation/cubit/technician_state.dart';



class TechnicianDetailsPageWeb extends StatelessWidget {
  final int technicianId;

  const TechnicianDetailsPageWeb({super.key, required this.technicianId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TechnicianCubit>(
      create: (_) => getIt<TechnicianCubit>()..loadTechnicianDetails(technicianId),
      child: _TechnicianDetailsView(technicianId: technicianId),
    );
  }
}

class _TechnicianDetailsView extends StatefulWidget {
  final int technicianId;

  const _TechnicianDetailsView({required this.technicianId});

  @override
  State<_TechnicianDetailsView> createState() => _TechnicianDetailsViewState();
}

class _TechnicianDetailsViewState extends State<_TechnicianDetailsView> {
  
  TechnicianEntity? _technician;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return AdminLayout(
      currentRoute: 'adminTechnicians',
      title: _technician?.user?.name ?? strings.technicianDetailsTitle,
      child: BlocConsumer<TechnicianCubit, TechnicianState>(
        listener: (context, state) {
          if (state is TechnicianError) {
            AppSnackBar.error(context, state.message);
          }
          if (state is TechnicianDetailsLoaded) {
            setState(() => _technician = state.technician);
          }
          if (state is TechnicianActionSuccess && state.technician.id == widget.technicianId) {
            setState(() => _technician = state.technician);
            // عدّل اسم الدالة إذا كانت مختلفة بملف AppSnackBar عندك (success / show / info...)
            AppSnackBar.error(context, state.message);
          }
        },
        builder: (context, state) {
          final isActionLoading = state is TechnicianListActionLoading &&
              state.actionTechnicianId == widget.technicianId;

          final technician = _technician;
          if (technician == null) {
            return const Center(child: AppLoadingWidget());
          }

          return _DetailsBody(
            technician: technician,
            isActionLoading: isActionLoading,
            onBack: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.goNamed('adminTechnicians');
              }
            },
            onApprove: () => context.read<TechnicianCubit>().approveTechnician(widget.technicianId),
            onReject: (reason) =>
                context.read<TechnicianCubit>().rejectTechnician(widget.technicianId, reason),
            onSuspend: () => context.read<TechnicianCubit>().suspendTechnician(widget.technicianId),
            onReactivate: () => context.read<TechnicianCubit>().reactivateTechnician(widget.technicianId),
          );
        },
      ),
    );
  }
}

class _DetailsBody extends StatelessWidget {
  final TechnicianEntity technician;
  final bool isActionLoading;
  final VoidCallback onBack;
  final VoidCallback onApprove;
  final void Function(String reason) onReject;
  final VoidCallback onSuspend;
  final VoidCallback onReactivate;

  const _DetailsBody({
    required this.technician,
    required this.isActionLoading,
    required this.onBack,
    required this.onApprove,
    required this.onReject,
    required this.onSuspend,
    required this.onReactivate,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1500), 
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

           
              Row(
                children: [
                  IconButton(
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back_rounded, size: 20),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      technician.user?.name ?? strings.technicianDetailsTitle,
                      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TechnicianStatusBadge(status: technician.status),
                ],
              ),

              const SizedBox(height: 20),

          
            
             

             
              _InfoCard(technician: technician),

              const SizedBox(height: 16),

          
              _CertificationsCard(certifications: technician.certifications),

              const SizedBox(height: 24),

      
              _BottomActionsBar(
                technician: technician,
                isLoading: isActionLoading,
                onApprove: onApprove,
                onReject: onReject,
                onSuspend: onSuspend,
                onReactivate: onReactivate,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
Widget _btn(String text, Color color, VoidCallback onTap) {
  return SizedBox(
    height: 50,
    child: OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 25),
      ),
    ),
  );
}
class _BottomActionsBar extends StatelessWidget {
  final TechnicianEntity technician;
  final bool isLoading;
  final VoidCallback onApprove;
  final void Function(String) onReject;
  final VoidCallback onSuspend;
  final VoidCallback onReactivate;

  const _BottomActionsBar({
    required this.technician,
    required this.isLoading,
    required this.onApprove,
    required this.onReject,
    required this.onSuspend,
    required this.onReactivate,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final buttons = <Widget>[];

    switch (technician.status) {
      case 'pending':
        buttons.add(_btn(strings.actionApprove, const Color(0xFF2E7D32), onApprove));
        buttons.add(_btn(strings.actionReject, const Color(0xFFC62828), () async {
          final reason = await showTechnicianRejectDialog(context);
          if (reason != null) onReject(reason);
        }));
        break;

      case 'approved':
        buttons.add(_btn(strings.actionSuspend, const Color(0xFF616161), onSuspend));
        break;

      case 'suspended':
        buttons.add(_btn(strings.actionReactivate, const Color(0xFF2E7D32), onReactivate));
        break;
    }

    if (buttons.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: buttons,
      ),
    );
  }
}

// ignore: unused_element
class _ActionsCard extends StatelessWidget {
  final TechnicianEntity technician;
  final bool isActionLoading;
  final VoidCallback onApprove;
  final void Function(String reason) onReject;
  final VoidCallback onSuspend;
  final VoidCallback onReactivate;

  const _ActionsCard({
    required this.technician,
    required this.isActionLoading,
    required this.onApprove,
    required this.onReject,
    required this.onSuspend,
    required this.onReactivate,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    if (isActionLoading) {
      return const _Card(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(height: 22, width: 22, child: CircularProgressIndicator(strokeWidth: 2)),
          ),
        ),
      );
    }

    final buttons = <Widget>[];
    switch (technician.status) {
      case 'pending':
        buttons.add(FilledButton.icon(
          onPressed: onApprove,
          style: FilledButton.styleFrom(backgroundColor: const Color(0xFF2E7D32)),
          icon: const Icon(Icons.check_rounded, size: 18),
          label: Text(strings.actionApprove),
        ));
        buttons.add(OutlinedButton.icon(
          onPressed: () async {
            final reason = await showTechnicianRejectDialog(context);
            if (reason != null && reason.isNotEmpty) onReject(reason);
          },
          style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFFC62828)),
          icon: const Icon(Icons.close_rounded, size: 18),
          label: Text(strings.actionReject),
        ));
        break;
      case 'approved':
        buttons.add(OutlinedButton.icon(
          onPressed: onSuspend,
          style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFF616161)),
          icon: const Icon(Icons.pause_circle_outline_rounded, size: 18),
          label: Text(strings.actionSuspend),
        ));
        break;
      case 'suspended':
        buttons.add(FilledButton.icon(
          onPressed: onReactivate,
          style: FilledButton.styleFrom(backgroundColor: const Color(0xFF2E7D32)),
          icon: const Icon(Icons.play_circle_outline_rounded, size: 18),
          label: Text(strings.actionReactivate),
        ));
        break;
      case 'rejected':
        break;
    }

    if (buttons.isEmpty) return const SizedBox.shrink();

    return _Card(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: buttons,
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final TechnicianEntity technician;

  const _InfoCard({required this.technician});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    final rows = <MapEntry<String, String?>>[
      MapEntry(strings.detailsId, technician.id?.toString()),
      MapEntry(strings.detailsUserId, technician.userId?.toString()),
      MapEntry(strings.detailsEmail, technician.user?.email),
      MapEntry(strings.detailsPhone, technician.phone),
      MapEntry(strings.detailsSpecialization, technician.specialization),
      MapEntry(strings.detailsCity, technician.city),
      MapEntry(strings.detailsExperience,
          technician.experienceYears != null ? '${technician.experienceYears} ${strings.yearsSuffix}' : null),
      MapEntry(strings.detailsHourlyRate, technician.hourlyRate),
      MapEntry(strings.detailsAvailable,
          technician.isAvailable == null ? null : (technician.isAvailable! ? strings.detailsYes : strings.detailsNo)),
      MapEntry(strings.detailsStatus, _statusLabel(strings, technician.status)),
      if (technician.status == 'rejected') MapEntry(strings.detailsRejectionReason, technician.rejectionReason),
      MapEntry(strings.detailsApprovedAt, technician.approvedAt),
      MapEntry(strings.detailsRejectedAt, technician.rejectedAt),
      MapEntry(strings.detailsSuspendedAt, technician.suspendedAt),
      MapEntry(strings.detailsCreatedAt, technician.createdAt),
      MapEntry(strings.detailsUpdatedAt, technician.updatedAt),
    ].where((e) => e.value != null && e.value!.isNotEmpty).toList();

    return _Card(
      child: LayoutBuilder(
        builder: (context, constraints) {
        
          final isWide = constraints.maxWidth > 560;
          return Wrap(
            runSpacing: 10,
            children: rows.map((e) {
              return SizedBox(
                width: isWide ? constraints.maxWidth / 2 - 8 : constraints.maxWidth,
                child: _InfoRow(label: e.key, value: e.value!),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  String _statusLabel(dynamic strings, String? status) {
    switch (status) {
      case 'approved':
        return strings.statusApproved;
      case 'rejected':
        return strings.statusRejected;
      case 'suspended':
        return strings.statusSuspended;
      case 'pending':
      default:
        return strings.statusPending;
    }
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
             "${ label}  :",
              style: const TextStyle(color: AppColors.black, fontWeight: FontWeight.w600, fontSize: 18,),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}

class _CertificationsCard extends StatelessWidget {
  final List<String> certifications;

  const _CertificationsCard({required this.certifications});

  void showFullImagePreview(BuildContext context, String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty) return;
  showDialog(
    context: context,
    barrierColor: Colors.black87,
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(24),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            InteractiveViewer(
              minScale: 0.5,
              maxScale: 5,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (c, e, s) => Container(
                      height: 200,
                      width: 200,
                      color: const Color(0xFFF0F0F0),
                      child: const Icon(Icons.broken_image_outlined, size: 40),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: IconButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                icon: const Icon(Icons.close_rounded, color: Colors.white),
                style: IconButton.styleFrom(backgroundColor: Colors.black45),
              ),
            ),
          ],
        ),
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return _Card(
      
      title: strings.detailsCertifications,
      child: certifications.isEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                strings.noCertifications,
                style: const TextStyle(color:AppColors.black, fontSize: 18),
              ),
            )
          : Wrap(
              spacing: 12,
              runSpacing: 12,
              children: certifications.map((url) {
                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => showFullImagePreview(context, url),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      url,
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const SizedBox(
                          width: 110,
                          height: 110,
                          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        );
                      },
                      errorBuilder: (context, error, stack) => Container(
                        width: 110,
                        height: 110,
                        color: const Color(0xFFF0F0F0),
                        child: const Icon(Icons.broken_image_outlined, color: Colors.black26),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}


class _Card extends StatelessWidget {
  final String? title;
  final Widget child;

  const _Card({this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(title!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: AppColors.black)),
            const SizedBox(height: 12),
          ],
          child,
        ],
      ),
    );
  }
}
