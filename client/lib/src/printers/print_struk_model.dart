class PrinterStrukModel {
  PrinterStrukModel({
    this.billId,
    this.billNumber,
    this.totalQty,
    this.company,
    this.outlet,
    this.device,
    this.address,
    this.customer,
    this.pax,
    this.totalBill,
    this.change,
    this.totalPay,
    this.paymentMethod,
    this.lisProduct,
  });

  final String? company;
  final String? outlet;
  final String? device;
  final String? address;
  final String? customer;
  final String? pax;
  final String? totalBill;
  final String? change;
  final String? totalPay;
  final String? totalQty;
  final List<Map>? paymentMethod;
  final String? billId;
  final String? billNumber;
  final List<PrinterProduct>? lisProduct;

  toJson() {
    final data = {};
    data['company'] = company;
    data['outlet'] = outlet;
    data['device'] = device;
    data['address'] = address;
    data['customer'] = customer;
    data['pax'] = pax;
    data['totalBill'] = totalBill;
    data['change'] = change;
    data['totalPay'] = totalPay;
    data['totalQty'] = totalQty;
    data['psyamentMethod'] = paymentMethod;
    data['lisProduct'] = lisProduct == null ? null : lisProduct!.map((e) => e.toJson()).toList();
    return data;
  }
}

class PrinterProduct {
  PrinterProduct({this.name, this.price, this.total, this.note, this.qty});

  final String? name;
  final String? price;
  final String? total;
  final String? note;
  final String? qty;

  toJson() {
    final data = {};
    data['name'] = name;
    data['price'] = price;
    data['total'] = total;
    data['note'] = note;
    data['qty'] = qty;

    return data;
  }
}
