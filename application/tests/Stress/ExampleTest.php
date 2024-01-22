<?php

use function Pest\Stressless\stress;

test('Stress task2', function () {
    // $result = stress('http://172.17.0.1')
    $result = stress('https://www.ozon.ru/')
        ->concurrently(requests: 1)
        ->for(5)->seconds()
        ->get();

    $result->dd();
//    $requests = $result->requests;
//
//    expect($requests->failed->count)
//        ->toBe(0);

//    expect($requests->duration->med)
//        ->toBeLessThan(100.0); // 100ms

});