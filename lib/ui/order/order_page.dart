import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:penatu/app/bloc/order/order_bloc.dart';
import 'package:penatu/app/bloc/order/order_event.dart';
import 'package:penatu/app/bloc/order/order_state.dart';
import 'package:penatu/app/helper/currency_helper.dart';
import 'package:penatu/app/model/detail_pesanan.dart';
import 'package:penatu/app/model/pesanan.dart';
import 'package:penatu/ui/dashboard/dashboard_page.dart';
import 'package:penatu/ui/dashboard/widget/card_detail_order.dart';
import 'package:penatu/ui/styles/button.dart';
import 'package:penatu/ui/styles/dialog.dart';

class OrderPage extends StatefulWidget {
  static const String routeName = '/order';

  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late List<DetailPesanan> orderDetail;
  late double totalPrice;
  late double kiloPrice;
  late ThemeData _theme;

  final TextEditingController _namaPelangganController =
      TextEditingController();
  final TextEditingController _nomorTeleponController = TextEditingController();
  late DateTime _tanggalDiambil;
  final TextEditingController _tanggalDiambilController =
      TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    orderDetail = [];
    totalPrice = 0;
    kiloPrice = 0;
    _tanggalDiambil = DateTime.now();
    context.read<OrderBloc>().add(GetOrderForm());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Tambah Pesanan'),
      ),
      body: SafeArea(
        child: BlocConsumer<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is LoadedOrderState) {
              this.kiloPrice = state.kiloPrice;
            } else if (state is SubmittedOrderState) {
              dialog(context, 'Success', 'Data telah tersimpan', false, () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  DashboardPage.routeName,
                  (route) => false,
                );
              });
            } else if (state is ErrorOrderState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingOrderState) {
              return Center(child: CircularProgressIndicator());
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                      // maxHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: 32, left: 32, right: 32, bottom: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Detail Pesanan',
                                  style: _theme.textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                DottedBorder(
                                  color: Colors.black.withOpacity(0.5),
                                  strokeWidth: 1,
                                  dashPattern: [
                                    10,
                                  ],
                                  child: Container(
                                    height: size.height * 0.25,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: orderDetail.isEmpty
                                        ? Center(
                                            child: Text('Data Pesanan Kosong'),
                                          )
                                        : ListView.separated(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: orderDetail.length,
                                            itemBuilder: (context, index) {
                                              return CardDetailOrder(
                                                  orderDetail[index]);
                                            },
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return Divider(
                                                color: Colors.black
                                                    .withOpacity(0.25),
                                              );
                                            },
                                          ),
                                  ),
                                ),

                                SizedBox(
                                  height: 4,
                                ),
                                Center(
                                  child: CustomTextButton(
                                    icon: Icons.add,
                                    label: 'Tambah Item',
                                    onPressed: () {
                                      dialogInputDetailOrder(
                                          context, kiloPrice);
                                    },
                                  ),
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(0.25),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                // Text(
                                Text(
                                  'Data Pelanggan',
                                  style: _theme.textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _namaPelangganController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          labelText: 'Nama Pelanggan',
                                          border: UnderlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter nama pelanggan';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 8),
                                      TextFormField(
                                        controller: _catatanController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          labelText: 'Catatan',
                                          border: UnderlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 8),
                                      TextFormField(
                                        controller: _nomorTeleponController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Nomor Telepon',
                                          border: UnderlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your nomor telepon';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 8),
                                      TextFormField(
                                        controller: _tanggalDiambilController,
                                        keyboardType: TextInputType.datetime,
                                        readOnly: true,
                                        // enabled: false,
                                        enableInteractiveSelection: true,
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Tanggal Diambil',
                                          border: UnderlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter tanggal diambil';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  '${CurrencyFormat.convertToIdr(number: _calculateTotalPrice())}',
                                  style: _theme.textTheme.displaySmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                PrimaryButton(
                                    label: 'Submit',
                                    isFullWidth: true,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        final pesanan = Pesanan(
                                          idPesanan: null,
                                            idUser: null,
                                            namaPelanggan:
                                                _namaPelangganController.text,
                                            nomorTeleponPelanggan:
                                                _nomorTeleponController.text,
                                            tanggalPemesanan:
                                                DateFormat('yyyy-MM-dd')
                                                    .format(DateTime.now()),
                                            tanggalPengembalian:
                                                _tanggalDiambilController.text,
                                            status: 'pending',
                                            catatan: _catatanController.text);
                                        context.read<OrderBloc>().add(
                                            PostUserOrder(
                                                pesanan, orderDetail));
                                      }
                                    })
                              ],
                            ),
                          ],
                        )),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Method
  Future<void> dialogInputDetailOrder(BuildContext context,
      [double? kiloPrice]) async {
    TextEditingController _namaFieldController = TextEditingController();
    TextEditingController _beratFieldController = TextEditingController();
    TextEditingController _jumlahFieldController = TextEditingController();
    TextEditingController _hargaFieldController = TextEditingController();
    String tipeLayanan = '';

    showMaterialModalBottomSheet(
        context: context,
        enableDrag: true,
        isDismissible: true,
        builder: (context) => StatefulBuilder(
                builder: (BuildContext context, StateSetter modalState) {
              return SingleChildScrollView(
                controller: ModalScrollController.of(context),
                padding: EdgeInsets.only(
                    left: 32,
                    top: 32,
                    right: 32,
                    bottom: 32 + MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Tambah Item',
                      style: _theme.textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text('Pilih Tipe Layanan',
                        style: _theme.textTheme.bodySmall),
                    DropdownButton(
                        value: tipeLayanan,
                        onChanged: (String? newValue) {
                          modalState(() {
                            tipeLayanan = newValue!;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                              child: Text("Paket"), value: "paket"),
                          DropdownMenuItem(
                              child: Text("Satuan"), value: "satuan"),
                          DropdownMenuItem(child: Text("-"), value: ""),
                        ]),
                    tipeLayanan == ''
                        ? const SizedBox.shrink()
                        : Column(
                            children: <Widget>[
                              TextField(
                                controller: _namaFieldController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  hintText: "Nama Pesanan",
                                ),
                              ),
                              TextField(
                                controller: _jumlahFieldController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  // FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: "Jumlah",
                                ),
                              ),
                              tipeLayanan == 'paket'
                                  ? TextField(
                                      controller: _beratFieldController,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: <TextInputFormatter>[
                                        // FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                          hintText: "Berat (Kg)",
                                          suffixText: "(Kg)"),
                                    )
                                  : TextField(
                                      controller: _hargaFieldController,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: <TextInputFormatter>[
                                        // FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        hintText: "Rp. 15000",
                                      ),
                                    ),
                              SizedBox(
                                height: 16,
                              ),
                              PrimaryButton(
                                  label: 'Simpan',
                                  isFullWidth: true,
                                  onPressed: () {
                                    if (_beratFieldController.text == '')
                                      _beratFieldController.text = '0';
                                    orderDetail.add(DetailPesanan(
                                        idDetailPesanan: '',
                                        idPesanan: '',
                                        namaDetailPesanan:
                                            _namaFieldController.text,
                                        berat: double.parse(
                                            _beratFieldController.text),
                                        jumlah: int.parse(
                                            _jumlahFieldController.text),
                                        harga: tipeLayanan == 'paket'
                                            ? double.parse(_beratFieldController
                                                    .text) *
                                                kiloPrice!
                                            : double.parse(
                                                _hargaFieldController.text),
                                        tipeLayanan: tipeLayanan));
                                    setState(() {});
                                    Navigator.pop(context);
                                  })
                            ],
                          )
                  ],
                ),
              );
            }));
  }

  Future<void> _selectDate(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _tanggalDiambil,
        firstDate: DateTime(_tanggalDiambil.year, _tanggalDiambil.month),
        lastDate: DateTime(_tanggalDiambil.year, _tanggalDiambil.month + 1));
    if (picked != null && picked != _tanggalDiambil) {
      _tanggalDiambil = picked;
      _tanggalDiambilController.text = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {});
    }
  }

  double _calculateTotalPrice() {
    if (orderDetail.isEmpty) return 0;

    double price = 0;
    for (var i = 0; i < orderDetail.length; i++) {
      price += orderDetail[i].harga;
    }

    return price;
  }
}
