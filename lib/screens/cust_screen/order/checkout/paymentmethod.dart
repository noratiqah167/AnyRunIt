//Payment Method
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  var bank;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.monetization_on),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'Payment method',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.black12,
            child: DropdownButton(
              icon: Icon(Icons.keyboard_arrow_down),
              isExpanded: true,
              dropdownColor: Colors.white,
              hint: Text(
                " Select Payment Method",
              ),
              onChanged: (val) {
                print(val);
                setState(() {
                  this.bank = val;
                });
              },
              value: this.bank,
              autofocus: true,
              elevation: 10,
              items: [
                DropdownMenuItem(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text('CASH ON DELIVERY'),
                    ],
                  ),
                  value: 'COD',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
