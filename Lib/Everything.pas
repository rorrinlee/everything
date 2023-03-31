{*******************************************************}
{                                                       }
{       Everything SDK Unit for Delphi 7                }
{                                                       }
{       The Everything SDK provides a DLL and Lib       }
{       interface to Everything over IPC.               }
{                                                       }
{       Copyright (C) 2017 David Carpenter              }
{                                                       }
{       Translator: Rorrin Lee                          }
{                                                       }
{*******************************************************}

unit Everything;

interface

uses
  Windows;

const
  // if not defined, version is 1
  EVERYTHING_SDK_VERSION = $02;

const
  EVERYTHING_OK	                    = $00; // no error detected
  EVERYTHING_ERROR_MEMORY	          =	$01; // out of memory.
  EVERYTHING_ERROR_IPC              = $02; // Everything search client is not running
  EVERYTHING_ERROR_REGISTERCLASSEX  = $03; // unable to register window class.
  EVERYTHING_ERROR_CREATEWINDOW	    =	$04; // unable to create listening window
  EVERYTHING_ERROR_CREATETHREAD	    =	$05; // unable to create listening thread
  EVERYTHING_ERROR_INVALIDINDEX	    =	$06; // invalid index
  EVERYTHING_ERROR_INVALIDCALL      = $07; // invalid call
  EVERYTHING_ERROR_INVALIDREQUEST	  =	$08; // invalid request data, request data first.
  EVERYTHING_ERROR_INVALIDPARAMETER =	$09; // bad parameter.

  EVERYTHING_SORT_NAME_ASCENDING                    = $01;
  EVERYTHING_SORT_NAME_DESCENDING	                  = $02;
  EVERYTHING_SORT_PATH_ASCENDING                    = $03;
  EVERYTHING_SORT_PATH_DESCENDING	                  = $04;
  EVERYTHING_SORT_SIZE_ASCENDING                    = $05;
  EVERYTHING_SORT_SIZE_DESCENDING	                  = $06;
  EVERYTHING_SORT_EXTENSION_ASCENDING	              = $07;
  EVERYTHING_SORT_EXTENSION_DESCENDING              = $08;
  EVERYTHING_SORT_TYPE_NAME_ASCENDING	              = $09;
  EVERYTHING_SORT_TYPE_NAME_DESCENDING              = $0a;
  EVERYTHING_SORT_DATE_CREATED_ASCENDING            = $0b;
  EVERYTHING_SORT_DATE_CREATED_DESCENDING	          = $0c;
  EVERYTHING_SORT_DATE_MODIFIED_ASCENDING	          = $0d;
  EVERYTHING_SORT_DATE_MODIFIED_DESCENDING          = $0e;
  EVERYTHING_SORT_ATTRIBUTES_ASCENDING              =	$0f;
  EVERYTHING_SORT_ATTRIBUTES_DESCENDING	            =	$10;
  EVERYTHING_SORT_FILE_LIST_FILENAME_ASCENDING      =	$11;
  EVERYTHING_SORT_FILE_LIST_FILENAME_DESCENDING	    =	$12;
  EVERYTHING_SORT_RUN_COUNT_ASCENDING	              =	$13;
  EVERYTHING_SORT_RUN_COUNT_DESCENDING              = $14;
  EVERYTHING_SORT_DATE_RECENTLY_CHANGED_ASCENDING	  =	$15;
  EVERYTHING_SORT_DATE_RECENTLY_CHANGED_DESCENDING  =	$16;
  EVERYTHING_SORT_DATE_ACCESSED_ASCENDING	          =	$17;
  EVERYTHING_SORT_DATE_ACCESSED_DESCENDING          =	$18;
  EVERYTHING_SORT_DATE_RUN_ASCENDING                = $19;
  EVERYTHING_SORT_DATE_RUN_DESCENDING	              =	$1a;

  EVERYTHING_REQUEST_FILE_NAME                           = $00000001;
  EVERYTHING_REQUEST_PATH	                               = $00000002;
  EVERYTHING_REQUEST_FULL_PATH_AND_FILE_NAME             = $00000004;
  EVERYTHING_REQUEST_EXTENSION                           = $00000008;
  EVERYTHING_REQUEST_SIZE	                               = $00000010;
  EVERYTHING_REQUEST_DATE_CREATED	                       = $00000020;
  EVERYTHING_REQUEST_DATE_MODIFIED                       = $00000040;
  EVERYTHING_REQUEST_DATE_ACCESSED                       = $00000080;
  EVERYTHING_REQUEST_ATTRIBUTES	                         = $00000100;
  EVERYTHING_REQUEST_FILE_LIST_FILE_NAME                 = $00000200;
  EVERYTHING_REQUEST_RUN_COUNT                           = $00000400;
  EVERYTHING_REQUEST_DATE_RUN	                           = $00000800;
  EVERYTHING_REQUEST_DATE_RECENTLY_CHANGED               = $00001000;
  EVERYTHING_REQUEST_HIGHLIGHTED_FILE_NAME               = $00002000;
  EVERYTHING_REQUEST_HIGHLIGHTED_PATH	                   = $00004000;
  EVERYTHING_REQUEST_HIGHLIGHTED_FULL_PATH_AND_FILE_NAME = $00008000;

  EVERYTHING_TARGET_MACHINE_X86	=	$01;
  EVERYTHING_TARGET_MACHINE_X64	=	$02;
  EVERYTHING_TARGET_MACHINE_ARM	=	$03;

