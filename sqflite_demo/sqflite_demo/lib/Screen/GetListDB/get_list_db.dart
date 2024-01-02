import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_demo/DbHelper/DBHelper.dart';
import 'package:sqflite_demo/Screen/AddData/add_Data_Controller.dart';
import 'get_list_controller.dart';

class GetListDB extends StatelessWidget {
  GetListDB({Key? key}) : super(key: key);

  GetListController getDataController = Get.put(GetListController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          getDataController.addDataScreen();
          const Center(
            child: CircularProgressIndicator(),
          );
        },
        child: const Text("ADD"),
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('DashBoard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Obx(
                () =>
                getDataController.getValue.value.isEmpty
                ? const Center(
                    child: Text(
                      'No Data Available',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: getDataController.getValue.value.length,
                    itemBuilder: (context, index) {
                      var data = getDataController.getValue.value[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [

                            Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(iconColor: Colors.black,
                                title: Row(
                                  children: [

                                    const Icon(Icons.person,color: Colors.black,),

                                    const SizedBox(width: 25),

                                    Text(
                                        '${data.name.toString()}',
                                      style: const TextStyle(
                                      fontSize: 15,fontWeight: FontWeight.bold,letterSpacing: 0.2
                                    ),),
                                  ],
                                ),
                                children: [
                                  ListTile(
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),

                                        Text('Email : ${data.email.toString()}'),

                                        const SizedBox(height: 10),

                                        Text('Address : ${data.address.toString()}'),

                                        const SizedBox(height: 10),

                                        Text('Mobile : ${data.mobile.toString()}'),

                                        // const SizedBox(height: 10),
                                        //
                                        // Text('age : ${data.age.toString()}'),
                                        //
                                        // const SizedBox(height: 10),
                                        //
                                        // Text('gender : ${data.gender.toString()}'),
                                        //
                                        // const SizedBox(height: 10),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            const SizedBox(width: 10),

                                            InkWell(
                                              onTap: () {
                                                getDataController.navigateToAddData(
                                                  id: getDataController.getValue.value[index].id ?? 0,
                                                  name: getDataController.getValue.value[index].name ?? "",
                                                  email: getDataController.getValue.value[index].email ?? "",
                                                  phone: getDataController.getValue.value[index].mobile ?? "",
                                                  address: getDataController.getValue.value[index].address ?? "",
                                                  // age: getDataController.getValue.value[index].age ?? "",
                                                  // gender: getDataController.getValue.value[index].gender ?? "",
                                                );
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                              ),
                                            ),

                                            const SizedBox(
                                              width: 10,
                                            ),

                                            InkWell(
                                              onTap: () {
                                                getDataController.deleteData(
                                                    getDataController.getValue
                                                        .value[index].id ??
                                                        0);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                    content:
                                                    Text("Data Deleted")));
                                              },
                                              child: const Icon(Icons.delete),
                                            ),

                                            const SizedBox(
                                              width: 10,
                                            ),

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      await DBHelper().getDbPath();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      height: context.height / 18,
                      width: context.height * 0.15,
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                          child: Text(
                            'path',
                            style:  TextStyle(fontSize: 15, color: Colors.white),
                          )),
                    ),
                  ),

                  InkWell(
                    onTap: () async {
                      await DBHelper().backUpDB();
                       ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Database Backup Done ')),
                      );
                    },
                    child: Container(margin: EdgeInsets.symmetric(vertical: 15),
                      height: context.height / 18,
                      width: context.height * 0.15,

                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                          child: Text(
                            'Backup',
                            style:  TextStyle(fontSize: 15, color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  InkWell(
                    onTap: () async {
                      await DBHelper().restoreDB();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Database Restored open App Again')),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      height: context.height / 18,
                      width: context.height * 0.15,
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                          child: Text(
                            'Restore',
                            style:  TextStyle(fontSize: 15, color: Colors.white),
                          )),
                    ),
                  ),

                  InkWell(
                    onTap: () async {
                      await DBHelper().deleteDB();
                      Get.back();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Database Deleted Please Reopen App')),
                      );
                    },
                    child: Container(margin: EdgeInsets.symmetric(vertical: 15),
                      height: context.height / 18,
                      width: context.height * 0.15,

                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                          child: Text(
                            'Delete',
                            style:  TextStyle(fontSize: 15, color: Colors.white),
                          )),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
