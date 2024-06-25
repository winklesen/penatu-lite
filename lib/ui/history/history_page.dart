import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:penatu/app/bloc/history/history_bloc.dart';
import 'package:penatu/app/bloc/history/history_event.dart';
import 'package:penatu/app/bloc/history/history_state.dart';
import 'package:penatu/app/model/pesanan.dart';
import 'package:penatu/ui/dashboard/widget/card_order.dart';

class HistoryPage extends StatefulWidget {
  static const String routeName = '/histori';

  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late ThemeData _theme;
  List<Pesanan> listPesanan = [];
  String filterStatus = 'All';
  bool isAscending = true;

  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(GetOrderHistory());
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: SafeArea(
        child: BlocConsumer<HistoryBloc, HistoryState>(
          listener: (context, state) {
            if (state is LoadedHistoryState) {
              listPesanan = state.listPesanan;
            } else if (state is ErrorHistoryState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingHistoryState) {
              return const Center(child: CircularProgressIndicator());
            }
            return buildHistoryContent(context);
          },
        ),
      ),
    );
  }

  Widget buildHistoryContent(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HistoryBloc>().add(GetOrderHistory());
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildFilterAndTitle(),
                  const SizedBox(height: 8),
                  buildOrderList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildFilterAndTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Last 30 Days', style: _theme.textTheme.headlineMedium),
        buildSortAndFilterButton(),
      ],
    );
  }

  Widget buildSortAndFilterButton() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.sort, size: _theme.iconTheme.size),
      onSelected: (value) {
        setState(() {
          if (value == 'Sort Ascending') {
            isAscending = true;
          } else if (value == 'Sort Descending') {
            isAscending = false;
          } else {
            filterStatus = value;
          }
        });
      },
      itemBuilder: (context) {
        return <String>[
          'Sort Ascending',
          'Sort Descending',
          'All',
          'pending',
          'on_progress',
          'done'
        ]
            .map((option) => PopupMenuItem(
                  value: option,
                  child: Text(option),
                ))
            .toList();
      },
    );
  }

  Widget buildOrderList() {
    List<Pesanan> filteredList = _getFilteredOrders();
    List<Pesanan> sortedList = _sortOrders(filteredList);
    return sortedList.isEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Lottie.asset(
                'assets/anims/empty_whale.json',
                width: MediaQuery.of(context).size.width * 0.5,
                fit: BoxFit.fill,
              ),
              Text(
                'Data Pesanan Kosong',
                style: _theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.black.withOpacity(0.5)),
              ),
            ],
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sortedList.length,
            itemBuilder: (context, index) {
              return CardOrder(sortedList[index]);
            },
          );
  }

  List<Pesanan> _getFilteredOrders() {
    if (filterStatus == 'All') {
      return listPesanan;
    }
    return listPesanan.where((order) => order.status == filterStatus).toList();
  }

  List<Pesanan> _sortOrders(List<Pesanan> orders) {
    orders.sort((a, b) {
      int compare = a.tanggalPemesanan.compareTo(b.tanggalPemesanan);
      return isAscending ? compare : -compare;
    });
    return orders;
  }
}
