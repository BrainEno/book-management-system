import 'package:bookstore_management_system/features/auth/data/datasources/local/user_dao.dart'
    show Users;
import 'package:bookstore_management_system/features/product/data/datasources/local/product_dao.dart'
    show Products;
import 'package:drift/drift.dart';

// 商品分类表：用于维护商品的分类层级、分类编码和状态。
class ProductCategories extends Table {
  @override
  List<String> get customConstraints => const [
    'CHECK (status BETWEEN 0 AND 3)',
  ];

  // 主键，自增编号。
  IntColumn get id => integer().autoIncrement()();
  // 上级分类ID，用于构建树状分类；顶级分类可为空。
  IntColumn get parentId => integer()
      .nullable()
      .references(
        ProductCategories,
        #id,
        onDelete: KeyAction.setNull,
        onUpdate: KeyAction.cascade,
      )();
  // 分类编码，便于程序和报表引用。
  TextColumn get code => text().withLength(min: 1, max: 64).unique()();
  // 分类名称。
  TextColumn get name => text().withLength(min: 1, max: 128)();
  // 排序号，数值越小越靠前。
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  // 状态：0=停用，1=启用，2=挂起，3=删除。
  IntColumn get status => integer().withDefault(const Constant(1))();
  // 创建时间。
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  // 更新时间。
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 出版社表：用于维护图书出版社的基础资料。
class Publishers extends Table {
  @override
  List<String> get customConstraints => const [
    'CHECK (status BETWEEN 0 AND 3)',
  ];

  // 主键，自增编号。
  IntColumn get id => integer().autoIncrement()();
  // 出版社编码，可选但建议填写，便于外部系统对接。
  TextColumn get code => text().nullable().withLength(min: 1, max: 64).unique()();
  // 出版社名称。
  TextColumn get name => text().withLength(min: 1, max: 255).unique()();
  // 联系人姓名。
  TextColumn get contactName => text().nullable()();
  // 联系电话。
  TextColumn get phone => text().nullable()();
  // 地址信息。
  TextColumn get address => text().nullable()();
  // 状态：0=停用，1=启用，2=挂起，3=删除。
  IntColumn get status => integer().withDefault(const Constant(1))();
  // 创建时间。
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  // 更新时间。
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 购销方式表：把商品和业务单据上的购销方式统一沉淀为主数据。
class PurchaseSaleModes extends Table {
  @override
  List<String> get customConstraints => const [
    'CHECK (default_discount_bp BETWEEN 0 AND 10000)',
    'CHECK (allow_member_discount IN (0, 1))',
    'CHECK (allow_returns IN (0, 1))',
    'CHECK (requires_approval IN (0, 1))',
    'CHECK (status BETWEEN 0 AND 3)',
  ];

  // 主键，自增编号。
  IntColumn get id => integer().autoIncrement()();
  // 购销方式编码。
  TextColumn get code => text().withLength(min: 1, max: 64).unique()();
  // 购销方式名称。
  TextColumn get name => text().withLength(min: 1, max: 128).unique()();
  // 默认折扣基点，10000 表示 100%。
  IntColumn get defaultDiscountBp =>
      integer().withDefault(const Constant(10000))();
  // 是否允许叠加会员折扣。
  BoolColumn get allowMemberDiscount =>
      boolean().withDefault(const Constant(true))();
  // 是否允许退货。
  BoolColumn get allowReturns => boolean().withDefault(const Constant(true))();
  // 是否需要审批。
  BoolColumn get requiresApproval =>
      boolean().withDefault(const Constant(false))();
  // 状态：0=停用，1=启用，2=挂起，3=删除。
  IntColumn get status => integer().withDefault(const Constant(1))();
  // 创建时间。
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  // 更新时间。
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 供应商表：用于维护采购来源和结算对象等基础资料。
class Suppliers extends Table {
  @override
  List<String> get customConstraints => const [
    'CHECK (status BETWEEN 0 AND 3)',
  ];

  // 主键，自增编号。
  IntColumn get id => integer().autoIncrement()();
  // 供应商编码，通常用于业务单据和报表。
  TextColumn get code => text().withLength(min: 1, max: 64).unique()();
  // 供应商名称。
  TextColumn get name => text().withLength(min: 1, max: 255).unique()();
  // 联系人姓名。
  TextColumn get contactName => text().nullable()();
  // 联系电话。
  TextColumn get phone => text().nullable()();
  // 地址信息。
  TextColumn get address => text().nullable()();
  // 结算周期或账期说明。
  TextColumn get settlementTerm => text().nullable()();
  // 状态：0=停用，1=启用，2=挂起，3=删除。
  IntColumn get status => integer().withDefault(const Constant(1))();
  // 创建时间。
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  // 更新时间。
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 客户表：用于维护零售客户、会员和批发客户等基础资料。
class Customers extends Table {
  @override
  List<String> get customConstraints => const [
    "CHECK (customer_type IN ('retail', 'member', 'wholesale'))",
    'CHECK (status BETWEEN 0 AND 3)',
  ];

