class Urls {
  static const String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static const String registration = "$_baseUrl/registration";
  static const String logIn = "$_baseUrl/login";
  static const String createNewTaskUrl = "$_baseUrl/createTask";
  static const String taskStatusCountUrl = "$_baseUrl/taskStatusCount";

  static  String taskListByStatusUrl(String status) =>
      "$_baseUrl/listTaskByStatus/$status";
}