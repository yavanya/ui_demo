import 'package:barbers_demo/domain/model/barber.dart';
import 'package:barbers_demo/presentation/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return model.isBusy
            ? Scaffold(
                backgroundColor: MyColors.bgColor,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                backgroundColor: MyColors.bgColor,
                bottomNavigationBar: _bottomNavBar(),
                body: ListView(
                  children: [
                    _SearchBar(),
                    _IndividualListView(model),
                    _SalonsListView(model),
                    SizedBox(height: 30),
                    _BottomWidget(model)
                  ],
                ),
              );
      },
    );
  }
}

class _IndividualListView extends StatelessWidget {
  final HomeViewModel model;
  _IndividualListView(this.model);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 245,
        width: double.infinity,
        child:
            _topListView(model.individuals, context, 'ИНДИВИДУАЛЬНЫЕ МАСТЕРА'));
  }
}

class _SalonsListView extends StatelessWidget {
  final HomeViewModel model;
  _SalonsListView(this.model);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 245,
        width: double.infinity,
        child: _topListView(model.salons, context, 'BEAUTY SALONS'));
  }
}

class _BottomWidget extends StatelessWidget {
  final HomeViewModel model;
  _BottomWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 740,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(52),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            _title('ПОСЛЕДНИЕ ПРОСМОТРЫ'),
            SizedBox(height: 30),
            _RecentListView(model),
            _title('ПОПУЛЯРНОЕ'),
            SizedBox(height: 30),
            _PopularListView(model)
          ],
        )
      ],
    );
  }
}

class _RecentListView extends StatelessWidget {
  final HomeViewModel model;
  _RecentListView(this.model);
  @override
  Widget build(BuildContext context) {
    return _bottomListView(model.recent, context);
  }
}

class _PopularListView extends StatelessWidget {
  final HomeViewModel model;
  _PopularListView(this.model);
  @override
  Widget build(BuildContext context) {
    return _bottomListView(model.popular, context);
  }
}

Widget _topListView(List<Barber> barbers, BuildContext context, String title) {
  List<Widget> _temp = [];
  barbers.forEach((e) {
    _temp.add(
      Container(
        margin: EdgeInsets.only(right: 23, bottom: 16, top: 16),
        width: 249,
        height: 245,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 12,
                      color: Colors.black.withAlpha(20),
                      offset: Offset(6, 6)),
                ],
                image: DecorationImage(
                    image: AssetImage('assets/images/photos${e.image}'),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset('assets/images/backgrounds/background.png')),
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    e.name,
                    style: const TextStyle(
                        color: MyColors.mainColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: 0.36),
                  ),
                  Text(
                    e.address,
                    style: const TextStyle(
                        color: MyColors.mainColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: 0.24),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 15,
                            height: 18,
                            child: Image.asset('assets/images/icons/star.png')),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            e.rating.toStringAsPrecision(2),
                            style: const TextStyle(
                                color: MyColors.mainColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                letterSpacing: 0.24),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            e.ratingString,
                            style: const TextStyle(
                                color: MyColors.mainColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                letterSpacing: 0.24),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  });
  _temp.insert(0, _verticalWidget(title));
  ListView _tempListView = ListView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.only(left: 0.0),
    children: _temp,
  );
  return _tempListView;
}

Widget _bottomListView(List<Barber> barbers, BuildContext context) {
  return SizedBox(
    width: double.infinity,
    height: 280,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: barbers.length,
      itemBuilder: (context, i) {
        return Container(
          margin: EdgeInsets.only(left: i == 0 ? 52 : 0, right: 23, bottom: 25),
          width: 226,
          height: 264,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 12,
                  color: Colors.black.withAlpha(25),
                  offset: Offset(2, 2)),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                child: Image.asset('assets/images/photos${barbers[i].image}'),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  barbers[i].name,
                  style: const TextStyle(
                      color: MyColors.mainColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      letterSpacing: 0.36),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  barbers[i].address,
                  style: const TextStyle(
                      color: MyColors.mainColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      letterSpacing: 0.24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25, top: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 15,
                        height: 18,
                        child: Image.asset('assets/images/icons/star.png')),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        barbers[i].rating.toStringAsPrecision(2),
                        style: const TextStyle(
                            color: MyColors.mainColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            letterSpacing: 0.24),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        barbers[i].ratingString,
                        style: const TextStyle(
                            color: MyColors.mainColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            letterSpacing: 0.24),
                      ),
                    ),
                    Spacer(),
                    barbers[i].isNew ? _newBox() : SizedBox()
                  ],
                ),
              )
            ],
          ),
        );
      },
    ),
  );
}

Widget _newBox() {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Container(
      width: 54,
      height: 13,
      decoration: BoxDecoration(
        color: MyColors.newColor,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Center(
        child: const Text(
          'Новинка',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 9,
              letterSpacing: 0.18),
        ),
      ),
    ),
  );
}

Widget _verticalWidget(String title) {
  return Container(
    margin: const EdgeInsets.only(right: 23, bottom: 16, top: 16),
    width: 84,
    height: 245,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      boxShadow: [
        BoxShadow(
            blurRadius: 12,
            color: Colors.black.withAlpha(20),
            offset: Offset(5, 5)),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Wrap(
          direction: Axis.vertical,
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: MyColors.mainColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ),
          ],
        ),
        SizedBox(width: 2),
        Wrap(
          direction: Axis.vertical,
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                'посмотреть все',
                style: const TextStyle(
                    color: MyColors.mainColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    letterSpacing: 2.5),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 50, bottom: 29),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(42),
          boxShadow: [
            BoxShadow(
                blurRadius: 20,
                color: Colors.black.withAlpha(20),
                offset: Offset(0, 6)),
          ],
        ),
        width: 308,
        height: 47,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 23),
                width: 24,
                height: 24,
                child: Image.asset('assets/images/icons/search.png')),
            const Padding(
              padding: EdgeInsets.only(left: 19),
              child: Text(
                'Найти',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    letterSpacing: 0.02,
                    color: MyColors.searchStringColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _bottomNavBar() {
  return Container(
    height: 88,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
            blurRadius: 12,
            color: Colors.black.withAlpha(12),
            offset: Offset(18, 0)),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: 18, child: Image.asset('assets/images/icons/home.png')),
        SizedBox(
            width: 24, child: Image.asset('assets/images/icons/calendar.png')),
        SizedBox(
            width: 24, child: Image.asset('assets/images/icons/account.png'))
      ],
    ),
  );
}

Widget _title(String title) {
  return Padding(
    padding: const EdgeInsets.only(left: 52.0),
    child: Text(
      title,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
        color: MyColors.mainColor,
      ),
    ),
  );
}

class MyColors {
  static const bgColor = Color(0xfff2f2f2);
  static const mainColor = Color(0xff251201);
  static const newColor = Color(0xffFF8585);
  static const searchStringColor = Color(0xffc8c8c8);
}
