// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:anycallmobile_trainingcenter/data/provider/checker_api.dart';
// import 'package:anycallmobile_trainingcenter/data/provider/client_api.dart';
// import 'package:anycallmobile_trainingcenter/feature/conversation/model/conversation_model.dart';
// import 'package:anycallmobile_trainingcenter/feature/conversation/repo/conversation_repo.dart';
// import 'package:universal_html/html.dart' as html;
// import 'package:get/get.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import '../model/channel_model.dart';


// class ConversationController extends GetxController implements GetxService{
//   final ConversationRepo conversationRepo;
//   ConversationController({required this.conversationRepo});

//   List <XFile>? _pickedImageFiles =[];
//   List <XFile>? get pickedImageFile => _pickedImageFiles;


//   FilePickerResult? _otherFile;
//   FilePickerResult? get otherFile => _otherFile;


//   File? _file;
//   PlatformFile? objFile;
//   File? get file=> _file;

//   List<MultipartBody> _selectedImageList = [];
//   List<MultipartBody> get selectedImageList => _selectedImageList;
//   bool _paginationLoading = true;
//   bool get paginationLoading => _paginationLoading;

//   int? _messagePageSize;
//   int? _messageOffset = 1;
//   int? get messagePageSize => _messagePageSize;
//   int? get messageOffset => _messageOffset;

//   int? _pageSize;
//   int? _offset = 1;
//   bool? _isLoading = false;
//   bool? get isLoading => _isLoading;
//   final String _name='';
//   String get name => _name;
//   final String _image='';
//   String get image => _image;

//   List<ChannelData>? _channelList;
//   List<ChannelData>? get channelList => _channelList;
//   List<ConversationData>? _conversationList;
//   List<ConversationData>? get conversationList => _conversationList;
//   final ScrollController scrollController = ScrollController();
//   final ScrollController messageScrollController = ScrollController();
//   int? get pageSize => _pageSize;
//   int? get offset => _offset;

//   var conversationController = TextEditingController();
//   final GlobalKey<FormState> conversationKey  = GlobalKey<FormState>();
//   String _channelId = '';
//   String get channelId => _channelId;
//   String _userTypeImage ='';
//   String get  userTypeImage => _userTypeImage;

//   void setChannelId(String channelId){
//     _channelId = channelId;
//   }


//   @override
//   void onInit(){
//     super.onInit();
//     conversationController.text = '';
//     scrollController.addListener(() {
//       if (scrollController.position.pixels == scrollController.position.maxScrollExtent){
//         if (_offset! < _pageSize!) {
//           getChannelList(_offset!+1, isFromPagination: true);
//         }
//       }
//     });

//     messageScrollController.addListener(() {
//       if (messageScrollController.position.pixels == messageScrollController.position.maxScrollExtent) {
//         if (_messageOffset! < _messagePageSize!) {
//           getConversation(_channelId,_messageOffset!+1, isFromPagination: true);
//         }
//       }
//     });
//   }

//   void pickMultipleImage(bool isRemove,{int? index}) async {
//     if(isRemove) {
//       if(index != null){
//         _pickedImageFiles!.removeAt(index);
//         _selectedImageList.removeAt(index);
//       }
//     }else {
//       _pickedImageFiles = await ImagePicker().pickMultiImage(imageQuality: 40);
//       if (_pickedImageFiles != null) {

//         for(int i =0; i< _pickedImageFiles!.length; i++){
//           _selectedImageList.add(MultipartBody('files[$i]',_pickedImageFiles![i]));
//         }
//       }
//     }
//     update();
//   }


//   void pickOtherFile(bool isRemove) async {
//     if(isRemove){
//       _otherFile=null;
//       _file = null;
//     }else{
//       _otherFile = (await FilePicker.platform.pickFiles(withReadStream: true))!;
//       if (_otherFile != null) {
//         objFile = _otherFile!.files.single;
//       }
//     }
//     update();
//   }

//   void removeFile() async {
//     _otherFile=null;
//     update();
//   }


//   Future<void> getChannelListBasedOnReferenceId(int offset,String referenceId) async{
//     _channelList = [];

//     update();
//     Response response = await conversationRepo.getChannelListBasedOnReferenceId(offset,referenceId);
//     if(response.statusCode == 200){
//       response.body['content']['data'].forEach((channel){
//         _channelList!.add(ChannelData.fromJson(channel));
//       });
//     }else{
//       ApiChecker.checkApi(response);
//     }
//     update();
//   }

//   Future<void> getChannelList(int offset, {bool isFromPagination = false}) async{
//     _offset = offset;
//     Response response = await conversationRepo.getChannelList(offset);
//     if(response.statusCode == 200){
//       if(!isFromPagination){
//         _channelList =[];
//         _paginationLoading = true;
//       }
//       response.body['content']['data'].forEach((channel){
//         _channelList!.add(ChannelData.fromJson(channel));
//         _pageSize =response.body['content']['last_page'];
//       });
//     }else{
//       ApiChecker.checkApi(response);
//     }
//     _paginationLoading = false;
//     _isLoading = false;
//     update();
//   }

//   Future<void> createChannel(String userID,String referenceID,{String name='Chatting Page', String image=''}) async{
//     _isLoading = true;
//     update();
//     Response response = await conversationRepo.createChannel(userID,referenceID);
//     if(response.statusCode == 200){
//       _isLoading = false;
//       Get.back();
//       //Get.toNamed(RouteHelper.getChatScreenRoute(response.body['content']['id'],name,image,response.body['content']['updated_at'],referenceID));
//     }else{
//       ApiChecker.checkApi(response);
//     }
//     update();
//   }

//    cleanOldData(){
//     _pickedImageFiles = [];
//     _selectedImageList = [];
//     _otherFile = null;
//     _file = null;
//   }


//   Future<void> getConversation(String channelID, int offset,{ bool isFromPagination = false, bool isInitial = false}) async{

//     if(!isFromPagination && isInitial){
//       _conversationList = null;
//     }
//     _messageOffset = offset;
//     Response response = await conversationRepo.getConversation(channelID, offset);
//     if(response.statusCode == 200){
//       if(!isFromPagination){
//         _conversationList = [];
//       }
//       response.body['content']['data'].forEach((conversation){_conversationList!.add(ConversationData.fromJson(conversation));
//       _messagePageSize =  response.body['content']['last_page'];
//       });
//     }else{
//       ApiChecker.checkApi(response);
//     }
//     update();
//   }


//   void downloadFile(String url, String dir) async {
//     await FlutterDownloader.enqueue(
//       url: url,
//       savedDir: dir,
//       showNotification: true,
//       saveInPublicStorage: true,
//       openFileFromNotification: true,
//     );
//   }
//   void downloadFileForWeb(String url) {
//     html.AnchorElement anchorElement =  html.AnchorElement(href: url);
//     anchorElement.download = url;
//     anchorElement.click();
//   }
//   void setUserImageType(String userType){
//     _userTypeImage = userType;
//     update();
//   }
// }