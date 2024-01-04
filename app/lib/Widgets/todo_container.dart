import 'package:app/Constants/colors.dart';
import 'package:flutter/material.dart';

class TodoContainer extends StatelessWidget {
  final int id;
  final String title;
  final String desc;
  final bool isDone;
  final String date;
  final Function onPress;


  void _showModel(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            color: whitegreybg,
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    color: green,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Add Todo',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      initialValue: title,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      // onSubmitted: (value) {
                      //   setState(() {
                      //     title = value;
                      //   });
                      // },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      initialValue: desc,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                      // onSubmitted: (value) {
                      //   setState(() {
                      //     desc = value;
                      //   });
                      // },
                    ),
                  ),
                  // Swithch for isDone
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Is Done?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Switch(
                          value: isDone,
                          onChanged: (value) {
                            // setState(() {
                            //   isDone = value;
                            // });
                          },
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green,
                      padding: const EdgeInsets.all(15.0),
                    ),
                    onPressed: null,
                    child: const Text(
                      "Update Todo",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  const TodoContainer({
      Key? key,
      required this.id,
      required this.title,
      required this.desc,
      required this.isDone,
      required this.date,
      required this.onPress
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
      child: InkWell(
        onTap: () => _showModel(
          context,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            // if isDone is true then color is green else color is red
            color: isDone
                ? green
                : red,  
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isDone
                  ? green
                  : red,
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
            // date and time
            
            trailing: IconButton(
              onPressed: () => onPress(),
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
