# ARCHITECTURE

## 启动链路

当前应用的启动职责已经从 `main.dart` 拆成了清晰的 4 段：

1. `lib/main.dart`
   只负责串联启动步骤，不再承载权限、窗口、路由、Provider、子窗口解析等细节。
2. `lib/app/bootstrap/app_startup.dart`
   负责启动期权限申请、桌面窗口初始化、子窗口参数解析。
3. `lib/core/init_dependencies.dart`
   作为依赖装配入口，转发给 `core/di/` 下的细粒度注册模块。
4. `lib/app/bookstore_scope.dart` + `lib/app/bookstore_app.dart`
   分别负责全局状态注入和主应用/子窗口应用壳。

## 文件结构树示意图

```text
lib
|-- main.dart
|-- app
|   |-- bookstore_app.dart
|   |-- bookstore_router.dart
|   |-- bookstore_scope.dart
|   |-- bootstrap
|   |   |-- app_runtime.dart
|   |   `-- app_startup.dart
|   `-- navigation
|       `-- app_window_destination.dart
|-- core
|   |-- init_dependencies.dart
|   |-- di
|   |   |-- service_locator.dart
|   |   |-- core_registrations.dart
|   |   |-- environment_config.dart
|   |   |-- persistence_registrations.dart
|   |   `-- feature_registrations.dart
|   |-- database
|   |   |-- database.dart
|   |   |-- database.g.dart
|   |   `-- database.steps.dart
|   |-- presentation
|   |   `-- pages
|   |       `-- desktop_shell.dart
|   |-- theme
|   |   |-- theme.dart
|   |   `-- theme_bloc.dart
|   `-- window
|       |-- app_window_manager.dart
|       |-- window_info.dart
|       `-- window_pop_out_service.dart
|-- features
|   |-- auth
|   |   |-- data
|   |   |-- domain
|   |   `-- presentation
|   `-- product
|       |-- data
|       |   |-- datasources
|       |   |-- mappers
|       |   |   |-- product_entity_mapper.dart
|       |   |   `-- product_record_mapper.dart
|       |   `-- repositories
|       |-- domain
|       |-- presentation
|       |   |-- blocs
|       |   |-- controllers
|       |   |   |-- mobile_discovery_controller.dart
|       |   |   `-- product_editor_isbn_receiver_service.dart
|       |   |-- pages
|       |   |   `-- product_page.dart
|       |   |-- screens
|       |   `-- widgets
|       |       |-- product_info_editor_view.dart
|       |       |-- product_info_editor
|       |       |   |-- product_info_editor_form_grid.dart
|       |       |   `-- desktop_isbn_scanner_*.dart
|       |       `-- product_query
|       |           |-- product_query_workspace.dart
|       |           |-- product_query_header.dart
|       |           |-- product_query_spreadsheet_panel.dart
|       |           |-- product_query_detail_panel.dart
|       |           |-- product_query_detail_form_controller.dart
|       |           |-- product_query_workspace_support.dart
|       |           |-- product_query_table_source.dart
|       |           `-- product_query_export_service.dart
|       `-- utils
`-- inventory
    `-- presentation
        `-- pages
            `-- inventory_page.dart
```

## 关键职责划分

- `main.dart`
  现在是纯编排层，只保留启动顺序。
- `app/`
  放应用装配逻辑，包括运行时上下文、路由、窗口页面注册表、Provider 壳。
- `core/di/`
  放依赖注入拆分模块：
  `core_registrations.dart` 处理 logger/theme/runtime；
  `environment_config.dart` 处理 `.env` 和环境变量；
  `persistence_registrations.dart` 处理 Hive/Drift；
  `feature_registrations.dart` 处理 auth/product 的仓储、usecase、bloc 注册。
- `core/window/`
  统一窗口管理能力。`desktop_shell.dart` 只负责 UI，浮窗创建逻辑下沉到 `window_pop_out_service.dart`。
- `features/product/presentation/controllers/product_editor_isbn_receiver_service.dart`
  承接原本混在编辑页中的 HTTP 接收与 Bonjour 广播职责。
- `features/product/presentation/widgets/product_query/`
  查询工作区已按“页编排 / 头部 / 表格 / 详情 / 表单控制器 / 导出服务”拆分，后续维护可以按组件继续演进。

## 这次重构的重点

- `main.dart`
  去掉了全局状态、权限申请、窗口初始化、路由与 Provider 重复装配。
- `init_dependencies.dart`
  从“大而全初始化脚本”改为清晰的装配入口，避免环境、存储、特性注册揉在一起。
- `desktop_shell.dart`
  导航项改为由 `app_window_destination.dart` 统一定义，浮窗逻辑抽到 `window_pop_out_service.dart`。
- `product_info_editor_view.dart`
  不再依赖 `main.dart` 的全局变量，改为通过 `AppRuntime` 判断子窗口环境，并复用 `ProductEditorIsbnReceiverService`。
- `product` 查询相关代码
  复用 `product_entity_mapper.dart` 统一 `Product -> ProductModel` 转换，避免窗口/查询工作区重复做模型适配。
