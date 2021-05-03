import 'package:flutter/material.dart';
import 'package:haggle_x/utils/widgets/form_padding.dart';

class CountryCodeWidget extends StatelessWidget {
  final Key key;
  final String flag;
  final String dialCode;
  final String name;
  final Function onClick;

  CountryCodeWidget({
    @required this.key,
    @required this.flag,
    @required this.dialCode,
    @required this.name,
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          flag,
          loadingBuilder:
              (BuildContext context, Widget child, ImageChunkEvent chunkEvent) {
            if (chunkEvent == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value: chunkEvent.expectedTotalBytes == null
                      ? null
                      : chunkEvent.cumulativeBytesLoaded /
                          chunkEvent.expectedTotalBytes,
                ),
              );
            }
          },
        ),
        FormPadding(0.5),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: onClick,
            child: Text(
              "($dialCode) $name",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        )
      ],
    );
  }
}
