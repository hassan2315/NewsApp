import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/screens/webview.dart';

Widget buildArtcileItem(
  article,
  BuildContext context,
) {
  if (article == null || article is! Map<String, dynamic>) {
    return const SizedBox.shrink();
  }
  return InkWell(
    onTap: () {
      navigateTo(context, WebViewScreen(article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.grey[200],
              child: Stack(
                children: [
                  CachedNetworkImage(
                      imageUrl: article['urlToImage'] ?? '',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const Icon(
                            Icons.error_outline_outlined,
                            size: 50,
                          )),
                  if (article['source'] != null)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Text(
                          '${article['source']['name']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title'] ?? ''}',
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMMd()
                        .format(DateTime.parse(article['publishedAt'] ?? '')),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?) validate,
  required String label,
  required IconData prefix,
  void Function()? onTap,
  bool isClickable = true,
  ValueChanged<String>? onChange,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    validator: validate,
    onTap: onTap,
    onChanged: onChange,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      border: const OutlineInputBorder(),
    ),
  );
}

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));