const
{$IFDEF MSWINDOWS}
  everything32 = 'everything32.dll';
  everything64 = 'everything64.dll';
{$ENDIF}
{$IFDEF LINUX}
  everything32 = 'everything32.so';
  everything64 = 'everything64.so';
{$ENDIF}
  // write search state
  procedure Everything_SetSearchW(lpString: PWideChar); stdcall;
  procedure Everything_SetSearchA(lpString: PChar); stdcall;
  procedure Everything_SetMatchPath(bEnable: BOOL); stdcall;
  procedure Everything_SetMatchCase(bEnable: BOOL); stdcall;
  procedure Everything_SetMatchWholeWord(bEnable: BOOL); stdcall;
  procedure Everything_SetRegex(bEnable: BOOL); stdcall;
  procedure Everything_SetMax(dwMax: DWORD); stdcall;
  procedure Everything_SetOffset(dwOffset: DWORD); stdcall;
  procedure Everything_SetReplyWindow(hWnd: HWND); stdcall;
  procedure Everything_SetReplyID(dwId: DWORD); stdcall;
  procedure Everything_SetSort(dwSort: DWORD); stdcall;
  procedure Everything_SetRequestFlags(dwRequestFlags: DWORD); stdcall;

  // read search state
  function Everything_GetMatchPath: BOOL; stdcall;
  function Everything_GetMatchCase: BOOL; stdcall;
  function Everything_GetMatchWholeWord: BOOL; stdcall;
  function Everything_GetRegex: BOOL; stdcall;
  function Everything_GetMax: DWORD; stdcall;
  function Everything_GetOffset: DWORD; stdcall;
  function Everything_GetSearchA: PChar; stdcall;
  function Everything_GetSearchW: PWideChar; stdcall;
  function Everything_GetLastError: DWORD; stdcall;
  function Everything_GetReplyWindow: HWND; stdcall;
  function Everything_GetReplyID: DWORD; stdcall;
  function Everything_GetSort: DWORD; stdcall;
  function Everything_GetRequestFlags: DWORD; stdcall;

  // execute query
  function Everything_QueryA(bWait: BOOL): BOOL; stdcall;
  function Everything_QueryW(bWait: BOOL): BOOL; stdcall;

  // query reply
  function Everything_IsQueryReply(message: UINT; wParam: WPARAM; lParam: LPARAM; dwId: DWORD): BOOL; stdcall;

  // write result state
  procedure Everything_SortResultsByPath; stdcall;

  // read result state
  function Everything_GetNumFileResults: DWORD; stdcall;
  function Everything_GetNumFolderResults: DWORD; stdcall;
  function Everything_GetNumResults: DWORD; stdcall;
  function Everything_GetTotFileResults: DWORD; stdcall;
  function Everything_GetTotFolderResults: DWORD; stdcall;
  function Everything_GetTotResults: DWORD; stdcall;
  function Everything_IsVolumeResult(dwIndex: DWORD): BOOL; stdcall;
  function Everything_IsFolderResult(dwIndex: DWORD): BOOL; stdcall;
  function Everything_IsFileResult(dwIndex: DWORD ): BOOL; stdcall;
  function Everything_GetResultFileNameW(dwIndex: DWORD): PWideChar; stdcall;
  function Everything_GetResultFileNameA(dwIndex: DWORD): PChar; stdcall;
  function Everything_GetResultPathW(dwIndex: DWORD): PWideChar; stdcall;
  function Everything_GetResultPathA(dwIndex: DWORD): PChar; stdcall;
  function Everything_GetResultFullPathNameA(dwIndex: DWORD; buf: PChar; bufsize: DWORD): DWORD; stdcall;
  function Everything_GetResultFullPathNameW(dwIndex: DWORD; wbuf: PWideChar; wbuf_size_in_wchars: DWORD): DWORD; stdcall;
  function Everything_GetResultListSort: DWORD; stdcall;
  function Everything_GetResultListRequestFlags: DWORD; stdcall;
  function Everything_GetResultExtensionW(dwIndex: DWORD): PWideChar; stdcall;
  function Everything_GetResultExtensionA(dwIndex: DWORD): PChar; stdcall;
  function Everything_GetResultSize(dwIndex: DWORD; lpSize: PLongWord): BOOL; // Everything 1.4.1

  function Everything_GetResultDateCreated(dwIndex: DWORD; lpDateCreated: PFileTime): BOOL; // Everything 1.4.1
  function Everything_GetResultDateModified(dwIndex: DWORD; lpDateModified: PFileTime): BOOL; // Everything 1.4.1
  function Everything_GetResultDateAccessed(dwIndex: DWORD; lpDateAccessed: PFileTime): BOOL; // Everything 1.4.1
  function Everything_GetResultAttributes(dwIndex: DWORD): DWORD; // Everything 1.4.1
  function Everything_GetResultFileListFileNameW(dwIndex: DWORD): PChar; // Everything 1.4.1
  function Everything_GetResultFileListFileNameA(dwIndex: DWORD): PChar; // Everything 1.4.1
  function Everything_GetResultRunCount(dwIndex: DWORD): DWORD; // Everything 1.4.1
  function Everything_GetResultDateRun(dwIndex: DWORD; lpDateRun: PFileTime): BOOL;
  function Everything_GetResultDateRecentlyChanged(dwIndex: DWORD; lpDateRecentlyChanged: PFileTime): BOOL;

  function Everything_GetResultHighlightedFileNameW(dwIndex: DWORD): PWideChar; // Everything 1.4.1
  function Everything_GetResultHighlightedFileNameA(dwIndex: DWORD): PChar; // Everything 1.4.1
  function Everything_GetResultHighlightedPathW(dwIndex: DWORD): PWideChar; // Everything 1.4.1
  function Everything_GetResultHighlightedPathA(dwIndex: DWORD): PChar; // Everything 1.4.1
  function Everything_GetResultHighlightedFullPathAndFileNameW(dwIndex: DWORD): PWideChar; // Everything 1.4.1
  function Everything_GetResultHighlightedFullPathAndFileNameA(dwIndex: DWORD): PChar; // Everything 1.4.1

