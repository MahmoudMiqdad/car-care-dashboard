// advertisement_widgets.dart
import 'dart:typed_data';

import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/advertisement/domain/entities/advertisement_entity.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


Future<bool?> showAdvertisementDeleteDialog(BuildContext context) async {
  final strings = context.l10n;
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(strings.adDeleteConfirmTitle, style: const TextStyle(fontSize: 20)),
      content: Text(strings.adDeleteConfirmMessage, style: const TextStyle(fontSize: 15)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(strings.cancel, style: const TextStyle(fontSize: 15)),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: const Color(0xFFC62828)),
          onPressed: () => Navigator.pop(context, true),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(strings.adActionDelete, style: const TextStyle(fontSize: 15)),
          ),
        ),
      ],
    ),
  );
}

class AdvertisementStatusBadge extends StatelessWidget {
  final bool? isActive;
  const AdvertisementStatusBadge({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final active = isActive ?? false;
    final color = active ? const Color(0xFF2E7D32) : const Color(0xFF616161);
    return UnconstrainedBox(
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      active ? strings.adStatusActive : strings.adStatusInactive,
      style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13),
    ),
  ),
);

  }
}

class AdvertisementFilterBar extends StatelessWidget {
  final String currentPlacement;
  final bool? currentIsActive;
  final ValueChanged<String> onPlacementChanged;
  final ValueChanged<bool?> onActiveChanged;

  const AdvertisementFilterBar({
    super.key,
    required this.currentPlacement,
    required this.currentIsActive,
    required this.onPlacementChanged,
    required this.onActiveChanged,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final placements = <String, String>{
      'all': strings.adFilterAll,
      'home': strings.adFilterHome,
      'general': strings.general,
      'dashboard': strings.dashboard,
      'service': strings.service,

    };

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ...placements.entries.map((entry) {
          final selected = entry.key == currentPlacement;
          return ChoiceChip(
            label: Text(entry.value),
            selected: selected,
            onSelected: (_) => onPlacementChanged(entry.key),
            labelPadding: const EdgeInsets.symmetric(horizontal: 4),
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.15),
            labelStyle: TextStyle(
              fontSize: 14,
              color: selected ? Theme.of(context).colorScheme.primary : AppColors.white,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
            backgroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          );
        }),
        const SizedBox(width: 8),
        DropdownButton<bool?>(
          value: currentIsActive,
          hint: Text(strings.adColumnStatus, style: const TextStyle(fontSize: 14)),
          items: [
            DropdownMenuItem(value: null, child: Text(strings.adFilterAll)),
            DropdownMenuItem(value: true, child: Text(strings.adStatusActive)),
            DropdownMenuItem(value: false, child: Text(strings.adStatusInactive)),
          ],
          onChanged: onActiveChanged,
        ),
      ],
    );
  }
}

class AdvertisementTableHeader extends StatelessWidget {
  const AdvertisementTableHeader({super.key});
  static const _style = TextStyle(fontWeight: FontWeight.w600, color: Colors.black54, fontSize: 15);

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: const Color(0xFFF6F7FB), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(strings.adColumnImage, style: _style)),
          Expanded(flex: 3, child: Text(strings.adColumnTitle, style: _style)),
          Expanded(flex: 2, child: Text(strings.adColumnPlacement, style: _style)),
          Expanded(flex: 3, child: Text(strings.adColumnPeriod, style: _style)),
          Expanded(flex: 1, child: Text(strings.adColumnSortOrder, style: _style)),
          Expanded(flex: 2, child: Text(strings.adColumnStatus, style: _style)),
          Expanded(flex: 3, child: Text(strings.adColumnActions, style: _style)),
        ],
      ),
    );
  }
}

Widget _btn(String text, Color color, VoidCallback onTap) {
  return SizedBox(
    height: 34,
    child: OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 13)),
    ),
  );
}

String _formatDate(String? iso) {
  if (iso == null || iso.isEmpty) return '—';
  try {
    final d = DateTime.parse(iso);
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  } catch (_) {
    return iso;
  }
}

class AdvertisementTableRow extends StatelessWidget {
  final AdvertisementEntity ad;
  final bool isActionLoading;
  final bool isMobile;
  final VoidCallback onViewDetails;
  final VoidCallback onEdit;
  final VoidCallback onActivate;
  final VoidCallback onDeactivate;
  final VoidCallback onDelete;