  // 主键，自增编号。
  IntColumn get id => integer().autoIncrement()();
  // 客户编码，便于在单据和报表中引用。
  TextColumn get code => text().withLength(min: 1, max: 64).unique()();
  // 客户名称。
  TextColumn get name => text().withLength(min: 1, max: 255)();
  // 客户类型：retail / member / wholesale。
  TextColumn get customerType => text()
      .withLength(min: 1, max: 16)
      .withDefault(const Constant('retail'))();
  // 联系电话。
  TextColumn get phone => text().nullable()();
  // 邮箱地址。
  TextColumn get email => text().nullable()();
  // 地址信息。
  TextColumn get address => text().nullable()();
  // 会员等级，仅会员或需要分级时使用。
  TextColumn get memberLevel => text().nullable()();
  // 状态：0=停用，1=启用，2=挂起，3=删除。
  IntColumn get status => integer().withDefault(const Constant(1))();
  // 创建时间。
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  // 更新时间。
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 仓库表：用于记录商品存放仓库、负责人和仓库状态。
class Warehouses extends Table {
  @override
  List<String> get customConstraints => const [
    'CHECK (status BETWEEN 0 AND 3)',
  ];

  // 主键，自增编号。
  IntColumn get id => integer().autoIncrement()();
  // 仓库编码。
  TextColumn get code => text().withLength(min: 1, max: 64).unique()();
  // 仓库名称。
  TextColumn get name => text().withLength(min: 1, max: 255).unique()();
  // 仓库地址。
  TextColumn get address => text().nullable()();
  // 仓库负责人，关联用户表。
  @ReferenceName('warehouseManagers')
  IntColumn get managerUserId => integer()
      .nullable()
      .references(
        Users,
        #id,
        onDelete: KeyAction.setNull,
        onUpdate: KeyAction.cascade,
      )();
  // 状态：0=停用，1=启用，2=挂起，3=删除。
  IntColumn get status => integer().withDefault(const Constant(1))();
  // 创建时间。
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  // 更新时间。
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 库存结存表：记录某仓库中某商品的当前库存、预留量和安全库存。
class StockBalances extends Table {
  @override
  List<String> get customConstraints => const [
    'CHECK (on_hand_qty >= 0)',
    'CHECK (reserved_qty >= 0)',
    'CHECK (safety_stock_qty >= 0)',
    'UNIQUE (warehouse_id, product_id)',
  ];

  // 主键，自增编号。
  IntColumn get id => integer().autoIncrement()();
  // 仓库ID。
  IntColumn get warehouseId => integer().references(
        Warehouses,
        #id,
        onDelete: KeyAction.cascade,
        onUpdate: KeyAction.cascade,
      )();
  // 商品ID。
  IntColumn get productId => integer().references(
        Products,
        #id,
        onDelete: KeyAction.cascade,
        onUpdate: KeyAction.cascade,
      )();
  // 实际可用库存。
  IntColumn get onHandQty => integer().withDefault(const Constant(0))();
  // 已预留但未出库的数量。
  IntColumn get reservedQty => integer().withDefault(const Constant(0))();
  // 安全库存阈值。
  IntColumn get safetyStockQty => integer().withDefault(const Constant(0))();
  // 货位编码或摆放位置。
  TextColumn get shelfCode => text().nullable()();
  // 最后更新时间。
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 库存流水表：记录入库、出库、退货和调整等库存变化事件。
class StockMovements extends Table {
  @override
  List<String> get customConstraints => const [
    "CHECK (movement_type IN ('purchase_in', 'purchase_return_out', 'sale_out', 'sale_return_in', 'adjust_in', 'adjust_out', 'stock_take_gain', 'stock_take_loss', 'return_in', 'return_out'))",
    'CHECK (qty_delta <> 0)',
  ];