// reset state and free any allocated memory
  procedure Everything_Reset; stdcall;
  procedure Everything_CleanUp; stdcall;
//
  function Everything_GetMajorVersion: DWORD; stdcall;
  function Everything_GetMinorVersion: DWORD; stdcall;
  function Everything_GetRevision: DWORD; stdcall;
  function Everything_GetBuildNumber: DWORD;
  function Everything_Exit: BOOL;
  function Everything_MSIExitAndStopService(msihandle: Pointer): UINT;
  function Everything_MSIStartService(msihandle: Pointer): UINT;
  function Everything_IsDBLoaded: BOOL; // Everything 1.4.1
  function Everything_IsAdmin: BOOL; // Everything 1.4.1
  function Everything_IsAppData: BOOL; // Everything 1.4.1
  function Everything_RebuildDB: BOOL; // Everything 1.4.1
  function Everything_UpdateAllFolderIndexes: BOOL; // Everything 1.4.1
  function Everything_SaveDB: BOOL; // Everything 1.4.1
  function Everything_SaveRunHistory: BOOL; // Everything 1.4.1
  function Everything_DeleteRunHistory: BOOL; // Everything 1.4.1
  function Everything_GetTargetMachine: DWORD; // Everything 1.4.1
  function Everything_IsFastSort(sortType: DWORD): BOOL; // Everything 1.4.1.859
  function Everything_IsFileInfoIndexed(fileInfoType: DWORD): BOOL; // Everything 1.4.1.859
