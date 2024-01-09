import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final httpClient =
    Dio(BaseOptions(baseUrl: 'http://expertdevelopers.ir/api/v1/'));

const defaultScrollPhysics = BouncingScrollPhysics();

const String vahed = 'تومان';
