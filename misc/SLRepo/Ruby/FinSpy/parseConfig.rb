# Copyright
# =========
# Copyright (C) 2012 Trustwave Holdings, Inc.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>
#
#
# parseConfig.rb by Josh Grunzweig 9-30-2012
#
# =Synopsis
#
# This is a simple Ruby script that is designed to parse the configuration from 
# an Android FinSpy sample. A lookup table is utilized to determine types of 
# data within the configuration file, and all results are put into STDOUT.
#
# The script makes use of two functions from Eric Monti's rbkb library (credited
# below).
#

file = ARGV.shift

unless file
  puts "Usage: ruby parseConfig.rb <config_file>"
  exit
end

hFile = File.open(file, "rb")
fileData = hFile.read

@nHash = {4522400=>"TlvTypeMobileTrackingStartRequest",
 4522656=>"TlvTypeMobileTrackingStopRequest",
 4523376=>"TlvTypeMobileTrackingDataV10",
 4535200=>"TlvTypeMobileTrackingConfig",
 4535440=>"TlvTypeMobileTrackingConfigRaw",
 4538432=>"TlvTypeMobileTrackingTimeInterval",
 4538688=>"TlvTypeMobileTrackingDistance",
 4538928=>"TlvTypeMobileTrackingSendOnAnyChannel",
 6291872=>"TlvTypeMobileLoggingMetaInfo",
 6292096=>"TlvTypeMobileLoggingData",
 4456864=>"TlvTypeMobileBlackberryMessengerMetaInfo",
 4457088=>"TlvTypeMobileBlackberryMessengerData",
 4457328=>"TlvTypeMobileBlackberryMsChatID",
 4457600=>"TlvTypeMobileBlackberryMsConversationPartners",
 4587936=>"TlvTypeMobilePhoneCallLogsMetaInfo",
 4588192=>"TlvTypeMobilePhoneCallLogsData",
 4588400=>"TlvTypeMobilePhoneCallLogsType",
 4588672=>"TlvTypeMobilePhoneCallAdditionalInformation",
 4588912=>"TlvTypeMobilePhoneCallLogsCallerNumber",
 4589168=>"TlvTypeMobilePhoneCallLogsCalleeNumber",
 4589440=>"TlvTypeMobilePhoneCallLogsCallerName",
 4589696=>"TlvTypeMobilePhoneCallLogsCalleeName",
 4591680=>"TlvTypeMobilePhoneCallLogLastEntryEndtime",
 4325792=>"TlvTypeMobileSMSMetaInfo",
 4326016=>"TlvTypeMobileSMSData",
 4326256=>"TlvTypeSMSSenderNumber",
 4326512=>"TlvTypeSMSRecipientNumber",
 4326768=>"TlvTypeSMSDirection",
 4326528=>"TlvTypeSMSInformation",
 4391328=>"TlvTypeMobileAddressBookMetaInfo",
 4391552=>"TlvTypeMobileAddressBookData",
 4407360=>"TlvTypeMobileAddressBookChecksum",
 8978752=>"TlvTypeMobileProxyMasterCommSig",
 8979104=>"TlvTypeMobileProxyMasterComm",
 8979360=>"TlvTypeMobileMasterProxyComm",
 8979616=>"TlvTypeProxyMasterMobileHeartBeatAnswer",
 8979872=>"TlvTypeMobileMasterProxyCommNotification",
 8782176=>"TlvTypeProxyMobileTargetCommSig",
 8782496=>"TlvTypeProxyMobileTargetComm",
 8782752=>"TlvTypeProxyMasterMobileTargetComm",
 1507744=>"TlvTypeAccessedFileMetaInfo",
 1507968=>"TlvTypeAccessedFileAccessTime",
 1508224=>"TlvTypeAccessedFileAccessEvent",
 1508496=>"TlvTypeAccessedFileRecording",
 1508736=>"TlvTypeAccessedApplicationName",
 1508912=>"TlvTypeConfigRecordImagesFromExplorer",
 1519776=>"TlvTypeGetAccessedConfigRequest",
 1520032=>"TlvTypeAccessedConfigReply",
 1520288=>"TlvTypeSetAccessedConfigRequest",
 1520448=>"TlvTypeConfigAccessedEvents",
 2240672=>"TlvTypeGetMouseClicksConfigRequest",
 2240928=>"TlvTypeMouseClicksConfigReply",
 2241184=>"TlvTypeSetMouseClicksConfigRequest",
 2228640=>"TlvTypeMouseClicksMetaInfo",
 2228896=>"TlvTypeMouseClicksFrame",
 2232448=>"TlvTypeMouseClicksEncodingType",
 2232896=>"TlvTypeConfigMouseClicksRectangle",
 2233152=>"TlvTypeConfigMouseClicksSensitivity",
 2233408=>"TlvTypeConfigMouseClicksType",
 2175136=>"TlvTypeGetVoIPConfigRequest",
 2175392=>"TlvTypeVoIPConfigReply",
 2175648=>"TlvTypeSetVoIPConfigRequest",
 2163104=>"TlvTypeVoIPMetaInfo",
 2166912=>"TlvTypeVoIPEncodingType",
 2167168=>"TlvTypeVoIPSessionType",
 2167424=>"TlvTypeVoIPApplicationName",
 2167696=>"TlvTypeVoIPAppScreenshot",
 2167952=>"TlvTypeVoIPAudioRecording",
 2168112=>"TlvTypeConfigVoIPScreenshotEnabled",
 2109600=>"TlvTypeGetForensicsConfigRequest",
 2109856=>"TlvTypeForensicsConfigReply",
 2110112=>"TlvTypeSetForensicsConfigRequest",
 2097568=>"TlvTypeUploadForensicsApplicationRequest",
 2097824=>"TlvTypeUploadForensicsApplicationReply",
 2098080=>"TlvTypeUploadForensicsApplicationChunk",
 2098336=>"TlvTypeUploadForensicsApplicationDoneRequest",
 2098592=>"TlvTypeUploadForensicsApplicationDoneReply",
 2101664=>"TlvTypeRemoveForensicsApplicationRequest",
 2101920=>"TlvTypeRemoveForensicsApplicationReply",
 2105760=>"TlvTypeForensicsAppExecuteRequest",
 2106016=>"TlvTypeForensicsAppExecuteReply",
 2106272=>"TlvTypeForensicsAppExecuteResult",
 2106528=>"TlvTypeForensicsAppExecuteResultChunk",
 2106784=>"TlvTypeForensicsAppExecuteResultDone",
 2107040=>"TlvTypeForensicsCancelAppExecuteRequest",
 2107296=>"TlvTypeForensicsCancelAppExecuteReply",
 2113680=>"TlvTypeConfigForensicsApplicationInfoGeneric",
 2113952=>"TlvTypeConfigForensicsApplicationInfo",
 2117760=>"TlvTypeConfigForensicsApplicationName",
 2117952=>"TlvTypeConfigForensicsApplicationSize",
 2118208=>"TlvTypeConfigForensicsApplicationID",
 2118528=>"TlvTypeConfigForensicsApplicationCmdline",
 2118784=>"TlvTypeConfigForensicsApplicationOutput",
 2118976=>"TlvTypeConfigForensicsApplicationTimeout",
 2119232=>"TlvTypeConfigForensicsApplicationVersion",
 2119552=>"TlvTypeForensicsFriendlyName",
 2119808=>"TlvTypeConfigForensicsApplicationOutputPrepend",
 2120064=>"TlvTypeConfigForensicsApplicationOutputContentType",
 1638816=>"TlvTypeDeletedFileMetaInfo",
 1639296=>"TlvTypeDeletedFileDeletionTime",
 1639552=>"TlvTypeDeletedFileRecycleBin",
 1639808=>"TlvTypeDeletedMethod",
 1640064=>"TlvTypeDeletedApplicationName",
 1640336=>"TlvTypeDeletedFileRecording",
 1650848=>"TlvTypeGetDeletedConfigRequest",
 1651104=>"TlvTypeDeletedConfigReply",
 1651360=>"TlvTypeSetDeletedConfigRequest",
 1573280=>"TlvTypePrintFileMetaInfo",
 1573520=>"TlvTypePrintFrame",
 1581184=>"TlvTypePrintApplicationName",
 1581440=>"TlvTypePrintFilename",
 1581696=>"TlvTypePrintEncodingType",
 1585312=>"TlvTypeGetPrintConfigRequest",
 1585568=>"TlvTypePrintConfigReply",
 1585824=>"TlvTypeSetPrintConfigRequest",
 1442208=>"TlvTypeChangedFileMetaInfo",
 1442432=>"TlvTypeChangedFileChangeTime",
 1442688=>"TlvTypeChangedFileChangeEvent",
 1442960=>"TlvTypeChangedFileRecording",
 1454240=>"TlvTypeGetChangedConfigRequest",
 1454496=>"TlvTypeChangedConfigReply",
 1454752=>"TlvTypeSetChangedConfigRequest",
 1454912=>"TlvTypeConfigChangedEvents",
 1311136=>"TlvTypeSkypeAudioMetaInfo",
 1311376=>"TlvTypeSkypeAudioRecording",
 1311648=>"TlvTypeSkypeTextRecording",
 1311904=>"TlvTypeSkypeFileMetaInfo",
 1312144=>"TlvTypeSkypeFileRecording",
 1312416=>"TlvTypeSkypeContactsRecording",
 1312640=>"TlvTypeSkypeContactsUserData",
 1323168=>"TlvTypeGetSkypeConfigRequest",
 1323424=>"TlvTypeSkypeConfigReply",
 1323680=>"TlvTypeSetSkypeConfigRequest",
 1324336=>"TlvTypeConfigSkypeAudioEnable",
 1324592=>"TlvTypeConfigSkypeTextEnable",
 1324848=>"TlvTypeConfigSkypeFileEnable",
 1325104=>"TlvTypeConfigSkypeContactsListEnable",
 1327232=>"TlvTypeSkypeAudioEncodingType",
 1327488=>"TlvTypeSkypeLoggedInUserAccountName",
 1327744=>"TlvTypeSkypeConversationPartnerAccountName",
 1328000=>"TlvTypeSkypeConversationPartnerDisplayName",
 1328256=>"TlvTypeSkypeChatMembers",
 1328512=>"TlvTypeSkypeTextMessage",
 1328768=>"TlvTypeSkypeChatID",
 1329024=>"TlvTypeSkypeSenderAccountName",
 1329280=>"TlvTypeSkypeSenderDisplayName",
 1329536=>"TlvTypeSkypeIncoming",
 1329792=>"TlvTypeSkypeSessionType",
 1192096=>"TlvTypeGetKeyloggerConfigRequest",
 1192352=>"TlvTypeKeyloggerConfigReply",
 1192608=>"TlvTypeSetKeyloggerConfigRequest",
 1180064=>"TlvTypeStartKeyLoggingRequest",
 1180320=>"TlvTypeStartKeyLoggingReply",
 1180576=>"TlvTypeKeyLoggingFrame",
 1180832=>"TlvTypeStopKeyLoggingRequest",
 1181088=>"TlvTypeKeyLoggingStoppedReply",
 1196416=>"TlvTypeKLFrameData",
 1126560=>"TlvTypeGetVideoConfigRequest",
 1126816=>"TlvTypeVideoConfigReply",
 1127072=>"TlvTypeSetVideoConfigRequest",
 1114528=>"TlvTypeStartScreenRequest",
 1114784=>"TlvTypeStartScreenReply",
 1115040=>"TlvTypeScreenFrame",
 1115296=>"TlvTypeStopScreenRequest",
 1115552=>"TlvTypeScreenStoppedReply",
 1115808=>"TlvTypeStartScreenRecording",
 1122720=>"TlvTypeStartWebCamRequest",
 1122976=>"TlvTypeStartWebCamReply",
 1123232=>"TlvTypeWebCamFrame",
 1123488=>"TlvTypeStopWebCamRequest",
 1123744=>"TlvTypeWebCamStoppedReply",
 1124000=>"TlvTypeStartWebCamRecording",
 1130560=>"TlvTypeVDFrameID",
 1130896=>"TlvTypeVDFrameData",
 1131136=>"TlvTypeOriginalVideoResolution",
 1131392=>"TlvTypeVideoResolution",
 1066112=>"TlvTypeVideoSessionType",
 1066368=>"TlvTypeVideoEncodingType",
 1132160=>"TlvTypeAutomaticRecordingUID",
 1061024=>"TlvTypeGetAudioConfigRequest",
 1061280=>"TlvTypeAudioConfigReply",
 1061536=>"TlvTypeSetAudioConfigRequest",
 1048992=>"TlvTypeStartMicrophoneRequest",
 1049248=>"TlvTypeStartMicrophoneReply",
 1049504=>"TlvTypeMicrophoneFrame",
 1049760=>"TlvTypeStopMicrophoneRequest",
 1050016=>"TlvTypeMicrophoneStoppedReply",
 1050272=>"TlvTypeStartMicrophoneRecording",
 1052736=>"TlvTypeMICFrameID",
 1053072=>"TlvTypeMICFrameData",
 1053312=>"TlvTypeAudioSessionType",
 1053568=>"TlvTypeAudioEncodingType",
 328096=>"TlvTypeGetSchedulerConfigRequest",
 328352=>"TlvTypeSchedulerConfigReply",
 328608=>"TlvTypeSetSchedulerConfigRequest",
 331920=>"TlvTypeSchedulerTask",
 332192=>"TlvTypeSchedulerTaskRecordByTime",
 332448=>"TlvTypeSchedulerTaskRecordScreenWhenAppRuns",
 332704=>"TlvTypeSchedulerTaskRecordMicWhenAppUsesIt",
 332960=>"TlvTypeSchedulerTaskRecordWebCamWhenAppUsesIt",
 360592=>"TlvTypeSCHTaskConfiguration",
 360752=>"TlvTypeSCHTaskEnabled",
 361344=>"TlvTypeSCHTaskStartDateTime",
 361600=>"TlvTypeSCHTaskStopDateTime",
 362112=>"TlvTypeSCHApplicationName",
 362288=>"TlvTypeSCHApplicationWindowOnly",
 299168=>"TlvTypeGetCmdLineConfigRequest",
 299424=>"TlvTypeCmdLineConfigReply",
 299680=>"TlvTypeSetCmdLineConfigRequest",
 262560=>"TlvTypeStartCmdLineSessionRequest",
 262816=>"TlvTypeStartCmdLineSessionReply",
 263072=>"TlvTypeStopCmdLineSessionRequest",
 263328=>"TlvTypeCmdLineSessionStoppedReply",
 263584=>"TlvTypeCmdLineExecute",
 263840=>"TlvTypeCmdLineExecutionResult",
 266352=>"TlvTypeCmdLineExecuteCommand",
 266560=>"TlvTypeCmdLineExecuteAnswerID",
 266864=>"TlvTypeCmdLineExecuteAnswerData",
 168096=>"TlvTypeGetFileSystemConfigRequest",
 168352=>"TlvTypeFileSystemConfigReply",
 168608=>"TlvTypeSetFileSystemConfigRequest",
 131488=>"TlvTypeGetAllDrivesRequest",
 131744=>"TlvTypeGetAllDrivesReply",
 135328=>"TlvTypeGetFolderContentsRequest",
 135584=>"TlvTypeGetFolderContentsReply",
 135840=>"TlvTypeGetFolderContentsNext",
 136096=>"TlvTypeGetFolderContentsEnd",
 139424=>"TlvTypeDownloadFileRequest",
 139680=>"TlvTypeCancelDownloadFileRequest",
 139936=>"TlvTypeDownloadFileReply",
 140192=>"TlvTypeDownloadFileNext",
 140448=>"TlvTypeDownloadFileEnd",
 140704=>"TlvTypeCancelDownloadFileReply",
 143520=>"TlvTypeUploadFileRequest",
 143776=>"TlvTypeCancelUploadFileRequest",
 144032=>"TlvTypeUploadFileReply",
 144288=>"TlvTypeUploadFileNext",
 144544=>"TlvTypeUploadFileEnd",
 144800=>"TlvTypeUploadFileCompleted",
 145056=>"TlvTypeCancelUploadFileReply",
 147616=>"TlvTypeDeleteFileRequest",
 147872=>"TlvTypeDeleteFileReply",
 151968=>"TlvTypeSearchFileRequest",
 152224=>"TlvTypeSearchFileReply",
 152480=>"TlvTypeSearchFileNext",
 152736=>"TlvTypeSearchFileEnd",
 152992=>"TlvTypeCancelSearchFileRequest",
 153248=>"TlvTypeCancelSearchFileReply",
 159888=>"TlvTypeFSFileDataChunk",
 160128=>"TlvTypeFSDiskDrive",
 160384=>"TlvTypeFSFullPath",
 160640=>"TlvTypeFSFilename",
 160896=>"TlvTypeFSFileExtension",
 161088=>"TlvTypeFSDiskDriveType",
 161408=>"TlvTypeFSFileSize",
 161584=>"TlvTypeFSIsFolder",
 161840=>"TlvTypeFSReadOnly",
 162096=>"TlvTypeFSHidden",
 162352=>"TlvTypeFSSystem",
 162688=>"TlvTypeFSFileCreationTime",
 162944=>"TlvTypeFSFileLastAccessTime",
 163200=>"TlvTypeFSFileLastWriteTime",
 163472=>"TlvTypeFSFullPathM",
 8978848=>"TlvTypeMasterMobileTargetConn",
 7471520=>"TlvTypeMasterTargetConn",
 7405984=>"TlvTypeMasterAgentLogin",
 7406240=>"TlvTypeMasterAgentLoginAnswer",
 7406752=>"TlvTypeMasterAgentTargetList",
 7407008=>"TlvTypeMasterAgentTargetOnlineList",
 7407264=>"TlvTypeMasterAgentTargetInfoReply",
 7407520=>"TlvTypeMasterAgentUserList",
 7407776=>"TlvTypeMasterAgentUserListReply",
 7408032=>"TlvTypeMasterAgentTargetArchivedList",
 7408288=>"TlvTypeMasterAgentTargetListEx",
 7408544=>"TlvTypeMasterAgentTargetOnlineListEx",
 7408800=>"TlvTypeMasterAgentMobileTargetArchivedList",
 7409056=>"TlvTypeMasterAgentMobileTargetList",
 7409312=>"TlvTypeMasterAgentMobileTargetOnlineList",
 7409824=>"TlvTypeMasterAgentQueryFirst",
 7410080=>"TlvTypeMasterAgentQueryNext",
 7410336=>"TlvTypeMasterAgentQueryLast",
 7410592=>"TlvTypeMasterAgentQueryAnswer",
 7410848=>"TlvTypeMasterAgentRemoveRecord",
 7411104=>"TlvTypeMasterAgentTargetInfoExReply",
 7411344=>"TlvTypeTargetInfoExProperty",
 7411616=>"TlvTypeTargetInfoExPropertyValue",
 7411840=>"TlvTypeTargetInfoExPropertyValueName",
 7411968=>"TlvTypeTargetInfoExPropertyValueData",
 7412384=>"TlvTypeMasterAgentAlarm",
 7413920=>"TlvTypeMasterAgentRetrieveData",
 7414176=>"TlvTypeMasterAgentRetrieveDataAnswer",
 7414432=>"TlvTypeMasterAgentRemoveUser",
 7414688=>"TlvTypeMasterAgentRemoveTarget",
 7414944=>"TlvTypeMasterAgentRetrieveDataComments",
 7415200=>"TlvTypeMasterAgentUpdateDataComments",
 7415712=>"TlvTypeMasterAgentRetrieveActivityLogging",
 7415968=>"TlvTypeMasterAgentRetrieveMasterLogging",
 7416224=>"TlvTypeMasterAgentRetrieveAgentActivityLogging",
 7417248=>"TlvTypeMasterAgentSendUserGUIConfig",
 7417504=>"TlvTypeMasterAgentGetUserGUIConfigRequest",
 7417760=>"TlvTypeMasterAgentGetUserGUIConfigReply",
 7418016=>"TlvTypeMasterAgentProxyList",
 7418272=>"TlvTypeMasterAgentProxyInfoReply",
 7419040=>"TlvTypeMasterAgentNameValuePacket",
 7419248=>"TlvTypeMasterAgentValueName",
 7419392=>"TlvTypeMasterAgentValueData",
 7419808=>"TlvTypeMasterAgentRetrieveTargetHistory",
 7421088=>"TlvTypeMasterAgentInstallMasterLicense",
 7421344=>"TlvTypeMasterAgentInstallSoftwareUpdate",
 7421600=>"TlvTypeMasterAgentInstallSoftwareUpdateChunk",
 7421856=>"TlvTypeMasterAgentInstallSoftwareUpdateDone",
 7422112=>"TlvTypeMasterAgentSoftwareUpdateInfo",
 7422368=>"TlvTypeMasterAgentSoftwareUpdateInfoReply",
 7422624=>"TlvTypeMasterAgentSoftwareUpdate",
 7422880=>"TlvTypeMasterAgentSoftwareUpdateReply",
 7423136=>"TlvTypeMasterAgentSoftwareUpdateNext",
 7423392=>"TlvTypeMasterAgentAddTimeSchedule",
 7423648=>"TlvTypeMasterAgentAddScreenSchedule",
 7423904=>"TlvTypeMasterAgentAddLockedSchedule",
 7424160=>"TlvTypeMasterAgentRemoveSchedule",
 7424416=>"TlvTypeMasterAgentGetSchedulerList",
 7424672=>"TlvTypeMasterAgentSchedulerTimeAction",
 7424928=>"TlvTypeMasterAgentSchedulerScreenAction",
 7425184=>"TlvTypeMasterAgentSchedulerLockedAction",
 7425440=>"TlvTypeMasterAgentProjectSoftwareUpdateInfo",
 7425696=>"TlvTypeMasterAgentProjectSoftwareUpdateInfoReply",
 7425952=>"TlvTypeMasterAgentProjectSoftwareUpdate",
 7426112=>"TlvTypeMasterAgentSchedulerID",
 7426368=>"TlvTypeMasterAgentSchedulerStartTime",
 7426624=>"TlvTypeMasterAgentSchedulerStopTime",
 7427488=>"TlvTypeMasterAgentAddRecordedDataAvailableSchedule",
 7427744=>"TlvTypeMasterAgentSchedulerRecordedDataAvailableAction",
 7428256=>"TlvTypeMasterAgentRetrieveRemoteMasterData",
 7428512=>"TlvTypeMasterAgentRetrieveRemoteMasterDataReply",
 7428768=>"TlvTypeMasterAgentDeleteRemoteMasterData",
 7429024=>"TlvTypeMasterAgentRetrieveOfflineMasterData",
 7429280=>"TlvTypeMasterAgentRetrieveOfflineMasterDataReply",
 7429536=>"TlvTypeMasterAgentDeleteOfflineMasterData",
 7430304=>"TlvTypeMasterAgentQueryFirstEx",
 7430560=>"TlvTypeMasterAgentQueryNextEx",
 7430816=>"TlvTypeMasterAgentQueryLastEx",
 7431072=>"TlvTypeMasterAgentQueryAnswerEx",
 7431328=>"TlvTypeMasterAgentSendUserPreferences",
 7431584=>"TlvTypeMasterAgentGetUserPreferencesRequest",
 7431840=>"TlvTypeMasterAgentGetUserPreferencesReply",
 7432096=>"TlvTypeMasterAgentListMCFilesRequest",
 8415392=>"TlvTypeMasterAgentListMCFilesReply",
 7432608=>"TlvTypeMasterAgentDeleteMCFiles",
 7432864=>"TlvTypeMasterAgentSendMCFiles",
 7433120=>"TlvTypeMasterAgentMCStatisticsRequest",
 7433376=>"TlvTypeMasterAgentMCStatisticsReply",
 7433616=>"TlvTypeMasterAgentMCStatisticsValues",
 7434400=>"TlvTypeMasterAgentTrojanKeyRequest",
 7434656=>"TlvTypeMasterAgentTrojanKeyReply",
 7434912=>"TlvTypeMasterAgentEvProtectionX509Request",
 7435168=>"TlvTypeMasterAgentEvProtectionX509Reply",
 7435424=>"TlvTypeMasterAgentEvProtectionImportCert",
 7435680=>"TlvTypeMasterAgentEvProtectionImportCertCompleted",
 7435936=>"TlvTypeMasterAgentConfigurationRequest",
 7436192=>"TlvTypeMasterAgentConfigurationReply",
 7436448=>"TlvTypeMasterAgentConfigurationUpdateRequest",
 7436704=>"TlvTypeMasterAgentConfigurationUpdateRequestCompleted",
 7436944=>"TlvTypeMasterAgentConfiguration",
 7437216=>"TlvTypeMasterAgentConfigurationValue",
 7437424=>"TlvTypeMasterAgentConfigurationValueName",
 7437568=>"TlvTypeMasterAgentConfigurationValueData",
 7437984=>"TlvTypeMasterAgentConfigurationTransferDone",
 7438496=>"TlvTypeMasterAgentRetrieveTargetFile",
 7438752=>"TlvTypeMasterAgentRetrieveTargetFileAnswer",
 7438912=>"TlvTypeMasterAgentAlarmEntryID",
 7439168=>"TlvTypeMasterAgentAlarmEntryVersion",
 7439424=>"TlvTypeMasterAgentAlarmTriggerFlags",
 7439776=>"TlvTypeMasterAgentGetAlarmList",
 7440032=>"TlvTypeMasterAgentAddAlarmEntry",
 7440288=>"TlvTypeMasterAgentRemoveAlarmEntry",
 7440544=>"TlvTypeMasterAgentAlarmEntry",
 7440800=>"TlvTypeMasterAgentSystemStatus",
 7441056=>"TlvTypeMasterAgentSystemStatusRequest",
 7441312=>"TlvTypeMasterAgentSystemStatusReply",
 7441552=>"TlvTypeMasterAgentLicenseValues",
 7441824=>"TlvTypeMasterAgentLicenseValuesRequest",
 7442080=>"TlvTypeMasterAgentLicenseValuesReply",
 7442592=>"TlvTypeMasterAgentGetNetworkConfigurationRequest",
 7442848=>"TlvTypeMasterAgentSetNetworkConfigurationRequest",
 7443104=>"TlvTypeMasterAgentSetNetworkConfigurationReply",
 7443360=>"TlvTypeMasterAgentRetrieveAllowedModulesList",
 7443616=>"TlvTypeMasterAgentRetrieveAllowedModulesListAnswer",
 7446688=>"TlvTypeMasterAgentRemoveAllTargetData",
 7446944=>"TlvTypeMasterAgentForceDownloadRecordedData",
 7447200=>"TlvTypeMasterAgentTargetCreateNotification",
 7447456=>"TlvTypeMasterAgentMobileTargetInfoReply",
 7447696=>"TlvTypeMasterAgentMobileTargetInfoValues",
 7450784=>"TlvTypeMasterAgentAlert",
 7454880=>"TlvTypeMasterAgentAddUser",
 7455392=>"TlvTypeMasterAgentAddUserReply",
 7455648=>"TlvTypeMasterAgentModifyUser",
 7455904=>"TlvTypeMasterAgentSetUserPermission",
 7456160=>"TlvTypeMasterAgentSetTargetPermission",
 7456400=>"TlvTypeMasterAgentUserPermission",
 7456656=>"TlvTypeMasterAgentTargetPermission",
 7456928=>"TlvTypeMasterAgentUserPermissionValuePacket",
 7457184=>"TlvTypeMasterAgentTargetPermissionValuePacket",
 7457344=>"TlvTypeMasterAgentUserPermissionValueName",
 7457600=>"TlvTypeMasterAgentTargetPermissionValueName",
 7457856=>"TlvTypeMasterAgentUserPermissionValueData",
 7458112=>"TlvTypeMasterAgentTargetPermissionValueData",
 7458464=>"TlvTypeMasterAgentModifyPassword",
 7458656=>"TlvTypeMasterAgentMobileTargetPermissionValueName",
 7458976=>"TlvTypeMasterAgentUploadFile",
 7459232=>"TlvTypeMasterAgentUploadFileChunk",
 7459488=>"TlvTypeMasterAgentUploadFileDone",
 7459744=>"TlvTypeMasterAgentUploadFilesTransferDone",
 7460000=>"TlvTypeMasterAgentGetTargetModuleConfigRequest",
 7460256=>"TlvTypeMasterAgentRemoveFile",
 7460512=>"TlvTypeMasterAgentMobileProxyList",
 7460768=>"TlvTypeMasterAgentSMSProxyList",
 7461024=>"TlvTypeMasterAgentSMSProxyInfoReply",
 7461280=>"TlvTypeMasterAgentCallPhoneNumberList",
 7461536=>"TlvTypeMasterAgentCallPhoneNumberInfoReply",
 7461792=>"TlvTypeMasterAgentGetMobileTargetModuleConfigRequest",
 7462048=>"TlvTypeMasterAgentSendSMS",
 7469984=>"TlvTypeMasterAgentEncryptionRequired",
 7470752=>"TlvTypeAgentMasterComm",
 7470240=>"TlvTypeMasterAgentFileCompleted",
 7470496=>"TlvTypeMasterAgentRequestCompleted",
 7471008=>"TlvTypeMasterAgentRequestStatus",
 7733664=>"TlvTypeRelayProxyComm",
 8454800=>"TlvTypeRelayData",
 7734176=>"TlvTypeRelayDummyHeartbeat",
 7668128=>"TlvTypeMasterTargetComm",
 7668384=>"TlvTypeTargetCloseAllLiveStreaming",
 7471424=>"TlvTypeProxyMasterCommSig",
 7471776=>"TlvTypeProxyMasterComm",
 7472032=>"TlvTypeMasterProxyComm",
 7472288=>"TlvTypeProxyMasterHeartBeatAnswer",
 7472544=>"TlvTypeProxyMasterDisconnect",
 7472704=>"TlvTypeProxyMasterNotification",
 7473056=>"TlvTypeProxyMasterRequest",
 7473312=>"TlvTypeMasterProxyCommNotification",
 7473568=>"TlvTypeMasterCheckTargetDisconnect",
 7536960=>"TlvTypeProxyTargetCommSig",
 7537312=>"TlvTypeProxyTargetComm",
 7537568=>"TlvTypeProxyMasterTargetComm",
 7537728=>"TlvTypeProxyTargetRequestCrypto",
 7538064=>"TlvTypeProxyTargetAnswerCrypto",
 8454544=>"TlvTypeProxyData",
 8458400=>"TlvTypeProxyTargetDisconnect",
 8458656=>"TlvTypeProxyMobileTargetDisconnect",
 8458912=>"TlvTypeProxyDummyHeartbeat",
 8459168=>"TlvTypeProxyMobileDummyHeartbeat",
 8585616=>"TlvTypeAgentData",
 8585808=>"TlvTypeAgentQueryID",
 8586048=>"TlvTypeAgentQueryModSubmodID",
 8586304=>"TlvTypeAgentQueryFromDate",
 8586560=>"TlvTypeAgentQueryToDate",
 8586816=>"TlvTypeAgentQuerySortOrder",
 8587136=>"TlvTypeAgentQueryValueFilter",
 8587328=>"TlvTypeAgentUID",
 8520080=>"TlvTypeMasterData",
 8520768=>"TlvTypeMasterMode",
 8521024=>"TlvTypeMasterToken",
 8521344=>"TlvTypeMasterQueryResult",
 8522368=>"TlvTypeMasterAlarmString",
 8651152=>"TlvTypeMobileTargetData",
 8651376=>"TlvTypeMobileTargetHeartBeatV10",
 8651632=>"TlvTypeMobileTargetExtendedHeartBeatV10",
 8651888=>"TlvTypeMobileHeartBeatReplyV10",
 8653472=>"TlvTypeMobileInstalledModulesReply",
 8656032=>"TlvTypeMobileTargetUploadModuleRequest",
 8656288=>"TlvTypeMobileTargetUploadModuleReply",
 8656544=>"TlvTypeMobileTargetUploadModuleChunk",
 8656800=>"TlvTypeMobileTargetUploadModuleDoneRequest",
 8657056=>"TlvTypeMobileTargetUploadModuleDoneReply",
 8657312=>"TlvTypeMobileTargetRemoveModuleRequest",
 8657568=>"TlvTypeMobileTargetRemoveModuleReply",
 8655008=>"TlvTypeMobileTargetOfflineUploadModuleRequest",
 8657824=>"TlvTypeMobileTargetOfflineUploadModuleReply",
 8658080=>"TlvTypeMobileTargetOfflineUploadModuleChunk",
 8658336=>"TlvTypeMobileTargetOfflineUploadModuleDoneRequest",
 8658592=>"TlvTypeMobileTargetOfflineUploadModuleDoneReply",
 8658848=>"TlvTypeMobileTargetOfflineError",
 8659104=>"TlvTypeMobileTargetError",
 8659360=>"TlvTypeMobileTargetGetRecordedFilesRequest",
 8659616=>"TlvTypeMobileTargetRecordedFilesReply",
 8659872=>"TlvTypeMobileTargetRecordedFileDownloadRequest",
 8660128=>"TlvTypeMobileTargetRecordedFileDownloadReply",
 8660384=>"TlvTypeMobileTargetRecordedFileDownloadChunk",
 8660640=>"TlvTypeMobileTargetRecordedFileDownloadCompleted",
 8660896=>"TlvTypeMobileTargetRecordedFileDeleteRequest",
 8661152=>"TlvTypeMobileTargetRecordedFileDeleteReply",
 8663968=>"TlvTypeMobileTargetOfflineConfig",
 8664224=>"TlvTypeMobileTargetEmergencyConfigAsTLV",
 8664432=>"TlvTypeMobileTargetEmergencyConfig",
 8671392=>"TlvTypeMobileTargetLoadModuleRequest",
 8671648=>"TlvTypeMobileTargetLoadModuleReply",
 8671904=>"TlvTypeMobileTargetUnLoadModuleRequest",
 8672160=>"TlvTypeMobileTargetUnLoadModuleReply",
 8675472=>"TlvTypeMobileTargetHeartbeatEvents",
 8675648=>"TlvTypeMobileTargetHeartbeatInterval",
 8675984=>"TlvTypeMobileTargetHeartbeatRestrictions",
 8676208=>"TlvTypeConfigSMSPhoneNumber",
 8676496=>"TlvTypeMobileTargetPositioning",
 8676672=>"TlvTypeMobileTrojanUID",
 8676976=>"TlvTypeMobileTrojanID",
 8677296=>"TlvTypeMobileTargetLocationChangedRange",
 8677440=>"TlvTypeConfigMobileAutoRemovalDateTime",
 8677808=>"TlvTypeConfigOverwriteProxyAndPhones",
 8678000=>"TlvTypeConfigCallPhoneNumber",
 8679488=>"TlvTypeLocationAreaCode",
 8679744=>"TlvTypeCellID",
 8680048=>"TlvTypeMobileCountryCode",
 8680304=>"TlvTypeMobileNetworkCode",
 8680560=>"TlvTypeIMSI",
 8680816=>"TlvTypeIMEI",
 8681072=>"TlvTypeGPSLatitude",
 8681328=>"TlvTypeGPSLongitude",
 8681520=>"TlvTypeFirstHeartbeat",
 8681872=>"TlvTypeInstalledModules",
 8683568=>"TlvTypeValidGPSValues",
 8389008=>"TlvTypeTargetData",
 8389280=>"TlvTypeTargetHeartBeat",
 8389680=>"TlvTypeTargetKeepSessionAlive",
 8390000=>"TlvTypeTargetLocalIP",
 8390256=>"TlvTypeTargetGlobalIP",
 8390448=>"TlvTypeTargetState",
 8390784=>"TlvTypeTargetID",
 8391072=>"TlvTypeGetInstalledModulesRequest",
 8391328=>"TlvTypeInstalledModulesReply",
 8391488=>"TlvTypeTrojanUID",
 8391808=>"TlvTypeTrojanID",
 8392000=>"TlvTypeTrojanMaxInfections",
 8392240=>"TlvTypeScreenSaverOn",
 8392496=>"TlvTypeScreenLocked",
 8392752=>"TlvTypeRecordedDataAvailable",
 8393024=>"TlvTypeDownloadedRecordedDataTimeStamp",
 8393280=>"TlvTypeInstallationMode",
 8393552=>"TlvTypeTargetRemoveNotification",
 8393792=>"TlvTypeTargetPlatformBits",
 8394032=>"TlvTypeRemoveItselfMaxInfectionReached",
 8394288=>"TlvTypeRemoveItselfAtMasterRequest",
 8394544=>"TlvTypeRemoveItselfAtAgentRequest",
 8394912=>"TlvTypeRemoveItselfAtAgentReqRequest",
 8395072=>"TlvTypeRecordedFilesDownloadTotal",
 8395328=>"TlvTypeRecordedFilesDownloadProgress",
 8395632=>"TlvTypeTargetLicenseInfo",
 8395840=>"TlvTypeRemoveTargetLicenseInfo",
 8396176=>"TlvTypeTargetAllConfigurations",
 8396960=>"TlvTypeTargetError",
 8401056=>"TlvTypeGetTargetConfigRequest",
 8401312=>"TlvTypeTargetConfigReply",
 8401568=>"TlvTypeSetTargetConfigRequest",
 8402304=>"TlvTypeConfigTargetID",
 8402496=>"TlvTypeConfigTargetHeartbeatInterval",
 8402800=>"TlvTypeConfigTargetProxy",
 8403008=>"TlvTypeConfigTargetPort",
 8403584=>"TlvTypeConfigAutoRemovalDateTime",
 8403776=>"TlvTypeConfigAutoRemovalIfNoProxy",
 8404032=>"TlvTypeInternalAutoRemovalElapsedTime",
 8405040=>"TlvTypeConfigActiveHiding",
 8409248=>"TlvTypeTargetLoadModuleRequest",
 8409504=>"TlvTypeTargetLoadModuleReply",
 8409760=>"TlvTypeTargetUnLoadModuleRequest",
 8410016=>"TlvTypeTargetUnLoadModuleReply",
 8410272=>"TlvTypeTargetUploadModuleRequest",
 8410528=>"TlvTypeTargetUploadModuleReply",
 8410784=>"TlvTypeTargetUploadModuleChunk",
 8411040=>"TlvTypeTargetUploadModuleDoneRequest",
 8411296=>"TlvTypeTargetUploadModuleDoneReply",
 8411552=>"TlvTypeTargetRemoveModuleRequest",
 8411808=>"TlvTypeTargetRemoveModuleReply",
 8412064=>"TlvTypeTargetOfflineUploadModuleRequest",
 8412320=>"TlvTypeTargetOfflineUploadModuleReply",
 8412576=>"TlvTypeTargetOfflineUploadModuleChunk",
 8412832=>"TlvTypeTargetOfflineUploadModuleDoneRequest",
 8413088=>"TlvTypeTargetOfflineUploadModuleDoneReply",
 8413344=>"TlvTypeTargetOfflineError",
 8413600=>"TlvTypeTargetUploadError",
 8417440=>"TlvTypeTargetGetRecordedFilesRequest",
 8417696=>"TlvTypeTargetRecordedFilesReply",
 8417952=>"TlvTypeTargetRecordedFileDownloadRequest",
 8418208=>"TlvTypeTargetRecordedFileDownloadReply",
 8418464=>"TlvTypeTargetRecordedFileDownloadChunk",
 8418720=>"TlvTypeTargetRecordedFileDownloadCompleted",
 8418976=>"TlvTypeTargetRecordedFileDeleteRequest",
 8419232=>"TlvTypeTargetRecordedFileDeleteReply",
 8419488=>"TlvTypeTargetGetRecordedFilesRequestEx",
 8419744=>"TlvTypeTargetRecordedFilesReplyEx",
 8420000=>"TlvTypeTargetRecordedFileDeleteRequestEx",
 8420256=>"TlvTypeTargetRecordedFilesDownloadRequestEx",
 16744768=>"TlvTypeProxyConnectionBroken",
 16712000=>"TlvTypeTargetConnectionBroken",
 16712256=>"TlvTypeAgentConnectionBroken",
 16712512=>"TlvTypeTargetOffline",
 16646544=>"TlvTypePlaintext",
 16646800=>"TlvTypeCompression",
 16647056=>"TlvTypeEncryption",
 16647232=>"TlvTypeTargetUID",
 16647536=>"TlvTypeIPAddress",
 16647808=>"TlvTypeUserName",
 16648064=>"TlvTypeComputerName",
 16648304=>"TlvTypeLoginName",
 16648560=>"TlvTypePassphrase",
 16648832=>"TlvTypeRecordID",
 16649088=>"TlvTypeOwner",
 16649344=>"TlvTypeMetaData",
 16649536=>"TlvTypeModuleID",
 16649856=>"TlvTypeOSName",
 16650048=>"TlvTypeModuleSubID",
 16650320=>"TlvTypeErrorCode",
 16650560=>"TlvTypeOffset",
 16650816=>"TlvTypeLength",
 16651088=>"TlvTypeRequestID",
 16651328=>"TlvTypeRequestType",
 16651584=>"TlvTypeVersion",
 16651840=>"TlvTypeMachineID",
 16652096=>"TlvTypeMajorNumber",
 16652352=>"TlvTypeMinorNumber",
 16652656=>"TlvTypeGlobalIPAddress",
 16652912=>"TlvTypeASCII_Filename",
 16653120=>"TlvTypeFilesize",
 16653392=>"TlvTypeFilecount",
 16653712=>"TlvTypeFiledata",
 16653968=>"TlvTypeMD5Sum",
 16654144=>"TlvTypeProxyPort",
 16654400=>"TlvTypeStatus",
 16654656=>"TlvTypeUserID",
 16654912=>"TlvTypeGroupID",
 16655168=>"TlvTypePermissions",
 16655424=>"TlvTypeRequestCode",
 16655680=>"TlvTypeDataSize",
 16655936=>"TlvTypeKeyType",
 16656240=>"TlvTypeEmail",
 16656432=>"TlvTypeEnabled",
 16656688=>"TlvTypeLicensed",
 16656960=>"TlvTypeAudioFrequency",
 16657216=>"TlvTypeAudioBitsPerSample",
 16657472=>"TlvTypeAudioChannels",
 16657728=>"TlvTypeStartTime",
 16657984=>"TlvTypeStopTime",
 16658240=>"TlvTypeBitMask",
 16658560=>"TlvTypeTimeZone",
 16658816=>"TlvTypeDateTime",
 16659072=>"TlvTypeStartSessionDateTime",
 16659328=>"TlvTypeStopSessionDateTime",
 16659520=>"TlvTypeDateTimeRef",
 16659776=>"TlvTypeScheduleRepeat",
 16660032=>"TlvTypeUnixMasterDateTime",
 16660288=>"TlvTypeUnixUTCDateTime",
 16660544=>"TlvTypeDurationInSeconds",
 16660864=>"TlvTypeMasterRefTime",
 16661120=>"TlvTypeMasterRefTimeStart",
 16661376=>"TlvTypeMasterRefTimeEnd",
 16661568=>"TlvTypeCounter",
 16661888=>"TlvTypeWhiteListEntry",
 16662144=>"TlvTypeBlackListEntry",
 16662336=>"TlvTypeBlackWhiteListingMode",
 16662576=>"TlvTypeConfigEnabled",
 16662848=>"TlvTypeConfigMaxRecordingSize",
 16663104=>"TlvTypeConfigAudioQuality",
 16663344=>"TlvTypeConfigVideoBlackAndWhite",
 16663616=>"TlvTypeConfigVideoResolution",
 16663872=>"TlvTypeConfigCaptureFrequency",
 16664128=>"TlvTypeConfigVideoQuality",
 16664384=>"TlvTypeConfigFilesStandardFilter",
 16664704=>"TlvTypeConfigFilesCustomFilter",
 16664896=>"TlvTypeConfigStandardLocation",
 16665216=>"TlvTypeConfigCustomLocation",
 16665408=>"TlvTypeConfigFileChunkSize",
 16665664=>"TlvTypeConfigFileTransferSpeed",
 16665904=>"TlvTypeConfigUploadFileOverwrite",
 16666160=>"TlvTypeConfigDeleteOverReboot",
 16666496=>"TlvTypeConfigCustomLocationException",
 16666752=>"TlvTypeExtraData",
 16667008=>"TlvTypeSignature",
 16667264=>"TlvTypeComments",
 16667520=>"TlvTypeDescription",
 16667776=>"TlvTypeFilenameExtension",
 16668032=>"TlvTypeSessionType",
 16668224=>"TlvTypePeriod",
 16668512=>"TlvTypeMobileTargetUID",
 16668784=>"TlvTypeMobileTargetID",
 16669072=>"TlvTypeMobilePlaintext",
 16669328=>"TlvTypeMobileCompression",
 16669584=>"TlvTypeMobileEncryption",
 16669824=>"TlvTypeEncodingType",
 16670576=>"TlvTypePhoneNumber",
 16670784=>"TlvTypeConfigCustomLocationMode",
 16674928=>"TlvTypeNetworkInterface",
 16675136=>"TlvTypeNetworkInterfaceMode",
 16675440=>"TlvTypeNetworkInterfaceAddress",
 16675696=>"TlvTypeNetworkInterfaceNetmask",
 16675952=>"TlvTypeNetworkInterfaceGateway",
 16676208=>"TlvTypeNetworkInterfaceDNS_1",
 16676464=>"TlvTypeNetworkInterfaceDNS_2",
 16677440=>"TlvTypeLoginTime",
 16677696=>"TlvTypeLogoffTime",
 16678720=>"TlvTypeGeneric_Type",
 16678976=>"TlvTypeChecksum",
 16679280=>"TlvTypeCity",
 16679536=>"TlvTypeCountry",
 16679792=>"TlvTypeCountryCode",
 16683072=>"TlvTypeTargetType",
 16683392=>"TlvTypeDurationString",
 8257792=>"TlvTypeTestMetaTypeInvalid",
 8258608=>"TlvTypeTestMetaTypeBool",
 8258880=>"TlvTypeTestMetaTypeUInt",
 8259152=>"TlvTypeTestMetaTypeInt",
 8259440=>"TlvTypeTestMetaTypeString",
 8259712=>"TlvTypeTestMetaTypeUnicode",
 8259984=>"TlvTypeTestMetaTypeRaw",
 8260256=>"TlvTypeTestMetaTypeGroup",
 8260416=>"TlvTypeTestMemberIdentifier",
 8260736=>"TlvTypeTestMemberName"}



