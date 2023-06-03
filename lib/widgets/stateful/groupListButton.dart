import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';

class GroupListButton extends StatefulWidget {
  const GroupListButton({Key? key}) : super(key: key);
  @override
  State<GroupListButton> createState() => _GroupListButtonState();
}

class _GroupListButtonState extends State<GroupListButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _toggleController;
  late Animation<double> _toggleValue;
  late final ValueNotifier<bool> _state = ValueNotifier(true);
  @override
  void initState() {
    super.initState();
    _toggleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    _toggleValue = Tween(begin: -0.2, end: 1.0).animate(
        CurvedAnimation(parent: _toggleController, curve: Curves.linear));
    _toggleController.animateTo(-0.2, duration: Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.36),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tất cả các nhóm',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightBlue.withOpacity(0.36),
                ),
                child: Container(
                  margin: EdgeInsets.only(right: 15),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Nhóm của bạn',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blueText.withOpacity(1),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ToggleButton(
            toggleValue: _toggleValue,
            toggleButton: () {
              toggleButton();
            },
            state: _state,
          ),
        ],
      ),
    );
  }

  toggleButton() {
    if (_toggleValue.value == -0.2)
      _toggleController
          .animateTo(1.0, duration: Duration(milliseconds: 200))
          .whenComplete(() => {_state.value = !_state.value});
    else
      _toggleController
          .animateBack(-0.2, duration: Duration(milliseconds: 200))
          .whenComplete(() => {_state.value = !_state.value});
  }
}

class ToggleButton extends AnimatedWidget {
  final VoidCallback toggleButton;
  final ValueNotifier<bool> state;
  const ToggleButton(
      {required Animation<double> toggleValue,
      required this.toggleButton,
      required this.state})
      : super(listenable: toggleValue);
  Animation<double> get toggleValue => listenable as Animation<double>;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: state,
        builder: (context, value, _) {
          return AnimatedPositioned(
            width: 235,
            height: 50,
            duration: Duration(milliseconds: 60),
            curve: Curves.easeIn,
            left: toggleValue.value * 160,
            child: InkWell(
              onTap: toggleButton,
              child: value
                  ? Container(
                      width: 250,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        alignment: Alignment.center,
                        child: Text(
                          'Tất cả các nhóm',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xF12424).withOpacity(1),
                          ),
                        ),
                      ),
                      key: UniqueKey(),
                    )
                  : Container(
                      width: 250,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue.withOpacity(1),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        alignment: Alignment.center,
                        child: Text(
                          'Nhóm của bạn',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blueDarkText.withOpacity(1),
                          ),
                        ),
                      ),
                      key: UniqueKey(),
                    ),
            ),
          );
        });
  }
}
