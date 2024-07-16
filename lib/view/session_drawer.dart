import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/chat_controller.dart';
import 'drawer_header_item.dart';
import 'list_tile_item.dart';

class SessionDrawer extends StatelessWidget {
  final ChatController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeaderItem(controller: controller),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.sessions.length,
                  itemBuilder: (context, index) {
                    String sessionId = controller.sessions[index];
                    return ListTileItem(sessionId: sessionId, controller: controller);
                  },
                )),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Created By Jerald Joyson',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

