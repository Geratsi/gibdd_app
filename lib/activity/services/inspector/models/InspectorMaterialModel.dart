
class InspectorMaterialModel {
  late double? lat;
  late double? long;
  late bool isImage;
  late bool wasSent;
  late bool isAsset;
  late bool isChecked;
  late String sourceURL;
  late String? comments;

  InspectorMaterialModel({
    required this.sourceURL, this.isImage=true, this.isAsset = true,
    this.isChecked = false, this.wasSent= false, this.lat, this.long,
    this.comments,
  });
}

