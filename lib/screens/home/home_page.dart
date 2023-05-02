import 'package:flutter/material.dart';
import 'package:you_it/config/themes/app_colors.dart';
import 'package:you_it/config/themes/app_text_styles.dart';
import 'package:you_it/widgets/stateless/description.dart';
import '../../widgets/stateless/personal_information.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isClicked = false;

  void changeHeart() {
    setState(() {
      _isClicked = !_isClicked;
    });
  }

  Widget buildTextButton(Function natigator) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () => natigator(),
      child: Row(
        children: const [
          Text(
            'Chỉnh sửa',
            style: AppTextStyles.heading,
          ),
          Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage('assets/images/home_background.png'),
            fit: BoxFit.cover,
          ),
          Stack(
            children: [
              Positioned(
                top: 20,
                right: 80,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      setState(() {});
                    },
                    child: Ink(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50)),
                      child: Image.asset('assets/images/chat_bubble_1.png'),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 55,
                  right: 80,
                  child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                          color: Color(0xffffE9E9E9),
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "9",
                        style: TextStyle(
                            fontSize: 11.7,
                            height: 1.3,
                            color: Color(0xfffEF6565)),
                        textAlign: TextAlign.center,
                      ))),
            ],
          ),
          Stack(
            children: [
              Positioned(
                top: 20,
                right: 20,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      setState(() {});
                    },
                    child: Ink(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50)),
                      child: Image.asset('assets/images/settings_1.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.2,
              minChildSize: 0.2,
              maxChildSize: 0.8,
              builder: (context, scrollController) {
                return ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                        height: 606,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  height: 7,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xff404040),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          child: CircleAvatar(
                                            backgroundColor:
                                                AppColors.lightPink,
                                            radius: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          '201.023',
                                          style: AppTextStyles.sectionTitle,
                                        ),
                                        Text(
                                          'Số lượt thích',
                                          style: AppTextStyles.body3,
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: changeHeart,
                                      child: Ink(
                                        height: 50,
                                        width: 50,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(60)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              color: _isClicked
                                                  ? AppColors.redPigment
                                                  : AppColors.lightGray,
                                              Icons.favorite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
                                child: Text(
                                  'Trần Vương Duy',
                                  style: AppTextStyles.sectionTitle,
                                ),
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width * 0.8,
                                        27),
                                    backgroundColor: AppColors.lightperiwinkle,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: const Text('Trò chuyện',
                                      style: AppTextStyles.heading),
                                ),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              PersonalInformation(
                                  department: 'Công nghệ phần mềm',
                                  address: 'Bình Dương',
                                  birthDay: DateTime(2003, 04, 08),
                                  session: 16),
                              Divider(
                                thickness: 1,
                              ),
                              Description(
                                  description:
                                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.')
                            ],
                          ),
                        ),
                      ),
                    ));
              })
        ],
      ));
}
