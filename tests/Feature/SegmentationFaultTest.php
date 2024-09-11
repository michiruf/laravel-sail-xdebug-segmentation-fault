<?php

use Illuminate\Support\Facades\Http;

it('will sometimes produce a segmentation fault #1', function () {
    Http::fake(function ($request) {
        throw new RuntimeException();
    });
    Http::get('https://local');
})->throws(RuntimeException::class);

it('will sometimes produce a segmentation fault #2', function () {
    Http::fake([
        'https://local' => Http::response(status: 800),
    ]);
    Http::get('https://local');
})->throws(InvalidArgumentException::class);