//
  function Everything_GetRunCountFromFileNameW(lpFileName: PWideChar): DWORD; // Everything 1.4.1
  function Everything_GetRunCountFromFileNameA(lpFileName: PChar): DWORD; // Everything 1.4.1
  function Everything_SetRunCountFromFileNameW(lpFileName: PWideChar; dwRunCount: DWORD): BOOL; // Everything 1.4.1
  function Everything_SetRunCountFromFileNameA(lpFileName: PChar; dwRunCount: DWORD): BOOL; // Everything 1.4.1
  function Everything_IncRunCountFromFileNameW(lpFileName: PWideChar): DWORD; // Everything 1.4.1
  function Everything_IncRunCountFromFileNameA(lpFileName: PChar): DWORD; // Everything 1.4.1

implementation

  procedure Everything_SetSearchW; external everything32 name 'Everything_SetSearchW';
  procedure Everything_SetSearchA; external everything32 name 'Everything_SetSearchA';
  procedure Everything_SetMatchPath; external everything32 name 'Everything_SetMatchPath';
  procedure Everything_SetMatchCase; external everything32 name 'Everything_SetMatchCase';
  procedure Everything_SetMatchWholeWord; external everything32 name 'Everything_SetMatchWholeWord';
  procedure Everything_SetRegex; external everything32 name 'Everything_SetRegex';
  procedure Everything_SetMax; external everything32 name 'Everything_SetMax';
  procedure Everything_SetOffset; external everything32 name 'Everything_SetOffset';
  procedure Everything_SetReplyWindow; external everything32 name 'Everything_SetReplyWindow';
  procedure Everything_SetReplyID; external everything32 name 'Everything_SetReplyID';
  procedure Everything_SetSort; external everything32 name 'Everything_SetSort'; // Everything 1.4.1
  procedure Everything_SetRequestFlags; external everything32 name 'Everything_SetRequestFlags'; // Everything 1.4.1

  function Everything_GetMatchPath; external everything32 name 'Everything_GetMatchPath';
  function Everything_GetMatchCase; external everything32 name 'Everything_GetMatchCase';
  function Everything_GetMatchWholeWord; external everything32 name 'Everything_GetMatchWholeWord';
  function Everything_GetRegex; external everything32 name 'Everything_GetRegex';
  function Everything_GetMax; external everything32 name 'Everything_GetMax';
  function Everything_GetOffset; external everything32 name 'Everything_GetOffset';
  function Everything_GetSearchA; external everything32 name 'Everything_GetSearchA';
  function Everything_GetSearchW; external everything32 name 'Everything_GetSearchW';
  function Everything_GetLastError; external everything32 name 'Everything_GetLastError';
  function Everything_GetReplyWindow; external everything32 name 'Everything_GetReplyWindow';
  function Everything_GetReplyID; external everything32 name 'Everything_GetReplyID';
  function Everything_GetSort; external everything32 name 'Everything_GetSort'; // Everything 1.4.1
  function Everything_GetRequestFlags; external everything32 name 'Everything_GetRequestFlags'; // Everything 1.4.1

  function Everything_GetResultDateCreated; external everything32 name 'Everything_GetResultDateCreated'; // Everything 1.4.1
  function Everything_GetResultDateModified; external everything32 name 'Everything_GetResultDateModified'; // Everything 1.4.1
  function Everything_GetResultDateAccessed; external everything32 name 'Everything_GetResultDateAccessed'; // Everything 1.4.1
  function Everything_GetResultAttributes; external everything32 name 'Everything_GetResultAttributes'; // Everything 1.4.1
  function Everything_GetResultFileListFileNameW; external everything32 name 'Everything_GetResultFileListFileNameW'; // Everything 1.4.1
  function Everything_GetResultFileListFileNameA; external everything32 name 'Everything_GetResultFileListFileNameA'; // Everything 1.4.1
  function Everything_GetResultRunCount; external everything32 name 'Everything_GetResultRunCount'; // Everything 1.4.1
  function Everything_GetResultDateRun; external everything32 name 'Everything_GetResultDateRun';
  function Everything_GetResultDateRecentlyChanged; external everything32 name 'Everything_GetResultDateRecentlyChanged';

  function Everything_GetResultHighlightedFileNameW; external everything32 name 'Everything_GetResultHighlightedFileNameW'; // Everything 1.4.1
  function Everything_GetResultHighlightedFileNameA; external everything32 name 'Everything_GetResultHighlightedFileNameA'; // Everything 1.4.1
  function Everything_GetResultHighlightedPathW; external everything32 name 'Everything_GetResultHighlightedPathW'; // Everything 1.4.1
  function Everything_GetResultHighlightedPathA; external everything32 name 'Everything_GetResultHighlightedPathA'; // Everything 1.4.1
  function Everything_GetResultHighlightedFullPathAndFileNameW; external everything32 name 'Everything_GetResultHighlightedFullPathAndFileNameW'; // Everything 1.4.1
  function Everything_GetResultHighlightedFullPathAndFileNameA; external everything32 name 'Everything_GetResultHighlightedFullPathAndFileNameA'; // Everything 1.4.1

  function Everything_QueryA; external everything32 name 'Everything_QueryA';
  function Everything_QueryW; external everything32 name 'Everything_QueryW';

  function Everything_IsQueryReply; external everything32 name 'Everything_IsQueryReply';

  procedure Everything_SortResultsByPath; external everything32 name 'Everything_SortResultsByPath';

  function Everything_GetNumFileResults; external everything32 name 'Everything_GetNumFileResults';
  function Everything_GetNumFolderResults; external everything32 name 'Everything_GetNumFolderResults';
  function Everything_GetNumResults; external everything32 name 'Everything_GetNumResults';

  function Everything_GetTotFileResults; external everything32 name 'Everything_GetTotFileResults';
  function Everything_GetTotFolderResults; external everything32 name 'Everything_GetTotFolderResults';
  function Everything_GetTotResults; external everything32 name 'Everything_GetTotResults';
  function Everything_IsVolumeResult; external everything32 name 'Everything_IsVolumeResult';
  function Everything_IsFolderResult; external everything32 name 'Everything_IsFolderResult';
  function Everything_IsFileResult; external everything32 name 'Everything_IsFileResult';
  function Everything_GetResultFileNameW; external everything32 name 'Everything_GetResultFileNameW';
  function Everything_GetResultFileNameA; external everything32 name 'Everything_GetResultFileNameA';
  function Everything_GetResultPathW; external everything32 name 'Everything_GetResultPathW';
  function Everything_GetResultPathA; external everything32 name 'Everything_GetResultPathA';
  function Everything_GetResultFullPathNameA; external everything32 name 'Everything_GetResultFullPathNameA';
  function Everything_GetResultFullPathNameW; external everything32 name 'Everything_GetResultFullPathNameW';
  function Everything_GetResultListSort; external everything32 name 'Everything_GetResultListSort'; // Everything 1.4.1
  function Everything_GetResultListRequestFlags; external everything32 name 'Everything_GetResultListRequestFlags'; // Everything 1.4.1
  function Everything_GetResultExtensionW; external everything32 name 'Everything_GetResultExtensionW'; // Everything 1.4.1
  function Everything_GetResultExtensionA; external everything32 name 'Everything_GetResultExtensionA'; // Everything 1.4.1
  function Everything_GetResultSize; external everything32 name 'Everything_GetResultSize'; // Everything 1.4.1

  procedure Everything_Reset; external everything32 name 'Everything_Reset';
  procedure Everything_CleanUp; external everything32 name 'Everything_CleanUp';

  function Everything_GetMajorVersion; external everything32 name 'Everything_GetMajorVersion';
  function Everything_GetMinorVersion; external everything32 name 'Everything_GetMinorVersion';
  function Everything_GetRevision; external everything32 name 'Everything_GetRevision';
  function Everything_GetBuildNumber; external everything32 name 'Everything_GetBuildNumber';
  function Everything_Exit; external everything32 name 'Everything_Exit';
  function Everything_MSIExitAndStopService; external everything32 name 'Everything_MSIExitAndStopService';
  function Everything_MSIStartService; external everything32 name 'Everything_MSIStartService';
  function Everything_IsDBLoaded; external everything32 name 'Everything_IsDBLoaded'; // Everything 1.4.1
  function Everything_IsAdmin; external everything32 name 'Everything_IsAdmin'; // Everything 1.4.1
  function Everything_IsAppData; external everything32 name 'Everything_IsAppData'; // Everything 1.4.1
  function Everything_RebuildDB; external everything32 name 'Everything_RebuildDB'; // Everything 1.4.1
  function Everything_UpdateAllFolderIndexes; external everything32 name 'Everything_UpdateAllFolderIndexes'; // Everything 1.4.1
  function Everything_SaveDB; external everything32 name 'Everything_SaveDB'; // Everything 1.4.1
  function Everything_SaveRunHistory; external everything32 name 'Everything_SaveRunHistory'; // Everything 1.4.1
  function Everything_DeleteRunHistory; external everything32 name 'Everything_DeleteRunHistory'; // Everything 1.4.1
  function Everything_GetTargetMachine; external everything32 name 'Everything_GetTargetMachine'; // Everything 1.4.1
  function Everything_IsFastSort; external everything32 name 'Everything_IsFastSort'; // Everything 1.4.1.859
  function Everything_IsFileInfoIndexed; external everything32 name 'Everything_IsFileInfoIndexed'; // Everything 1.4.1.859

  function Everything_GetRunCountFromFileNameW; external everything32 name 'Everything_GetRunCountFromFileNameW'; // Everything 1.4.1
  function Everything_GetRunCountFromFileNameA; external everything32 name 'Everything_GetRunCountFromFileNameA'; // Everything 1.4.1
  function Everything_SetRunCountFromFileNameW; external everything32 name 'Everything_SetRunCountFromFileNameW'; // Everything 1.4.1
  function Everything_SetRunCountFromFileNameA; external everything32 name 'Everything_SetRunCountFromFileNameA'; // Everything 1.4.1
  function Everything_IncRunCountFromFileNameW; external everything32 name 'Everything_IncRunCountFromFileNameW'; // Everything 1.4.1
  function Everything_IncRunCountFromFileNameA; external everything32 name 'Everything_IncRunCountFromFileNameA'; // Everything 1.4.1

end.



