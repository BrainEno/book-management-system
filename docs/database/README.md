# 数据库设计审查与 Schema 产物

这份目录基于当前项目里的 Drift / SQLite 定义整理，主要来源如下：

- `lib/core/database/database.dart`
- `lib/features/product/data/datasources/local/product_dao.dart`
- `lib/features/auth/data/datasources/local/user_dao.dart`
- `lib/features/product/data/models/product_model.dart`
- `lib/features/product/presentation/widgets/product_info_editor/product_info_editor_form_state.dart`

## 现有 SQLite 结构结论

当前项目真正落地到 SQLite 的业务表，主要只有两张：

- `products`: 商品主数据表，当前已经承载了图书资料、价格、折扣、货架位、操作员等信息
- `users`: 登录用户表

这套结构可以支撑“基础商品录入 + 查询 + 简单维护”，但距离“商用图书进销存”还有明显差距。更准确地说，当前更像是“图书资料库”，还不是完整的“进货/销售/库存业务库”。

## 当前类型设计里相对合理的部分

- `id` 使用 `INTEGER PRIMARY KEY AUTOINCREMENT`，适合本地 SQLite 主键
- `title / author / isbn / publisher` 使用 `TEXT`，方向正确
- `publication_year` 使用 `INTEGER`，合理
- `created_at / updated_at` 在 Drift 中声明为 `DateTimeColumn`，项目当前实际按 Unix Epoch 秒落库，作为 SQLite 存储策略是可行的
- `users.status` 用整数状态码表达生命周期，也是常见做法

## 当前设计里更建议调整的部分

### 1. 金额字段使用 `REAL`

当前 `price / purchase_price / internal_pricing / wholesale_price` 都是 `REAL`。

对商用进销存来说，这会带来金额精度风险。更稳妥的方式是：

- 用 `INTEGER` 存“分”为单位
- 或统一用定点规则存储，例如 `INTEGER` 基点值

建议后续迁移为：

- `retail_price_cent`
- `purchase_price_cent`
- `internal_price_cent`
- `wholesale_price_cent`

### 2. 折扣字段语义不够清晰

当前 `retail_discount / wholesale_discount / member_discount` 是 `REAL`，界面默认值却是 `100`。这说明它实际上更像“百分数”而不是“浮点折扣系数”。

建议改成整数基点，例如：

- `10000 = 100%`
- `8500 = 85 折`

这样更适合价格计算，也便于和金额整数化保持一致。

### 3. `products` 表里大量字段被强制 `NOT NULL`

当前领域实体里很多字段是可空的，但 SQLite 表全部要求必填，最后通过界面和 mapper 填充：

- `0`
- `100`
- `2025`
- `不区分`

这能降低录入门槛，但会让“未知”和“真实值就是 0 / 不区分”混在一起。对统计、筛选、后续数据治理都不友好。

更建议：

- 真正必填的字段继续 `NOT NULL`
- 非关键字段允许为空
- 如果业务上必须有默认值，优先使用明确的代码字段或字典表

### 4. `operator` 目前是 `TEXT`

当前商品表里的 `operator` 保存的是用户名文本，不是外键。

这会导致：

- 用户改名后历史记录难以追溯
- 无法做可靠的用户关联查询
- 无法表达“创建人”和“最后修改人”的区别

建议改成：

- `created_by INTEGER`
- `updated_by INTEGER`

并外键关联 `users.id`。

### 5. 缺少关键唯一约束

当前 `products` 表没有明显的唯一约束，尤其缺少：

- `isbn`
- `product_id`
- `self_encoding`

在图书业务里，同一 ISBN 通常代表同一版本图书主数据，不应该靠重复商品行来表示库存数量。库存数量应该落在库存表，而不是靠重复商品记录表达。

### 6. 字典类字段全部直接存 `TEXT`

下面这些字段当前都直接存中文文本：

- `category`
- `publisher`
- `purchase_sale_mode`
- `packaging`
- `properity`
- `statistical_class`

MVP 阶段这样做很快，但一旦需要：

- 多条件筛选
- 统计报表
- 主数据维护
- 名称统一修订

就会开始吃力。更适合拆成基础资料表，或至少使用编码值。

### 7. 当前表结构不包含真正的进销存流水

项目目前没有以下业务核心表：

- 仓库
- 库存结存
- 库存流水
- 采购单 / 采购明细
- 销售单 / 销售明细
- 供应商
- 客户 / 会员

所以当前数据库还不能完整支撑“采购入库 -> 库存变化 -> 销售出库 -> 对账统计”这一套闭环。

## 推荐的商用图书进销存 Schema

我给出了一套“保留你当前 `products/users` 语义，但扩展成可商用”的推荐结构：

- 主数据层：`users / product_categories / publishers / products / suppliers / customers / warehouses`
- 库存层：`stock_balances / stock_movements`
- 业务单据层：`purchase_orders / purchase_order_items / sales_orders / sales_order_items`

这套结构的核心思路是：

- `products` 只存“商品主数据”
- 库存数量放到 `stock_balances`
- 每次入库、出库、盘点、退货都记录 `stock_movements`
- 采购和销售用“单头 + 明细行”建模
- 金额统一改成整数分
- 折扣统一改成整数基点
- 操作员统一改成外键

## 本目录文件说明

- `current_app_schema.dbml`: 按当前代码真实结构整理出的现状 schema
- `bookstore_recommended_schema.dbml`: 推荐的商用图书进销存 schema，可直接导入 `dbdiagram.io`
- `bookstore_recommended_schema.mmd`: Mermaid ER 图源码，可导入 Mermaid Live Editor

## 交互编辑方式

### DBML

最推荐编辑 `bookstore_recommended_schema.dbml`：

1. 打开 `https://dbdiagram.io`
2. 选择导入 DBML
3. 粘贴或上传 `docs/database/bookstore_recommended_schema.dbml`
4. 你可以直接拖拽、改字段、改关系，并导出 PNG / PDF / SQL

### Mermaid

如果你更习惯 Markdown / 文档流：

1. 打开 `https://mermaid.live`
2. 导入 `docs/database/bookstore_recommended_schema.mmd`
3. 可以直接调整关系和显示结构

## 建议的落地顺序

如果后面你希望我继续把这套设计真正落到 Drift 代码，我建议按下面顺序做迁移：

1. 先只重构 `products` 和 `users` 的字段类型与约束
2. 再新增 `warehouses / stock_balances / stock_movements`
3. 最后引入 `purchase_orders / sales_orders` 两类业务单据表

这样迁移风险最低，也最容易和你当前 UI 逐步对齐。
