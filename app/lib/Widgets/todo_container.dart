import 'package:flutter/material.dart';

class TodoContainer extends StatelessWidget {
  final int id;
  final String title;
  final String desc;
  final bool isDone;
  final String date;

  const TodoContainer(
      {Key? key,
      required this.id,
      required this.title,
      required this.desc,
      required this.isDone,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Container(
        width: double.infinity ,
        decoration: BoxDecoration(
          color: Colors.blueGrey[900],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blueGrey[900],
            child: isDone
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
          ), 
          title: Text(
            title.length > 15 ? '${title.substring(0, 15)}...' : title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            desc.length > 35 ? '${desc.substring(0, 35)}...' : desc,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
