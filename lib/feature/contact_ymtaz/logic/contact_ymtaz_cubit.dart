import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/feature/contact_ymtaz/data/models/contact_us_types.dart';
import 'package:yamtaz/feature/contact_ymtaz/data/models/my_contact_ymtaz_Response.dart';
import 'package:yamtaz/feature/contact_ymtaz/data/repos/contact_ymtaz.dart';
import 'package:yamtaz/feature/contact_ymtaz/logic/contact_ymtaz_state.dart';

class ContactYmtazCubit extends Cubit<ContactYmtazState> {
  final ContactYmtazRepo _contactYmtazRepo;

  ContactYmtazCubit(this._contactYmtazRepo)
      : super(const ContactYmtazState.initial());

  TextEditingController subject = TextEditingController();
  TextEditingController details = TextEditingController();
  int? contactUsTypeId;
  File? attachments;

  void getData() {
    var userType = CacheHelper.getData(key: 'userType');
    if (userType == 'client') {
      emitGetContactYmtazClient();
    } else if (userType == 'provider') {
      emitGetContactYmtazClient();
    }
  }

  Future<File?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'png',
          'JPEG',
          'JPG',
          'jpg',
          'jpeg',
          'PNG',
          // 'PDF'
        ],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        File pickedFile = File(file.path!);

        // if (file.size! > (5 * 1024 * 1024)) { // 5 MB limit as an example
        //   emit(const SignUpState.errorImage(
        //       error: 'File size exceeds the allowed limit (5 MB).'));
        //   print("object");
        //   return null;
        // }

        String fileExtension = extension(pickedFile.path);
        if (fileExtension == '.png' ||
            fileExtension == '.jpg' ||
            fileExtension == '.jpeg' ||
            fileExtension == '.PNG' ||
            fileExtension == '.JPG' ||
            fileExtension == '.JPEG' ||
            fileExtension == '.pdf') {
          return pickedFile;
        } else {
          return null;
        }

        // You can now use the pickedFile as needed

        // You can return the file if needed
        // return pickedFile;
      } else {}
    } catch (e) {}

    // If there is an error or the user cancels, return null
    return null;
  }

  MyContactYmtazResponse? myContactYmtazResponse;

  Future<void> emitGetContactYmtazClient() async {
    emit(const ContactYmtazState.loading());
    var userType = CacheHelper.getData(key: 'userType');
    var response;
    if (userType == 'client') {
      response = await _contactYmtazRepo.getContactYmtazClient();
    } else if (userType == 'provider') {
      response = await _contactYmtazRepo.getContactYmtazProvider();
    }
    response.when(success: (contactYmtazResponse) {
      myContactYmtazResponse = contactYmtazResponse;
      emit(ContactYmtazState.loaded(contactYmtazResponse));
    }, failure: (fail) {
      emit(ContactYmtazState.error(fail['message']));
    });
  }

  ContactUsTypes? contactUsTypes;

  Future<void> getContactUsTypes() async {
    emit(const ContactYmtazState.loadingContactUsTypes());
    var response;
    response = await _contactYmtazRepo.getContactUsTypes();
    response.when(success: (contactYmtazTypes) {
      contactUsTypes = contactYmtazTypes;
      print("object");
      emit(const ContactYmtazState.loadedContactUsTypes());
    }, failure: (fail) {
      emit(ContactYmtazState.errorContactUsTypes(fail['message']));
    });
  }

  Future<void> emitPostContactYmtazClient(FormData data) async {
    emit(const ContactYmtazState.loadingSendMessage());
    var userType = CacheHelper.getData(key: 'userType');
    var response;

    if (userType == 'client') {
      response = await _contactYmtazRepo.postContactYmtazClient(data);
    } else if (userType == 'provider') {
      response = await _contactYmtazRepo.postContactYmtazProvider(data);
    }

    response.when(success: (contactYmtazResponse) {
      emit(ContactYmtazState.successSendMessage(contactYmtazResponse));
    }, failure: (fail) {
      emit(ContactYmtazState.errorSendMessage(fail['message']));
    });
  }

  Future<void> getAboutUs() async {
    emit(const ContactYmtazState.loading());
    var response;
    response = await _contactYmtazRepo.getAboutUs();
    response.when(success: (contactYmtazResponse) {
      emit(ContactYmtazState.loadedAboutUs(contactYmtazResponse));
    }, failure: (fail) {
      emit(ContactYmtazState.error(fail['message']));
    });
  }

  Future<void> getFaq() async {
    emit(const ContactYmtazState.loading());
    var response;
    response = await _contactYmtazRepo.getFaq();
    response.when(success: (contactYmtazResponse) {
      emit(ContactYmtazState.loadedFaq(contactYmtazResponse));
    }, failure: (fail) {
      emit(ContactYmtazState.error(fail['message']));
    });
  }

  Future<void> getPrivacyPolicy() async {
    emit(const ContactYmtazState.loading());
    var response;
    response = await _contactYmtazRepo.getPrivacyPolicy();
    response.when(success: (contactYmtazResponse) {
      emit(ContactYmtazState.loadedPrivacyPolicy(contactYmtazResponse));
    }, failure: (fail) {
      emit(ContactYmtazState.error(fail['message']));
    });
  }

  Future<void> getSocial() async {
    emit(const ContactYmtazState.loading());
    var response;
    response = await _contactYmtazRepo.getSocial();
    response.when(success: (contactYmtazResponse) {
      emit(ContactYmtazState.loadedSocialMedia(contactYmtazResponse));
    }, failure: (fail) {
      emit(ContactYmtazState.error(fail['message']));
    });
  }
}
