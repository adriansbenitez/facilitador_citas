import 'package:cached_network_image/cached_network_image.dart';
import 'package:facilitador_citas/models/models.dart';
import 'package:flutter/material.dart';

import '../config/language.dart';
import '../utils/images.dart';
import 'app_placeholder.dart';

enum StaffViewType { basic, information, qrcode }

class AppStaffInfo extends StatelessWidget {
  final StaffModel? staff;
  final VoidCallback? onPressed;
  final StaffViewType type;

  const AppStaffInfo({
    Key? key,
    this.staff,
    this.onPressed,
    this.type = StaffViewType.basic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case StaffViewType.information:
        if (staff == null) {
          return AppPlaceholder(
            child: Row(
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 10,
                        width: 100,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 10,
                        width: 100,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 10,
                        width: 150,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        Widget description = Container();
        if (staff!.about.isNotEmpty) {
          description = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                staff!.about,
                maxLines: 1,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          );
        }
        return InkWell(
          onTap: onPressed,
          child: Row(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: staff!.profileImage,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Theme.of(context).dividerColor.withOpacity(0.05),
                      ),
                    ),
                  );
                },
                placeholder: (context, url) {
                  return AppPlaceholder(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return AppPlaceholder(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(Icons.error),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${staff!.firstName} ${staff!.lastName}',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    description,
                    const SizedBox(height: 4),
                    Text(
                      staff!.email,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              RotatedBox(
                quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                child: const Icon(
                  Icons.keyboard_arrow_right,
                  textDirection: TextDirection.ltr,
                ),
              )
            ],
          ),
        );

      case StaffViewType.qrcode:
        return Container();

      default:
        if (staff == null) {
          return AppPlaceholder(
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 10,
                      width: 150,
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          );
        }
        return InkWell(
          onTap: onPressed,
          child: Row(
            children: <Widget>[
              staff!.profileImage == null ?
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  Images.profiledefault,
                  height: 40,
                  width: 40,
                ),
              )
               : CachedNetworkImage(
                imageUrl: staff!.profileImage,
                placeholder: (context, url) {
                  return AppPlaceholder(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return AppPlaceholder(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.error),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${staff!.firstName} ${staff!.lastName}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    staff!.email,
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              )
            ],
          ),
        );
    }
  }
}
