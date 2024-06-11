import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:penatu/app/bloc/dashboard/dashboard_bloc.dart';
import 'package:penatu/app/bloc/dashboard/dashboard_event.dart';
import 'package:penatu/ui/styles/button.dart';

Future<void> dialogInputKiloPrice(
    BuildContext context, [double? kiloPrice]) async {
  TextEditingController _textFieldController =
      TextEditingController(text: kiloPrice != null ? '$kiloPrice' : null);

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Masukan harga per Kilo'),
        content: TextField(
          controller: _textFieldController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: InputDecoration(
            hintText: "15000",
            prefixText: 'Rp.',
          ),
        ),
        actions: <Widget>[
          CustomTextButton(
            label: 'Batal',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          PrimaryButton(
            label: 'Simpan',
            onPressed: () {
              double price = double.parse(_textFieldController.text);
              Navigator.pop(context);
              context.read<DashboardBloc>().add(SetPricePerKilo(price));
            },
          ),
        ],
      );
    },
  );
}


