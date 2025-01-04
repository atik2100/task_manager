import 'package:flutter/material.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        title: const Text("This is Title"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("This is Subtile"),
            const SizedBox(height: 4),
            const Text("12/12/24"),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.green,
                  ),
                  child:  const Text("done",style: TextStyle(color: Colors.white),),
                ),

                Row(
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.green,
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.edit_note_sharp),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.pink,
                      ),
                      onPressed: () {},
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
}
