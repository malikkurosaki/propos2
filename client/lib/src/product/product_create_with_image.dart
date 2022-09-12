import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propos/src/product/product_val.dart';
import 'package:http/http.dart' as http;
import 'package:propos/utils/config.dart';
import 'package:propos/utils/vl.dart';

// class _ProductImage {
//   final isInclude = false.obs;
//   final imageId = "".obs;
//   String imageName = "";
// }

class ProductCreateWithImage extends StatelessWidget {
  const ProductCreateWithImage({Key? key}) : super(key: key);

  // ProductCreateWithImage({Key? key,
  //   required this.productImage
  // }) : super(key: key);


  // final dataImage = _ProductImage();
  // final RxMap<String, dynamic> productImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(
        () => Column(
          children: [
            CheckboxListTile(
              title: const Text("Include With Image ?"),
              value: ProductVal.dataImage.isInclude.value,
              onChanged: (value) {
                ProductVal.dataImage.isInclude.value = value!;
              },
              subtitle: const Text("tab pada gambar dibawah untuk memulai upload gambar"),
            ),
            Visibility(
              visible: ProductVal.dataImage.isInclude.value,
              child: InkWell(
                child: SizedBox(
                    width: double.infinity,
                    child: CachedNetworkImage(
                        errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        imageUrl: "${Config.host}/product-image/${ProductVal.productImage['name']}")),
                onTap: () async {
                  await _uploadImage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  _uploadImage() async {
    final upload = http.MultipartRequest(
      'POST',
      Uri.parse("${Config.host}/img/upload?userId=${Vl.userId.val}"),
    );
    final image = await ImagePicker().pickImage(maxHeight: 500, maxWidth: 500, source: ImageSource.gallery);
    if (image != null) {
      upload.files.add(http.MultipartFile.fromBytes("image", await image.readAsBytes(), filename: "${image.name}.png"));
      final res = await upload.send().then((value) => value.stream.bytesToString());
      final result = jsonDecode(res);
      ProductVal.productImage.assignAll(result);
      ProductVal.productImage.refresh();
      ProductVal.dataImage.imageId.value = ProductVal.productImage['id'];
      ProductVal.dataImage.imageName = result['name'];

      debugPrint(result.toString());

      // debugPrint(result.toString());
    } else {
      SmartDialog.showToast("No image selected");
    }
  }
}


