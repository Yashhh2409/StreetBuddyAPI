<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\V1\CustomerAddressController;

Route::get('/customer-addresses', [CustomerAddressController::class, 'index']);
