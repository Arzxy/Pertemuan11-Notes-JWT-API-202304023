<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

use App\Models\Note;

class NoteSeeder extends Seeder
{
    public function run(): void
    {
        Note::create([
            'user_id' => 1,
            'title' => 'Belajar Flutter',
            'content' => 'Mempelajari JWT Authentication',
        ]);
        Note::create([
            'user_id' => 1,
            'title' => 'Laravel API',
            'content' => 'Belajar membuat REST API',
        ]);
    }
}