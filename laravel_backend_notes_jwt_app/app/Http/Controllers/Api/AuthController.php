<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    // REGISTER
    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        return response()->json([
            'message' => 'Register telah berhasil',
            'user' => $user,
        ]);
    }

    // LOGIN
    public function login(Request $request)
    {
        $credentials =
            $request->only('email', 'password');

        if (!$token = auth()->attempt($credentials)) {
            return response()->json([
                'message' => 'Email atau password kamu salah',
            ], 401);
        }

        return response()->json([
            'token' => $token,
        ]);
    }

    // PROFILE
    public function me()
    {
        return response()->json(
            auth()->user()
        );
    }

    // LOGOUT
    public function logout()
    {
        auth()->logout();

        return response()->json([
            'message' => 'Logout telah berhasil',
        ]);
    }
}