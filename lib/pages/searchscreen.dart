import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";

  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Container(
          child: Column(
            children: <Widget>[
              Container(color: Colors.white54,
                  padding: EdgeInsets.fromLTRB(10, 15, 5, 15),
                  child: Row(
                    children: <Widget>[
                      Expanded(flex:6,
                        child: TextField(
                          focusNode: focusNode,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          autofocus: true,
                          controller: _filter,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white12,
                            prefixIcon: Icon(
                              Icons.search,
                              size:30,
                            ),
                            suffixIcon:focusNode.hasFocus
                                ? IconButton(
                              icon: Icon(
                                Icons.cancel,
                                size:27,),
                              onPressed: () {
                                setState(() {
                                  _filter.clear();
                                  _searchText = "";
                                });
                              },
                            )
                                : Container(),
                            hintText: "검색",

                          ),
                        ),
                      ),
                      focusNode.hasFocus ? Expanded(
                          child: TextButton(
                            child: Text("취소",
                                style: TextStyle(fontSize: 20)),
                            onPressed: () {
                              setState(() {
                                _filter.clear();
                                _searchText = "";
                                focusNode.unfocus();
                              });
                            },
                          )
                      )
                          : Expanded(
                        flex: 0,
                        child: Container(),
                      )],
                  )
              )],
          )
      ),
    );
  }
}