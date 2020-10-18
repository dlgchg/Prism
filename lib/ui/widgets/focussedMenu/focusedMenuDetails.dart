import 'dart:ui';
import 'package:Prism/data/favourites/provider/favouriteProvider.dart';
import 'package:Prism/data/pexels/provider/pexelsWithoutProvider.dart' as PData;
import 'package:Prism/data/prism/provider/prismWithoutProvider.dart' as Data;
import 'package:Prism/data/profile/wallpaper/profileWallProvider.dart';
import 'package:Prism/data/profile/wallpaper/getUserProfile.dart' as UserData;
import 'package:Prism/data/wallhaven/provider/wallhavenWithoutProvider.dart'
    as WData;
import 'package:Prism/routes/routing_constants.dart';
import 'package:Prism/theme/jam_icons_icons.dart';
import 'package:Prism/theme/themeModel.dart';
import 'package:Prism/ui/widgets/menuButton/downloadButton.dart';
import 'package:Prism/ui/widgets/menuButton/favWallpaperButton.dart';
import 'package:Prism/ui/widgets/menuButton/setWallpaperButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Prism/theme/config.dart' as config;

class FocusedMenuDetails extends StatefulWidget {
  final String provider;
  final Offset childOffset;
  final Size childSize;
  final int index;

  final Widget child;

  const FocusedMenuDetails({
    Key key,
    @required this.provider,
    @required this.childOffset,
    @required this.childSize,
    @required this.child,
    @required this.index,
  }) : super(key: key);

  @override
  _FocusedMenuDetailsState createState() => _FocusedMenuDetailsState();
}

