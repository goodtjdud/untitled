import 'package:flutter/material.dart';
import 'package:untitled/pages/searchpage2.dart';



class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController editingController = TextEditingController();

  final List<Map<String, dynamic>> _data = [
    //이 data 구조가 json 형식 느낌이라 json 임포트 용을 하면 될듯
    {
      "약명": '타이레놀정500밀리그램',
      "제조사": '주) 한국얀센',
      "성분": '아세트아미노펜',
      "효능": "감기로 인한 발열 및 통증, 두통, 신경통, 근육통, 월경통, 염좌통",
      "복용": '만 12세 이상 소아 및 성인은 1회 1~2정씩 1일 3~4회'
    },
    {
      "약명": '타이레놀정160밀리그램',
      "제조사": '주) 한국얀센',
      "성분": '아세트아미노펜',
      "효능": '모름',
      "복용": '모름'
    },
    {
      "약명": '어린이타이레놀현탁액',
      "제조사": '주) 한국얀센',
      "성분": '아세트아미노펜',
      "효능": '모름',
      "복용": '모름'
    },

    {"약명": 'a', "제조사": 'a', "성분": 'a', "효능": 'a', "복용": 'a'},
    {"약명": 'b', "제조사": 'b', "성분": 'b', "효능": 'b', "복용": 'b'},
    {"약명": 'c', "제조사": 'c', "성분": 'c', "효능": 'c', "복용": 'c'},
    {"약명": 'd', "제조사": 'd', "성분": 'd', "효능": 'd', "복용": 'd'},
    {"약명": 'e', "제조사": 'e', "성분": 'e', "효능": 'e', "복용": 'e'},
    {"약명": 'f', "제조사": 'f', "성분": 'f', "효능": 'f', "복용": 'f'},
    {"약명": 'g', "제조사": 'g', "성분": 'g', "효능": 'g', "복용": 'g'},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _data;
    super.initState();
  }


  // List<List<dynamic>> _data = [];
  // // This function is triggered when the floating button is pressed
  // void _loadCSV() async {
  //   final _rawData = await rootBundle.loadString("assets/medicsv2.csv");
  //   List<List<dynamic>> _listData =
  //   const CsvToListConverter().convert(_rawData);
  //   setState(() {
  //     _data = _listData;
  //   });
  // }
  //
  // loadingCSV() {
  //   _loadCSV();
  // }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _data;
    } else {
      results = _data
          .where((user) =>
          user["약명"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    // loadingCSV();
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
      return GestureDetector(
        //화면 아무곳이나 터치하면 그냥키보드 내려가도록 추가 기능은 함
        //safearea빼고 하니까 됨
        //애매하긴 하다. 작동은 되는데 이게 터치하면 어차피 페이지 이동해서
        //찾는 약품이 없거나 혹은 약품들이 수가 줄어들면 사용됨.
        //처음 화면에서 검색만 하려고 했을때는 빈 공간이 거의 없긴 함.
        // 보이스 어시스턴트 기능 킨 채로도 한번 탭 혹은 두번의 탭으로 내려가는지 확인하기.
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              controller: editingController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
      Expanded(
        child: _foundUsers.isNotEmpty
          ? ListView.builder(
            shrinkWrap: true,
              scrollDirection:
              Axis.vertical, //vertical : 수직으로 나열 / horizontal : 수평으로 나열
              itemCount: _foundUsers.length, //리스트의 개수
              itemBuilder: (BuildContext context, int index) =>
                //리스트의 반목문 항목 형성
                Card(
                  key: ValueKey(_foundUsers[index]["약명"]),
                  color: Colors.lightGreen[100],
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(vertical: 1),
                    child: ListTile(
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),

                      title: SizedBox(
                        child: Text(
                                _foundUsers[index]["약명"].toString(),
                                 style: TextStyle(
                                 fontSize:25),
                                 )
                              ),
                      subtitle: SizedBox(
                        child: Text(
                        _foundUsers[index]["제조사"].toString(),
                        style: TextStyle(
                        fontSize: 23,
                        ),
                      ),
                      ),
                      onTap:() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                SearchedPage(
                                  mediinfo: _foundUsers[index],)));
                      }
                      ),
                ),
    )
    : const Text(
    '찾으시는 약품이 없습니다',
    style: TextStyle(fontSize: 24),
    ),
              ),
      ]
    ),
          );
        }),
      ),
    );
  }
}
