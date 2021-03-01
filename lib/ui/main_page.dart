import 'package:flutter/material.dart';
import 'package:personal_website/ui/cartoon_page.dart';
import 'package:personal_website/ui/fiction_page.dart';
import 'package:personal_website/ui/home_page.dart';
import 'package:personal_website/ui/video_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

const _menuTabValues = {
  "首页": ["都市", "穿越", "科幻", "网游", "玄幻", "修真", "言情", "历史", "其他", "竞技"],
  "小说": ["都市", "穿越", "科幻", "网游", "玄幻", "修真", "言情", "历史", "其他", "竞技"],
  "漫画": ["都市", "穿越", "科幻", "网游", "玄幻", "修真", "言情", "历史", "其他", "竞技"],
  "视频": ["都市", "穿越", "科幻", "网游", "玄幻", "修真", "言情", "历史", "其他", "竞技"]
};

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  String _selectedMenuKey = _menuTabValues.keys.first;
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
            builder: (BuildContext context) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: 30,
                  ),
                  onPressed: () {
                    print("onPressed");
                    Scaffold.of(context).openDrawer();
                  },
                )),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: _menuTabValues[_selectedMenuKey]
              .map((tabTitle) => buildTabBar(tabTitle))
              .toList(),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: TabBarView(
          controller: _tabController,
          children: _menuTabValues[_selectedMenuKey]
              .map((tabTitle) => buildBody(tabTitle))
              .toList(),
        ),
      ),
      drawer: buildDrawer(),
    );
  }

  /// 构建tab标题
  Widget buildTabBar(String tabTitle) {
    return Tab(
      text: tabTitle,
    );
  }

  /// 构建内容
  Widget buildBody(String tabTitle) {
    for (int i = 0; i < _menuTabValues.keys.length; i++) {
      bool result = _menuTabValues.keys.elementAt(i) == _selectedMenuKey;
      if (result) {
        switch (i) {
          case 0:
            return HomePage();
          case 1:
            return FictionPage(tabTitle);
          case 2:
            return CartoonPage(tabTitle);
          case 3:
            return VideoPage(tabTitle);
          default:
            return HomePage();
        }
      }
    }
    return HomePage();
  }

  /// 构建侧滑drawer
  Drawer buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              '杨建新',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            accountEmail: Text(
              '18758851013@163.com',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            decoration: BoxDecoration(
                // 头部背景
                image: DecorationImage(
                    image: NetworkImage(
                        "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1264701161,404102866&fm=26&gp=0.jpg"),
                    fit: BoxFit.cover)),
            currentAccountPicture: Center(
              // 当前账户头像
              child: ClipOval(
                child: Image.network(
                  'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3873623821,1133496150&fm=26&gp=0.jpg',
                  width: 70,
                  height: 70,
                  cacheWidth: 70,
                  cacheHeight: 70,
                ),
              ),
            ),
          ),
          buildDrawerItem(
              Icons.cake,
              Icons.dashboard,
              _menuTabValues.keys.elementAt(0),
              Colors.red,
              Colors.blue,
              Colors.transparent,
              Colors.grey.shade200),
          buildDrawerItem(
              Icons.fact_check,
              Icons.gamepad,
              _menuTabValues.keys.elementAt(1),
              Colors.red,
              Colors.blue,
              Colors.transparent,
              Colors.grey.shade200),
          buildDrawerItem(
              Icons.hail,
              Icons.icecream,
              _menuTabValues.keys.elementAt(2),
              Colors.red,
              Colors.blue,
              Colors.transparent,
              Colors.grey.shade200),
          buildDrawerItem(
              Icons.keyboard,
              Icons.nat,
              _menuTabValues.keys.elementAt(3),
              Colors.red,
              Colors.blue,
              Colors.transparent,
              Colors.grey.shade200),
        ],
      ),
    );
  }

  /// 构建drawerItem
  buildDrawerItem(
    IconData leading,
    IconData trailing,
    String selectedKey,
    Color focusColor,
    Color hoverColor,
    Color tileColor,
    Color selectedTileColor,
  ) {
    return ListTile(
      // 导航栏
      leading: Icon(
        leading,
        size: 30,
      ),
      trailing: Icon(
        trailing,
        size: 25,
      ),
      title: Text(
        selectedKey,
        style: TextStyle(fontSize: 16, color: Colors.black26),
      ),
      tileColor: tileColor,
      selectedTileColor: selectedTileColor,
      enabled: true,
      focusColor: focusColor,
      hoverColor: hoverColor,
      selected: _selectedMenuKey == selectedKey,
      onTap: () {
        _selectedMenuKey = selectedKey;
        setState(() {
          Navigator.pop(context);
        });
      },
    );
  }

  @override
  void initState() {
    _tabController = TabController(
        length: _menuTabValues[_selectedMenuKey].length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