  const AdvertisementTableRow({
    super.key,
    required this.ad,
    required this.isActionLoading,
    this.isMobile = false,
    required this.onViewDetails,
    required this.onEdit,
    required this.onActivate,
    required this.onDeactivate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return isMobile ? _buildMobileCard(context) : _buildDesktopRow(context);
  }

  Widget _thumb() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: ad.imageUrl != null
          ? Image.network(
              ad.imageUrl!,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) => Container(
                width: 60,
                height: 60,
                color: const Color(0xFFF0F0F0),
                child: const Icon(Icons.broken_image_outlined, color: Colors.black26),
              ),
            )
          : Container(
              width: 60,
              height: 60,
              color: const Color(0xFFF0F0F0),
              child: const Icon(Icons.image_outlined, color: Colors.black26),
            ),
    );
  }

  Widget _buildDesktopRow(BuildContext context) {
    final strings = context.l10n;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: InkWell(
        onTap: onViewDetails,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            Expanded(flex: 2, child: _thumb()),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(ad.title ?? '—', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15), overflow: TextOverflow.ellipsis),
              ),
            ),
            Expanded(flex: 2, child: Text(ad.placement ?? '—', style: const TextStyle(fontSize: 14))),
            Expanded(
              flex: 3,
              child: Text('${_formatDate(ad.startsAt)} → ${_formatDate(ad.endsAt)}', style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold )),
            ),
            Expanded(flex: 1, child: Text('${ad.sortOrder ?? 0}', style: const TextStyle(fontSize: 14))),
            Expanded(flex: 2, child: AdvertisementStatusBadge(isActive: ad.isActive)),
            Expanded(
              flex: 3,
              child: isActionLoading
                  ? const Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)))
             
                  : GestureDetector(
                      onTap: () {},
                      child: _buildActions(strings),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileCard(BuildContext context) {
    final strings = context.l10n;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: onViewDetails,
            borderRadius: BorderRadius.circular(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _thumb(),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ad.title ?? '—', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15), overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text('${_formatDate(ad.startsAt)} → ${_formatDate(ad.endsAt)}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                    ],
                  ),
                ),
                AdvertisementStatusBadge(isActive: ad.isActive),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 14,
            runSpacing: 6,
            children: [
              Text('${strings.adColumnPlacement}: ${ad.placement ?? '—'}', style: const TextStyle(fontSize: 12, color: Colors.black87)),
              Text('${strings.adColumnSortOrder}: ${ad.sortOrder ?? 0}', style: const TextStyle(fontSize: 12, color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 12),
          isActionLoading
              ? const Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)))
              : _buildActions(strings),
        ],
      ),
    );
  }

  Widget _buildActions(dynamic strings) {
    final buttons = <Widget>[
      _btn(strings.adActionEdit, Colors.blueGrey, onEdit),
      if (ad.isActive == true)
        _btn(strings.adActionDeactivate, const Color(0xFF616161), onDeactivate)
      else
        _btn(strings.adActionActivate, const Color(0xFF2E7D32), onActivate),
      _btn(strings.adActionDelete, const Color(0xFFC62828), onDelete),
    ];
    return Wrap(spacing: 8, runSpacing: 6, children: buttons);
  }
}

class AdvertisementImagePicker extends StatelessWidget {
  final XFile? pickedImage;
  final String? existingImageUrl;
  final VoidCallback onPick;

  const AdvertisementImagePicker({
    super.key,
    required this.pickedImage,
    required this.existingImageUrl,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final hasNew = pickedImage != null;
    final hasExisting = existingImageUrl != null && existingImageUrl!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(strings.adFormImageLabel, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
        const SizedBox(height: 4),
        Text(strings.adFormImageHint, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        const SizedBox(height: 10),
        InkWell(
          onTap: onPick,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: const Color(0xFFF6F7FB),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12),
            ),
            child: hasNew
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FutureBuilder<Uint8List>(
                      future: pickedImage!.readAsBytes(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                        return Image.memory(snapshot.data!, fit: BoxFit.cover);
                      },
                    ),
                  )
                : hasExisting
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          existingImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stack) =>
                              const Icon(Icons.broken_image_outlined, color: Colors.black26, size: 40),
                        ),
                      )
                    : const Icon(Icons.add_photo_alternate_outlined, color: Colors.black38, size: 40),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: OutlinedButton.icon(
            onPressed: onPick,
            icon: const Icon(Icons.upload_rounded, size: 20),
            label: Text((hasNew || hasExisting) ? strings.adFormChangeImage : strings.adFormChooseImage ,      style: TextStyle( fontWeight: FontWeight.bold, fontSize: 25),)
          ),
        ),
      ],
    );
  }
}