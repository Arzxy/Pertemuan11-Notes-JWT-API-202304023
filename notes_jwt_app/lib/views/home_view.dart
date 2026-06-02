import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/note_model.dart';
import '../services/api_service.dart';
import 'login_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ApiService _apiService = ApiService();

  // FETCH NOTES
  Future<List<Note>> fetchNotes(String token) async {
    final response = await _apiService.getNotes(token);

    return response.map<Note>((json) => Note.fromJson(json)).toList();
  }

  // ADD / EDIT DIALOG
  void showNoteDialog({String? id, String? oldTitle, String? oldContent}) {
    final titleController = TextEditingController(text: oldTitle);

    final contentController = TextEditingController(text: oldContent);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: Text(id == null ? 'Tambah Catatan' : 'Edit Catatan'),

          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              TextField(
                controller: titleController,

                decoration: const InputDecoration(labelText: 'Title'),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: contentController,

                maxLines: 3,

                decoration: const InputDecoration(labelText: 'Content'),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Batal'),
            ),

            ElevatedButton(
              onPressed: () async {
                // CREATE
                if (id == null) {
                  await _apiService.createNote(
                    authProvider.token!,

                    titleController.text,

                    contentController.text,
                  );
                }
                // UPDATE
                else {
                  await _apiService.updateNote(
                    authProvider.token!,

                    id,

                    titleController.text,

                    contentController.text,
                  );
                }

                if (mounted) {
                  Navigator.pop(context);

                  setState(() {});
                }
              },

              child: Text(id == null ? 'Tambah' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  // DELETE NOTE
  void deleteNote(String id) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    await _apiService.deleteNote(authProvider.token!, id);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Pribadi'),

        actions: [
          // LOGOUT
          IconButton(
            icon: const Icon(Icons.logout),

            onPressed: () async {
              await authProvider.logout();

              if (mounted) {
                Navigator.pushReplacement(
                  context,

                  MaterialPageRoute(builder: (_) => const LoginView()),
                );
              }
            },
          ),
        ],
      ),

      // ADD BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNoteDialog();
        },

        child: const Icon(Icons.add),
      ),

      body: FutureBuilder<List<Note>>(
        future: fetchNotes(authProvider.token!),

        builder: (context, snapshot) {
          // LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ERROR
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // EMPTY
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada catatan'));
          }

          final notes = snapshot.data!;

          // NOTES LIST
          return ListView.builder(
            itemCount: notes.length,

            itemBuilder: (context, index) {
              final note = notes[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

                child: ListTile(
                  title: Text(note.title),

                  subtitle: Text(note.content),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      // EDIT
                      IconButton(
                        icon: const Icon(Icons.edit),

                        onPressed: () {
                          showNoteDialog(
                            id: note.id,

                            oldTitle: note.title,

                            oldContent: note.content,
                          );
                        },
                      ),

                      // DELETE
                      IconButton(
                        icon: const Icon(Icons.delete),

                        onPressed: () {
                          deleteNote(note.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
