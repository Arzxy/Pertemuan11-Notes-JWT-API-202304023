<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\NoteController;

// JWT PROTECTED
Route::middleware(['api.key'])->group(function () {

    Route::post('/register', [AuthController::class, 'register']);
    
    // AUTH
    Route::post('/login', [AuthController::class, 'login']);

});

// JWT PROTECTED
Route::middleware(['api.key', 'auth:api'])->group(function () {

    // PROFILE
    Route::get('/me', [AuthController::class, 'me']);

    // LOGOUT
    Route::post('/logout',[AuthController::class, 'logout']);

    // NOTES
    Route::get('/notes', [NoteController::class, 'index']);

    Route::post('/notes', [NoteController::class, 'store']);

    Route::put('/notes/{id}', [NoteController::class, 'update']);

    Route::delete('/notes/{id}',[NoteController::class, 'destroy']);
    
});