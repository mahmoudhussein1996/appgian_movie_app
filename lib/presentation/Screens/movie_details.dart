import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

import '../../utils/colors.dart';


class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/movie_details';

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  StreamController<String> controllerUrl = StreamController<String>();

  void generateLink(BranchUniversalObject buo, BranchLinkProperties lp) async {
    BranchResponse response =
        await FlutterBranchSdk.getShortUrl(buo: buo, linkProperties: lp);
    if (response.success) {
      debugPrint(response.result);
      controllerUrl.sink.add('${response.result}');
    } else {
      controllerUrl.sink
          .add('Error : ${response.errorCode} - ${response.errorMessage}');
    }
  }

  @override
  void initState() {
    // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final Map? details = routeArgs;
    // getData(details!['id']);
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          BranchLinkProperties lp = BranchLinkProperties(
              channel: 'facebook',
              feature: 'sharing',
              //parameter alias
              //Instead of our standard encoded short url, you can specify the vanity alias.
              // For example, instead of a random string of characters/integers, you can set the vanity alias as *.app.link/devonaustin.
              // Aliases are enforced to be unique** and immutable per domain, and per link - they cannot be reused unless deleted.
              //alias: 'https://branch.io' //define link url,
              stage: 'new share',
              campaign: 'xxxxx',
              tags: ['one', 'two', 'three']);
          lp.addControlParam('\$uri_redirect_mode', '1');
          // ..addControlParam('referring_user_id', 'asdf'),
          return generateLink(
            BranchUniversalObject(
                canonicalIdentifier: 'flutter/branch',
                //parameter canonicalUrl
                //If your content lives both on the web and in the app, make sure you set its canonical URL
                // (i.e. the URL of this piece of content on the web) when building any BUO.
                // By doing so, we’ll attribute clicks on the links that you generate back to their original web page,
                // even if the user goes to the app instead of your website! This will help your SEO efforts.
                canonicalUrl: 'https://flutter.dev',
                title: 'Flutter Branch Plugin',
                imageUrl:
                'https://flutter.dev/assets/flutter-lockup-4cb0ee072ab312e59784d9fbf4fb7ad42688a7fdaea1270ccf6bbf4f34b7e03f.svg',
                contentDescription: 'Flutter Branch Description',
                contentMetadata: BranchContentMetaData()
                  ..addCustomMetadata('Movie Name', details!['title'])
                  ..addCustomMetadata('custom_number', 12345)
                  ..addCustomMetadata('custom_bool', true)
                  ..addCustomMetadata('key', 1),
                keywords: ['Plugin', 'Branch', 'Flutter'],
                publiclyIndex: true,
                locallyIndex: true,
                expirationDateInMilliSec: DateTime.now()
                    .add(const Duration(days: 365))
                    .millisecondsSinceEpoch),
            lp,
          );
        },
        child: Container(
          width: 250,
          height: 100,
          color: AppColors.redColor,
          child: Center(
            child: Text(
              'Generate Link\n\n\'click here to \ngenerating deep link\n',
              style: TextStyle(color: AppColors.whiteColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xff2c3840),
            image: DecorationImage(
              image: CachedNetworkImageProvider(details!['banner']),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1), BlendMode.dstATop),
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Stack(
                children: [
                  Positioned(
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: details['banner'],
                      ),
                    ),
                  ),
                  Positioned(
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                details['title'],
                style:  TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Released:  ${details['release']}',
                      style:  TextStyle(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                       Icon(
                        Icons.star,
                        color: AppColors.yelloColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        details['vote_average'].toString(),
                        style:  TextStyle(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
               Divider(
                thickness: 2,
                color: AppColors.greyColor
              ),
              const SizedBox(
                height: 2,
              ),
               Text(
                'Overview:',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(),
              Text(
                details['overview'],
                style:  TextStyle(
                  color: AppColors.whiteColor,
                  height: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
