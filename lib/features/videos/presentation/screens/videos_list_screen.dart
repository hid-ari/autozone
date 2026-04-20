// Hideki Rafael Sarmiento Ariyama 20241453
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/videos_service.dart';
import '../../../../core/utils/image_utils.dart';

class VideosListScreen extends StatefulWidget {
  const VideosListScreen({super.key});

  @override
  State<VideosListScreen> createState() => _VideosListScreenState();
}

class _VideosListScreenState extends State<VideosListScreen> {
  List _videos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    final response = await VideosService.getVideos();
    if (response['success'] == true && mounted) {
      setState(() {
        _videos = response['data'] ?? [];
        _isLoading = false;
      });
    } else if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Videos Educativos')),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _videos.length,
            itemBuilder: (context, index) {
              final video = _videos[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.black26,
                child: Column(
                  children: [
                    if (video['thumbnail'] != null)
                      Image.network(ImageUtils.getValidUrl(video['thumbnail']), height: 200, width: double.infinity, fit: BoxFit.cover),
                    ListTile(
                      title: Text(video['titulo'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(video['descripcion'] ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
                      trailing: const Icon(Icons.play_circle_fill, color: Colors.orangeAccent),
                      onTap: () async {
                        if (video['url'] != null) {
                          final uri = Uri.parse(video['url']);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          }
                        }
                      },
                    )
                  ],
                ),
              );
            },
          ),
    );
  }
}

