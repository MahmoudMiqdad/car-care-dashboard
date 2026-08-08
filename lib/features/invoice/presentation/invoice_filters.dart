class InvoiceFilters {
  final String? providerType;
  final int? providerId;
  final String status; // all / draft / issued / paid / overdue / cancelled
  final String? from;
  final String? to;

  const InvoiceFilters({
    this.providerType,
    this.providerId,
    this.status = 'all',
    this.from,
    this.to,
  });

  InvoiceFilters copyWith({
    String? providerType,
    int? providerId,
    String? status,
    String? from,
    String? to,
  }) {
    return InvoiceFilters(
      providerType: providerType ?? this.providerType,
      providerId: providerId ?? this.providerId,
      status: status ?? this.status,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }
}