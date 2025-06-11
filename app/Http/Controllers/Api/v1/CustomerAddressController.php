<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\CustomerAddress;
use Illuminate\Http\JsonResponse;

class CustomerAddressController extends Controller
{
    public function index(): JsonResponse
    {
        $addresses = CustomerAddress::select('id', 'latitude', 'longitude', 'user_id')->get();

        return response()->json([
            'success' => true,
            'data' => $addresses
        ]);
    }
}
