import 'package:flutter/material.dart';
import 'package:sarmad/_base/widgets/base_stateful_widget.dart';
import 'package:sarmad/res/const_colors.dart';
import 'package:sarmad/util/lang/app_localization_keys.dart';
import 'package:sarmad/util/ui/screen_controller.dart';

class HomeScreen extends BaseStatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  bool isGridView = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _mNameController = TextEditingController();
  final TextEditingController _natController = TextEditingController();

  @override
  void initState() {
    /// to exit full screen
    exitFullScreen();
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(),
    );
  }

  ///////////////////////////////////////////////////////////
//////////////////// Widget methods ///////////////////////
///////////////////////////////////////////////////////////

  ///App bar of home screen
  AppBar _getAppBar() {
    return AppBar(
      title: Text(translate(LangKeys.appName)),
    );
  }

  ///Returns a screen whole body
  Widget _getBody() {
    return Form(
      key: _formKey,
      child: Column(
        children: [_getSearchAndViewPreferencesButtons(), _getListOrGridView()],
      ),
    );
  }

  ///Returns Search button and view preferences button in a Single row
  ///Switching between (ListView and GridView)
  ///Search button open search ModalBottomSheet that contains search criteria
  ///Search criteria (fName,mName,nat) all of them are optionals
  Widget _getSearchAndViewPreferencesButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_newSearchButton(), _switchGridAndListViewButton()],
      ),
    );
  }

  ///Return new search button
  Widget _newSearchButton() {
    return Padding(
      padding: EdgeInsets.all(width * 0.01),
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))))),
          onPressed: () {
            onSearchTap();
          },
          child: Row(
            children: [
              const Icon(
                Icons.search,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(translate(LangKeys.newSearch)),
            ],
          )),
    );
  }

  ///Return switching between GridView and ListView icon button
  Widget _switchGridAndListViewButton() {
    return IconButton(
        icon: isGridView
            ? const Icon(
                Icons.format_list_bulleted_rounded,
                color: ConstColors.app,
              )
            : const Icon(
                Icons.grid_view_rounded,
                color: ConstColors.app,
              ),
        onPressed: () {
          setState(() {
            isGridView = !isGridView;
          });
        });
  }

  ///Returns a listview or gridview regarding user preferences
  ///uses isGridView bool parameter
  Widget _getListOrGridView() {
    return Expanded(
      child: isGridView
          ? GridView.builder(
              itemCount: 10,
              padding: EdgeInsets.only(
                  left: width * 0.02,
                  right: width * 0.02,
                  bottom: width * 0.08),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.25),
              itemBuilder: (context, index) => _getDataList())
          : ListView.builder(
              itemCount: 10,
              padding: EdgeInsets.only(
                  left: width * 0.02,
                  right: width * 0.02,
                  bottom: width * 0.08),
              itemBuilder: (context, index) => _getDataList(),
            ),
    );
  }

  ///Widget returns a list of data returned from API to be viewed
  Widget _getDataList() {
    return SizedBox(
      width: width * 0.80,
      child: Card(
        color: ConstColors.accent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _getDataRow(translate(LangKeys.name), data: "Youssef"),
              _getDataRow(translate(LangKeys.description), data: "Developer"),
              _getDataRow(translate(LangKeys.nationality), data: "Egypt"),
              _getDataRow(translate(LangKeys.placeOfBirth), data: "Ismailia"),
              _getDataRow(translate(LangKeys.score), data: "97.0"),
            ],
          ),
        ),
      ),
    );
  }

  ///That widget returns a row that contains data returned from API
  Widget _getDataRow(String title, {String? data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: ConstColors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(data ?? "-",
            style: const TextStyle(
              color: ConstColors.text,
              fontWeight: FontWeight.w700,
            )),
      ],
    );
  }

  ///Search Modal bottom sheet
  void onSearchTap() {
    if (mounted) {
      showModalBottomSheet(
          isDismissible: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16))),
          context: context,
          builder: (context) {
            return Container(
                height: height * 0.40,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        _searchBottomSheetTitle(),
                        const SizedBox(height: 20),
                        _getSearchField("First name", _fNameController),
                        const SizedBox(height: 10),
                        _getSearchField("Middle name", _mNameController),
                        const SizedBox(height: 10),
                        _getSearchField("Nationality", _natController),
                      ],
                    ),
                    _getSearchButton()
                  ],
                ));
          });
    }
  }

  ///Returns search widget for calling search API
  ///Called from Modal bottom sheet
  Widget _getSearchField(String hint, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: ConstColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        hintText: hint,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _getSearchButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.05),
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))))),
          onPressed: () {},
          child: Text("Search")),
    );
  }

  Widget _searchBottomSheetTitle() {
    return Text(
      "Search",
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w700, color: ConstColors.app),
    );
  }
}
