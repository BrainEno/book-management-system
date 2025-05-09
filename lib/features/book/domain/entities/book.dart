class Book {
  final String bookId;
  final int id;
  final String title;
  final String author;
  final String isbn;
  //售价
  final double price;
  //商品分类
  final String category;
  //出版社
  final String publisher;
  //自编码
  final String selfEncoding;
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
  //书标
  final String? bookmark;
  //包装*
  final String? packaging;
  //商品属性
  final String? properity;
  //统计分类
  final String? statisticalClass;
  //操作人员
  final String operator;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Book({
    required this.bookId,
    required this.id,
    required this.title,
    required this.author,
    required this.isbn,
    //售价
    required this.price,
    //商品分类
    required this.category,
    //出版社
    required this.publisher,
    //自编码
    required this.selfEncoding,
    //操作人员
    required this.operator,
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
    //书标
    this.bookmark,
    //包装*
    this.packaging,
    //商品属性
    this.properity,
    //统计分类
    this.statisticalClass,

    this.createdAt,
    this.updatedAt,
  });
}