class _FocusedMenuDetailsState extends State<FocusedMenuDetails> {
  Size size;
  var maxMenuWidth;
  var menuHeight;
  var leftOffset;
  var topOffset;
  var fabHeartTopOffset;
  var fabWallLeftOffset;
  var fabWallTopOffset;
  var fabHeartLeftOffset;
  @override
  void initState() {
    size = MediaQuery.of(context).size;
    maxMenuWidth = size.width * 0.63;
    menuHeight = size.height * 0.14;
    leftOffset = (widget.childOffset.dx + maxMenuWidth) < size.width
        ? MediaQuery.of(context).orientation == Orientation.portrait
            ? widget.childOffset.dx +
                widget.childSize.width +
                size.width * 0.015
            : widget.childOffset.dx + widget.childSize.width + size.width * 0.01
        : MediaQuery.of(context).orientation == Orientation.portrait
            ? (widget.childOffset.dx - maxMenuWidth + widget.childSize.width)
            : (widget.childOffset.dx -
                maxMenuWidth +
                widget.childSize.width +
                size.width * 0.3);
    topOffset = (widget.childOffset.dy + menuHeight + widget.childSize.height) <
            size.height
        ? MediaQuery.of(context).orientation == Orientation.portrait
            ? widget.childOffset.dy +
                widget.childSize.height +
                size.width * 0.015
            : widget.childOffset.dy +
                widget.childSize.height +
                size.width * 0.015
        : MediaQuery.of(context).orientation == Orientation.portrait
            ? widget.childOffset.dy - menuHeight + size.width * 0.125
            : widget.childOffset.dy - menuHeight;

    fabHeartTopOffset =
        (widget.childOffset.dy + menuHeight + widget.childSize.height) <
                size.height
            ? MediaQuery.of(context).orientation == Orientation.portrait
                ? size.width * 0.175
                : size.width * 0.1
            : MediaQuery.of(context).orientation == Orientation.portrait
                ? -size.width * 0.175
                : -size.width * 0.1;
    fabWallLeftOffset = (widget.childOffset.dx + maxMenuWidth) < size.width
        ? MediaQuery.of(context).orientation == Orientation.portrait
            ? -size.width * 0.175
            : -size.width * 0.1
        : MediaQuery.of(context).orientation == Orientation.portrait
            ? size.width * 0.175
            : size.width * 0.1;

    fabWallTopOffset =
        (widget.childOffset.dy + menuHeight + widget.childSize.height) <
                size.height
            ? MediaQuery.of(context).orientation == Orientation.portrait
                ? size.width * 0.05
                : size.width * 0.02
            : MediaQuery.of(context).orientation == Orientation.portrait
                ? -size.width * 0.05
                : -size.width * 0.02;
    fabHeartLeftOffset = (widget.childOffset.dx + maxMenuWidth) < size.width
        ? MediaQuery.of(context).orientation == Orientation.portrait
            ? -size.width * 0.05
            : -size.width * 0.02
        : MediaQuery.of(context).orientation == Orientation.portrait
            ? size.width * 0.05
            : size.width * 0.02;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.provider);
    try {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Provider.of<ThemeModel>(context, listen: false)
                                .returnTheme() ==
                            ThemeType.Dark
                        ? Colors.black.withOpacity(0.75)
                        : Colors.white.withOpacity(0.75),
                  )),
              Positioned(
                  top: widget.childOffset.dy,
                  left: widget.childOffset.dx,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: AbsorbPointer(
                        absorbing: true,
                        child: Container(
                            width: widget.childSize.width,
                            height: widget.childSize.height,
                            child: widget.child)),
                  )),
              widget.provider == "WallHaven"
                  ? Positioned(
                      top: widget.childOffset.dy +
                          widget.childSize.height * 4 / 10,
                      left: widget.childOffset.dx,
                      child: TweenAnimationBuilder(
                        duration: Duration(milliseconds: 150),
                        builder: (BuildContext context, value, Widget child) {
                          return Transform.scale(
                            scale: value,
                            alignment: Alignment.bottomRight,
                            child: child,
                          );
                        },
                        tween: Tween(begin: 0.0, end: 1.0),
                        child: Container(
                          width: widget.childSize.width,
                          height: widget.childSize.height * 6 / 10,
                          decoration: BoxDecoration(
                            color: config.Colors().secondDarkColor(1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 7, 15, 15),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ActionChip(
                                          pressElevation: 5,
                                          padding: EdgeInsets.fromLTRB(
                                              14, 11, 14, 11),
                                          avatar: Icon(
                                            JamIcons.ordered_list,
                                            color: HexColor(WData
                                                            .walls[widget.index]
                                                            .colors[WData
                                                                .walls[widget
                                                                    .index]
                                                                .colors
                                                                .length -
                                                            1])
                                                        .computeLuminance() >
                                                    0.5
                                                ? Colors.black
                                                : Colors.white,
                                            size: 20,
                                          ),
                                          backgroundColor: HexColor(WData
                                              .walls[widget.index].colors[WData
                                                  .walls[widget.index]
                                                  .colors
                                                  .length -
                                              1]),
                                          label: Text(
                                            WData.walls[widget.index].category
                                                    .toString()[0]
                                                    .toUpperCase() +
                                                WData.walls[widget.index]
                                                    .category
                                                    .toString()
                                                    .substring(1),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                  color: HexColor(WData
                                                                  .walls[widget
                                                                      .index]
                                                                  .colors[WData
                                                                      .walls[widget
                                                                          .index]
                                                                      .colors
                                                                      .length -
                                                                  1])
                                                              .computeLuminance() >
                                                          0.5
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                          ),
                                          onPressed: () {}),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 10),
                                        child: Text(
                                          WData.walls[widget.index].id
                                              .toString()
                                              .toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            JamIcons.eye,
                                            size: 20,
                                            color: Colors.white70,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Views: ${WData.walls[widget.index].views.toString()}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            JamIcons.set_square,
                                            size: 20,
                                            color: Colors.white70,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "${WData.walls[widget.index].resolution.toString()}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: config.Colors()
                                              .secondDarkColor(1),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomRight:
                                                  Radius.circular(20))),
                                      padding: EdgeInsets.all(0),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Icon(
                                          JamIcons.close,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : widget.provider == "Prism"
                      ? Positioned(
                          top: widget.childOffset.dy +
                              widget.childSize.height * 4 / 10,
                          left: widget.childOffset.dx,
                          child: TweenAnimationBuilder(
                            duration: Duration(milliseconds: 150),
                            builder:
                                (BuildContext context, value, Widget child) {
                              return Transform.scale(
                                scale: value,
                                alignment: Alignment.bottomRight,
                                child: child,
                              );
                            },
                            tween: Tween(begin: 0.0, end: 1.0),
                            child: Container(
                              width: widget.childSize.width,
                              height: widget.childSize.height * 6 / 10,
                              decoration: BoxDecoration(
                                color: config.Colors().secondDarkColor(1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 7, 15, 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          ActionChip(
                                              pressElevation: 5,
                                              padding: EdgeInsets.all(5),
                                              avatar: CircleAvatar(
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                        Data.subPrismWalls[
                                                                widget.index]
                                                            ["userPhoto"]),
                                              ),
                                              backgroundColor: Colors.black,
                                              labelPadding: EdgeInsets.fromLTRB(
                                                  7, 3, 7, 3),
                                              label: Text(
                                                Data.subPrismWalls[widget.index]
                                                            ["by"]
                                                        .toString()[0]
                                                        .toUpperCase() +
                                                    Data.subPrismWalls[
                                                            widget.index]["by"]
                                                        .toString()
                                                        .substring(1),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    PhotographerProfileRoute,
                                                    arguments: [
                                                      Data.subPrismWalls[
                                                          widget.index]["by"],
                                                      Data.subPrismWalls[widget
                                                          .index]["email"],
                                                      Data.subPrismWalls[widget
                                                          .index]["userPhoto"]
                                                    ]);
                                              }),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 5, 0, 10),
                                            child: Text(
                                              Data.subPrismWalls[widget.index]
                                                      ["id"]
                                                  .toString()
                                                  .toUpperCase(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                JamIcons.save,
                                                size: 20,
                                                color: Colors.white70,
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                "${Data.subPrismWalls[widget.index]["size"].toString()}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                JamIcons.set_square,
                                                size: 20,
                                                color: Colors.white70,
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                "${Data.subPrismWalls[widget.index]["resolution"].toString()}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: GestureDetector(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: config.Colors()
                                                  .secondDarkColor(1),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20))),
                                          padding: EdgeInsets.all(0),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 5, 10, 5),
                                            child: Icon(
                                              JamIcons.close,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        onTap: () async {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : widget.provider == "ProfileWall"
                          ? Positioned(
                              top: widget.childOffset.dy +
                                  widget.childSize.height * 4 / 10,
                              left: widget.childOffset.dx,
                              child: TweenAnimationBuilder(
                                duration: Duration(milliseconds: 150),
                                builder: (BuildContext context, value,
                                    Widget child) {
                                  return Transform.scale(
                                    scale: value,
                                    alignment: Alignment.bottomRight,
                                    child: child,
                                  );
                                },
                                tween: Tween(begin: 0.0, end: 1.0),
                                child: Container(
                                  width: widget.childSize.width,
                                  height: widget.childSize.height * 6 / 10,
                                  decoration: BoxDecoration(
                                    color: config.Colors().secondDarkColor(1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0)),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 7, 15, 15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ActionChip(
                                                  pressElevation: 5,
                                                  padding: EdgeInsets.fromLTRB(
                                                      14, 11, 14, 11),
                                                  avatar: Icon(
                                                    JamIcons.camera,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  backgroundColor: Colors.black,
                                                  label: Text(
                                                    Provider.of<ProfileWallProvider>(
                                                                context,
                                                                listen: false)
                                                            .profileWalls[widget
                                                                .index]["by"]
                                                            .toString()[0]
                                                            .toUpperCase() +
                                                        Provider.of<ProfileWallProvider>(
                                                                context,
                                                                listen: false)
                                                            .profileWalls[widget
                                                                .index]["by"]
                                                            .toString()
                                                            .substring(1),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4
                                                        .copyWith(
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                  onPressed: () {}),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 5, 0, 10),
                                                child: Text(
                                                  Provider.of<ProfileWallProvider>(
                                                          context,
                                                          listen: false)
                                                      .profileWalls[
                                                          widget.index]["id"]
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    JamIcons.save,
                                                    size: 20,
                                                    color: Colors.white70,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "${Provider.of<ProfileWallProvider>(context, listen: false).profileWalls[widget.index]["size"].toString()}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    JamIcons.set_square,
                                                    size: 20,
                                                    color: Colors.white70,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "${Provider.of<ProfileWallProvider>(context, listen: false).profileWalls[widget.index]["resolution"].toString()}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: config.Colors()
                                                      .secondDarkColor(1),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20))),
                                              padding: EdgeInsets.all(0),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 5, 10, 5),
                                                child: Icon(
                                                  JamIcons.close,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            onTap: () async {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : widget.provider == "UserProfileWall"
                              ? Positioned(
                                  top: widget.childOffset.dy +
                                      widget.childSize.height * 4 / 10,
                                  left: widget.childOffset.dx,
                                  child: TweenAnimationBuilder(
                                    duration: Duration(milliseconds: 150),
                                    builder: (BuildContext context, value,
                                        Widget child) {
                                      return Transform.scale(
                                        scale: value,
                                        alignment: Alignment.bottomRight,
                                        child: child,
                                      );
                                    },
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    child: Container(
                                      width: widget.childSize.width,
                                      height: widget.childSize.height * 6 / 10,
                                      decoration: BoxDecoration(
                                        color:
                                            config.Colors().secondDarkColor(1),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20.0)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20.0)),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 7, 15, 15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  ActionChip(
                                                      pressElevation: 5,
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              14, 11, 14, 11),
                                                      avatar: Icon(
                                                        JamIcons.camera,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                                      backgroundColor:
                                                          Colors.black,
                                                      label: Text(
                                                        UserData.userProfileWalls[
                                                                    widget
                                                                        .index]
                                                                    ["by"]
                                                                .toString()[0]
                                                                .toUpperCase() +
                                                            UserData
                                                                .userProfileWalls[
                                                                    widget
                                                                        .index]
                                                                    ["by"]
                                                                .toString()
                                                                .substring(1),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline4
                                                            .copyWith(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                      ),
                                                      onPressed: () {}),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 5, 0, 10),
                                                    child: Text(
                                                      UserData.userProfileWalls[
                                                              widget.index]
                                                              ["id"]
                                                          .toString()
                                                          .toUpperCase(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        JamIcons.save,
                                                        size: 20,
                                                        color: Colors.white70,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        "${UserData.userProfileWalls[widget.index]["size"].toString()}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        JamIcons.set_square,
                                                        size: 20,
                                                        color: Colors.white70,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        "${UserData.userProfileWalls[widget.index]["resolution"].toString()}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: GestureDetector(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: config.Colors()
                                                          .secondDarkColor(1),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                  padding: EdgeInsets.all(0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 5, 10, 5),
                                                    child: Icon(
                                                      JamIcons.close,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : widget.provider == "Pexels"
                                  ? Positioned(
                                      top: widget.childOffset.dy +
                                          widget.childSize.height * 4 / 10,
                                      left: widget.childOffset.dx,
                                      child: TweenAnimationBuilder(
                                        duration: Duration(milliseconds: 200),
                                        builder: (BuildContext context, value,
                                            Widget child) {
                                          return Transform.scale(
                                            scale: value,
                                            alignment: Alignment.bottomRight,
                                            child: child,
                                          );
                                        },
                                        tween: Tween(begin: 0.0, end: 1.0),
                                        child: Container(
                                          width: widget.childSize.width,
                                          height:
                                              widget.childSize.height * 6 / 10,
                                          decoration: BoxDecoration(
                                            color: config.Colors()
                                                .secondDarkColor(1),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20.0)),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20.0)),
                                            child: Stack(
                                              fit: StackFit.expand,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 7, 15, 15),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      ActionChip(
                                                          pressElevation: 5,
                                                          padding: EdgeInsets
                                                              .fromLTRB(14, 11,
                                                                  14, 11),
                                                          backgroundColor:
                                                              Colors.black,
                                                          avatar: Icon(
                                                              JamIcons.camera,
                                                              color:
                                                                  Colors.white,
                                                              size: 20),
                                                          label: Text(
                                                            PData
                                                                .wallsP[widget
                                                                    .index]
                                                                .photographer
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline4
                                                                .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                          ),
                                                          onPressed: () {
                                                            launch(PData
                                                                .wallsP[widget
                                                                    .index]
                                                                .url);
                                                          }),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 5, 0, 10),
                                                        child: Text(
                                                          PData.wallsP[widget.index].url
                                                                      .toString()
                                                                      .replaceAll(
                                                                          "https://www.pexels.com/photo/", "")
                                                                      .replaceAll(
                                                                          "-", " ")
                                                                      .replaceAll(
                                                                          "/", "")
                                                                      .length >
                                                                  8
                                                              ? PData.wallsP[widget.index].url
                                                                      .toString()
                                                                      .replaceAll(
                                                                          "https://www.pexels.com/photo/", "")
                                                                      .replaceAll(
                                                                          "-", " ")
                                                                      .replaceAll(
                                                                          "/",
                                                                          "")[0]
                                                                      .toUpperCase() +
                                                                  PData.wallsP[widget.index].url
                                                                      .toString()
                                                                      .replaceAll(
                                                                          "https://www.pexels.com/photo/", "")
                                                                      .replaceAll(
                                                                          "-", " ")
                                                                      .replaceAll("/", "")
                                                                      .substring(1, PData.wallsP[widget.index].url.toString().replaceAll("https://www.pexels.com/photo/", "").replaceAll("-", " ").replaceAll("/", "").length - 7)
                                                              : PData.wallsP[widget.index].url.toString().replaceAll("https://www.pexels.com/photo/", "").replaceAll("-", " ").replaceAll("/", "")[0].toUpperCase() + PData.wallsP[widget.index].url.toString().replaceAll("https://www.pexels.com/photo/", "").replaceAll("-", " ").replaceAll("/", "").substring(1),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline5,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            JamIcons.set_square,
                                                            color:
                                                                Colors.white70,
                                                            size: 20,
                                                          ),
                                                          SizedBox(width: 5),
                                                          Text(
                                                            "${PData.wallsP[widget.index].width.toString()}x${PData.wallsP[widget.index].height.toString()}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: GestureDetector(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: config.Colors()
                                                              .secondDarkColor(
                                                                  1),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          20))),
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                10, 5, 10, 5),
                                                        child: Icon(
                                                          JamIcons.close,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () async {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : widget.provider == "Liked"
                                      ? Provider.of<FavouriteProvider>(context,
                                                          listen: false)
                                                      .liked[widget.index]
                                                  ["provider"] ==
                                              "WallHaven"
                                          ? Positioned(
                                              top: widget.childOffset.dy +
                                                  widget.childSize.height *
                                                      2 /
                                                      8,
                                              left: widget.childOffset.dx,
                                              child: TweenAnimationBuilder(
                                                duration:
                                                    Duration(milliseconds: 200),
                                                builder: (BuildContext context,
                                                    value, Widget child) {
                                                  return Transform.scale(
                                                    scale: value,
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: child,
                                                  );
                                                },
                                                tween:
                                                    Tween(begin: 0.0, end: 1.0),
                                                child: Container(
                                                  width: widget.childSize.width,
                                                  height:
                                                      widget.childSize.height *
                                                          6 /
                                                          8,
                                                  decoration: BoxDecoration(
                                                    color: config.Colors()
                                                        .secondDarkColor(1),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20.0)),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20.0)),
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  15,
                                                                  7,
                                                                  15,
                                                                  15),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              ActionChip(
                                                                  pressElevation:
                                                                      5,
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          14,
                                                                          11,
                                                                          14,
                                                                          11),
                                                                  avatar: Icon(
                                                                    JamIcons
                                                                        .ordered_list,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 20,
                                                                  ),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black,
                                                                  label: Text(
                                                                    Provider.of<FavouriteProvider>(context, listen: false)
                                                                            .liked[widget.index][
                                                                                "category"]
                                                                            .toString()[
                                                                                0]
                                                                            .toUpperCase() +
                                                                        Provider.of<FavouriteProvider>(context,
                                                                                listen: false)
                                                                            .liked[widget.index]["category"]
                                                                            .toString()
                                                                            .substring(1),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline4
                                                                        .copyWith(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                  ),
                                                                  onPressed:
                                                                      () {}),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        5,
                                                                        0,
                                                                        10),
                                                                child: Text(
                                                                  Provider.of<FavouriteProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .liked[
                                                                          widget
                                                                              .index]
                                                                          ["id"]
                                                                      .toString()
                                                                      .toUpperCase(),
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline5,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    JamIcons
                                                                        .eye,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .white70,
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                    "Views: ${Provider.of<FavouriteProvider>(context, listen: false).liked[widget.index]["views"].toString()}",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText2,
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    JamIcons
                                                                        .set_square,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .white70,
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                    "${Provider.of<FavouriteProvider>(context, listen: false).liked[widget.index]["resolution"].toString()}",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText2,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child:
                                                              GestureDetector(
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                      0xFF2F2F2F),
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              20),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              20))),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            10,
                                                                            5,
                                                                            10,
                                                                            5),
                                                                child: Icon(
                                                                  JamIcons
                                                                      .close,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () async {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Provider.of<FavouriteProvider>(
                                                              context,
                                                              listen: false)
                                                          .liked[widget.index]
                                                      ["provider"] ==
                                                  "Prism"
                                              ? Positioned(
                                                  top: widget.childOffset.dy +
                                                      widget.childSize.height *
                                                          2 /
                                                          8,
                                                  left: widget.childOffset.dx,
                                                  child: TweenAnimationBuilder(
                                                    duration: Duration(
                                                        milliseconds: 200),
                                                    builder:
                                                        (BuildContext context,
                                                            value,
                                                            Widget child) {
                                                      return Transform.scale(
                                                        scale: value,
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: child,
                                                      );
                                                    },
                                                    tween: Tween(
                                                        begin: 0.0, end: 1.0),
                                                    child: Container(
                                                      width: widget
                                                          .childSize.width,
                                                      height: widget.childSize
                                                              .height *
                                                          6 /
                                                          8,
                                                      decoration: BoxDecoration(
                                                        color: config.Colors()
                                                            .secondDarkColor(1),
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    20.0)),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    20.0)),
                                                        child: Stack(
                                                          fit: StackFit.expand,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      15,
                                                                      7,
                                                                      15,
                                                                      15),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  ActionChip(
                                                                      pressElevation:
                                                                          5,
                                                                      padding: EdgeInsets.fromLTRB(
                                                                          14,
                                                                          11,
                                                                          14,
                                                                          11),
                                                                      avatar:
                                                                          Icon(
                                                                        JamIcons
                                                                            .camera,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .black,
                                                                      label:
                                                                          Text(
                                                                        Provider.of<FavouriteProvider>(context, listen: false).liked[widget.index]["photographer"].toString()[0].toUpperCase() +
                                                                            Provider.of<FavouriteProvider>(context, listen: false).liked[widget.index]["photographer"].toString().substring(1),
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline4
                                                                            .copyWith(
                                                                              color: Colors.white,
                                                                            ),
                                                                      ),
                                                                      onPressed:
                                                                          () {}),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            0,
                                                                            5,
                                                                            0,
                                                                            10),
                                                                    child: Text(
                                                                      Provider.of<FavouriteProvider>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .liked[
                                                                              widget.index]
                                                                              [
                                                                              "id"]
                                                                          .toString()
                                                                          .toUpperCase(),
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headline5,
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        JamIcons
                                                                            .save,
                                                                        size:
                                                                            20,
                                                                        color: Colors
                                                                            .white70,
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              10),
                                                                      Text(
                                                                        "${Provider.of<FavouriteProvider>(context, listen: false).liked[widget.index]["size"].toString()}",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        JamIcons
                                                                            .set_square,
                                                                        size:
                                                                            20,
                                                                        color: Colors
                                                                            .white70,
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              10),
                                                                      Text(
                                                                        "${Provider.of<FavouriteProvider>(context, listen: false).liked[widget.index]["resolution"].toString()}",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              child:
                                                                  GestureDetector(
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      color: Color(
                                                                          0xFF2F2F2F),
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              20),
                                                                          bottomRight:
                                                                              Radius.circular(20))),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            10,
                                                                            5,
                                                                            10,
                                                                            5),
                                                                    child: Icon(
                                                                      JamIcons
                                                                          .close,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                                onTap:
                                                                    () async {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Provider.of<FavouriteProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .liked[widget.index]
                                                          ["provider"] ==
                                                      "Pexels"
                                                  ? Positioned(
                                                      top: widget
                                                              .childOffset.dy +
                                                          widget.childSize
                                                                  .height *
                                                              1 /
                                                              2,
                                                      left:
                                                          widget.childOffset.dx,
                                                      child:
                                                          TweenAnimationBuilder(
                                                        duration: Duration(
                                                            milliseconds: 200),
                                                        builder: (BuildContext
                                                                context,
                                                            value,
                                                            Widget child) {
                                                          return Transform
                                                              .scale(
                                                            scale: value,
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: child,
                                                          );
                                                        },
                                                        tween: Tween(
                                                            begin: 0.0,
                                                            end: 1.0),
                                                        child: Container(
                                                          width: widget
                                                              .childSize.width,
                                                          height: widget
                                                                  .childSize
                                                                  .height *
                                                              1 /
                                                              2,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF2F2F2F),
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius.circular(
                                                                        20.0)),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius.circular(
                                                                        20.0)),
                                                            child: Stack(
                                                              fit: StackFit
                                                                  .expand,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          15,
                                                                          7,
                                                                          15,
                                                                          15),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      ActionChip(
                                                                          pressElevation:
                                                                              5,
                                                                          padding: EdgeInsets.fromLTRB(
                                                                              14,
                                                                              11,
                                                                              14,
                                                                              11),
                                                                          backgroundColor: Colors
                                                                              .black,
                                                                          avatar: Icon(JamIcons.camera,
                                                                              color: Colors
                                                                                  .white,
                                                                              size:
                                                                                  20),
                                                                          label:
                                                                              Text(
                                                                            Provider.of<FavouriteProvider>(context, listen: false).liked[widget.index]["photographer"].toString(),
                                                                            style: Theme.of(context).textTheme.headline4.copyWith(
                                                                                  color: Colors.white,
                                                                                ),
                                                                          ),
                                                                          onPressed:
                                                                              () {}),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            JamIcons.set_square,
                                                                            color:
                                                                                Colors.white70,
                                                                            size:
                                                                                20,
                                                                          ),
                                                                          SizedBox(
                                                                              width: 5),
                                                                          Text(
                                                                            Provider.of<FavouriteProvider>(context, listen: false).liked[widget.index]["resolution"].toString(),
                                                                            style:
                                                                                Theme.of(context).textTheme.headline6,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomRight,
                                                                  child:
                                                                      GestureDetector(
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Color(
                                                                              0xFF2F2F2F),
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(20),
                                                                              bottomRight: Radius.circular(20))),
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets.fromLTRB(
                                                                            10,
                                                                            5,
                                                                            10,
                                                                            5),
                                                                        child:
                                                                            Icon(
                                                                          JamIcons
                                                                              .close,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onTap:
                                                                        () async {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Positioned(
                                                      top: widget
                                                              .childOffset.dy +
                                                          widget.childSize
                                                                  .height *
                                                              1 /
                                                              2,
                                                      left:
                                                          widget.childOffset.dx,
                                                      child:
                                                          TweenAnimationBuilder(
                                                        duration: Duration(
                                                            milliseconds: 200),
                                                        builder: (BuildContext
                                                                context,
                                                            value,
                                                            Widget child) {
                                                          return Transform
                                                              .scale(
                                                            scale: value,
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: child,
                                                          );
                                                        },
                                                        tween: Tween(
                                                            begin: 0.0,
                                                            end: 1.0),
                                                        child: Container(
                                                          width: widget
                                                              .childSize.width,
                                                          height: widget
                                                                  .childSize
                                                                  .height *
                                                              1 /
                                                              2,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF2F2F2F),
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius.circular(
                                                                        20.0)),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius.circular(
                                                                        20.0)),
                                                            child: Stack(
                                                              fit: StackFit
                                                                  .expand,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          15,
                                                                          7,
                                                                          15,
                                                                          15),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            JamIcons.heart_f,
                                                                            color:
                                                                                Colors.white70,
                                                                            size:
                                                                                20,
                                                                          ),
                                                                          SizedBox(
                                                                              width: 5),
                                                                          Text(
                                                                            "Likes: " +
                                                                                Provider.of<FavouriteProvider>(context, listen: false).liked[widget.index]["fav"].toString(),
                                                                            style:
                                                                                Theme.of(context).textTheme.headline6,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            JamIcons.eye,
                                                                            color:
                                                                                Colors.white70,
                                                                            size:
                                                                                20,
                                                                          ),
                                                                          SizedBox(
                                                                              width: 5),
                                                                          Text(
                                                                            "Views: " +
                                                                                Provider.of<FavouriteProvider>(context, listen: false).liked[widget.index]["views"].toString(),
                                                                            style:
                                                                                Theme.of(context).textTheme.headline6,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            JamIcons.set_square,
                                                                            color:
                                                                                Colors.white70,
                                                                            size:
                                                                                20,
                                                                          ),
                                                                          SizedBox(
                                                                              width: 5),
                                                                          Text(
                                                                            Provider.of<FavouriteProvider>(context, listen: false).liked[widget.index]["resolution"].toString(),
                                                                            style:
                                                                                Theme.of(context).textTheme.headline6,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomRight,
                                                                  child:
                                                                      GestureDetector(
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Color(
                                                                              0xFF2F2F2F),
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(20),
                                                                              bottomRight: Radius.circular(20))),
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets.fromLTRB(
                                                                            10,
                                                                            5,
                                                                            10,
                                                                            5),
                                                                        child:
                                                                            Icon(
                                                                          JamIcons
                                                                              .close,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onTap:
                                                                        () async {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                      : Positioned(
                                          top: widget.childOffset.dy +
                                              widget.childSize.height * 2 / 8,
                                          left: widget.childOffset.dx,
                                          child: TweenAnimationBuilder(
                                            duration:
                                                Duration(milliseconds: 200),
                                            builder: (BuildContext context,
                                                value, Widget child) {
                                              return Transform.scale(
                                                scale: value,
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: child,
                                              );
                                            },
                                            tween: Tween(begin: 0.0, end: 1.0),
                                            child: Container(
                                              width: widget.childSize.width,
                                              height: widget.childSize.height *
                                                  6 /
                                                  8,
                                              decoration: BoxDecoration(
                                                color: config.Colors()
                                                    .secondDarkColor(1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20.0)),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20.0)),
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          15, 7, 15, 15),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          ActionChip(
                                                              pressElevation: 5,
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          14,
                                                                          11,
                                                                          14,
                                                                          11),
                                                              backgroundColor:
                                                                  Colors.black,
                                                              avatar: Icon(
                                                                  JamIcons
                                                                      .camera,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 20),
                                                              label: Text(
                                                                PData
                                                                    .wallsC[widget
                                                                        .index]
                                                                    .photographer
                                                                    .toString(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline4
                                                                    .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                              ),
                                                              onPressed: () {}),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0,
                                                                    5,
                                                                    0,
                                                                    10),
                                                            child: Text(
                                                              PData.wallsC[widget.index].url
                                                                          .toString()
                                                                          .replaceAll(
                                                                              "https://www.pexels.com/photo/", "")
                                                                          .replaceAll(
                                                                              "-", " ")
                                                                          .replaceAll(
                                                                              "/", "")
                                                                          .length >
                                                                      8
                                                                  ? PData.wallsC[widget.index].url.toString().replaceAll("https://www.pexels.com/photo/", "").replaceAll("-", " ").replaceAll("/", "")[0].toUpperCase() +
                                                                      PData.wallsC[widget.index].url
                                                                          .toString()
                                                                          .replaceAll(
                                                                              "https://www.pexels.com/photo/", "")
                                                                          .replaceAll(
                                                                              "-", " ")
                                                                          .replaceAll(
                                                                              "/",
                                                                              "")
                                                                          .substring(
                                                                              1,
                                                                              PData.wallsC[widget.index].url.toString().replaceAll("https://www.pexels.com/photo/", "").replaceAll("-", " ").replaceAll("/", "").length -
                                                                                  7)
                                                                  : PData.wallsC[widget.index].url.toString().replaceAll("https://www.pexels.com/photo/", "").replaceAll("-", " ").replaceAll("/", "")[0].toUpperCase() +
                                                                      PData
                                                                          .wallsC[widget.index]
                                                                          .url
                                                                          .toString()
                                                                          .replaceAll("https://www.pexels.com/photo/", "")
                                                                          .replaceAll("-", " ")
                                                                          .replaceAll("/", "")
                                                                          .substring(1),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                JamIcons
                                                                    .set_square,
                                                                color: Colors
                                                                    .white70,
                                                                size: 20,
                                                              ),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                "${PData.wallsC[widget.index].width.toString()}x${PData.wallsC[widget.index].height.toString()}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline6,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: GestureDetector(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xFF2F2F2F),
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          20))),
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 5,
                                                                    10, 5),
                                                            child: Icon(
                                                              JamIcons.close,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () async {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
              Positioned(
                top: topOffset,
                left: leftOffset,
                child: SetWallpaperButton(
                  colorChanged: false,
                  url: widget.provider == "WallHaven"
                      ? WData.walls[widget.index].path.toString()
                      : widget.provider == "Prism"
                          ? Data.subPrismWalls[widget.index]["wallpaper_url"]
                              .toString()
                          : widget.provider == "ProfileWall"
                              ? Provider.of<ProfileWallProvider>(context,
                                      listen: false)
                                  .profileWalls[widget.index]["wallpaper_url"]
                                  .toString()
                              : widget.provider == "UserProfileWall"
                                  ? UserData.userProfileWalls[widget.index]
                                          ["wallpaper_url"]
                                      .toString()
                                  : widget.provider == "Pexels"
                                      ? PData
                                          .wallsP[widget.index].src["original"]
                                          .toString()
                                      : widget.provider == "Liked"
                                          ? Provider.of<FavouriteProvider>(
                                                  context,
                                                  listen: false)
                                              .liked[widget.index]["url"]
                                              .toString()
                                          : PData.wallsC[widget.index]
                                              .src["original"]
                                              .toString(),
                ),
              ),
              Positioned(
                top: topOffset - fabHeartTopOffset,
                left: leftOffset - fabHeartLeftOffset,
                child: widget.provider == "WallHaven"
                    ? FavouriteWallpaperButton(
                        id: WData.walls[widget.index].id.toString(),
                        provider: "WallHaven",
                        wallhaven: WData.walls[widget.index],
                        trash: false,
                      )
                    : widget.provider == "Prism"
                        ? FavouriteWallpaperButton(
                            id: Data.subPrismWalls[widget.index]["id"]
                                .toString(),
                            provider: "Prism",
                            prism: Data.subPrismWalls[widget.index],
                            trash: false,
                          )
                        : widget.provider == "ProfileWall"
                            ? FavouriteWallpaperButton(
                                id: Provider.of<ProfileWallProvider>(context,
                                        listen: false)
                                    .profileWalls[widget.index]["id"]
                                    .toString(),
                                provider: "Prism",
                                prism: Provider.of<ProfileWallProvider>(context,
                                        listen: false)
                                    .profileWalls[widget.index],
                                trash: false,
                              )
                            : widget.provider == "UserProfileWall"
                                ? FavouriteWallpaperButton(
                                    id: UserData.userProfileWalls[widget.index]
                                            ["id"]
                                        .toString(),
                                    provider: "Prism",
                                    prism:
                                        UserData.userProfileWalls[widget.index],
                                    trash: false,
                                  )
                                : widget.provider == "Pexels"
                                    ? FavouriteWallpaperButton(
                                        id: PData.wallsP[widget.index].id
                                            .toString(),
                                        provider: "Pexels",
                                        pexels: PData.wallsP[widget.index],
                                        trash: false,
                                      )
                                    : widget.provider == "Liked"
                                        ? FavouriteWallpaperButton(
                                            id: Provider.of<FavouriteProvider>(
                                                    context,
                                                    listen: false)
                                                .liked[widget.index]["id"]
                                                .toString(),
                                            provider:
                                                Provider.of<FavouriteProvider>(
                                                        context,
                                                        listen: false)
                                                    .liked[widget.index]
                                                        ["provider"]
                                                    .toString(),
                                            trash: true,
                                          )
                                        : FavouriteWallpaperButton(
                                            id: PData.wallsC[widget.index].id
                                                .toString(),
                                            provider: "Pexels",
                                            pexels: PData.wallsC[widget.index],
                                            trash: false,
                                          ),
              ),
              Positioned(
                top: topOffset + fabWallTopOffset,
                left: leftOffset + fabWallLeftOffset,
                child: DownloadButton(
                  colorChanged: false,
                  link: widget.provider == "WallHaven"
                      ? WData.walls[widget.index].path.toString()
                      : widget.provider == "Prism"
                          ? Data.subPrismWalls[widget.index]["wallpaper_url"]
                              .toString()
                          : widget.provider == "ProfileWall"
                              ? Provider.of<ProfileWallProvider>(context,
                                      listen: false)
                                  .profileWalls[widget.index]["wallpaper_url"]
                                  .toString()
                              : widget.provider == "UserProfileWall"
                                  ? UserData.userProfileWalls[widget.index]
                                          ["wallpaper_url"]
                                      .toString()
                                  : widget.provider == "Pexels"
                                      ? PData
                                          .wallsP[widget.index].src["original"]
                                          .toString()
                                      : widget.provider == "Liked"
                                          ? Provider.of<FavouriteProvider>(
                                                  context,
                                                  listen: false)
                                              .liked[widget.index]["url"]
                                              .toString()
                                          : PData.wallsC[widget.index]
                                              .src["original"]
                                              .toString(),
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      print(e.toString());
      Navigator.pop(context);
      return Container();
    }
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
