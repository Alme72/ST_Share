import 'package:flutter/material.dart';
import 'package:test_project/page/home.dart';
import '../repository/contents_repository.dart';

class DetailContentView extends StatefulWidget {
  Map<String, dynamic> data;
  DetailContentView({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailContentView> createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView>
    with TickerProviderStateMixin {
  ScrollController controller = ScrollController();
  double locationAlpha = 0;
  final ContentsRepository contentsRepository = ContentsRepository();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late List<String> imgList;
  late Size size;
  late AnimationController _animationController;
  late Animation _colorTween;

  late PageController _pageController;
  int _currentPage = 0;
  int _actualPage = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _colorTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    imgList = widget.data["image"];
    _currentPage = 0;
    // _loadMyFavoriteContentState();
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.8, // 이미지 사이의 간격을 조절할 수 있습니다.
    );
    _pageController.addListener(() {
      if (_pageController.page?.round() == widget.data['image'].length) {
        setState(() {
          _currentPage = 0;
          _actualPage = 0;
        });
      } else {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  // _loadMyFavoriteContentState() async {
  //   bool ck = await contentsRepository.isMyFavoriteContents(widget.data["cid"]);
  //   setState(() {
  //     isMyFavoriteContent = ck;
  //   });
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  Widget _makeIcon(IconData icon) {
    return AnimatedBuilder(
      animation: _colorTween,
      builder: (context, child) => Icon(icon, color: Colors.black),
    );
  }

  // appBar Widget 구현
  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: _makeIcon(Icons.arrow_back),
      ),
      backgroundColor: Colors.white.withAlpha(locationAlpha.toInt()),
      elevation: 0,
      actions: [
        IconButton(onPressed: () {}, icon: _makeIcon(Icons.share)),
        IconButton(onPressed: () {}, icon: _makeIcon(Icons.more_vert)),
      ],
    );
  }

  Widget _makeSliderImage() {
    return SizedBox(
      height: size.width * 0.8,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PageView.builder(
            itemCount: widget.data["image"].length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.data["image"][index],
                  fit: BoxFit.cover,
                ),
              );
            },
            //enableInfiniteScroll: true,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(500)),
            child: Text(
              '${_currentPage + 1}/${widget.data["image"].length}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.data['image'].length, (index) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 5.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.black //Colors.white
                        : Colors.grey
                            .withOpacity(0.4), //Colors.white.withOpacity(0.4),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget _sellerSimpleInfo() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset("assets/images/user.png"),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data["boardWriter"],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(widget.data["location"]),
                ],
              ),
              // Expanded(
              //   child: ManorTemperature(manorTemp: 37.3),
              // )
            ],
          ),
        ),
      ],
    );
  }

  Widget _line() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _contentDetail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Text(
            widget.data["boardTitle"],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "디지털/가전 ∙ ${widget.data["boardCreatedTime"]}", //category 추가 건의
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            widget.data["boardContents"],
            style: const TextStyle(fontSize: 15, height: 1.5),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Text(
                "조회수 ∙ ${widget.data["boardHits"].toString()}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return CustomScrollView(controller: controller, slivers: [
      SliverList(
        delegate: SliverChildListDelegate(
          [
            _makeSliderImage(),
            _sellerSimpleInfo(),
            _line(),
            _contentDetail(),
            _line(),
            //_otherCellContents(),
          ],
        ),
      ),
    ]);
  }

  Widget _bottomBarWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 55,
      //color: Colors.white,
      child: Row(
        children: [
          // GestureDetector(
          //   onTap: () async {
          //     if (isMyFavoriteContent) {
          //       await contentsRepository
          //           .deleteMyFavoriteContent(widget.data["cid"]);
          //     } else {
          //       await contentsRepository.addMyFavoriteContent(widget.data);
          //     }
          //     setState(() {
          //       isMyFavoriteContent = !isMyFavoriteContent;
          //     });
          //     scaffoldKey.currentState.showSnackBar(SnackBar(
          //       duration: const Duration(milliseconds: 1000),
          //       content: Text(
          //           isMyFavoriteContent ? "관심목록에 추가됐어요." : "관심목록에서 제거됐어요."),
          //     ));
          //   },
          //   child: SvgPicture.asset(
          //     isMyFavoriteContent
          //         ? "assets/svg/heart_on.svg"
          //         : "assets/svg/heart_off.svg",
          //     width: 20,
          //     height: 20,
          //     color: const Color(0xfff08f4f),
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 10),
            height: 40,
            width: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Home().calcStringToWon(widget.data["price"].toString()),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromARGB(255, 132, 206, 243),
                  ),
                  child: const Text(
                    "채팅으로 거래하기",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const SizedBox(
      height: 20,
    );
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomBarWidget(),
    );
  }
}