  // 主键，自增编号。
  IntColumn get id => integer().autoIncrement()();
  // 流水单号，唯一标识一次库存变化。
  TextColumn get movementNo => text().withLength(min: 1, max: 64).unique()();
  // 流水类型：purchase_in / purchase_return_out / sale_out / sale_return_in /
  // adjust_in / adjust_out / stock_take_gain / stock_take_loss。
  TextColumn get movementType => text().withLength(min: 1, max: 32)();
  // 来源单据类型，例如 purchase_order / sales_order。
  TextColumn get refType => text().nullable()();
  // 来源单据ID。
  IntColumn get refId => integer().nullable()();
  // 仓库ID。
  IntColumn get warehouseId => integer().references(
        Warehouses,
        #id,
        onDelete: KeyAction.cascade,
        onUpdate: KeyAction.cascade,
      )();
  // 商品ID。
  IntColumn get productId => integer().references(
        Products,
        #id,
        onDelete: KeyAction.cascade,
        onUpdate: KeyAction.cascade,
      )();
  // 数量变化值，正数表示增加，负数表示减少。
  IntColumn get qtyDelta => integer()();
  // 单位成本，按分存储。
  IntColumn get unitCostCent => integer().nullable()();
  // 本次流水对应金额，按分存储。
  IntColumn get amountCent => integer().nullable()();
  // 发生时间。
  DateTimeColumn get occurredAt => dateTime()();
  // 操作人，关联用户表。
  @ReferenceName('stockMovementOperators')
  IntColumn get operatorUserId => integer()
      .nullable()
      .references(
        Users,
        #id,
        onDelete: KeyAction.setNull,
        onUpdate: KeyAction.cascade,
      )();
  // 备注信息。
  TextColumn get note => text().nullable()();
  // 创建时间。
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// 采购单主表：记录向供应商采购商品的单据头信息。
class PurchaseOrders extends Table {
  @override
  List<String> get customConstraints => const [
    'CHECK (status BETWEEN 0 AND 4)',
    'CHECK (total_amount_cent >= 0)',
    'CHECK (paid_amount_cent >= 0)',
  ];

  // 主键，自增编号。
  IntColumn get id => integer().autoIncrement()();
  // 采购单号，唯一。
  TextColumn get orderNo => text().withLength(min: 1, max: 64).unique()();
  // 供应商ID。
  IntColumn get supplierId => integer().references(
        Suppliers,
        #id,
        onDelete: KeyAction.restrict,
        onUpdate: KeyAction.cascade,
      )();
  // 入库仓库ID。
  IntColumn get warehouseId => integer().references(
        Warehouses,
        #id,
        onDelete: KeyAction.restrict,
        onUpdate: KeyAction.cascade,
      )();
  // 单据状态：0=草稿，1=已审核，2=部分收货，3=已完成，4=已取消。
  IntColumn get status => integer().withDefault(const Constant(0))();
  // 下单时间。
  DateTimeColumn get orderedAt => dateTime()();
  // 预计到货时间。
  DateTimeColumn get expectedAt => dateTime().nullable()();
  // 采购总金额，按分存储。
  IntColumn get totalAmountCent => integer().withDefault(const Constant(0))();
  // 已付款金额，按分存储。
  IntColumn get paidAmountCent => integer().withDefault(const Constant(0))();
  // 创建人，关联用户表。
  @ReferenceName('purchaseOrdersCreatedBy')
  IntColumn get createdBy => integer()
      .nullable()
      .references(
        Users,
        #id,
        onDelete: KeyAction.setNull,
        onUpdate: KeyAction.cascade,
      )();
  // 审核人，关联用户表。
  @ReferenceName('purchaseOrdersApprovedBy')
  IntColumn get approvedBy => integer()
      .nullable()
      .references(
        Users,
        #id,
        onDelete: KeyAction.setNull,
        onUpdate: KeyAction.cascade,
      )();
  // 过账人，关联用户表。
  @ReferenceName('purchaseOrdersPostedBy')
  IntColumn get postedBy => integer()
      .nullable()
      .references(
        Users,
        #id,
        onDelete: KeyAction.setNull,
        onUpdate: KeyAction.cascade,
      )();
  // 过账时间。
  DateTimeColumn get postedAt => dateTime().nullable()();
  // 备注信息。
  TextColumn get note => text().nullable()();
  // 创建时间。
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  // 更新时间。
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 采购单明细表：记录采购单中每个商品的数量、单价和折扣。
class PurchaseOrderItems extends Table {
  @override
  List<String> get customConstraints => const [
    'CHECK (qty > 0)',
    'CHECK (unit_price_cent >= 0)',
    'CHECK (discount_bp BETWEEN 0 AND 10000)',
    'CHECK (line_amount_cent >= 0)',
    'CHECK (received_qty >= 0)',
    'UNIQUE (purchase_order_id, line_no)',
  ];

