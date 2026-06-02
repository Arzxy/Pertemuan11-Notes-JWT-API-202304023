<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Note;

class NoteController extends Controller
{
    // GET NOTES
    public function index()
    {
        $notes = Note::where('user_id', auth()->id())->get();

        return response()->json(
            $notes
        );
    }

    // CREATE NOTE
    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required',
            'content' => 'required',
        ]);

        $note = Note::create([
            'user_id' => auth()->id(),
            'title' => $request->title,
            'content' => $request->content,
        ]);

        return response()->json([
            'message' => 'Catatan telah berhasil dibuat',
            'data' => $note,
        ]);
    }

    // UPDATE NOTE
    public function update(Request $request, $id)
    {
        $note = Note::where('user_id', auth()->id())->findOrFail($id);

        $note->update([
            'title' => $request->title,
            'content' => $request->content,
        ]);

        return response()->json([
            'message' => 'Catatan telah berhasil diupdate',
            'data' => $note,
        ]);
    }

    // DELETE NOTE
    public function destroy($id)
    {
        $note = Note::where('user_id', auth()->id())->findOrFail($id);

        $note->delete();

        return response()->json([
            'message' => 'Catatan telah berhasil dihapus',
        ]);
    }
}