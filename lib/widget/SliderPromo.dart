import 'package:car_online/entity/News.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Config.dart';

class SliderPromo extends StatelessWidget {
  List<News> news;

  SliderPromo(this.news);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        aspectRatio: 2.0,
        enlargeCenterPage: false,
        viewportFraction: 0.94,
        enableInfiniteScroll: false
      ),
      itemCount: (news.length / 2).round(),
      itemBuilder: (context, index, realIdx) {
        final int first = index * 2;
        final int second = first + 1;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [first, second].map((idx) {
            return Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                  child:Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Config.primaryDarkColor,
                            borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                          ),
                          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Text("${news[idx].name}", style: TextStyle(color: Colors.white, fontSize: Config.textSmallSize, fontWeight: FontWeight.w500)),
                        ),
                      ),

                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Config.splashOverlayColor,
                            onTap: (){

                            },
                          ),
                        ),
                      )
                    ],
                  )
                )
              ),

            );
          }).toList(),
        );
      },
    );
  }

}



