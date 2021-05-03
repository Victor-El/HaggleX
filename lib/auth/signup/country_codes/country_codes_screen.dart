import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haggle_x/auth/signup/country_codes/blocs/country_code_change_notifier.dart';
import 'package:haggle_x/auth/signup/country_codes/models/country_code.dart';
import 'package:haggle_x/auth/signup/country_codes/services/country_code_json_service.dart';
import 'package:haggle_x/auth/signup/country_codes/widgets/country_code_widget.dart';
import 'package:haggle_x/utils/constants.dart';
import 'package:haggle_x/utils/widgets/form_padding.dart';
import 'package:provider/provider.dart';

class CountryCodeScreen extends StatefulWidget {
  @override
  _CountryCodeScreenState createState() => _CountryCodeScreenState();
}

class _CountryCodeScreenState extends State<CountryCodeScreen> {
  Future<List<CountryCode>> _countryCodesFuture;
  List<CountryCode> _countryCodes;
  List<CountryCode> _filterableCountryCodes;
  var _searchController = TextEditingController();

  @override
  void initState() {
    _countryCodesFuture = CountryCodeService.getInstance().getCountryCodes();
    _countryCodes = List.empty(growable: true);
    super.initState();
  }

  void _searchFieldOnChanged(String text) {
    if (_filterableCountryCodes == null) {
      _filterableCountryCodes = List<CountryCode>.empty(growable: true);
      _filterableCountryCodes.addAll(_countryCodes);
    }
    print(text);
    var newList = _countryCodes
        .where((element) =>
            element.name.toLowerCase().startsWith(text.toLowerCase()))
        .toList();
    setState(() {
      _filterableCountryCodes.clear();
      _filterableCountryCodes.addAll(newList);
    });
  }

  void _onEditingComplete() {
    print("comp");
    var newList = _countryCodes
        .where((element) => element.name.startsWith(_searchController.text))
        .toList();
    setState(() {
      _filterableCountryCodes.clear();
      _filterableCountryCodes.addAll(newList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(SCREEN_PADDING),
        child: Column(
          children: [
            FormPadding(),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white70,
                ),
                hintText: "Search for country",
                hintStyle: TextStyle(color: Colors.white70),
                fillColor: Colors.white38,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  gapPadding: 20,
                ),
              ),
              textInputAction: TextInputAction.search,
              onChanged: _searchFieldOnChanged,
              onEditingComplete: _onEditingComplete,
            ),
            FormPadding(0.5),
            Divider(
              thickness: 1,
              color: Colors.white54,
            ),
            FormPadding(0.2),
            FutureBuilder(
                future: _countryCodesFuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    _countryCodes.addAll(snapshot.data);
                    if (_filterableCountryCodes == null) {
                      _filterableCountryCodes =
                      List<CountryCode>.empty(growable: true);
                    }
                    if (_filterableCountryCodes.isEmpty) {
                      _filterableCountryCodes.addAll(_countryCodes);
                    }
                  }
                  return snapshot.data == null
                      ? Container(
                          child: Center(
                            child: SizedBox(
                              width: 200,
                              height: 200,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Container(
                            child: ListView.builder(
                              itemCount: _filterableCountryCodes.length,
                              itemBuilder: (ctx, idx) {
                                return CountryCodeWidget(
                                  key: ValueKey(idx),
                                  flag: _filterableCountryCodes[idx].flag,
                                  dialCode:
                                      _filterableCountryCodes[idx].dialCode,
                                  name: _filterableCountryCodes[idx].name,
                                  onClick: () {
                                    Provider.of<CountryCodeChangeNotifier>(
                                            context,
                                            listen: false)
                                        .updateCountryCode(CountryCode(
                                            _filterableCountryCodes[idx].name,
                                            _filterableCountryCodes[idx]
                                                .dialCode,
                                            _filterableCountryCodes[idx].flag));
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                          ),
                        );
                }),
          ],
        ),
      ),
    );
  }
}
