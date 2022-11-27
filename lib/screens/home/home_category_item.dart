import 'package:facilitador_citas/models/models.dart';
import 'package:flutter/material.dart';

class HomeCategoryItem extends StatelessWidget {
  final SingleCategorieModel? item;
  final Function(SingleCategorieModel)? onPressed;

  const HomeCategoryItem({
    Key? key,
    this.item,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return AppPlaceholder(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.21,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 10,
                width: 48,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.21,
      child: GestureDetector(
        onTap: () => onPressed!(item!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Container()
            ),
            const SizedBox(height: 4),
            Text(
              item!.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.button!.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