  // 主键，自增编号。
  IntColumn get id => integer().autoIncrement()();
  // 采购单ID。
  IntColumn get purchaseOrderId => integer().references(
        PurchaseOrders,
        #id,
        onDelete: KeyAction.cascade,
        onUpdate: KeyAction.cascade,
      )();
  // 行号，便于同单据内排序。
  IntColumn get lineNo => integer()();
  // 商品ID。
  IntColumn get productId => integer().references(
        Products,
        #id,
        onDelete: KeyAction.restrict,
        onUpdate: KeyAction.cascade,
      )();
  // 采购数量。
  IntColumn get qty => integer()();
  // 采购单价，按分存储。
  IntColumn get unitPriceCent => integer()();
  // 折扣基点，10000 表示 100%。
  IntColumn get discountBp => integer().withDefault(const Constant(10000))();
  // 行金额，按分存储。
  IntColumn get lineAmountCent => integer()();
  // 已收货数量。
  IntColumn get receivedQty => integer().withDefault(const Constant(0))();
  // 实际上架货位。
  TextColumn get shelfCode => text().nullable()();
  // 备注信息。
  TextColumn get note => text().nullable()();
}

// 销售单主表：记录向客户销售商品的单据头信息。
class SalesOrders extends Table {
  @override
  List<String> get customConstraints => const [
    'CHECK (status BETWEEN 0 AND 4)',
    'CHECK (total_amount_cent >= 0)',
    'CHECK (receivable_amount_cent >= 0)',
    'CHECK (received_amount_cent >= 0)',
  ];

  // 主键，自增编号。
  IntColumn get id => integer().autoIncrement()();
  // 销售单号，唯一。
  TextColumn get orderNo => text().withLength(min: 1, max: 64).unique()();
  // 客户ID，零售场景下可为空。
  IntColumn get customerId => integer()
      .nullable()
      .references(
        Customers,
        #id,
        onDelete: KeyAction.setNull,
        onUpdate: KeyAction.cascade,
      )();
  // 出库仓库ID。
  IntColumn get warehouseId => integer().references(
        Warehouses,
        #id,
        onDelete: KeyAction.restrict,
        onUpdate: KeyAction.cascade,
      )();
  // 单据状态：0=草稿，1=已确认，2=已完成，3=已取消，4=已退款。
  IntColumn get status => integer().withDefault(const Constant(0))();
  // 销售渠道：store / online 等。
  TextColumn get salesChannel =>
      text().withLength(min: 1, max: 32).withDefault(const Constant('store'))();
  // 销售时间。
  DateTimeColumn get soldAt => dateTime()();
  // 销售总金额，按分存储。
  IntColumn get totalAmountCent => integer().withDefault(const Constant(0))();
  // 应收金额，按分存储。
  IntColumn get receivableAmountCent =>
      integer().withDefault(const Constant(0))();
  // 已收金额，按分存储。
  IntColumn get receivedAmountCent => integer().withDefault(const Constant(0))();
  // 创建人，关联用户表。
  @ReferenceName('salesOrdersCreatedBy')
  IntColumn get createdBy => integer()
      .nullable()
      .references(
        Users,
        #id,
        onDelete: KeyAction.setNull,
        onUpdate: KeyAction.cascade,
      )();
  // 备注信息。
  TextColumn get note => text().nullable()();
  // 创建时间。
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  // 更新时间。
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 销售单明细表：记录销售单中每个商品的数量、单价和成本信息。
class SalesOrderItems extends Table {
  @override
  List<String> get customConstraints => const [
    'CHECK (qty > 0)',
    'CHECK (unit_price_cent >= 0)',
    'CHECK (discount_bp BETWEEN 0 AND 10000)',
    'CHECK (line_amount_cent >= 0)',
    'UNIQUE (sales_order_id, line_no)',
  ];

  // 主键，自增编号。
  IntColumn get id => integer().autoIncrement()();
  // 销售单ID。
  IntColumn get salesOrderId => integer().references(
        SalesOrders,
        #id,
        onDelete: KeyAction.cascade,
        onUpdate: KeyAction.cascade,
      )();
  // 行号，便于同单据内排序。
  IntColumn get lineNo => integer()();
  // 商品ID。
  IntColumn get productId => integer().references(
        Products,
        #id,
        onDelete: KeyAction.restrict,
        onUpdate: KeyAction.cascade,
      )();
  // 销售数量。
  IntColumn get qty => integer()();
  // 销售价，按分存储。
  IntColumn get unitPriceCent => integer()();
  // 折扣基点，10000 表示 100%。
  IntColumn get discountBp => integer().withDefault(const Constant(10000))();
  // 行金额，按分存储。
  IntColumn get lineAmountCent => integer()();
  // 成本价，按分存储。
  IntColumn get costPriceCent => integer().nullable()();
  // 备注信息。
  TextColumn get note => text().nullable()();
}
