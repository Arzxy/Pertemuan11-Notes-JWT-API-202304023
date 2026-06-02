<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class ApiKeyMiddleware
{
    public function handle(Request $request, Closure $next): Response
    {
        $apiKey = $request->header(
            'set-apikey'
        );

        // API KEY YANG VALID
        $validApiKey = 'AKMAL-API-KEY';

        if (!$apiKey || $apiKey !== $validApiKey) {

            return response()->json([
                'message' => 'API Key tidak valid'
            ], 401);
        }

        return $next($request);
    }
}