unit PAK_DBEngine;

interface

const
  N_SQLITE_OK = 0;
  N_SQLITE_ERROR = 1;
  N_SQLITE_ROW = 100;
  N_SQLITE_DONE = 101;

  N_SQLITE_INTEGER = 1;
  N_SQLITE_FLOAT = 2;
  N_SQLITE_TEXT = 3;
  N_SQLITE_BLOB = 4;
  N_SQLITE_NULL = 5;

  {$IFDEF DEBUG}
    DBEngineDll = 'Sqlite3CodecLibForDelphi.dll'; //_d!!!!!!!!!!!
  {$ELSE}
    DBEngineDll = 'Sqlite3CodecLibForDelphi.dll';
  {$ENDIF}
type
  TCallBack_S3 = function(NotUsed:Pointer; argc:Integer; argv: PPAnsiChar; azColName: PPAnsiChar):Integer;cdecl;

  function CheckPakDataFileExists:Boolean; cdecl; external DBEngineDll;
  //function CheckPakEmerFileExists:Boolean; cdecl; external DBEngineDll;
  function GetLastPakError:Integer;cdecl; external DBEngineDll;
  function CheckPakPassword(const token:PAnsiChar):Boolean; cdecl; external DBEngineDll;
  function CheckIfFirstUsePak:Boolean; cdecl; external DBEngineDll;
  function SQL_Exec(sSql: PAnsiChar; fnCallBack:TCallBack_S3; pszErrMsg:PPAnsichar):Boolean;cdecl; external DBEngineDll;
  function SQL_PrepareV2(const zSql:PAnsiChar; nByte, iWhich: Integer):Integer;cdecl;external DBEngineDll;
  function SQL_Finalize(iWhich: Integer):Integer;cdecl;external DBEngineDll;
  function SQL_Reset(iWhich: Integer):Integer;cdecl;external DBEngineDll;
  function SQL_Step(iWhich: Integer):Integer;cdecl;external DBEngineDll;
  function SQL_BindInt(iWhich: Integer; iCol, iVal:Integer):Integer;cdecl;external DBEngineDll;
  function SQL_BindText(iWhich: Integer; iCol:Integer; const szVal:PAnsiChar; iValLen:Integer):Integer;cdecl;external DBEngineDll;
  function SQL_ErrMsg(iWhich: Integer):PAnsiChar;cdecl;external DBEngineDll;
  function SQL_ColumnCount(iWhich: Integer):Integer;cdecl;external DBEngineDll;
  function SQL_ColumnType(iWhich,iCol:Integer):Integer;cdecl;external DBEngineDll;
  function SQL_ColumnInt(iWhich,iCol:Integer):Integer;cdecl;external DBEngineDll;
  function SQL_ColumnDouble(iWhich,iCol:Integer):Double;cdecl;external DBEngineDll;
  function SQL_ColumnText(iWhich, iCol:Integer):PAnsiChar;cdecl;external DBEngineDll;
  function SQL_Rekey(ANewKey:Pointer; iLen:Integer):Integer;cdecl;external DBEngineDll;
implementation

end.
