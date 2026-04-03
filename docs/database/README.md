# 数据库设计审查与 Schema 产物

这份目录基于当前项目里的 Drift / SQLite 定义整理，主要来源如下：

- `lib/core/database/database.dart`
- `lib/features/product/data/datasources/local/product_dao.dart`
- `lib/features/auth/data/datasources/local/user_dao.dart`
- `lib/features/product/data/models/product_model.dart`
- `lib/features/product/presentation/widgets/product_info_editor/product_info_editor_form_state.dart`

## 现有 SQLite 结构结论

当前项目真正落地到 SQLite 的业务表，已经从最初的 2 张扩展到一组更完整的基础表：

- `products`: 商品主数据表，当前仍保留现有商品字段结构
- `users`: 登录用户表
- `product_categories / publishers / suppliers / customers / warehouses`: 主数据层
- `stock_balances / stock_movements`: 库存层
- `purchase_orders / purchase_order_items / sales_orders / sales_order_items`: 业务单据层

这套结构可以支撑“基础商品录入 + 查询 + 简单维护”，但距离“商用图书进销存”还有明显差距。更准确地说，当前更像是“图书资料库”，还不是完整的“进货/销售/库存业务库”。

## 当前类型设计里相对合理的部分

- `id` 使用 `INTEGER PRIMARY KEY AUTOINCREMENT`，适合本地 SQLite 主键
- `title / author / isbn / publisher` 使用 `TEXT`，方向正确
- `publication_year` 使用 `INTEGER`，合理
- `created_at / updated_at` 在 Drift 中声明为 `DateTimeColumn`，项目当前实际按 Unix Epoch 秒落库，作为 SQLite 存储策略是可行的
- `users.status` 用整数状态码表达生命周期，也是常见做法

## 当前设计里已完成的调整

截至 `2026-04-03`，下面这些原本建议调整的 `product` 相关项已经落地完成：

### 1. 金额字段改为整数存储

已完成：

- `price / purchase_price / internal_pricing / wholesale_price` 已改为 SQLite `INTEGER`
- Drift 层通过 type converter 继续暴露为 Dart `double`
- 相关测试已经覆盖“金额按分落库”的行为

### 2. 折扣字段改为整数基点

已完成：

- `retail_discount / wholesale_discount / member_discount` 已改为整数基点存储
- Dart 层仍按原有百分数语义读取和写入
- 相关测试已经覆盖“折扣按基点落库”的行为

### 3. 非关键字段不再强制 `NOT NULL`

已完成：

- `isbn / category / publisher / purchase_sale_mode / packaging / properity / statistical_class / publication_year` 等字段已调整为可空
- 应用层写库时会把空字符串和约定占位值统一归一

### 4. `operator` 改为用户外键

已完成：

- 商品表已不再直接保存 `operator TEXT`
- 已改为 `created_by / updated_by`
- 已通过标准 Drift `references(Users, #id)` 建立外键关系
- 查询层会回填创建人与最后修改人的用户名，供界面展示

### 5. 增加关键唯一约束

已完成：

- `product_id` 已保持 `NOT NULL UNIQUE`
- `self_encoding` 已保持 `NOT NULL UNIQUE`
- `isbn` 已改为“允许为空，但非空唯一”
- 应用层写库时会把空白 ISBN 归一为 `NULL`

当前关于 ISBN 的设计决策仍然保持如下：

- `product_id` 作为全品类统一商品编码，保持 `NOT NULL UNIQUE`
- `isbn` 允许为空，但在“非空时”保持唯一
- “图书必须填写 ISBN” 继续由业务规则控制，而不是由全表字段约束一刀切

## 当前仍建议后续处理的部分

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

### 7. 当前表结构已经有了，但上层业务流程还没完全接上

支持表已经落到 Drift 里了，但它们还主要停留在“表结构 + 迁移 + 基础验证”层面，后面仍需要补齐：

- 采购入库和销售出库的业务服务
- 库存结存的增减逻辑
- 采购单 / 销售单与库存流水之间的联动
- 主数据管理界面和筛选检索入口

所以当前数据库结构已经能承载完整闭环，但应用层还需要继续往上接，才能真正把“采购入库 -> 库存变化 -> 销售出库 -> 对账统计”跑通。

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

## 当前落地进度

截至 `2026-04-03`，`product` 第一阶段已完成：

- `1 / 2 / 3 / 4 / 5` 已落地
- `products` 相关迁移逻辑已补齐，可兼容旧表数据归一到当前结构

截至同一天，推荐 schema 里的支持表也已落地到 Drift：

- `product_categories / publishers / suppliers / customers / warehouses`
- `stock_balances / stock_movements`
- `purchase_orders / purchase_order_items / sales_orders / sales_order_items`
- `AppDatabase.schemaVersion` 已升级到 `6`

当前仍未开始的部分：

- `6 / 7`
- `products` 主表还没有切换到推荐 schema 里的归一化字段设计
- 仍需要把商品主表和主数据表进一步联动起来，才能完全贴近推荐方案

## 当前验证结果

本次 product 第一阶段调整后，已通过：

- `flutter test`

这意味着当前 `product` 相关的数据库映射、本地数据源、编辑表单、查询导出、数据库迁移和新增支持表都已经通过现有测试验证。
