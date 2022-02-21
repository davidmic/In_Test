import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:in_test/exhibition/data/model/exhibit_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class exhibitWidget extends StatelessWidget {
  const exhibitWidget({
    Key? key,
    required this.exhibit,
    required PageController controller,
  })  : _controller = controller,
        super(key: key);

  final Exhibit exhibit;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            exhibit.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: PageView.builder(
              controller: _controller,
              itemCount: exhibit.images.length,
              itemBuilder: (context, imageIndex) {
                return FancyShimmerImage(
                  imageUrl: exhibit.images[imageIndex],
                  errorWidget: Image.network(
                    'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1',
                    fit: BoxFit.fill,
                  ),
                );
              }),
        ),
        SizedBox(height: 5),
        SmoothPageIndicator(
          controller: _controller, // PageController
          count: exhibit.images.length,
          effect: WormEffect(
            spacing: 8.0,
            radius: 4.0,
            dotWidth: 25.0,
            dotHeight: 10.0,
            dotColor: Colors.grey.withOpacity(0.3),
            strokeWidth: 2,
            activeDotColor: Colors.grey,
          ), // your preferred effect
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
