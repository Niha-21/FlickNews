import 'package:news_app/models/extra_model.dart';

List<ExtraModel> getData(){

  
  List<ExtraModel> data = new List<ExtraModel>();
  ExtraModel xModel;

  xModel = new ExtraModel();
  xModel.country = "in";
  xModel.category = "Business";
  data.add(xModel);

  return data;
}