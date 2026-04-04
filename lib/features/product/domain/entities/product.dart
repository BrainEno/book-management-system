class Product {
  final String productId;
  final int id;
  final String title;
  final String author;
  final String? isbn;
  //售价
  final double price;
  //商品分类
  final String? category;
  //商品分类主数据 ID
  final int? categoryId;
  //出版社
  final String? publisher;
  //出版社主数据 ID
  final int? publisherId;
  //自编码
  final String selfEncoding;
  //创建人用户 ID
  final int? createdBy;
  //最后修改人用户 ID
  final int? updatedBy;
  //内部定价
  final double? internalPricing;
  //进货价
  final double? purchasePrice;
  //出版年
  final int? publicationYear;
  //零售折扣
  final double? retailDiscount;
  //批发折扣
  final double? wholesaleDiscount;
  //批发价*
  final double? wholesalePrice;
  //会员折扣
  final double? memberDiscount;
  //购销方式*
  final String? purchaseSaleMode;
  //购销方式主数据 ID
  final int? purchaseSaleModeId;
  //书标
  final String? bookmark;
  //包装*
  final String? packaging;
  //商品属性
  final String? properity;
  //统计分类
  final String? statisticalClass;
  //商品状态，0=停用，1=启用，2=作废
  final int status;
  //库存单位
  final String stockUnit;
  //库存下限预警
  final int? minStockAlertQty;
  //库存上限预警
  final int? maxStockAlertQty;
  //当前界面展示的操作人员名称
  final String? operator;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Product({
    required this.productId,
    required this.id,
    required this.title,
    required this.author,
    this.isbn,
    //售价
    required this.price,
    //商品分类
    this.category,
    this.categoryId,
    //出版社
    this.publisher,
    this.publisherId,
    //自编码
    required this.selfEncoding,
    this.createdBy,
    this.updatedBy,
    //操作人员
    this.operator,
    //内部定价
    this.internalPricing,
    //进货价
    this.purchasePrice,
    //出版年
    this.publicationYear,
    //零售折扣
    this.retailDiscount,
    //批发折扣
    this.wholesaleDiscount,
    //批发价*
    this.wholesalePrice,
    //会员折扣
    this.memberDiscount,
    //购销方式*
    this.purchaseSaleMode,
    this.purchaseSaleModeId,
    //书标
    this.bookmark,
    //包装*
    this.packaging,
    //商品属性
    this.properity,
    //统计分类
    this.statisticalClass,
    this.status = 1,
    this.stockUnit = '册',
    this.minStockAlertQty,
    this.maxStockAlertQty,

    this.createdAt,
    this.updatedAt,
  });
}
