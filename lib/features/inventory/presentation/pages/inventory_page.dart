import 'package:flutter/material.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '库存页面',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: '关联商品',
              hintText: '粘贴商品信息到这里',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          Text('你可以把其他窗口的信息粘贴到这里。'),
        ],
      ),
    );
  }
}
