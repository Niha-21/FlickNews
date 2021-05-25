import 'package:news_app/models/category_model.dart';
List<CategoryModel> getCategories(){


  List<CategoryModel> category = new List<CategoryModel>();
  CategoryModel categoryModel;

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Business";
  categoryModel.imgURL = "https://images.unsplash.com/photo-1544725121-be3bf52e2dc8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1647&q=80";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Sports";
  categoryModel.imgURL = "https://images.unsplash.com/photo-1602472097151-72eeec7a3185?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTA3fHxzcG9ydHN8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Science";
  categoryModel.imgURL = "https://images.unsplash.com/photo-1554475900-0a0350e3fc7b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8c2NpZW5jZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "General";
  categoryModel.imgURL = "https://images.unsplash.com/photo-1521295121783-8a321d551ad2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fHdvcmxkfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Entertainment";
  categoryModel.imgURL = "https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Health";
  categoryModel.imgURL = "https://images.unsplash.com/photo-1494390248081-4e521a5940db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1595&q=80";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Technology";
  categoryModel.imgURL = "https://images.unsplash.com/photo-1485988412941-77a35537dae4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1072&q=80";
  category.add(categoryModel);

  return category;
}