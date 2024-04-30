import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sarmad/_base/widgets/base_stateful_widget.dart';
import 'package:sarmad/api/models/search/SearchWrapper.dart';
import 'package:sarmad/api/models/search/search_send_model.dart';
import 'package:sarmad/res/const_colors.dart';
import 'package:sarmad/ui/screens/home/bloc/home_bloc.dart';
import 'package:sarmad/ui/widgets/widgets.dart';
import 'package:sarmad/util/lang/app_localization_keys.dart';
import 'package:sarmad/util/ui/feedback_controller.dart';
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
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    /// to exit full screen
    exitFullScreen();
    _homeBloc = context.read<HomeBloc>();
    _homeBloc.add(HomeInitialEvent());
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
            _homeBloc.add(NewSearchEvent());
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

  ///Returns a listview or gridview regarding user preferences with API data
  ///uses isGridView bool parameter
  Widget _getListOrGridView() {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is DataLoadingState) {
          showLoading();
        } else {
          hideLoading();
        }
        if (state is NewSearchState) {
          onSearchTap();
        }
        if (state is ErrorState) {
          showToast(state.message);
        }
        if (state is NetworkError) {
          showToast(state.message);
        }
      },
      builder: (context, state) {
        if (state is HomeInitialState) {
          return Expanded(child: noData(appLocal));
        } else if (state is DataLoadingState) {
          return const SizedBox();
        } else if (state is DataLoadedState) {
          return Expanded(
            child: isGridView
                ? GridView.builder(
                    itemCount: state.data.screenResult?.length,
                    padding: EdgeInsets.only(
                        left: width * 0.02,
                        right: width * 0.02,
                        bottom: width * 0.08),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.60),
                    itemBuilder: (context, index) =>
                        _getDataList(state.data.screenResult, index))
                : ListView.builder(
                    itemCount: state.data.screenResult?.length,
                    padding: EdgeInsets.only(
                        left: width * 0.02,
                        right: width * 0.02,
                        bottom: width * 0.08),
                    itemBuilder: (context, index) =>
                        _getDataList(state.data.screenResult, index),
                  ),
          );
        } else {
          return Expanded(child: noData(appLocal));
        }
      },
    );
  }

  ///Widget returns a list of data returned from API to be viewed
  Widget _getDataList(List<ScreenResult>? data, int index) {
    return SizedBox(
      width: width * 0.80,
      child: Card(
        color: ConstColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isGridView
                  ? _getDataColumnForGrid(translate(LangKeys.name),
                      data: data?[index].name)
                  : _getDataRow(translate(LangKeys.name),
                      data: data?[index].name),
              isGridView
                  ? _getDataColumnForGrid(translate(LangKeys.description),
                      data: data?[index].searchTypes?.first.description)
                  : _getDataRow(translate(LangKeys.description),
                      data: data?[index].searchTypes?.first.description),
              isGridView
                  ? _getDataColumnForGrid(translate(LangKeys.nationality),
                      data: data?[index].nat)
                  : _getDataRow(translate(LangKeys.nationality),
                      data: data?[index].nat),
              isGridView
                  ? _getDataColumnForGrid(translate(LangKeys.placeOfBirth),
                      data: data?[index].placesOfBirth?.first)
                  : _getDataRow(translate(LangKeys.placeOfBirth),
                      data: data?[index].placesOfBirth?.first),
              isGridView
                  ? _getDataColumnForGrid(translate(LangKeys.score),
                      data: data?[index].score.toString())
                  : _getDataRow(translate(LangKeys.score),
                      data: data?[index].score.toString()),
            ],
          ),
        ),
      ),
    );
  }

  ///That widget returns a row that contains data returned from API for ListView
  Widget _getDataRow(String title, {String? data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: ConstColors.text,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(data ?? "-",
            softWrap: true,
            style: const TextStyle(
              color: ConstColors.text,
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }

  ///That widget returns a row that contains data returned from API for GridView
  Widget _getDataColumnForGrid(String title, {String? data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: ConstColors.text,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(data ?? "-",
            softWrap: true,
            style: const TextStyle(
              color: ConstColors.text,
              fontWeight: FontWeight.w600,
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
                        _getSearchField(
                            translate(LangKeys.firstName), _fNameController),
                        const SizedBox(height: 10),
                        _getSearchField(
                            translate(LangKeys.middleName), _mNameController),
                        const SizedBox(height: 10),
                        _getSearchField(
                            translate(LangKeys.nationality), _natController),
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
          onPressed: () {
            Navigator.of(context).pop();
            _homeBloc.add(SearchButtonEvent(SearchSendModel(
                fName: _fNameController.text,
                mName: _mNameController.text,
                nat: _natController.text)));
          },
          child: Text(translate(LangKeys.search))),
    );
  }

  Widget _searchBottomSheetTitle() {
    return Text(
      translate(LangKeys.search),
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w700, color: ConstColors.app),
    );
  }
}