# Taken from Eric Monti's awesome Ruby Blackbag toolkit. He's an awesome guy 
# and I'm sure he won't mind. That being said, everyone should check out his 
# stuff at https://github.com/emonti/rbkb/
# 
module Rbkb
  HEXCHARS = [("0".."9").to_a, ("a".."f").to_a].flatten
end

class String
  # Convert a string to ASCII hex string. Supports a few options for format:
  #
  #   :delim - delimter between each hex byte
  #   :prefix - prefix before each hex byte
  #   :suffix - suffix after each hex byte
  # 
  def hexify(opts={})
    delim = opts[:delim]
    pre = (opts[:prefix] || "")
    suf = (opts[:suffix] || "")
    if (rx=opts[:rx]) and not rx.kind_of? Regexp
      raise "rx must be a regular expression for a character class"
    end
    hx=Rbkb::HEXCHARS
    out=Array.new
    self.each_byte do |c| 
      hc = if (rx and not rx.match c.chr)
             c.chr 
           else
             pre + (hx[(c >> 4)] + hx[(c & 0xf )]) + suf
           end
      out << (hc)
    end
    out.join(delim)
  end

  # Convert ASCII hex string to raw. 
  #
  # Parameters:
  #
  #   d = optional 'delimiter' between hex bytes (zero+ spaces by default)
  def unhexify(d=/\s*/)
    self.strip.gsub(/([A-Fa-f0-9]{1,2})#{d}?/) { $1.hex.chr }
  end
end


def formatType(num)
  num.to_s(16).rjust(8, "0").unhexify.reverse
end

def revEndian(str)
  if str.length == 1
    str.unpack("C*").first
  elsif str.length == 2
    str.unpack("S*").first
  elsif str.length == 4
    str.unpack("L*").first
  elsif str.length == 8
    str.unpack("Q*").first
  end
end

def parseTLV(str, t)
  tlvSize = revEndian(str[0..3])
  tlvType = revEndian(str[4..7])
  tlvData = str[8..tlvSize-1]
  if @nHash.has_key?(tlvType)
    tabs = "\t"*t
    puts
    
    data = nil
    case @nHash[tlvType]
  
    when "TlvTypeMobileTargetUID"
      data = revEndian(tlvData).to_s.rjust(15, '0')
    when "TlvTypeMobileTrackingSendOnAnyChannel", "TlvTypeMobileTrackingTimeInterval", "TlvTypeMobileTrackingDistance", "TlvTypeMobileTargetHeartbeatEvents", "TlvTypeMobileTargetLocationChangedRange", "TlvTypeTrojanMaxInfections", "TlvTypeUserID", "TlvTypeConfigTargetPort", "TlvTypeMobileTargetHeartbeatInterval", "TlvTypeConfigAutoRemovalIfNoProxy"
      data = revEndian(tlvData)
    when "TlvTypeMobileTrojanUID"
      data = tlvData.force_encoding("BINARY").scan(/./).reverse.join.hexify.upcase.rjust(8, '0')
    when "TlvTypeVersion", "TlvTypeRequestID"
      data = revEndian(tlvData).to_s.rjust(8, '0')
    when "TlvTypeMobileTargetHeartBeatV10"
      parseHB(tlvData, t)
    when "TlvTypeConfigMobileAutoRemovalDateTime"
      data = Time.at(revEndian(tlvData))
    when "TlvTypeInstalledModules"
      parsed = tlvData.scan(/./)
      data = ""
      data << "%s %s  |" % ["Logging:", parsed[68]=="\x01" ? "On" : "Off"]
      data << "  %s %s  |" % ["Spy Call:", parsed[64]=="\x01" ? "On" : "Off"]
      data << "  %s %s  |" % ["Call Interception:", parsed[65]=="\x01" ? "On" : "Off"]
      data << "  %s %s  |" % ["SMS:", parsed[66]=="\x01" ? "On" : "Off"]
      data << "  %s %s  |" % ["Address Book:", parsed[67]=="\x01" ? "On" : "Off"]
      data << "  %s %s  |" % ["Tracking:", parsed[69]=="\x01" ? "On" : "Off"]
      data << "  %s %s" % ["Phone Logs:", parsed[70]=="\x01" ? "On" : "Off"]
    else
      data = tlvData
    end

    if data
      printf("%sSection Size: %s\n%sSection Type: %s\n%sSection Data: ",tabs, tlvSize, tabs, @nHash[tlvType], tabs)
      p data.to_s
    end

    if tlvData[4..7]
      if @nHash.has_key?(revEndian(tlvData[4..7]))
        parseTLV(tlvData, t+1)
      end
    end

    if str.size > tlvSize
      parseTLV(str[tlvSize..str.size-1], t)
    end

  end
end


# Stripping out the last byte of the configuration. Unsure why it is there. 
# Believe it might be an end marker, as I saw the same last byte in 3-4 config
# files. 
parseTLV(fileData[0..fileData.size-2], 0)




