import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/history/history_bloc.dart';
import 'package:penatu/app/bloc/history/history_event.dart';
import 'package:penatu/app/bloc/history/history_state.dart';
import 'package:penatu/app/bloc/order_detail/order_detail_state.dart';
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
  late List<Pesanan> listPesanan;

  @override
  void initState() {
    super.initState();

    listPesanan = [];
    context.read<HistoryBloc>().add(GetOrderHistory());
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: SafeArea(
        child: BlocConsumer<HistoryBloc, HistoryState>(
          listener: (context, state) {
            if (state is LoadedHistoryState) {
              this.listPesanan = state.listPesanan;
            } else if (state is ErrorHistoryState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingHistoryState) {
              return Center(child: CircularProgressIndicator());
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<HistoryBloc>().add(GetOrderHistory());
                  },
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _textTitle(),
                          const SizedBox(
                            height: 8,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: listPesanan.length,
                            itemBuilder: (context, index) {
                              return CardOrder(listPesanan[index]);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Widget
  Widget _textTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          'Last 30 Days',
          style: _theme.textTheme.headlineMedium,
        ),
        IconButton(
          icon: Icon(Icons.sort, size: _theme.iconTheme.size),
          onPressed: () {},
        )
      ],
    );
  }
}
