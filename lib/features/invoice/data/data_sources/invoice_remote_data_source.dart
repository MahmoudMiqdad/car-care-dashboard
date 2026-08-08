import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/invoice/data/models/invoice_model.dart';



class InvoiceRemoteDataSource {
  final ApiService _api;
  const InvoiceRemoteDataSource(this._api);

  Future<InvoiceListModel> getInvoices({
    String? providerType,
    int? providerId,
    String? status,
    String? from,
    String? to,
  }) async {
    final query = <String, String>{};
    if (providerType != null && providerType.isNotEmpty) query['provider_type'] = providerType;
    if (providerId != null) query['provider_id'] = providerId.toString();
    if (status != null && status.isNotEmpty && status != 'all') query['status'] = status;
    if (from != null && from.isNotEmpty) query['from'] = from;
    if (to != null && to.isNotEmpty) query['to'] = to;

    final queryString = query.entries.map((e) => '${e.key}=${e.value}').join('&');
    final endpoint = queryString.isEmpty
        ? ApiEndpoints.adminBillingInvoices
        : '${ApiEndpoints.adminBillingInvoices}?$queryString';

    final res = await _api.get(endPoint: endpoint);
    return InvoiceListModel.fromJson(res);
  }

  Future<InvoiceModel> getInvoice(int id) async {
    final res = await _api.get(endPoint: '${ApiEndpoints.adminBillingInvoices}/$id');
    return InvoiceModel.fromJson(res);
  }

  Future<InvoiceGenerateResponseModel> generateInvoices({
    required String periodStart,
    required String periodEnd,
    String? providerType,
    int? providerId,
  }) async {
    final res = await _api.post(
      endPoint: ApiEndpoints.adminBillingInvoicesGenerate,
      data: {
        'period_start': periodStart,
        'period_end': periodEnd,
        if (providerType != null) 'provider_type': providerType,
        if (providerId != null) 'provider_id': providerId,
      },
    );
    return InvoiceGenerateResponseModel.fromJson(res);
  }

  Future<InvoiceModel> issueInvoice(int id) async {
    final res = await _api.post(
      endPoint: '${ApiEndpoints.adminBillingInvoices}/$id/issue',
      data: {},
    );
    return InvoiceModel.fromJson(res);
  }

  Future<InvoiceModel> markInvoicePaid(
    int id, {
    String? externalPaymentMethod,
    String? externalPaymentReference,
    String? notes,
  }) async {
    final res = await _api.post(
      endPoint: '${ApiEndpoints.adminBillingInvoices}/$id/mark-paid',
      data: {
        if (externalPaymentMethod != null) 'external_payment_method': externalPaymentMethod,
        if (externalPaymentReference != null) 'external_payment_reference': externalPaymentReference,
        if (notes != null) 'notes': notes,
      },
    );
    return InvoiceModel.fromJson(res);
  }

  Future<InvoiceModel> cancelInvoice(int id) async {
    final res = await _api.post(
      endPoint: '${ApiEndpoints.adminBillingInvoices}/$id/cancel',
      data: {},
    );
    return InvoiceModel.fromJson(res);
  }
}