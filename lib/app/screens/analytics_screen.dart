import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:my_souq/app/models/sales.dart';
import 'package:my_souq/app/services/admin_service.dart';
import 'package:my_souq/app/widgets/analytics_charts.dart';
import 'package:my_souq/app/widgets/loader.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  AdminService adminService = AdminService();
  List<Sales>? sales;
  double? totalSales;
  double? totalOrders;
  double? totalProducts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAnalytics();
  }

  void getAnalytics() async {
    var dataSale = await adminService.getTotalSales(context);
    totalSales = dataSale['totalSales'];
    totalOrders = dataSale['totalOrders'];
    totalProducts = dataSale['totalProducts'];
    sales = dataSale['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return sales == null ? const Loader()
        : Column(
      children: [
        Text(
          'Total Sales: \$$totalSales',
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        Text(
          'Total Orders: \$$totalOrders',
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        Text(
          'Total Products: \$$totalProducts',
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(
          height: 250,
          child: AnalyticsCharts(
            seriesList: [
              charts.Series(
                  id: 'Sales',
                  data: sales!,
                  domainFn: (Sales mySales, _) {
                    return mySales.label;
                  },
                  measureFn: (Sales mySales, _) {
                    return mySales.totalSale;
                  }
              )
            ],
          ),
        )
      ],
    );
  }
}
