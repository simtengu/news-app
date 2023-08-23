import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/features/home/bloc/bloc/home_bloc.dart';
import 'package:news_app/features/home/screens/home.dart';
import 'package:news_app/features/home/screens/settings.dart';
import 'package:news_app/features/posts/bloc/posts_bloc.dart';
import 'package:news_app/features/posts/views/filtered_posts_screen.dart';
import 'package:news_app/features/posts/views/saved_posts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_app/features/posts/views/search_post.dart';

class HomeTabsScreen extends StatefulWidget {
  const HomeTabsScreen({super.key});

  @override
  State<HomeTabsScreen> createState() => _HomeTabsScreenState();
}

class _HomeTabsScreenState extends State<HomeTabsScreen> {
  int active_screen_index = 0;

  final List<Widget> _tabs_container = const [
    HomeScreen(),
    FilteredPostsScreen(),
    SavedPostsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<PostsBloc>(
          create: (context) => PostsBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: Container(
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromARGB(255, 243, 239, 239),
                width: 4,
              ),
            ),
            child: Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu),
              );
            }),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 239, 239),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SearchPostScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Builder(builder: (context) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 26,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: AppConstants.bgPrimaryLight,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.view_list_outlined,
                  text: 'Feed',
                ),
                GButton(
                  icon: Icons.bookmark_border,
                  text: 'Saved',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
              ],
              selectedIndex: active_screen_index,
              onTabChange: (index) {
                BlocProvider.of<HomeBloc>(context).add(NavigateTabEvent(
                    pageIndex: index,
                    filterInfo: const {
                      "searchCategory": "all",
                      "filterCountry": "worldwide"
                    }));
              },
            ),
          );
        }),
        drawer: Builder(builder: (context) {
          return Drawer(
            backgroundColor: AppConstants.secondary,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero)),
            elevation: 20,
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    color: AppConstants.bgPrimaryLight,
                    height: 166,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.asset(
                            '${AppConstants.imgPath}news1.png',
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Word News',
                              style: TextStyle(
                                  color: AppConstants.secondary,
                                  fontSize: AppConstants.heading2,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Get informed',
                              style: TextStyle(
                                  fontSize: AppConstants.body2,
                                  fontWeight: FontWeight.bold,
                                  color: AppConstants.primary),
                            ),
                          ],
                        )
                      ],
                    )),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("Home"),
                  onTap: () {
                    if (active_screen_index != 0) {
                      BlocProvider.of<HomeBloc>(context).add(NavigateTabEvent(
                        pageIndex: 0,
                      ));
                    }
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.view_list_outlined),
                  title: const Text("Feed"),
                  onTap: () {
                    if (active_screen_index != 1) {
                      BlocProvider.of<HomeBloc>(context).add(NavigateTabEvent(
                          pageIndex: 1,
                          filterInfo: const {
                            "searchCategory": "all",
                            "filterCountry": "worldwide"
                          }));
                    }
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.bookmark_border),
                  title: const Text("Saved"),
                  onTap: () {
                    if (active_screen_index != 2) {
                      BlocProvider.of<HomeBloc>(context).add(NavigateTabEvent(
                        pageIndex: 2,
                      ));
                    }
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Settings"),
                  onTap: () {
                    if (active_screen_index != 3) {
                      BlocProvider.of<HomeBloc>(context).add(NavigateTabEvent(
                        pageIndex: 3,
                      ));
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }),
        body: Builder(builder: (context) {
          return BlocConsumer<HomeBloc, HomeState>(
            listenWhen: (previous, current) => current is HomeActionState,
            buildWhen: (previous, current) => current is! HomeActionState,
            listener: (context, state) {
              if (state is NavigateTabState) {
                if (active_screen_index != state.pageIndex) {
                  setState(() {
                    active_screen_index = state.pageIndex;
                  });
                }
                if (state.pageIndex == 1) {
                  
                  //for updating active filters................................................
                  BlocProvider.of<PostsBloc>(context).add(
                      PostFilterChangedEvent(
                          country: state.filterInfo!['filterCountry']!,
                          searchCategory:
                              state.filterInfo!['searchCategory']!));
                  //for fetching posts and navgating to filters page................................................

                  BlocProvider.of<PostsBloc>(context).add(
                      LoadfilteredPostsEvent(
                          country: state.filterInfo!['filterCountry']!,
                          searchCategory:
                              state.filterInfo!['searchCategory']!));
                }
              }
            },
            builder: (context, state) =>
                SafeArea(child: _tabs_container[active_screen_index]),
          );
        }),
      ),
    );
  }
}
