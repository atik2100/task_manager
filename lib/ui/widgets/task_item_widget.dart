import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/snack_bar_massege.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key, required this.taskModel,

  });

  final TaskModel taskModel;



  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        title:  Text(taskModel.title ?? ""),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(taskModel.description ?? ""),
            const SizedBox(height: 4),
             Text(taskModel.createdDate ?? ""),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: _getStatusColor(taskModel.status),
                  ),

                  child: Text(taskModel.status ?? "",style: const TextStyle(color: Colors.white),),
                ),

                Row(
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.green,
                      ),
                      onPressed: () {
                        _showStatusDialog(context);
                      },
                      icon: const Icon(Icons.edit_note_sharp),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.pink,
                      ),
                      onPressed: () {
                        _showDeleteDialog(context);
                      },
                      icon: const Icon(Icons.delete_forever_outlined),
                    ),
                  ],
                ),

              ],
            )
          ],
        ),
      ),
    );
  }

  void _showStatusDialog(BuildContext context) {

    String selectedStatus = taskModel.status ?? "New";
    showDialog(
        context: context,
        builder: (context) {
      return  AlertDialog(
              title: const Text("Edit Task Status"),
        content: DropdownButtonFormField<String>(
                value: selectedStatus,
                items: ["New", "Progress", "Completed", "Cancelled"]
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
            .toList(),
          onChanged: (value){
                  selectedStatus = value!;
          },
        ),
        actions: [
          TextButton(
              onPressed: (){
                // Navigator.pop(context);
                Get.back();
              },
              child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () async{
                // Navigator.pop(context);
                Get.back();
                await _editTaskStatus(selectedStatus,context);
              },
              child: const Text("Save")),
        ],
          );
        });
  }

  Future<void> _editTaskStatus(String newStatus, BuildContext context) async{
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.updateTaskStatusUrl(newStatus, taskModel.sId ?? ""));
    if(response.isSuccess){
      showSnackBarMassage(context, "Status Updated!!");
    } else {
      showSnackBarMassage(context, response.errorMassage);
    }

  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text("Delete Task"),
        content: const Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
                onPressed: () {
                  // Navigator.pop(context);
                  Get.back();
                },
                child: const Text("No"),
              ),
          TextButton(
            onPressed: () {
              _deleteTask(context);
              // Navigator.pop(context);
              Get.back();
            },
            child: const Text("Yes",style: TextStyle(color: Colors.red),),
          ),
            ],
      );
    });
  }

  Future<void> _deleteTask(BuildContext context) async{
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.deleteTaskUrl(taskModel.sId ?? ""));
    if (response.isSuccess){
      showSnackBarMassage(context, "Your task Deleted!!");
    } else {
      showSnackBarMassage(context, response.errorMassage);
    }
  }

  Color _getStatusColor(String? status) {
    if(status == "New"){
      return Colors.blue;
    } else if (status == "Progress" ) {
      return Colors.orange;
    } else if (status == "Completed" ) {
      return Colors.green;
    } else if (status == "Cancelled" ) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

}
