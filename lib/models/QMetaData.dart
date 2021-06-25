class QMetaData {
  String companyName;
  String companyLogoURL;
  String backGroundImageURL;
  String locationName;
  String locationID;
  String storeLocationCommonNumber;
  String address;
  String phoneNumber;
  String qID;
  String qName;
  String qManager;
  String qManagerUserID;
  String qMode;
  String maxPeopleInStore;
  String numberOfPeoplePerHour;
  String currentProcessingTime;
  String maxPeopleInQueue;
  String numberOfDoors;
  String shortQueueLength;
  String queueLength;
  String queueWaitTime;
  String walkInToReservedRatioFraction;
  String promoURL;
  String promoImageUrL;
  String storeInfoURL;
  String promoImage;
  String minsEarlyToLeave;
  String parkingLotDistance;
  String maxReservationDistance;
  String storeEntranceDistance;
  String maxLatenessBeforeCancellation;
  String trainingCode;
  String latitude;
  String longitude;
  List<String> openHours;
  List<String> closeHours;
  List<Null> calendar;
  String status;
  String storeHeadCount;
  String minutesBeforeOpening;
  String minutesBeforeClosing;
  String managedExit;
  String managedExitLastUpdate;
  String managedEntrance;
  String managedEntranceLastUpdate;
  String managedTimeOutMinutes;
  String nowServingTicketType;
  String nowServingTicketImage;
  String nowServingTicketNumber;
  String nowServingTicketUpdateTimeStamp;
  String nowServingDeviceID;
  String enableHeadCountDisplay;
  String specialQueueFeature;
  String earliestAvailableReservation;
  String firstAvailableSlot;
  String lastAvailableSlot;
  String offerTimeSlotsEveryXMinutes;
  String numberOfReservationsPerTimeSlot;
  List<AppointmentTypes> appointmentTypes;

  QMetaData(
      {this.companyName,
      this.companyLogoURL,
      this.backGroundImageURL,
      this.locationName,
      this.locationID,
      this.storeLocationCommonNumber,
      this.address,
      this.phoneNumber,
      this.qID,
      this.qName,
      this.qManager,
      this.qManagerUserID,
      this.qMode,
      this.maxPeopleInStore,
      this.numberOfPeoplePerHour,
      this.currentProcessingTime,
      this.maxPeopleInQueue,
      this.numberOfDoors,
      this.shortQueueLength,
      this.queueLength,
      this.queueWaitTime,
      this.walkInToReservedRatioFraction,
      this.promoURL,
      this.promoImageUrL,
      this.storeInfoURL,
      this.promoImage,
      this.minsEarlyToLeave,
      this.parkingLotDistance,
      this.maxReservationDistance,
      this.storeEntranceDistance,
      this.maxLatenessBeforeCancellation,
      this.trainingCode,
      this.latitude,
      this.longitude,
      this.openHours,
      this.closeHours,
      this.calendar,
      this.status,
      this.storeHeadCount,
      this.minutesBeforeOpening,
      this.minutesBeforeClosing,
      this.managedExit,
      this.managedExitLastUpdate,
      this.managedEntrance,
      this.managedEntranceLastUpdate,
      this.managedTimeOutMinutes,
      this.nowServingTicketType,
      this.nowServingTicketImage,
      this.nowServingTicketNumber,
      this.nowServingTicketUpdateTimeStamp,
      this.nowServingDeviceID,
      this.enableHeadCountDisplay,
      this.specialQueueFeature,
      this.earliestAvailableReservation,
      this.firstAvailableSlot,
      this.lastAvailableSlot,
      this.offerTimeSlotsEveryXMinutes,
      this.numberOfReservationsPerTimeSlot,
      this.appointmentTypes});

  QMetaData.fromJson(Map<String, dynamic> json) {
    companyName = json['CompanyName'];
    companyLogoURL = json['CompanyLogoURL'];
    backGroundImageURL = json['BackGroundImageURL'];
    locationName = json['LocationName'];
    locationID = json['LocationID'];
    storeLocationCommonNumber = json['StoreLocationCommonNumber'];
    address = json['Address'];
    phoneNumber = json['PhoneNumber'];
    qID = json['QID'];
    qName = json['QName'];
    qManager = json['QManager'];
    qManagerUserID = json['QManagerUserID'];
    qMode = json['QMode'];
    maxPeopleInStore = json['MaxPeopleInStore'];
    numberOfPeoplePerHour = json['NumberOfPeoplePerHour'];
    currentProcessingTime = json['CurrentProcessingTime'];
    maxPeopleInQueue = json['MaxPeopleInQueue'];
    numberOfDoors = json['NumberOfDoors'];
    shortQueueLength = json['ShortQueueLength'];
    queueLength = json['QueueLength'];
    queueWaitTime = json['QueueWaitTime'];
    walkInToReservedRatioFraction = json['WalkInToReservedRatioFraction'];
    promoURL = json['PromoURL'];
    promoImageUrL = json['PromoImageUrL'];
    storeInfoURL = json['StoreInfoURL'];
    promoImage = json['PromoImage'];
    minsEarlyToLeave = json['MinsEarlyToLeave'];
    parkingLotDistance = json['ParkingLotDistance'];
    maxReservationDistance = json['MaxReservationDistance'];
    storeEntranceDistance = json['StoreEntranceDistance'];
    maxLatenessBeforeCancellation = json['MaxLatenessBeforeCancellation'];
    trainingCode = json['TrainingCode'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    openHours = json['OpenHours'].cast<String>();
    closeHours = json['CloseHours'].cast<String>();
    status = json['Status'];
    storeHeadCount = json['StoreHeadCount'];
    minutesBeforeOpening = json['MinutesBeforeOpening'];
    minutesBeforeClosing = json['MinutesBeforeClosing'];
    managedExit = json['ManagedExit'];
    managedExitLastUpdate = json['ManagedExitLastUpdate'];
    managedEntrance = json['ManagedEntrance'];
    managedEntranceLastUpdate = json['ManagedEntranceLastUpdate'];
    managedTimeOutMinutes = json['ManagedTimeOutMinutes'];
    nowServingTicketType = json['NowServingTicketType'];
    nowServingTicketImage = json['NowServingTicketImage'];
    nowServingTicketNumber = json['NowServingTicketNumber'];
    nowServingTicketUpdateTimeStamp = json['NowServingTicketUpdateTimeStamp'];
    nowServingDeviceID = json['NowServingDeviceID'];
    enableHeadCountDisplay = json['EnableHeadCountDisplay'];
    specialQueueFeature = json['SpecialQueueFeature'];
    earliestAvailableReservation = json['EarliestAvailableReservation'];
    firstAvailableSlot = json['FirstAvailableSlot'];
    lastAvailableSlot = json['LastAvailableSlot'];
    offerTimeSlotsEveryXMinutes = json['OfferTimeSlotsEveryXMinutes'];
    numberOfReservationsPerTimeSlot = json['NumberOfReservationsPerTimeSlot'];
    if (json['AppointmentTypes'] != null) {
      appointmentTypes = new List<AppointmentTypes>();
      json['AppointmentTypes'].forEach((v) {
        appointmentTypes.add(new AppointmentTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyName'] = this.companyName;
    data['CompanyLogoURL'] = this.companyLogoURL;
    data['BackGroundImageURL'] = this.backGroundImageURL;
    data['LocationName'] = this.locationName;
    data['LocationID'] = this.locationID;
    data['StoreLocationCommonNumber'] = this.storeLocationCommonNumber;
    data['Address'] = this.address;
    data['PhoneNumber'] = this.phoneNumber;
    data['QID'] = this.qID;
    data['QName'] = this.qName;
    data['QManager'] = this.qManager;
    data['QManagerUserID'] = this.qManagerUserID;
    data['QMode'] = this.qMode;
    data['MaxPeopleInStore'] = this.maxPeopleInStore;
    data['NumberOfPeoplePerHour'] = this.numberOfPeoplePerHour;
    data['CurrentProcessingTime'] = this.currentProcessingTime;
    data['MaxPeopleInQueue'] = this.maxPeopleInQueue;
    data['NumberOfDoors'] = this.numberOfDoors;
    data['ShortQueueLength'] = this.shortQueueLength;
    data['QueueLength'] = this.queueLength;
    data['QueueWaitTime'] = this.queueWaitTime;
    data['WalkInToReservedRatioFraction'] = this.walkInToReservedRatioFraction;
    data['PromoURL'] = this.promoURL;
    data['PromoImageUrL'] = this.promoImageUrL;
    data['StoreInfoURL'] = this.storeInfoURL;
    data['PromoImage'] = this.promoImage;
    data['MinsEarlyToLeave'] = this.minsEarlyToLeave;
    data['ParkingLotDistance'] = this.parkingLotDistance;
    data['MaxReservationDistance'] = this.maxReservationDistance;
    data['StoreEntranceDistance'] = this.storeEntranceDistance;
    data['MaxLatenessBeforeCancellation'] = this.maxLatenessBeforeCancellation;
    data['TrainingCode'] = this.trainingCode;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['OpenHours'] = this.openHours;
    data['CloseHours'] = this.closeHours;
    data['Status'] = this.status;
    data['StoreHeadCount'] = this.storeHeadCount;
    data['MinutesBeforeOpening'] = this.minutesBeforeOpening;
    data['MinutesBeforeClosing'] = this.minutesBeforeClosing;
    data['ManagedExit'] = this.managedExit;
    data['ManagedExitLastUpdate'] = this.managedExitLastUpdate;
    data['ManagedEntrance'] = this.managedEntrance;
    data['ManagedEntranceLastUpdate'] = this.managedEntranceLastUpdate;
    data['ManagedTimeOutMinutes'] = this.managedTimeOutMinutes;
    data['NowServingTicketType'] = this.nowServingTicketType;
    data['NowServingTicketImage'] = this.nowServingTicketImage;
    data['NowServingTicketNumber'] = this.nowServingTicketNumber;
    data['NowServingTicketUpdateTimeStamp'] =
        this.nowServingTicketUpdateTimeStamp;
    data['NowServingDeviceID'] = this.nowServingDeviceID;
    data['EnableHeadCountDisplay'] = this.enableHeadCountDisplay;
    data['SpecialQueueFeature'] = this.specialQueueFeature;
    data['EarliestAvailableReservation'] = this.earliestAvailableReservation;
    data['FirstAvailableSlot'] = this.firstAvailableSlot;
    data['LastAvailableSlot'] = this.lastAvailableSlot;
    data['OfferTimeSlotsEveryXMinutes'] = this.offerTimeSlotsEveryXMinutes;
    data['NumberOfReservationsPerTimeSlot'] =
        this.numberOfReservationsPerTimeSlot;
    if (this.appointmentTypes != null) {
      data['AppointmentTypes'] =
          this.appointmentTypes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppointmentTypes {
  List<String> questionnaireIDArray;
  List<Null> promotionIDArray;
  String sId;
  bool requireHeadCount;
  bool requireDetailProfile;
  String appointmentTypeID;
  String description;
  bool followOnAppointment;
  int followOnPeriodDays;

  AppointmentTypes(
      {this.questionnaireIDArray,
      this.promotionIDArray,
      this.sId,
      this.requireHeadCount,
      this.requireDetailProfile,
      this.appointmentTypeID,
      this.description,
      this.followOnAppointment,
      this.followOnPeriodDays});

  AppointmentTypes.fromJson(Map<String, dynamic> json) {
    questionnaireIDArray = json['QuestionnaireIDArray'].cast<String>();
   
    sId = json['_id'];
    requireHeadCount = json['RequireHeadCount'];
    requireDetailProfile = json['RequireDetailProfile'];
    appointmentTypeID = json['AppointmentTypeID'];
    description = json['Description'];
    followOnAppointment = json['FollowOnAppointment'];
    followOnPeriodDays = json['FollowOnPeriodDays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['QuestionnaireIDArray'] = this.questionnaireIDArray;
   
    data['_id'] = this.sId;
    data['RequireHeadCount'] = this.requireHeadCount;
    data['RequireDetailProfile'] = this.requireDetailProfile;
    data['AppointmentTypeID'] = this.appointmentTypeID;
    data['Description'] = this.description;
    data['FollowOnAppointment'] = this.followOnAppointment;
    data['FollowOnPeriodDays'] = this.followOnPeriodDays;
    return data;
  }
}