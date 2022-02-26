import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:lottie_practice/src/core/constants/app_theme.dart';
import 'package:lottie_practice/src/core/constants/lotties.dart';
import 'package:lottie_practice/src/core/theme/theme.dart';
import 'package:lottie_practice/src/pages/widgets/biometrics_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Lottie Practice",
      theme: AppTheme.light,
      home: const AppPage(),
    );
  }
}

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  int _previousIndex = 0;

  late AnimationController _idleAnimation;
  late AnimationController _onSelectedAnimation;
  late AnimationController _onChangedAnimation;

  String _label = 'Notification';
  final _titles = ['Notification', 'BookMark', 'Like'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _onSelectedAnimation.reset();
      _onSelectedAnimation.forward();

      _onChangedAnimation.value = 1;
      _onChangedAnimation.reverse();

      setState(() {
        _previousIndex = _selectedIndex;
        _selectedIndex = index;
        _label = _titles[index];
      });
    });
  }

  Duration animationDuration = const Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _idleAnimation = AnimationController(vsync: this);
    _onSelectedAnimation =
        AnimationController(vsync: this, duration: animationDuration);
    _onChangedAnimation =
        AnimationController(vsync: this, duration: animationDuration);
  }

  @override
  void dispose() {
    super.dispose();
    _idleAnimation.dispose();
    _onSelectedAnimation.dispose();
    _onChangedAnimation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lottie Practice',
          style: filterByTitleStyle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          const transitionDuration = Duration(milliseconds: 400);

          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: transitionDuration,
              reverseTransitionDuration: transitionDuration,
              pageBuilder: (_, animation, ___) {
                return FadeTransition(
                  opacity: animation,
                  // child: const BiometricsPage(), Uses Lottie
                  child: const FlyingPlanePage(),
                );
              },
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: Center(child: Text(_label, style: productNameStyle)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Lottie.asset(bellNotification,
                width: 60,
                height: 60,
                frameRate: FrameRate(60),
                repeat: false,
                controller: _selectedIndex == 0
                    ? _onSelectedAnimation
                    : _previousIndex == 0
                        ? _onChangedAnimation
                        : _idleAnimation),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Lottie.asset(bookmark,
                width: 60,
                height: 60,
                frameRate: FrameRate(60),
                repeat: false,
                controller: _selectedIndex == 1
                    ? _onSelectedAnimation
                    : _previousIndex == 1
                        ? _onChangedAnimation
                        : _idleAnimation),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Lottie.asset(likeNoBackground,
                width: 60,
                height: 60,
                frameRate: FrameRate(60),
                repeat: false,
                controller: _selectedIndex == 2
                    ? _onSelectedAnimation
                    : _previousIndex == 2
                        ? _onChangedAnimation
                        : _idleAnimation),
            label: '',
          ),
        ],
      ),
    );
  }
}
