class BookstoreStatuses {
  const BookstoreStatuses._();

  static const int inactive = 0;
  static const int active = 1;
  static const int suspended = 2;
  static const int deleted = 3;
}

class ProductStatuses {
  const ProductStatuses._();

  static const int inactive = 0;
  static const int active = 1;
  static const int obsolete = 2;
}

class PurchaseOrderStatuses {
  const PurchaseOrderStatuses._();

  static const int draft = 0;
  static const int approved = 1;
  static const int partReceived = 2;
  static const int completed = 3;
  static const int cancelled = 4;
}

class StockMovementTypes {
  const StockMovementTypes._();

  static const String purchaseIn = 'purchase_in';
  static const String purchaseReturnOut = 'purchase_return_out';
  static const String saleOut = 'sale_out';
  static const String saleReturnIn = 'sale_return_in';
  static const String adjustIn = 'adjust_in';
  static const String adjustOut = 'adjust_out';
  static const String stockTakeGain = 'stock_take_gain';
  static const String stockTakeLoss = 'stock_take_loss';
  static const String legacyReturnIn = 'return_in';
  static const String legacyReturnOut = 'return_out';
}

class StockReferenceTypes {
  const StockReferenceTypes._();

  static const String purchaseOrder = 'purchase_order';
  static const String salesOrder = 'sales_order';
  static const String inventoryAdjustment = 'inventory_adjustment';
  static const String manualAdjustment = 'manual_adjustment';
}

class PurchaseSaleModeSeed {
  const PurchaseSaleModeSeed({
    required this.code,
    required this.name,
    this.defaultDiscountBp = 10000,
    this.allowMemberDiscount = true,
    this.allowReturns = true,
    this.requiresApproval = false,
    this.status = BookstoreStatuses.active,
  });

  final String code;
  final String name;
  final int defaultDiscountBp;
  final bool allowMemberDiscount;
  final bool allowReturns;
  final bool requiresApproval;
  final int status;
}

const defaultPurchaseSaleModes = <PurchaseSaleModeSeed>[
  PurchaseSaleModeSeed(code: 'retail', name: '普通零售'),
  PurchaseSaleModeSeed(code: 'member', name: '会员价销售'),
  PurchaseSaleModeSeed(code: 'wholesale', name: '团购/批销'),
  PurchaseSaleModeSeed(code: 'consignment', name: '寄售'),
  PurchaseSaleModeSeed(
    code: 'clearance',
    name: '特价清仓',
    allowMemberDiscount: false,
  ),
];
