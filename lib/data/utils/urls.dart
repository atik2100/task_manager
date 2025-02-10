class Urls {
  static const String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static const String registration = "$_baseUrl/registration";
  static const String logIn = "$_baseUrl/login";
  static const String createNewTaskUrl = "$_baseUrl/createTask";
  static const String taskStatusCountUrl = "$_baseUrl/taskStatusCount";

  static  String taskListByStatusUrl(String status) =>
      "$_baseUrl/listTaskByStatus/$status";

  static String updateTaskStatusUrl(String taskStatus, String id) =>
      "$_baseUrl/updateTaskStatus/$id/$taskStatus";
  static String deleteTaskUrl(String id ) =>
      "$_baseUrl/deleteTask/$id";

  static const String updateProfileUrl = "$_baseUrl/profileUpdate";

  static String recoverVerifyEmailUrl(String email) => "$_baseUrl/RecoverVerifyEmail/$email";

  static String recoverVerifyOTPUrl (String email, String otp) => "$_baseUrl/RecoverVerifyOTP/$email/$otp";

  static const recoverResetPassUrl = "$_baseUrl/RecoverResetPass";

}
