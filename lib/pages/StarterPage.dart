import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../animations/FadeAnimations.dart';
import 'HomePage.dart';
class StarterPage extends StatefulWidget {
  const StarterPage({Key? key}) : super(key: key);

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> with TickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _textVisible = true;

  @override
  void initState(){
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 100)
    );
    _animation = Tween<double>(
        begin: 1.0,
        end: 25.0
    ).animate(_animationController);
    super.initState();
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  void onTap(){
    setState(() {
      _textVisible=false;
    });

    _animationController.forward().then((f) =>
        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: HomePage()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/Goat-Cheese_-Pear-_-Kale-Salad.png'),
              fit: BoxFit.cover
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.2),
                  ]
              )
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FadeAnimation(.5,Text('Taking Order For Faster Delivery',style: TextStyle(color:Colors.white, fontSize: 50, fontWeight:FontWeight.bold  ),)),
                SizedBox(height: 20,),
                FadeAnimation(1,Text('See resturants nearby by \nadding location',style: TextStyle(color: Colors.white,height: 1.4,fontSize:18 ),)),
                SizedBox(height: 100,),
                FadeAnimation(1.2,
                  ScaleTransition(
                      scale: _animation,
                      child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.yellow,
                                    Colors.orange
                                  ]
                              )
                          ),
                          child: AnimatedOpacity(
                            opacity: _textVisible ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 50),
                            child: MaterialButton(
                              onPressed: () => onTap(),
                              minWidth: double.infinity,
                              child: Text('Start',style: TextStyle(color: Colors.white),),
                            ),
                          )
                      )),
                ),
                SizedBox(height: 30,),
                FadeAnimation(1.4,
                    AnimatedOpacity(
                      opacity: _textVisible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 50),
                      child: Align(
                        child: Text('Now Deliver To Your Door 24/7',style: TextStyle(color: Colors.white60,fontSize: 15),),
                      ),
                    )),
                SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}