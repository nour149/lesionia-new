import 'package:flutter/material.dart';
import 'package:new_lesionia_project/services/image_service.dart';
// screen to show image
import 'image_detail_screen.dart';
class Image_History extends StatefulWidget {
  const Image_History({Key? key}) : super(key: key);

  @override
  State<Image_History> createState() => _Image_HistoryState();
}

class _Image_HistoryState extends State<Image_History> {
  List<dynamic> dataList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMetadata();
  }

  Future<void> loadMetadata() async {
    final data = await Image_Service.getallimagesdata(context); // GET route to load metadata only
    setState(() {
      dataList = data ?? ['no content'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/patientsDetail');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Image History")),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : dataList.contains('no content')
            ? _noContent()
            : ListView.separated(
          itemCount: dataList.length,
          separatorBuilder: (_, __) => Divider(color: Colors.grey),
          itemBuilder: (context, index) {
            final item = dataList[index];
            return ListTile(
              leading: Icon(Icons.image),
              title: Text("Sample ID: ${item['idsample']}"),
              subtitle: Text("Date: ${item['date_MED']}"),

              onTap: () async {
                // Fetch image bytes from backend using the image path
                final imageBytes = await Image_Service.GetAllImages(
                  context,
                  item['path'], // backend route uses this path to get the image
                );

                if (imageBytes != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ImageDetailScreen(
                        imageBytes: imageBytes,
                        datemed: item['date_MED'],
                        idsample: item['idsample'], accuarcy: item['accuarcy'], classid: item['classid'],
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to load image")),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _noContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('There is no saved image yet!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Icon(Icons.warning, size: 100, color: Colors.grey),
        ],
      ),
    );
  }
}
