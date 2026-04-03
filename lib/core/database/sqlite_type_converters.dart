import 'package:drift/drift.dart';

class MoneyAsCentsConverter extends TypeConverter<double, int> {
  const MoneyAsCentsConverter();

  @override
  double fromSql(int fromDb) {
    return fromDb / 100;
  }

  @override
  int toSql(double value) {
    return (value * 100).round();
  }
}

class DiscountAsBasisPointsConverter extends TypeConverter<double, int> {
  const DiscountAsBasisPointsConverter();

  @override
  double fromSql(int fromDb) {
    return fromDb / 100;
  }

  @override
  int toSql(double value) {
    return (value * 100).round();
  }
}

const moneyAsCentsConverter = MoneyAsCentsConverter();
const nullableMoneyAsCentsConverter = NullAwareTypeConverter.wrap(
  moneyAsCentsConverter,
);

const discountAsBasisPointsConverter = DiscountAsBasisPointsConverter();
const nullableDiscountAsBasisPointsConverter = NullAwareTypeConverter.wrap(
  discountAsBasisPointsConverter,
);
