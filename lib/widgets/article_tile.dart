import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jals/constants/dummy_image.dart';
import 'package:jals/models/article_model.dart';
import 'package:jals/models/video_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/ui/video/video_player.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/image.dart';
import 'package:jals/widgets/image_loader.dart';

class ArticleTile extends StatelessWidget {
  final ArticleModel article;

  const ArticleTile({
    Key key,
    @required this.article,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: InkWell(
        onTap: () {
          NavigationService _navigationService = locator<NavigationService>();
          _navigationService.navigateTo(ArticleViewRoute, argument: article);
        },
        child: Row(
          children: [
            Container(
              height: getProportionatefontSize(80),
              width: getProportionatefontSize(80),
              child: AspectRatio(
                aspectRatio: 1,
                child: ShowNetworkImage(imageUrl: article.coverImage),
              ),
            ),
            Expanded(
              child: ListTile(
                title: TextTitle(
                  text: "${article.title}",
                ),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 5),
                        child: TextCaption(
                          text: article.downloadDate != null
                              ? "Downloaded ${DateFormat("dd/MM/yyyy").format(article.downloadDate)}"
                              : "${article.author}",
                        ),
                      ),
                    ),
                    article.isBookmarked == null || article.downloaded
                        ? SizedBox()
                        : article.isBookmarked
                            ? Icon(
                                Icons.bookmark,
                                color: kPrimaryColor,
                                size: 20,
                              )
                            : SizedBox(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AudioTile extends StatelessWidget {
  final String image, title, author;

  const AudioTile(
      {Key key, @required this.image, @required this.title, this.author = ""})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      children: [
        Container(
          height: getProportionatefontSize(60),
          width: getProportionatefontSize(60),
          child: AspectRatio(
            aspectRatio: 1,
            child: ShowNetworkImage(imageUrl: image),
          ),
        ),
        Expanded(
          child: ListTile(
            trailing: Icon(Icons.more_vert),
            title: TextTitle(
              text: "$title",
              maxLines: 2,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: TextCaption(
                text: "$author",
              ),
            ),
          ),
        )
      ],
    );
  }
}

class VideoTile extends StatelessWidget {
  final VideoModel videoModel;
  // final String image, title, author;
  final bool showPrimaryButton, showSecondaryButton;

  const VideoTile({
    Key key,
    @required this.videoModel,
    // @required this.image,
    // @required this.title,
    // @required this.author,
    this.showPrimaryButton = true,
    this.showSecondaryButton = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => VideoPlayerView(
              videoModel: videoModel,
            ),
          ),
        );
      },
      child: Row(
        children: [
          Container(
            height: getProportionatefontSize(100),
            width: getProportionatefontSize(100),
            child: AspectRatio(
              aspectRatio: 1,
              child: ShowNetworkImage(
                  imageUrl: videoModel.coverImage ?? dummyImage),
            ),
          ),
          SizedBox(
            width: getProportionatefontSize(20),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              height: getProportionatefontSize(100),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextTitle(
                          maxLines: 2,
                          text: "${videoModel.title}",
                        ),
                      ),
                      Icon(Icons.more_vert),
                    ],
                  ),
                  SizedBox(
                    height: getProportionatefontSize(5),
                  ),
                  TextCaption(
                    text: "${videoModel.author}",
                  ),
                  SizedBox(
                    height: getProportionatefontSize(5),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      showSecondaryButton
                          ? ClipOval(
                              child: Container(
                                color: kGreen.withOpacity(0.15),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: kGreen,
                                  size: getProportionatefontSize(15),
                                ),
                              ),
                            )
                          : SizedBox(),
                      Spacer(),
                      showPrimaryButton
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: kGreen,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionatefontSize(20),
                                vertical: getProportionatefontSize(2),
                              ),
                              child: Center(
                                child: Text(
                                  "Buy",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getProportionatefontSize(12)),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  SizedBox(
                    height: getProportionatefontSize(5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoTileLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      children: [
        Container(
          height: getProportionatefontSize(100),
          width: getProportionatefontSize(100),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              height: 10,
              width: 100,
              child: ImageShimmerLoadingStateLight(),
            ),
          ),
        ),
        SizedBox(
          width: getProportionatefontSize(20),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 2),
            height: getProportionatefontSize(100),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10,
                  // width: 150,
                  child: ImageShimmerLoadingStateLight(),
                ),
                SizedBox(
                  height: getProportionatefontSize(10),
                ),
                Container(
                  height: 10,
                  width: 100,
                  child: ImageShimmerLoadingStateLight(),
                ),
                SizedBox(
                  height: getProportionatefontSize(5),
                ),
                Spacer(),
                SizedBox(
                  height: getProportionatefontSize(5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProductTile extends StatelessWidget {
  final String image, title, author, type;

  const ProductTile(
      {Key key,
      @required this.image,
      @required this.title,
      this.author = "",
      @required this.type})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      children: [
        Container(
          height: getProportionatefontSize(80),
          width: getProportionatefontSize(80),
          child: AspectRatio(
            aspectRatio: 1,
            child: ShowNetworkImage(imageUrl: image),
          ),
        ),
        SizedBox(
          width: getProportionatefontSize(20),
        ),
        Expanded(
          child: Container(
            height: getProportionatefontSize(80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCaption(
                  text: "$type",
                ),
                SizedBox(
                  height: getProportionatefontSize(5),
                ),
                TextTitle(
                  maxLines: 1,
                  text: "$title+",
                ),
                SizedBox(
                  height: getProportionatefontSize(5),
                ),
                TextCaption(
                  text: "$author",
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
