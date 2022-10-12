import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_template/data/network/api_services.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvm_template/data/response/exceptions.dart';
import 'package:get/get.dart';

class NetworkApiService extends ApiService {
  @override
  Future<Either<AppException,dynamic>> getGetApiResponse(String url) async {
    try{
      final http.Response response = await http.get(Uri.parse(url));
      if(kDebugMode){
        log('GET API HIT ==> $url');
        Get.showSnackbar(
            GetSnackBar(
              title: 'GET API HIT',
              message: url,
              backgroundColor: Colors.amber,
              duration: const Duration(seconds: 5),
            )
        );
      }
      return returnResponse(response);
    } catch(e){
      onRequestFailure(url);
      return Left(FetchDataException("Failed to send request"));
    }
  }

  @override
  Future<Either<AppException,dynamic>> getPatchApiResponse(String url, data) async {
    try{
      final http.Response response = await http.patch(Uri.parse(url), body: data);
      if(kDebugMode){
        log('PATCH API HIT ==> $url');
        Get.showSnackbar(
            GetSnackBar(
              title: 'PATCH API HIT',
              message: url,
              backgroundColor: Colors.amber,
              duration: const Duration(seconds: 5),
            )
        );
      }
      return returnResponse(response);
    } catch(e){
      onRequestFailure(url);
      return Left(FetchDataException("Failed to send request"));
    }
  }

  @override
  Future<Either<AppException,dynamic>> getPostApiResponse(String url, data) async {
    try{
      final http.Response response = await http.post(Uri.parse(url), body: data);
      if(kDebugMode){
        log('POST API HIT ==> $url');
        Get.showSnackbar(
            GetSnackBar(
              title: 'POST API HIT',
              message: url,
              backgroundColor: Colors.amber,
              duration: const Duration(seconds: 5),
            )
        );
      }
      return returnResponse(response);
    } catch(e) {
      onRequestFailure(url);
      return Left(FetchDataException("Failed to send request"));
    }
  }

  Either<AppException,dynamic> returnResponse(http.Response response) {
    try{
      final data = jsonDecode(response.body);
      if(kDebugMode){
        log('RESPONSE DATA ==> $data');
        Get.showSnackbar(
            GetSnackBar(
              title: 'API RESPONSE',
              message:  '$data',
              backgroundColor: Colors.green,
            )
        );
      }
      return Right(data);
    } on SocketException{
      return Left(FetchDataException("Failed to send request"));
    } catch(e) {
      switch(response.statusCode){
        case 400: return Left(BadRequestException('Bad Request Error'));
        case 404: return Left(UnauthorisedException('User unauthorised'));
      }
      return Left(FetchDataException("Failed to send request"));
    }
  }

  void onRequestFailure(String? url){
    if(kDebugMode){
      Get.showSnackbar(
          GetSnackBar(
            title: 'Request Failed',
            message: url,
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 5),
          )
      );
    }
  }
}