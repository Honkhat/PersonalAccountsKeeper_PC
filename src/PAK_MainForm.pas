﻿unit PAK_MainForm;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_layouts, vg_objects, vg_effects, vg_ani, vg_listbox,
  vg_extctrls, vg_controls, vg_textbox, Menus, PAK_Language, PAK_AcCardFrm,
  vg_memo, PAK_DBEngine, ExtCtrls, vg_grid, IniFiles, vg_treeview, Contnrs{TObjectStack},
  ShellAPI, aboutboxfrm, PAK_DonateForm;

const
  N_SHORT4MEASURE = 16;//result shortage by Canvas.MeasureText
  N_PADDR_PWDCIRCLE = 5;//Padding.Right for circles of pwd mask
  N_WIDTH_PWDCIRCLE = 8;//width of circles for pwd mask
  N_LEN_ERRMSG = 200;//length of globally used error message
  F_SCALE_WHEELICON = 1.3;

  S_FOLDER_TB = 'PAK_Folder';//Folder table name
  S_AC_TB = 'PAK_AC';//Account table name
  //S_CFG_TB = 'PAK_CFG';//Configuration table name
  S_IDREUSE_TB = 'PAK_ID_REUSE';//for id reuse
  S_PWDSTAR = '************';//MASK FOR PASSWORD
  S_INI_FILE = 'cfg'; //.ini file name
  S_INI_SECTION = 'PAK_CFG';//PAK CFG SECTION FOR .INI FILE
  S_INI_NODE_LANG = 'LANG'; //LANGUAGE NODE
  {
  Some design notes:
  1. store the deleted items for one month;
  }
type
  TPopupMenuType = (pmtFolder, pmtFile);
  TAcViewMode = (avmNew, avmView);
  //TModuleType = (mtAcView, mtBrowse, mtSetting);//No longer in use as ShowPAKModul2 is born;
  TMenuItemTag = (mitOpen, mitEdit, mitRename, mitDelete, mitMove, mitDetail, mitVstUrl);
  PTvgLayout = ^TvgLayout;
  PTvgTreeItem = ^TvgTreeViewItem;
  PTvgListBoxItem = ^TvgListBoxItem;
  PTreeDataModel = ^TTreeDataModel;
  TTreeDataModel = record
    Parent: PTreeDataModel;
    Chilren: array of PTreeDataModel;
    Index, ParentIdx:Integer;
    Name: string;
  end;

  TPAKMainFrm = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    LayoutLogo: TvgLayout;
    LayoutTop: TvgLayout;
    ContentContainer: TvgRectangle;
    PathP: TvgPath;
    LayoutAppNameEn: TvgLayout;
    Pathe: TvgPath;
    Pathr: TvgPath;
    Paths: TvgPath;
    Patho: TvgPath;
    Pathn: TvgPath;
    Patha: TvgPath;
    Pathl: TvgPath;
    PathA_: TvgPath;
    PathC: TvgPath;
    PathC2: TvgPath;
    PathO2: TvgPath;
    PathU: TvgPath;
    PathN2: TvgPath;
    PathT: TvgPath;
    PathS2: TvgPath;
    PathK: TvgPath;
    PathE2: TvgPath;
    PathE3: TvgPath;
    PathP2: TvgPath;
    PathE4: TvgPath;
    PathR2: TvgPath;
    LayoutAppName: TvgLayout;
    vglpsClose: TvgEllipse;
    PathX: TvgPath;
    FloatAnimation1: TvgFloatAnimation;
    FloatAnimation2: TvgFloatAnimation;
    RcOperation: TvgRectangle;
    RcClps: TvgRectangle;
    FloatAnimation7: TvgFloatAnimation;
    FloatAnimation8: TvgFloatAnimation;
    RcExpand: TvgRectangle;
    RcOprWidthOut: TvgFloatAnimation;
    LayoutOpr: TvgLayout;
    RcBtnAdd: TvgRectangle;
    RcVert: TvgRectangle;
    RcHorz: TvgRectangle;
    FloatAnimation3: TvgFloatAnimation;
    FloatAnimation4: TvgFloatAnimation;
    RcOprWidthClps: TvgFloatAnimation;
    RcBtnBrowse: TvgRectangle;
    BtnBrowseImg: TvgPath;
    FloatAnimation5: TvgFloatAnimation;
    FloatAnimation6: TvgFloatAnimation;
    RcBtnSetting: TvgRectangle;
    BtnSettingImg: TvgPath;
    FloatAnimation9: TvgFloatAnimation;
    FloatAnimation10: TvgFloatAnimation;
    LayoutExplorer: TvgLayout;
    ExtremeStyleMy: TvgResources;
    GlowEffect1: TvgGlowEffect;
    PathRearLegL: TvgPath;
    LayBtns4Browser: TvgLayout;
    LayBottom: TvgLayout;
    BtnNewFolder: TvgBitmapButton;
    BtnParentFolder: TvgBitmapButton;
    TxtBrwCurDir: TvgText;
    EditSearch: TvgTextBoxClearBtn;
    BtnSearch: TvgBitmapButton;
    TxtVersion: TvgText;
    RcBottom: TvgRectangle;
    RcArcLeft: TvgRectangle;
    PathDonate: TvgPath;
    PathAuthor: TvgPath;
    RcArcR: TvgRectangle;
    PathAuthorEff: TvgInnerGlowEffect;
    PathDonateEff: TvgInnerGlowEffect;
    RcAuthor: TvgRectangle;
    RcDonate: TvgRectangle;
    PathClps: TvgPath;
    Rsc001: TvgResources;
    lstFolder: TvgListBox;
    PathFolder: TvgPath;
    PathFile: TvgPath;
    Image1: TvgImage;
    ImageFolder32: TvgImage;
    ImageFile32: TvgImage;
    pm4Folder: TPopupMenu;
    pm4File: TPopupMenu;
    EditShare: TvgRoundTextBox;
    LayoutBrowser: TvgLayout;
    LayoutAcViewer: TvgLayout;
    TxtAcInfoTip: TvgText;
    LayoutCardContent: TvgLayout;
    LayoutCardYESNO: TvgLayout;
    BtnPrevCard: TvgScrollArrowLeft;
    BtnNextCard: TvgScrollArrowRight;
    LstCardInfo: TvgListBox;
    GlowEffect0: TvgGlowEffect;
    GlowEffect2: TvgGlowEffect;
    ItemAcCardUsr: TvgListBoxItem;
    LayoutSetting: TvgLayout;
    ImgUr: TvgImage;
    TxtUsrTip: TvgText;
    TxtUsr: TvgText;
    ItemAcCardPwd: TvgListBoxItem;
    ImgPwd: TvgImage;
    TxtPwdTip: TvgText;
    ItemAcCardUrl: TvgListBoxItem;
    ImgUrl: TvgImage;
    TxtUrlTip: TvgText;
    TxtUrl: TvgText;
    ItemAcCardFolder: TvgListBoxItem;
    ImgGroup: TvgImage;
    TxtFolderTip: TvgText;
    TxtFolder: TvgText;
    ItemAcCardNoteShort: TvgListBoxItem;
    ImgNote1: TvgImage;
    TxtNoteShortTip: TvgText;
    TxtNoteShort: TvgText;
    ItemAcCardNoteLong: TvgListBoxItem;
    LayNoteLongTop: TvgLayout;
    ImgNote2: TvgImage;
    TxtNoteLongTip: TvgText;
    BtnSaveAc: TvgCornerButton;
    BtnCancelAc: TvgCornerButton;
    TxtPwd: TvgText;
    EditNoteLong: TvgMemo;
    LayoutPwdMask: TvgLayout;
    EdtNoteLongEffect: TvgGlowEffect;
    LogInPopup: TvgMessagePopup;
    BtnLogIn: TvgButton;
    PathLock: TvgPath;
    EditPakPwd: TvgRoundTextBox;
    TxtPakPwdTip: TvgText;
    BtnCancelLogIn: TvgButton;
    LayBtmLogIn: TvgLayout;
    LayCfmPwdLogIn: TvgLayout;
    TxtCfmPakPwd: TvgText;
    EditCfmPwdLogIn: TvgRoundTextBox;
    LayPwdLogIn: TvgLayout;
    vgcrclCircle1: TvgCircle;
    BtnSettingWheelCenter: TvgCircle;
    BtnChangePwd: TvgPath;
    BtnHelp: TvgPath;
    BtnSOS: TvgPath;
    BtnSoftAuthor: TvgPath;
    BtnOtherSetting: TvgPath;
    RcCoverChangePwd: TvgRectangle;
    RcCoverHelp: TvgRectangle;
    EffChangePwd: TvgGlowEffect;
    RcCoverOtherSetting: TvgRectangle;
    RcCoverSoftAuthor: TvgRectangle;
    RcCoverSOS: TvgRectangle;
    BtnBack: TvgBitmapButton;
    BtnNewAc: TvgBitmapButton;
    PathNewAc: TvgPath;
    LayBrwListArea: TvgLayout;
    GridBrwAc: TvgGrid;
    ColBrwAcUsr: TvgColumn;
    ColBrwAcPwd: TvgColumn;
    ColBrwAcUrl: TvgColumn;
    SplitterBrw: TvgSplitter;
    PopupDirTree: TvgPopup;
    TreeDir: TvgTreeView;
    RcDirTreeBk: TvgRectangle;
    TxtDirTreeTip: TvgText;
    LayDirTreeBtns: TvgLayout;
    BtnDirReeCancel: TvgButton;
    BtnDirTreeOK: TvgButton;
    TreeItemRoot: TvgTreeViewItem;
    LaySetModule: TvgLayout;
    laySetLOCK: TvgLayout;
    laySetFAQ: TvgLayout;
    laySetSOS: TvgLayout;
    laySetSet: TvgLayout;
    TxtFaq01_Q: TvgText;
    TxtFaq01_A: TvgText;
    TxtFaq02_Q: TvgText;
    TxtFaq02_A: TvgText;
    TxtFaq03_Q: TvgText;
    TxtFaq03_A: TvgText;
    TxtFaq04_Q: TvgText;
    TxtFaq04_A: TvgText;
    TxtFaq05_Q: TvgText;
    TxtFaq05_A: TvgText;
    LaySetLock1: TvgLayout;
    TxtSetLockNewPwdTip: TvgText;
    EditSetLockNewPwd1: TvgTextBox;
    LaySetLock2: TvgLayout;
    TxtSetLockPwdCfmTip: TvgText;
    EditSetLockPwd2: TvgTextBox;
    BtnSetLockOK: TvgButton;
    BtnSetLockReset: TvgButton;
    ImgSetSOS_dog: TvgImage;
    TxtSetSOS_oops: TvgText;
    TxtSOS01: TvgText;
    TxtSOS02: TvgText;
    TxtSOS03: TvgText;
    LaySetSet01: TvgLayout;
    TxtSetLangTip: TvgText;
    ComboSetLang: TvgStringComboBox;
    procedure vglpsCloseMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure RcExpandMouseEnter(Sender: TObject);
    procedure RcClpsClick(Sender: TObject);
    procedure RcOprWidthClpsFinish(Sender: TObject);
    procedure RcOprWidthOutFinish(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PathRearLegLClick(Sender: TObject);
    procedure RcAuthorMouseEnter(Sender: TObject);
    procedure RcAuthorMouseLeave(Sender: TObject);
    procedure RcDonateMouseEnter(Sender: TObject);
    procedure RcDonateMouseLeave(Sender: TObject);
    procedure BtnNewFolderClick(Sender: TObject);
    procedure lstBrwFolderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure BtnParentFolderClick(Sender: TObject);
    procedure EditShareKillFocus(Sender: TObject);
    procedure EditShareKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure OnMenuItem4FolderClick(Sender: TObject);
    procedure OnMenuItem4FileClick(Sender: TObject);
    procedure RcBtnAddClick(Sender: TObject);
    procedure RcBtnBrowseClick(Sender: TObject);
    procedure RcBtnSettingClick(Sender: TObject);
    procedure TxtUsrClick(Sender: TObject);
    procedure TxtUrlClick(Sender: TObject);
    procedure TxtFolderClick(Sender: TObject);
    procedure TxtNoteShortClick(Sender: TObject);
    procedure LayoutPwdMaskMouseEnter(Sender: TObject);
    procedure TxtPwdClick(Sender: TObject);
    procedure TxtPwdMouseLeave(Sender: TObject);
    procedure ImgNote2Click(Sender: TObject);
    procedure EditNoteLongKillFocus(Sender: TObject);
    procedure BtnSaveAcClick(Sender: TObject);
    procedure BtnCancelAcClick(Sender: TObject);
    procedure BtnLogInClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnCancelLogInClick(Sender: TObject);
    procedure ClosePAK;
    procedure EditPakPwdKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EditCfmPwdLogInKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure BtnSettingWheelCenterMouseEnter(Sender: TObject);
    procedure BtnSettingWheelCenterMouseLeave(Sender: TObject);
    procedure RcCoverChangePwdMouseEnter(Sender: TObject);
    procedure RcCoverChangePwdMouseLeave(Sender: TObject);
    procedure RcCoverHelpMouseEnter(Sender: TObject);
    procedure RcCoverHelpMouseLeave(Sender: TObject);
    procedure RcCoverOtherSettingMouseEnter(Sender: TObject);
    procedure RcCoverOtherSettingMouseLeave(Sender: TObject);
    procedure RcCoverSoftAuthorMouseEnter(Sender: TObject);
    procedure RcCoverSoftAuthorMouseLeave(Sender: TObject);
    procedure RcCoverSOSMouseEnter(Sender: TObject);
    procedure RcCoverSOSMouseLeave(Sender: TObject);
    procedure BtnSettingWheelCenterClick(Sender: TObject);
    procedure RcCoverChangePwdClick(Sender: TObject);
    procedure GridBrwAcMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure ColBrwAcUsrMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure GridBrwAcGetValue(Sender: TObject; const Col, Row: Integer;
      var Value: Variant);
    procedure GridBrwAcMouseMove(Sender: TObject; Shift: TShiftState; X, Y, Dx,
      Dy: Single);
    procedure GridBrwAcMouseLeave(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnNewAcClick(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure RcAuthorClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BtnBackClick(Sender: TObject);
    procedure EditNoteLongKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure BtnDirReeCancelClick(Sender: TObject);
    procedure BtnDirTreeOKClick(Sender: TObject);
    procedure SplitterBrwDragIng(Sender: TObject);
    procedure lstFolderDblClick(Sender: TObject);
    procedure BtnNextCardClick(Sender: TObject);
    procedure BtnPrevCardClick(Sender: TObject);
    procedure EditSearchKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure RcCoverHelpClick(Sender: TObject);
    procedure RcCoverOtherSettingClick(Sender: TObject);
    procedure RcCoverSoftAuthorClick(Sender: TObject);
    procedure RcCoverSOSClick(Sender: TObject);
    procedure RcDonateClick(Sender: TObject);
    procedure ComboSetLangChange(Sender: TObject);
    procedure BtnSetLockResetClick(Sender: TObject);
    procedure BtnSetLockOKClick(Sender: TObject);
  private
    { Private declarations }
    FCurPakModule: PTvgLayout;//current show pak module;
    FCurSetSubMod: PTvgLayout;//current sub module of LaySetting;
    FLangPointer: PString; //lang array pointer
    FCurLangIdx: TLanguageType;//current language index
    FEditShareKillFoucusCalled: Boolean;//avoid KillFocus() being called twice
    FEdtNoteLongTxtChgd: Boolean;
    FEdtShareTxtChgd:Boolean;//if text in EdtShare changed
    FEditShareValueValid:Boolean;//if the input text is valid
    FFstUsePak:Boolean;//first use PAK
    FLastHoverAcRow: Integer;
    FIniFile: TIniFile;
    FCurDirInTree: TvgTreeViewItem;//if defined as PTvgTreeViewItem, not work..
    FCurViewAcIdx: Integer;//tag for AC-Browsing mode;
    FAcViewMode:TAcViewMode;
    procedure DoApplyResource(Sender: TObject);
    procedure InitAcCardInfo;
    procedure InitPopupMenu4Folder;
    procedure InitPopupMenu4File;
    procedure LanguageChanged(iNewIdx: TLanguageType);

    procedure ShowEditShare(LstItem: TvgListBoxItem;ShowTxt: string);
    //procedure ShowPAKModule(typename: TModuleType);
    procedure ShowPAKModul2(AModule: PTvgLayout);//Better than ShowPAKModule;
    procedure ShowSetSubmodule(AModule: PTvgLayout);
    procedure ApplyMode4LayAcViewer(mode: TAcViewMode);
    procedure MakeTvgTextFit(TxtCtrl: TvgText; MaxWidth:Single);
    procedure AssignAcCardItem(TxtCtrl: TvgText;AText: string);//call MakeTvgTextFit inside
    procedure MakePwdMaskFit(iWidth: Single);
    procedure AcCardInfoChanged;
    procedure OnLayoutSettingLeave;
    procedure ResetLastPwdToMask;
    procedure FormTreeRecursive(AItemModel:PTreeDataModel; AParentItem:PTvgTreeItem);
    procedure RefreshGridAC; //Show all accounts under current dir;
    procedure ForceGridACDataToUI;
    procedure SwitchAcCard(iDirection:Integer);

    function LoadAllFoldersToTree:Boolean;
    function CreateBasicTb:Boolean;
    function SyncFolderToDb(LstItem: PTvgListBoxItem; AName:string):Boolean;
    function CheckFolderNameValid(AName: string):Boolean;
    function CheckShareEditValid(ATarget: TvgVisualObject):Boolean;
    function CreateLstFderItem: TvgListBoxItem;
    function CheckAcInfoStored:Boolean;
    function GetFullPathByTreeNode(ATreeNode: PTvgTreeItem):string;
    function GetDirTreeItmByID(iID: Integer): TvgTreeViewItem;
    function GetNewID(bForFolder:Boolean): Integer;
    function GetRealPwdIdx:Integer;
    function SetCurDir(AFolder:TvgTreeViewItem; bGoParent:Boolean):Boolean;
    function DeleteFolderInDB(AFolderDel:TvgTreeViewItem):Boolean;
    function DeleteAc(iID: Integer):Boolean;
  public
    { Public declarations }
    procedure OnHeaderBrwAcClick(Sender: TObject);
    function  GetLangStr(index:TLangStrIndex):string;
  end;

  function FN_CB_S3(NotUsed:Pointer; argc:Integer; argv: PPAnsiChar; azColName: PPAnsiChar):Integer;cdecl;
  procedure EmptyDataSqlResult;
  procedure EmptyDataGridAC;
var
  PAKMainFrm: TPAKMainFrm;
  DataSqlResult: array of array of Variant;
  DataGridAC: array of array of Variant;
  G_PErrMsg: PAnsiChar;

implementation

{$R *.dfm}

procedure EmptyDataSqlResult;
var
  i: Integer;
begin
  for i := 0 to High(DataSqlResult) do
  begin
    SetLength(DataSqlResult[i], 0);
  end;
  SetLength(DataSqlResult, 0);
end;

procedure EmptyDataGridAC;
var
  i: Integer;
begin
  for i := 0 to High(DataGridAC) do
  begin
    SetLength(DataGridAC[i], 0);
  end;
  SetLength(DataGridAC, 0);
end;

function FN_CB_S3(NotUsed:Pointer; argc:Integer; argv: PPAnsiChar; azColName: PPAnsiChar):Integer;
var
  i, iRow: Integer;
begin
  //callback function for sqlite3 used by dll file which is generated by VS
  if argc < 1 then //"SELECT" OR "CREATE" OR ERROR
  begin
    EmptyDataSqlResult;
  end
  else begin
    iRow := Length(DataSqlResult); //Empty before call SQL_Exec()!!
    SetLength(DataSqlResult, iRow + 1);
    SetLength(DataSqlResult[iRow], argc);

    for i := 0 to argc - 1 do
    begin
      DataSqlResult[iRow][i] := AnsiString(argv^);

//      sTmp := Format('%s : %s', [argv^, azColName^]);
//      MessageBoxA(0, PAnsiChar(sTmp), 'Test', MB_OK);

      Inc(argv);
      //Inc(azColName);
    end;
  end;

  Result := 0;
end;

procedure TPAKMainFrm.AcCardInfoChanged;
begin
  if not BtnSaveAc.Visible then
    BtnSaveAc.Visible := True;
  if not BtnSaveAc.Enabled then
    BtnSaveAc.Enabled := True;
end;

procedure TPAKMainFrm.ApplyMode4LayAcViewer(mode: TAcViewMode);
begin
  FAcViewMode := mode;
  BtnCancelAc.Visible := True;
  BtnSaveAc.Visible := True;
  BtnSaveAc.Enabled := False;
  if avmNew = mode then
  begin
    BtnPrevCard.Visible := False;
    BtnNextCard.Visible := False;
    InitAcCardInfo;//"Click here to edit"
  end
  else if avmView = mode then
  begin
    BtnPrevCard.Visible := True;
    BtnNextCard.Visible := True;

    //assign values with FCurViewAcIdx..
    SwitchAcCard(0);
  end;
end;

procedure TPAKMainFrm.AssignAcCardItem(TxtCtrl: TvgText; AText: string);
begin
  TxtCtrl.Text := AText;
  if Length(AText) < 1 then
  begin
    Exit;
  end;
//  with TxtCtrl.Parent as TvgListBoxItem do
//  begin
    MakeTvgTextFit(TxtCtrl, Width - 140);
  //end;
end;

procedure TPAKMainFrm.BtnBackClick(Sender: TObject);
begin
  if not CheckShareEditValid(TxtAcInfoTip) then
    Exit;

  if not CheckAcInfoStored then
    Exit;
  ShowPAKModul2(@LayoutBrowser);//ShowPAKModule(mtBrowse);
end;

procedure TPAKMainFrm.BtnCancelAcClick(Sender: TObject);
begin
  if EditShare.Visible then
  begin
    FEditShareKillFoucusCalled := True;
    EditShare.Visible := False;
    FEditShareValueValid := True;
  end;
  if avmNew = FAcViewMode then
    InitAcCardInfo
  else
    SwitchAcCard(0);
  BtnSaveAc.Enabled := False;
end;

procedure TPAKMainFrm.BtnCancelLogInClick(Sender: TObject);
begin
  LogInPopup.ModalResult := mrCancel;
  vgScene1.Visible := False;
  ClosePAK;
end;

procedure TPAKMainFrm.BtnDirReeCancelClick(Sender: TObject);
begin
  PopupDirTree.ClosePopup;
end;

procedure TPAKMainFrm.BtnDirTreeOKClick(Sender: TObject);
var
  sPath:string;
  LstItm: TvgListBoxItem;
  tmpTreeItm, TreeItm: TvgTreeViewItem;
  sSql: AnsiString;
  I: Integer;
begin
  TreeItm := TreeDir.Selected;
  if nil <> TreeItm then
  begin
    //set TxtFolder text..
    sPath := GetFullPathByTreeNode(@TreeItm);

    if LayoutAcViewer.Visible then
    begin
      TxtFolder.Tag := TreeItm.Tag;
      if not SameStr(sPath, TxtFolder.Text) then
      begin
        AssignAcCardItem(TxtFolder, sPath);
        BtnSaveAc.Enabled := True;
      end;
    end
    else if LayoutBrowser.Visible then
    begin
      //check if location changed..
      LstItm := lstFolder.Selected;
      if (nil <> LstItm) and (FCurDirInTree.Tag <> TreeItm.Tag) then
      begin
        //update db..
        SQL_Exec('BEGIN;', nil, nil);
        sSql := 'UPDATE '+S_FOLDER_TB+' SET ParentIndex=' + IntToStr(TreeItm.Tag)+
                ' WHERE ID='+IntToStr(LstItm.Tag)+';';
        if not SQL_Exec(PAnsiChar(sSql), FN_CB_S3, @G_PErrMsg) then
        begin
          MessagePopup(GetLangStr(lsiError), G_PErrMsg, vgMessageError, [vgButtonOK],
                  vgScene1, TxtBrwCurDir, True);
          Exit;
        end;
        SQL_Exec('COMMIT;', nil, nil);
        //update DirTree..
        for I := 0 to FCurDirInTree.Count - 1 do
        begin
          tmpTreeItm := FCurDirInTree.ItemByIndex(I);
          if LstItm.Tag = tmpTreeItm.Tag then
          begin
            tmpTreeItm.Parent := TreeItm;
            Break;
          end;
        end;
        LstItm.Free;
      end;
    end;
  end;
  PopupDirTree.ClosePopup;
end;

procedure TPAKMainFrm.BtnLogInClick(Sender: TObject);
var
  sToken: string;
begin
  BtnLogIn.Enabled := False;//to handle "crazy-click" situation

  //PASSWORD CANN'T BE EMPTY!!
  if Length(EditPakPwd.Text) < 3 then //pwd requirement: >=3
  begin
    LogInPopup.Enabled := False;
    MessagePopup(GetLangStr(lsiError), GetLangStr(lsiPwdTooShort), vgMessageError, [vgButtonYes],
          vgScene1, TxtPakPwdTip);
    LogInPopup.Enabled := True;
    BtnLogIn.Enabled := True;
    EditPakPwd.Text := '';
    EditPakPwd.SetFocus;
    Exit;
  end;

  sToken := EditPakPwd.Text;

  if FFstUsePak then //check if the passwords are the same
  begin
    if not SameText(sToken, EditCfmPwdLogIn.Text)then
    begin
      LogInPopup.Enabled := False;
      MessagePopup(GetLangStr(lsiError), GetLangStr(lsiPwdNotMatch), vgMessageError, [vgButtonYes],
            vgScene1, TxtPakPwdTip);
      LogInPopup.Enabled := True;
      EditPakPwd.Text := '';
      EditPakPwd.SetFocus;
    end
    else begin //set PAK password
      if not CheckPakPassword(PAnsiChar(AnsiString(sToken))) then
      begin
        LogInPopup.Enabled := False;
        MessagePopup(GetLangStr(lsiError), 'Error Code:'+IntToStr(GetLastPakError)+'. Or you can try to run it as administrator.', vgMessageError, [vgButtonYes],
            vgScene1, TxtPakPwdTip);
        LogInPopup.Enabled := True;
      end
      else begin
        LogInPopup.ModalResult := mrOk;//set pwd success
      end;
    end;
  end
  else begin //not first time to use PAK
    if not CheckPakPassword(PAnsiChar(AnsiString(sToken))) then
    begin
      LogInPopup.Enabled := False;
        MessagePopup(GetLangStr(lsiError), GetLangStr(lsiWrongPwd), vgMessageError, [vgButtonYes],
            vgScene1, TxtPakPwdTip);
      LogInPopup.Enabled := True;
      EditPakPwd.Text := '';
      EditPakPwd.SetFocus;
    end
    else
    begin
      LogInPopup.ModalResult := mrOk;//validate pwd success
    end;
  end;
  BtnLogIn.Enabled := True; //function complete

end;

procedure TPAKMainFrm.BtnNewAcClick(Sender: TObject);
begin
  if not CheckShareEditValid(TxtBrwCurDir) then
    Exit;

  ApplyMode4LayAcViewer(avmNew);
  ShowPAKModul2(@LayoutAcViewer);//ShowPAKModule(mtAcView);
end;

procedure TPAKMainFrm.BtnNewFolderClick(Sender: TObject);
var
  Item: TvgListBoxItem;
  sSql: AnsiString;
  iTmp: Integer;
begin
  if not CheckShareEditValid(TxtBrwCurDir) then
    Exit;

  //create custom list item
  Item := CreateLstFderItem;
  iTmp := GetNewID(True);
  if iTmp < 0 then
  begin
    Item.Destroy;
    Exit;
  end;

  Item.Tag := iTmp;//0 for ROOT; start from 1;
  Item.TagString := '0';//0:New;1:Old;

  ShowEditShare(Item, GetLangStr(lsiNewFolder));
end;

procedure TPAKMainFrm.BtnNextCardClick(Sender: TObject);
begin
  SwitchAcCard(1);
end;

procedure TPAKMainFrm.BtnParentFolderClick(Sender: TObject);
var
  sSql: AnsiString;
begin
  if not CheckShareEditValid(TxtBrwCurDir) then
    Exit;

  SetCurDir(TvgTreeViewItem(FCurDirInTree.Parent), True);
end;

procedure TPAKMainFrm.BtnPrevCardClick(Sender: TObject);
begin
  SwitchAcCard(-1);
end;

procedure TPAKMainFrm.BtnSaveAcClick(Sender: TObject);
var
  iTmp, iRow:Integer;
  bOK: Boolean;
  sClkEdt, sUrl, sNote1, sNote2: string;
  sSql: AnsiString;
  TxtItm: TvgTextBox;
begin
  BtnSaveAc.Enabled := False; //avoid maniac-click;
  if not CheckShareEditValid(TxtAcInfoTip) then
    Exit;
  //Save Ac Info..
  //NULL != User && NULL != PWD
  bOK := True;
  sClkEdt := GetLangStr(lsiClickEdt);
  if TxtUsr.Tag < 1 then  //TxtUsr Judgement
    bOK := False
  else if nil <> StrPos(PAnsiChar(AnsiString(sClkEdt)), PAnsiChar(AnsiString(TxtUsr.Text))) then
      bOK := False;

  if not bOK then
  begin
    MessagePopup(GetLangStr(lsiError), GetLangStr(lsiUsrEmpty), vgMessageError,
        [vgButtonOK], vgScene1, TxtUsr, True);
    Exit;
  end;

  if TxtPwd.Tag < 1 then  //TxtPwd Judgement
    bOK := False
  else if nil <> StrPos(PAnsiChar(AnsiString(sClkEdt)), PAnsiChar(AnsiString(TxtPwd.Text))) then
    bOK := False;
  if not bOK then
  begin
    MessagePopup(GetLangStr(lsiError), GetLangStr(lsiNoEmpty), vgMessageError,
        [vgButtonOK], vgScene1, TxtPwd, True);
    Exit;
  end;

  if TxtFolder.Tag < 0 then  //TxtFolder Judgement,!!!esp FolderIndex!!!!
    bOK := False;
  if not bOK then
  begin
    MessagePopup(GetLangStr(lsiError), GetLangStr(lsiFdrNSet), vgMessageError,
        [vgButtonOK], vgScene1, TxtFolder, True);
    Exit;
  end;
  //filter text "click here to edit" before store..
  if nil = StrPos(PAnsiChar(AnsiString(sClkEdt)), PAnsiChar(AnsiString(TxtUrl.Text))) then //URL filter..
    sURL := TxtUrl.Text;
  if nil = StrPos(PAnsiChar(AnsiString(sClkEdt)), PAnsiChar(AnsiString(TxtNoteShort.Text))) then //NoteShort filter..
    sNote1 := TxtNoteShort.Text;
  if nil = StrPos(PAnsiChar(AnsiString(GetLangStr(lsiClickIco2Edt))), PAnsiChar(AnsiString(EditNoteLong.Text))) then //NoteLong filter..
    sNote2 := EditNoteLong.Text;

  if 0 > TxtAcInfoTip.Tag then  //tag AC index in db;
  begin
    iTmp := GetNewID(False);
    if 0 > iTmp then
    begin
      MessagePopup(GetLangStr(lsiError), G_PErrMsg, vgMessageError, [vgButtonYes],
          vgScene1, TxtUsr, True);
      Exit;
    end;
    TxtAcInfoTip.Tag := iTmp;
  end;
  //AC not new, use UPDATE sentence; else, INSERT;
  //or INSERT TO REPLACE;
  SQL_Exec('BEGIN;', nil, nil);
  sSql := 'INSERT OR REPLACE INTO '+S_AC_TB+' (ID, Usr, Pwd, URL, Note1, Note2, FolderIdx) VALUES (' +
          IntToStr(TxtAcInfoTip.Tag) +','''+AnsiString(TxtUsr.Text)+''','''+AnsiString(TxtPwd.Text)+
          ''','''+AnsiString(sUrl)+''','''+AnsiString(sNote1)+''','''+AnsiString(sNote2)+''','+
          IntToStr(TxtFolder.Tag)+');';
  if not SQL_Exec(PAnsiChar(sSql), nil, @G_PErrMsg) then
  begin
    MessagePopup(GetLangStr(lsiError), G_PErrMsg, vgMessageError, [vgButtonOK],
          vgScene1, TxtUsr, True);
    Exit;
  end;
  SQL_Exec('COMMIT;', nil, nil);
  //IF in cur dir, refresh ui!
  if (0=GridBrwAc.Tag) {and (TxtBrwCurDir.Tag = TxtFolder.Tag)} then
  begin
    RefreshGridAC;
    //另外一种情况: 从当前目录中移到另一目录中, GridBrwAc也要刷新(删除移动的记录);
//    iRow := -1;//row index of changed account;
//    for iTmp := 0 to High(DataGridAC) do
//    begin
//      if TxtAcInfoTip.Tag = DataGridAC[iTmp][5]{ID of AC} then
//      begin
//        iRow := iTmp;
//        Break;
//      end;
//    end;
//    if -1 = iRow then //must be new;
//    begin
//      iTmp := Length(DataGridAC);
//      SetLength(DataGridAC, iTmp+1);
//      SetLength(DataGridAC[iTmp], 7); //Usr,Pwd,URL,Note1,Note2,ID,RealPwd;
//      GridBrwAc.RowCount := iTmp; //8 COLUMNS IN SEARCH MODE!!!!!!!!!!!!
//      GridBrwAc.RefreshColumns;   //Hard code is not good here.
//      iRow := iTmp;
//    end;
//
//    DataGridAC[iRow][0] := TxtUsr.Text;
//    DataGridAC[iRow][1] := S_PWDSTAR;
//    DataGridAC[iRow][6] := TxtPwd.Text; //7 for search mode!!
//    DataGridAC[iRow][2] := sUrl;
//    DataGridAC[iRow][3] := sNote1;
//    DataGridAC[iRow][4] := sNote2;
//    DataGridAC[iRow][5] := TxtAcInfoTip.Tag;
//    //force to refresh ui..
//    TxtItm := TvgTextBox(ColBrwAcUsr.CellControlByRow(iRow));
//    if Assigned(TxtItm) then
//    begin
//      TxtItm.Text := DataGridAC[iRow][0];
//    end;
//    TxtItm := TvgTextBox(ColBrwAcUrl.CellControlByRow(iRow));
//    if Assigned(TxtItm) then
//    begin
//      TxtItm.Text := DataGridAC[iRow][2];
//    end;
  end;

  //reset variables..
  TxtAcInfoTip.Tag := -1;
  //  创建成功后给出提示Success, 同时给Usr.Tag := AcID;  在每次新建的时候reset，编辑的时候传过来。!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  MessagePopup(GetLangStr(lsiFdbk), GetLangStr(lsiSaveSuc), vgMessageInformation, [vgButtonOK],
    vgScene1, TxtUsr, True);
end;

procedure TPAKMainFrm.BtnSearchClick(Sender: TObject);
begin
  if not CheckShareEditValid(TxtBrwCurDir) then
    Exit;
  GridBrwAc.Tag := 1;//tag that it is search mode;
  RefreshGridAC;
end;

procedure TPAKMainFrm.BtnSetLockOKClick(Sender: TObject);
var
  sAnsi: AnsiString;
  sTmp: string;
begin
  if (Length(EditSetLockNewPwd1.Text) < 1) or (Length(EditSetLockPwd2.Text) < 1) then
  begin
    MessagePopup(GetLangStr(lsiError), GetLangStr(lsiNoEmpty), vgMessageError, [vgButtonYes],
          vgScene1, EditSetLockNewPwd1);
    Exit;
  end;

  if not SameStr(EditSetLockNewPwd1.Text, EditSetLockPwd2.Text) then
  begin
    MessagePopup(GetLangStr(lsiError), GetLangStr(lsiPwdNotMatch), vgMessageError, [vgButtonYes],
          vgScene1, EditSetLockNewPwd1);
    Exit;
  end;

  sAnsi := AnsiString(EditSetLockNewPwd1.Text);
  if N_SQLITE_OK <> SQL_Rekey(PAnsiChar(sAnsi), Length(sAnsi)) then
  begin
    if lteng = FCurLangIdx then
      sTmp := GetLangStr(lsiChng)+' '+GetLangStr(lsiFail)+'!'
    else
      sTmp := GetLangStr(lsiChng)+GetLangStr(lsiFail)+'!';
    MessagePopup(GetLangStr(lsiError), sTmp, vgMessageError, [vgButtonYes],
          vgScene1, EditSetLockNewPwd1);
  end
  else begin
    if lteng = FCurLangIdx then
      sTmp := GetLangStr(lsiChng)+' '+GetLangStr(lsiSuc)+'!'
    else
      sTmp := GetLangStr(lsiChng)+GetLangStr(lsiSuc)+'!';
    MessagePopup(GetLangStr(lsiFdbk), sTmp, vgMessageInformation, [vgButtonYes],
          vgScene1, EditSetLockNewPwd1);
    BtnSetLockResetClick(Self);
  end;
end;

procedure TPAKMainFrm.BtnSetLockResetClick(Sender: TObject);
begin
  EditSetLockNewPwd1.Text := '';
  EditSetLockPwd2.Text := '';
end;

procedure TPAKMainFrm.BtnSettingWheelCenterClick(Sender: TObject);
begin
  ShowSetSubmodule(nil);
end;

procedure TPAKMainFrm.BtnSettingWheelCenterMouseEnter(Sender: TObject);
begin
  BtnSettingWheelCenter.Opacity := 1;
end;

procedure TPAKMainFrm.BtnSettingWheelCenterMouseLeave(Sender: TObject);
begin
  BtnSettingWheelCenter.Opacity := 0.5;
end;

function TPAKMainFrm.CheckAcInfoStored: Boolean;
begin
  if BtnSaveAc.Visible and BtnSaveAc.Enabled then
  begin
    Result := False;
    MessagePopup(GetLangStr(lsiError), GetLangStr(lsiErrAcSaveOrN), vgMessageWarning, [vgButtonYes],
          vgScene1, TxtFolderTip);
  end
  else
    Result := True;
end;

function TPAKMainFrm.CheckFolderNameValid(AName: string): Boolean;
begin
  //' .
  Result := True;
end;

function TPAKMainFrm.CheckShareEditValid(ATarget: TvgVisualObject): Boolean;
begin
  if not FEditShareValueValid then//operations not ok
  begin
    Result := False;
    MessagePopup(GetLangStr(lsiError), GetLangStr(lsiEditShareInUse), vgMessageError, [vgButtonYes],
          vgScene1, ATarget, False);//!!Don't ShowModal or the RcBtnBrowse.Draw() method will crash!!
    Exit;
  end;

  Result := True;
end;

procedure TPAKMainFrm.ClosePAK;
begin
 if EditShare.Visible then
  EditShare.Visible := False;
  EditShare.Free;
  Close;
end;

procedure TPAKMainFrm.ColBrwAcUsrMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
//var
//  i:Integer;
//  sTmp: AnsiString;
begin
//  sTmp := Format('RowIndex: %d', [ColBrwAcUsr.Index]);
//  MessageBoxA(0, PAnsiChar(sTmp), 'Test', MB_OK);
end;

procedure TPAKMainFrm.ComboSetLangChange(Sender: TObject);
begin
  LanguageChanged(TLanguageType(ComboSetLang.ItemIndex+1));
end;

function TPAKMainFrm.CreateBasicTb: Boolean;
var
  sSql: AnsiString;
begin
  FillMemory(G_PErrMsg, N_LEN_ERRMSG, 0);

  //--Create PAK Root Folder table--
  EmptyDataSqlResult;
  sSql := 'SELECT tbl_name FROM sqlite_master WHERE Type = ''table'' AND tbl_name = '''+ S_FOLDER_TB+''' limit 1'; //faster than 'SELECT COUNT(*)'
  if not SQL_Exec(PAnsiChar(sSql), FN_CB_S3, @G_PErrMsg) then
  begin
    Result := False;
    Exit;
  end
  else if 1 > Length(DataSqlResult) then //NOT EXIST, CREATE TABLE AND INDEX
  begin
    SQL_Exec('begin;', nil, nil); //begin transaction
    sSql := 'CREATE TABLE '+S_FOLDER_TB+ '(ID INTEGER PRIMARY KEY, Name TEXT UNIQUE, ParentIndex INTEGER NOT NULL);';
    if not SQL_Exec(PAnsiChar(sSql), FN_CB_S3, @G_PErrMsg) then
    begin
      Result := False;
      Exit;
    end;
    sSql := 'CREATE INDEX PAK_FD_INDEX ON '+S_FOLDER_TB+'(ID);';
    if not SQL_Exec(PAnsiChar(sSql), FN_CB_S3, @G_PErrMsg) then
    begin
      Result := False;
      Exit;
    end;
    SQL_Exec('commit;', nil, nil);//end transaction
  end;

  //--Create PAK Account Table--
  EmptyDataSqlResult;
  sSql := 'SELECT tbl_name FROM sqlite_master WHERE Type = ''table'' AND tbl_name = '''+ S_AC_TB+''' limit 1;';
  if not SQL_Exec(PAnsiChar(sSql), FN_CB_S3, @G_PErrMsg) then
  begin
    Result := False;
    Exit;
  end
  else if 1 > Length(DataSqlResult) then //NOT EXIST, CREATE TABLE AND INDEX
  begin
    SQL_Exec('begin;', nil, nil); //begin transaction
    sSql := 'CREATE TABLE '+S_AC_TB+ '(ID INTEGER PRIMARY KEY, Usr TEXT NOT NULL, Pwd TEXT NOT NULL, URL TEXT, Note1 TEXT, Note2 TEXT, FolderIdx INTEGER NOT NULL)';
    if not SQL_Exec(PAnsiChar(sSql), FN_CB_S3, @G_PErrMsg) then
    begin
      Result := False;
      Exit;
    end;
    sSql := 'CREATE INDEX PAK_AC_INDEX ON '+S_AC_TB+'(ID);';
    if not SQL_Exec(PAnsiChar(sSql), FN_CB_S3, @G_PErrMsg) then
    begin
      Result := False;
      Exit;
    end;
    SQL_Exec('commit;', nil, nil);//end transaction
  end;

  //--PAK ID-REUSE TABLE--
  SQL_Exec('BEGIN;', nil, nil);
  sSql := 'CREATE TABLE IF NOT EXISTS '+S_IDREUSE_TB+'(ItemType INTEGER NOT NULL, ResvID INTEGER NOT NULL, PRIMARY KEY(ItemType, ResvID));';
  if not SQL_Exec(PAnsiChar(sSql), FN_CB_S3, @G_PErrMsg) then
  begin
    Result := False;
    Exit;
  end;
  SQL_Exec('COMMIT;', nil, nil);

  //--PAK Configaration TABLE--
//  sSql := 'CREATE TABLE IF NOT EXISTS '+S_CFG_TB+'(ID INTEGER PRIMAY KEY, Value1 TEXT, Value2 INTEGER);';
//  if not SQL_Exec(PAnsiChar(sSql), FN_CB_S3, @G_PErrMsg) then
//  begin
//    Result := False;
//    Exit;
//  end;

  Result := True;
end;

function TPAKMainFrm.CreateLstFderItem: TvgListBoxItem;
var
  Item: TvgListBoxItem;
begin
  Item := TvgListBoxItem.Create(nil);
  Item.Parent := lstFolder;
  Item.Height := 90;
  // this code set event - when we need to setup item
  Item.OnApplyResource := DoApplyResource;
  // this set our style to new item
  Item.Resource := 'Cus0ListItem';

  Result := Item;
end;

function TPAKMainFrm.DeleteAc(iID: Integer): Boolean;
var
  sSql: AnsiString;

begin
  SQL_Exec('BEGIN;', nil, nil);
  sSql := 'DELETE FROM '+S_AC_TB+' WHERE ID='+IntToStr(iID)+';';
  if not SQL_Exec(PAnsiChar(sSql), nil, @G_PErrMsg) then
  begin
    MessagePopup(GetLangStr(lsiError), G_PErrMsg, vgMessageError, [vgButtonOK],
          vgScene1, TxtUsr, True);
    Result := False;
    Exit;
  end;
  SQL_Exec('COMMIT;', nil, nil);
  Result := True;
end;

function TPAKMainFrm.DeleteFolderInDB(AFolderDel:TvgTreeViewItem):Boolean;
var
  sSql: AnsiString;
  bSqlErr: Boolean;
  I, iTmp, iCode, iWhichStmt: Integer;
  tmpTreeItm: TvgTreeViewItem;
  stackFder: TObjectStack; //stack for folders while traverse children non-recursively.
  ArrChildFder:array of Integer;//all child folders under AFolderDel;
  ArrChildAC: array of Integer;//all child accounts under AFolderDel;
begin
  if nil = AFolderDel then//delete all PAK data if it's 0!
  begin
    Result := False;
    Exit;
  end;

  //gather all folders that ancestor it which need to be deleted..
  //as recursive algm may cause physical stack crash, we use non-recursive algm..
  stackFder := TObjectStack.Create;
  tmpTreeItm := AFolderDel;
  while((nil <> tmpTreeItm) or (stackFder.Count > 0)) do
  begin
//    if 0 = tmpTreeItm.Count then //depth end;
//    begin
//      if stackFder.Count < 1 then //all over.
//        Break;
//      tmpTreeItm := stackFder.Pop;
//    end
//    else begin
//      //1. visit current node(push into ArrChildFder)..
//      iTmp := Length(ArrChildFder);
//      SetLength(ArrChildFder, iTmp + 1);
//      ArrChildFder[iTmp] := tmpTreeItm.Tag;
//      //2. push all chidren besides 1st child to stack..
//
//    end;

    //Emulator algorithm of human thought!
    //1.visit current node(push into ArrChildFder)..
    iTmp := Length(ArrChildFder);
    SetLength(ArrChildFder, iTmp + 1);
    ArrChildFder[iTmp] := tmpTreeItm.Tag;
    //2.check if has child folders..
    if tmpTreeItm.Count < 1 then
    begin
      //2.1 popup one tree item and continue traverse..
      if stackFder.Count < 1 then //all over.
        Break;
      tmpTreeItm := TvgTreeViewItem(stackFder.Pop);
    end
    else begin
      //2.2.1 push all chidren besides 1st child to stack..
      for I := 1 to tmpTreeItm.Count - 1 do
      begin
        stackFder.Push(tmpTreeItm.ItemByIndex(I));
      end;
      //2.2.2 visit 1st child..
      tmpTreeItm := tmpTreeItm.ItemByIndex(0);
    end;
  end;
  stackFder.Free;

  //delete self and child folders and ACs under it!
  //using Transaction and prepare_V2 and bind to speed up!!
  for iWhichStmt := 0 to 1 do
  begin
    sSql := 'BEGIN;';//Transaction begin!
    if N_SQLITE_OK <> SQL_PrepareV2(PAnsiChar(sSql), Length(sSql), iWhichStmt) then
    begin
      SQL_Finalize(iWhichStmt);
      MessagePopup(GetLangStr(lsiError), SQL_ErrMsg(iWhichStmt), vgMessageError, [vgButtonOK],
          vgScene1, TxtBrwCurDir, True);
      Result := False;
      Exit;
    end;
    if N_SQLITE_DONE <> SQL_Step(iWhichStmt) then
       bSqlErr := True;
    bSqlErr := (N_SQLITE_OK <> SQL_Finalize(iWhichStmt));
    if bSqlErr then
    begin
      MessagePopup(GetLangStr(lsiError), SQL_ErrMsg(iWhichStmt), vgMessageError, [vgButtonOK],
          vgScene1, TxtBrwCurDir, True);
      Result := False;
      Exit;
    end;

    //--recycle the deleted ID of folders--
    sSql := 'INSERT INTO '+S_IDREUSE_TB+' (ItemType, ResvID) VALUES (0,?);';
    //1.recycle ID of self and children folders recursively!!
    if N_SQLITE_OK <> SQL_PrepareV2(PAnsiChar(sSql), Length(sSql), iWhichStmt) then
    begin
      SQL_Finalize(iWhichStmt);
      MessagePopup(GetLangStr(lsiError), string(SQL_ErrMsg(iWhichStmt))+'ID Recycle Process of Folder Error!', vgMessageError, [vgButtonOK],
          vgScene1, TxtAcInfoTip);
      Result := False;
      Exit;
    end;
    for I := 0 to High(ArrChildFder) do
    begin
      if N_SQLITE_OK <> SQL_BindInt(iWhichStmt, 1, ArrChildFder[I]) then
      begin
        MessagePopup(GetLangStr(lsiError), 'ID Recycle Process of Folder Error!', vgMessageError, [vgButtonOK],
          vgScene1, TxtAcInfoTip);
        Result := False;
        Exit;
      end;
      if N_SQLITE_DONE <> SQL_Step(iWhichStmt) then
      begin
        SQL_Finalize(iWhichStmt);
        MessagePopup(GetLangStr(lsiError), 'ID Recycle Process of Folder Error!', vgMessageError, [vgButtonOK],
            vgScene1, TxtAcInfoTip);
        Result := False;
        Exit;
      end;
      SQL_Reset(iWhichStmt);
    end;
    SQL_Finalize(iWhichStmt);//always free when sql prepared changes;

    //2. delete folders recursively..
    sSql := 'DELETE FROM '+S_FOLDER_TB+' WHERE ID=?;';
    if N_SQLITE_OK <> SQL_PrepareV2(PAnsiChar(sSql), Length(sSql), iWhichStmt) then
    begin
      SQL_Finalize(iWhichStmt);
      MessagePopup(GetLangStr(lsiError), 'Delete Folders Error!', vgMessageError, [vgButtonOK],
          vgScene1, TxtAcInfoTip);
      Result := False;
      Exit;
    end;
    for I := 0 to High(ArrChildFder) do
    begin
      SQL_BindInt(iWhichStmt, 1, ArrChildFder[I]);
      if N_SQLITE_DONE <> SQL_Step(iWhichStmt) then
      begin
        SQL_Finalize(iWhichStmt);
        MessagePopup(GetLangStr(lsiError), 'Delete Folders Error!', vgMessageError, [vgButtonOK],
            vgScene1, TxtAcInfoTip);
        Result := False;
        Exit;
      end;
      SQL_Reset(iWhichStmt);
    end;
    SQL_Finalize(iWhichStmt);//always free when sql prepared changes;

    //3. gather all ACs..
    //EmptyDataSqlResult;
    //use sqlite3_step() here, of course sqlite3_exec() can be used too;
    if Length(ArrChildAC) < 1 then//make sure only gather it once;
    begin
      sSql := 'SELECT ID FROM '+S_AC_TB+' WHERE FolderIdx=?;';
      if N_SQLITE_OK <> SQL_PrepareV2(PAnsiChar(sSql), Length(sSql), iWhichStmt) then
      begin
        SQL_Finalize(iWhichStmt);
        MessagePopup(GetLangStr(lsiError), 'Gathering all child ACs'' ID process Error!', vgMessageError, [vgButtonOK],
            vgScene1, TxtAcInfoTip);
        Result := False;
        Exit;
      end;
      for I := 0 to High(ArrChildFder) do
      begin
        SQL_BindInt(iWhichStmt, 1, ArrChildFder[I]);

        while True do //get 'select' results;
        begin
          iCode := SQL_Step(iWhichStmt);
          if N_SQLITE_ROW = iCode then
          begin
            iTmp := Length(ArrChildAC);
            SetLength(ArrChildAC, iTmp+1);
            ArrChildAC[iTmp] := SQL_ColumnInt(iWhichStmt, 0);
          end
          else if N_SQLITE_DONE = iCode then
          begin
            Break;
          end
          else begin
            SQL_Finalize(iWhichStmt);
            MessagePopup(GetLangStr(lsiError), 'Gathering all child ACs'' ID process Error!', vgMessageError, [vgButtonOK],
                vgScene1, TxtAcInfoTip);
            Result := False;
            Exit;
          end;
        end;

        SQL_Reset(iWhichStmt); //reset, then stmt can be reused;
      end;
      SQL_Finalize(iWhichStmt);//always free when sql prepared changes;
    end;
    //4. recycle ID of all ACs..
    if Length(ArrChildAC) > 0 then
    begin
      sSql := 'INSERT INTO '+S_IDREUSE_TB+' (ItemType, ResvID) VALUES (1,?);';
      if N_SQLITE_OK <> SQL_PrepareV2(PAnsiChar(sSql), Length(sSql), iWhichStmt) then
      begin
        SQL_Finalize(iWhichStmt);
        MessagePopup(GetLangStr(lsiError), 'Recycle ID of deleted ACs Error!', vgMessageError, [vgButtonOK],
            vgScene1, TxtAcInfoTip);
        Result := False;
        Exit;
      end;
      for I := 0 to High(ArrChildAC) do
      begin
        SQL_BindInt(iWhichStmt, 1, ArrChildAC[I]);
        if N_SQLITE_DONE <> SQL_Step(iWhichStmt) then
        begin
          SQL_Finalize(iWhichStmt);
          MessagePopup(GetLangStr(lsiError), string(SQL_ErrMsg(iWhichStmt))+'Recycle ID of deleted ACs Error!', vgMessageError, [vgButtonOK],
              vgScene1, TxtAcInfoTip);
          Result := False;
          Exit;
        end;
        SQL_Reset(iWhichStmt);
      end;
      SQL_Finalize(iWhichStmt);//always free when sql prepared changes;

      //5. delete all ACs..
       sSql := 'DELETE FROM '+S_AC_TB+' WHERE ID=?;';
      if N_SQLITE_OK <> SQL_PrepareV2(PAnsiChar(sSql), Length(sSql), iWhichStmt) then
      begin
        SQL_Finalize(iWhichStmt);
        MessagePopup(GetLangStr(lsiError), 'Delete ACs Error!', vgMessageError, [vgButtonOK],
            vgScene1, TxtAcInfoTip);
        Result := False;
        Exit;
      end;
      for I := 0 to High(ArrChildAC) do
      begin
        SQL_BindInt(iWhichStmt, 1, ArrChildAC[I]);
        if N_SQLITE_DONE <> SQL_Step(iWhichStmt) then
        begin
          SQL_Finalize(iWhichStmt);
          MessagePopup(GetLangStr(lsiError), 'Delete ACs Error!', vgMessageError, [vgButtonOK],
              vgScene1, TxtAcInfoTip);
          Result := False;
          Exit;
        end;
        SQL_Reset(iWhichStmt);
      end;
      SQL_Finalize(iWhichStmt);//always free when sql prepared changes;
    end;

    //Transaction End!
     sSql := 'COMMIT;';//Transaction begin!
    if N_SQLITE_OK <> SQL_PrepareV2(PAnsiChar(sSql), Length(sSql), iWhichStmt) then
    begin
      SQL_Finalize(iWhichStmt);
      MessagePopup(GetLangStr(lsiError), SQL_ErrMsg(iWhichStmt), vgMessageError, [vgButtonOK],
          vgScene1, TxtBrwCurDir, True);
      Result := False;
      Exit;
    end;
    if N_SQLITE_DONE <> SQL_Step(iWhichStmt) then
       bSqlErr := True;
    bSqlErr := (N_SQLITE_OK <> SQL_Finalize(iWhichStmt));
    if bSqlErr then
    begin
      MessagePopup(GetLangStr(lsiError), SQL_ErrMsg(iWhichStmt), vgMessageError, [vgButtonOK],
          vgScene1, TxtBrwCurDir, True);
      Result := False;
      Exit;
    end;//COMMIT Transaction over..
  end; //Loop 2 sqlite3_stmt over;
  SetLength(ArrChildAC, 0);
  SetLength(ArrChildFder, 0);

  Result := True;
end;

procedure TPAKMainFrm.DoApplyResource(Sender: TObject);
var
  B: TvgBitmap;
  Item: TvgListboxItem;
begin
  Item := TvgListBoxItem(Sender);
  //FindBing() method

  //if 0 = Item.Tag mod 2 then
    B := TvgImage(ImageFolder32.Clone(Self)).Bitmap;
//  else
//  begin
//    B := TvgImage(ImageFile32.Clone(Self)).Bitmap;
//  end;
  Item.Binding['ItemImg'] := ObjectToVariant(B);
  //Item.Binding['ItemTxt'] := 'Personal Accounts Keeper!';
end;

procedure TPAKMainFrm.EditCfmPwdLogInKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if FFstUsePak and (VK_RETURN = Key) then
  begin
    BtnLogInClick(Self);
  end;
end;

procedure TPAKMainFrm.EditNoteLongKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  //tag that EditNoteLong's text changed;
  if ((Key <> VK_LEFT) and (Key <> VK_RIGHT) and (Key <> VK_UP) and (Key <> VK_DOWN)) then
    FEdtNoteLongTxtChgd := True;
end;

procedure TPAKMainFrm.EditNoteLongKillFocus(Sender: TObject);
begin
  //judge if changed..
  if FEdtNoteLongTxtChgd then
  begin
    AcCardInfoChanged;
    EditNoteLong.Tag := 1;//tag that it's been edited by user;
    FEdtNoteLongTxtChgd := False;
  end;
  EditNoteLong.Resource := 'MemoReadOnly';
  EditNoteLong.ReadOnly := True;
end;

procedure TPAKMainFrm.EditPakPwdKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if (not FFstUsePak) and (VK_RETURN = Key) then //LayoutConfirmPwd is invisible
  begin
    BtnLogInClick(Self);
  end;
end;

procedure TPAKMainFrm.EditSearchKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if VK_RETURN = Key then //LayoutConfirmPwd is invisible
  begin
    BtnSearchClick(Self);//CheckShareEditValid(TxtBrwCurDir) inside!
  end;
end;

procedure TPAKMainFrm.EditShareKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if VK_RETURN = Key then
    EditShareKillFocus(Self)
  else begin
    if ((Key <> VK_LEFT) and (Key <> VK_RIGHT) and (Key <> VK_UP) and (Key <> VK_DOWN)) then
      FEdtShareTxtChgd := True;
  end;

end;

procedure TPAKMainFrm.EditShareKillFocus(Sender: TObject);
var
  LstItem: TvgListBoxItem;
begin
  //if comes from VK_RETURN, DON'T RESPOND AGAIN!
  if FEditShareKillFoucusCalled then
    Exit;
  FEditShareKillFoucusCalled := True;

  FEditShareValueValid := True;
  if LayoutBrowser.Visible then //mtBrowse pattern
  begin
    LstItem := lstFolder.ItemByIndex(EditShare.Tag);
    if Assigned(LstItem) then
      begin
        //task1:Check if the folder name is unique..
        //task2:Check the file name characters
        //we throw task1 and task2 to sqlite3 :)
        if not SyncFolderToDb(@LstItem, EditShare.Text) then
        begin
          FEditShareValueValid := False;
          MessagePopup(GetLangStr(lsiError), G_PErrMsg, vgMessageError, [vgButtonYes],
            vgScene1, TxtBrwCurDir);
        end
        else begin
          if FEdtShareTxtChgd then
            LstItem.Binding['ItemTxt'] := EditShare.Text;
        end;
    end;
  end
  else if LayoutAcViewer.Visible then
  begin
//    LstItem := LstCardInfo.ItemByIndex(EditShare.Tag);
//    if Assigned(LstItem) then
//    begin
//      LstCardInfo.Binding['AcItem'] := EditShare.Text;
//      TvgText(VariantToObject(LstItem.Binding['AcItem'])).Visible := True;//not work!!How?
//    end;

//..if valid!!!!!
      if 0 = EditShare.Tag then //TxtUsr
      begin
        if Length(EditShare.Text) < 1 then //invalid
        begin
          FEditShareValueValid := False;
          MessagePopup(GetLangStr(lsiError), GetLangStr(lsiUsrEmpty), vgMessageError, [vgButtonYes],
            vgScene1, TxtUsr);
        end
        else if not SameText(TxtUsr.Text, EditShare.Text) then  //valid
        begin
          AcCardInfoChanged;
        end;
        if FEditShareValueValid then
        begin
          AssignAcCardItem(TxtUsr, EditShare.Text);
          TxtUsr.Tag := 1; //tag that it's been edited by user;
          TxtUsr.Visible := True;
        end;
      end
      else if 1 = EditShare.Tag then //TxtPwd
      begin
        if Length(EditShare.Text) < 1 then //Can't be empty
        begin
          FEditShareValueValid := False;
          MessagePopup(GetLangStr(lsiError), GetLangStr(lsiNoEmpty), vgMessageError, [vgButtonYes],
            vgScene1, TxtPwd);
        end
        else if not SameText(TxtPwd.Text, EditShare.Text) then
        begin
          AcCardInfoChanged;
        end;
        if FEditShareValueValid then
        begin
          AssignAcCardItem(TxtPwd, EditShare.Text);
          TxtPwd.Tag := 1; //tag that it's been edited by user;
          TxtPwd.Visible := False;
          MakePwdMaskFit(TxtPwd.Width);
          LayoutPwdMask.Visible := True;
          EditShare.Password := False;
        end;
      end
      else if 2 = EditShare.Tag then //TxtUrl
      begin
        //we don't validate the url, as user may prefer to use it to store other text..
        //it's clear after usr click the VisitUrl menu item;
        if not SameText(TxtUrl.Text, EditShare.Text) then
        begin
          AssignAcCardItem(TxtUrl, EditShare.Text);
          TxtUrl.Tag := 1; //tag that it's been edited by user;
          AcCardInfoChanged;
        end;
        TxtUrl.Visible := True;
      end
//      else if 3 = EditShare.Tag then //TxtFolder
//      begin
//        //AssignAcCardItem(TxtFolder, EditShare.Text); //get current dir!!!!!!
//        TxtFolder.Visible := True;
//
//        //popup SelectFolder Dialogue
//      end
      else if 4 = EditShare.Tag then //TxtNoteShort
      begin
        if not SameText(TxtNoteShort.Text, EditShare.Text) then
        begin
          AssignAcCardItem(TxtNoteShort, EditShare.Text);
          TxtNoteShort.Tag := 1; //tag that it's been edited by user;
          AcCardInfoChanged;
        end;
        TxtNoteShort.Visible := True;
      end;
  end;

  if FEditShareValueValid then
  begin
    EditShare.Visible := False;
    EditShare.Parent := Root1; //avoid being deleted by deleting ListBoxItem
    EditShare.Tag := -1;
  end
  else begin
    EditShare.SetFocus;
    FEditShareKillFoucusCalled := False;
  end;
  FEdtShareTxtChgd := False;
end;

procedure TPAKMainFrm.ForceGridACDataToUI;
var
  I: Integer;
  TxtItm: TvgTextBox;
begin
  if Length(DataGridAC) < 1 then
  begin
    GridBrwAc.RowCount := 0;
    Exit;
  end;

  GridBrwAc.RowCount := Length(DataGridAC);
  for I := 0 to High(DataGridAC) do
  begin
    TxtItm := TvgTextBox(ColBrwAcUsr.CellControlByRow(I));
    if Assigned(TxtItm) then
    begin
      TxtItm.Text := DataGridAC[I][0];
    end;
    TxtItm := TvgTextBox(ColBrwAcPwd.CellControlByRow(I));
    if Assigned(TxtItm) then
    begin
      TxtItm.Text := DataGridAC[I][1];
    end;
    TxtItm := TvgTextBox(ColBrwAcUrl.CellControlByRow(I));
    if Assigned(TxtItm) then
    begin
      TxtItm.Text := DataGridAC[I][2];
    end;
  end;
end;

procedure TPAKMainFrm.FormCreate(Sender: TObject);
var
  ItmHeader: TvgHeaderItem;
  pTmp: Pointer;
  iTmp: Integer;
  sTmp: string;
begin
  //1. Initial values of variants;
  //2. UI Init;
  //3. Configuration Init;
  FCurPakModule := nil;
  FCurSetSubMod := nil;
  FEditShareKillFoucusCalled := False;
  FEditShareValueValid := True;
  FEdtNoteLongTxtChgd := False;
  FEdtShareTxtChgd := False;
  GetMem(G_PErrMsg, N_LEN_ERRMSG);
  FLastHoverAcRow := -1;
  TreeItemRoot.Tag := 0;//ROOT folder index is 0;
  FCurDirInTree := nil;
  TxtBrwCurDir.Tag := 0;//Current Folder Index(0:ROOT);
  //--Init Grid control--
  pTmp := ColBrwAcUsr.GetHeader;
  if nil <> pTmp then
  begin
    ItmHeader := TvgHeaderItem(pTmp^);
    ItmHeader.DragMode := vgDragManual;
    ItmHeader.Tag := 0;
    //TagString tag sort sequence
    ItmHeader.OnClick := OnHeaderBrwAcClick;
  end;
  pTmp := ColBrwAcUrl.GetHeader;
  if nil <> pTmp then
  begin
    ItmHeader := TvgHeaderItem(pTmp^);
    ItmHeader.DragMode := vgDragManual;
    ItmHeader.Tag := 2;
    ItmHeader.OnClick := OnHeaderBrwAcClick;
  end;
  SplitterBrw.FOnSplitterIng := SplitterBrwDragIng;
  //--Load default language set by user--
  sTmp := ExtractFilePath(Application.ExeName);
  sTmp := sTmp + S_INI_FILE;
  FIniFile := TIniFile.Create(sTmp);
  iTmp := FIniFile.ReadInteger(S_INI_SECTION, S_INI_NODE_LANG, -1);
  if iTmp < 0 then
    iTmp := Integer(lteng);
  FCurLangIdx := ltnone; //in order to trigger LanguageChanged()
  FLangPointer := nil;
  FFstUsePak := False;
  if (iTmp < 1) or (iTmp > 2) then
    iTmp := 1;
  ComboSetLang.ItemIndex := iTmp - 1;//(TLanguageType(iTmp));//default:lteng
  //LanguageChanged(TLanguageType(iTmp));
  //--depends language config--
  InitPopupMenu4Folder; //do InitData() job in SplashWindow?
  InitPopupMenu4File;

  ShowPAKModul2(@LayoutBrowser);//ShowPAKModule(mtBrowse);

  //don't show main form on task bar
  SetWindowLong(Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);
end;

procedure TPAKMainFrm.FormDestroy(Sender: TObject);
begin
  FIniFile.WriteInteger(S_INI_SECTION, S_INI_NODE_LANG, Integer(FCurLangIdx));
  FIniFile.Free;
end;

procedure TPAKMainFrm.FormResize(Sender: TObject);
begin
  MessageBoxA(Handle, 'OnFormResize!', 'Test', MB_OK);
end;

procedure TPAKMainFrm.FormShow(Sender: TObject);
begin
  FFstUsePak := CheckIfFirstUsePak;
  if not FFstUsePak  then
  begin
    LayCfmPwdLogIn.Visible := False;
    //LayPwdLogIn.Padding.Top := LayCfmPwdLogIn.Height / 2;
    LayPwdLogIn.Padding.Bottom := LayCfmPwdLogIn.Height / 2;
  end;
  LogInPopup.PopupModal;

  //--Splash Screen showing initialization work--
  if not CreateBasicTb then //With pwd can db operations do.
  begin
    MessagePopup(GetLangStr(lsiError), G_PErrMsg, vgMessageError, [vgButtonYes],
          vgScene1, nil);
    Exit;
  end;
  //--Load ROOT level folders and accounts--
  if not LoadAllFoldersToTree then
  begin
    MessagePopup(GetLangStr(lsiError), G_PErrMsg, vgMessageError, [vgButtonYes],
          vgScene1, nil);
    Exit;
  end;
  BtnParentFolder.Enabled := False;//ROOT dir already!
  FCurDirInTree := TreeItemRoot;
  TxtBrwCurDir.Text := GetLangStr(lsiCurPath) + ' \';
  GridBrwAc.Tag := 0;//normal mode;
  RefreshGridAC;
end;

procedure TPAKMainFrm.FormTreeRecursive(AItemModel: PTreeDataModel;
  AParentItem: PTvgTreeItem);
var
  TreeViewItm: TvgTreeViewItem;
  I: Integer;
begin
  TreeViewItm := TvgTreeViewItem.Create(Self);
  if nil = AParentItem then
    TreeViewItm.Parent := TreeItemRoot
  else
    TreeViewItm.Parent := AParentItem^;
  TreeViewItm.Tag := AItemModel^.Index;
  TreeViewItm.Text := AItemModel^.Name;
  TreeViewItm.TagString := IntToStr(AItemModel^.ParentIdx);

  for I := 0 to High(AItemModel^.Chilren) do
  begin
    FormTreeRecursive((AItemModel^.Chilren)[I], @TreeViewItm);
  end;
end;

function TPAKMainFrm.GetDirTreeItmByID(iID: Integer): TvgTreeViewItem;
var
  oTreeItm: TvgTreeViewItem;
  stackFder: TObjectStack;
  I: Integer;
begin
  oTreeItm := TreeItemRoot;
  stackFder := TObjectStack.Create;
  while iID <> oTreeItm.Tag do //MUST EXIST;
  begin
    //first handle the border situation;
    if oTreeItm.Count < 1 then
    begin
      if stackFder.Count < 1 then
      begin
        stackFder.Free;
        Result := nil;
        Exit;
      end;
      oTreeItm := TvgTreeViewItem(stackFder.Pop)
    end
    else begin
    //push other folders to stack..
    for I := 1 to oTreeItm.Count - 1 do
      stackFder.Push(oTreeItm.ItemByIndex(I));

    //point to the first child folder;
    oTreeItm := oTreeItm.ItemByIndex(0);
    end;
  end;
  stackFder.Free;
  Result := oTreeItm;
end;

function TPAKMainFrm.GetFullPathByTreeNode(ATreeNode: PTvgTreeItem): string;
var
  sPath: string;
  ATreeItem: PTvgTreeItem;
begin
  if nil = ATreeNode then
  begin
    Result := '';
    Exit;
  end
  else if 0 = ATreeNode^.Tag then
  begin
    Result := '\';
    Exit;
  end;

  ATreeItem := ATreeNode;
  while True do
  begin
    if 0 = ATreeItem^.Tag then
    begin
      sPath := '\' + sPath;
      Break;
    end;

    sPath := ATreeItem^.Text + '\' + sPath;
    ATreeItem := @(ATreeItem^.Parent);
  end;
  Result := sPath;
end;

function TPAKMainFrm.GetLangStr(index: TLangStrIndex): string;
var
  iMove : Integer;
begin
  if nil = FLangPointer then
  begin
    Result := '';
    Exit;
  end;

  iMove := Integer(index);
  Inc(FLangPointer, iMove);
  Result := FLangPointer^;
  Dec(FLangPointer, iMove);//reset position (to point to the array address)

//  //--old low-efficient implementation--
//  if Integer(lteng) = FCurLangIdx then
//    Result := LangEngArray[index]
//  else if Integer(ltchn) = FCurLangIdx then
//    Result := LangChnArray[index];
end;

function TPAKMainFrm.GetNewID(bForFolder:Boolean): Integer;
var
  sTmp: string;
  sSql: AnsiString;
  iResult, iType: Integer;
begin
  //--Get new index for folder or account depends on 'ForFolder' variable--
  if bForFolder then
    iType := 0
  else
    iType := 1;

  EmptyDataSqlResult;
  sSql := 'SELECT ResvID FROM '+S_IDREUSE_TB+' WHERE ItemType='+IntToStr(iType)+' limit 1;';//0:ItemType for folder;1:Ac;
  if not SQL_Exec(PAnsiChar(sSql), FN_CB_S3, @G_PErrMsg) then
  begin  //try to reuse id
    Result := -1;
    MessagePopup(GetLangStr(lsiError), G_PErrMsg, vgMessageError, [vgButtonOK],
      vgScene1, TxtAcInfoTip, True);
    Exit;
  end
  else //SQL_Exec suc
  begin
    if Length(DataSqlResult) > 0 then
    begin
      iResult:= StrToInt(VarToStr(DataSqlResult[0][0]));
      //Remove this reserved ID as it's been used!
      SQL_Exec('BEGIN;', nil, nil);
      sSql := 'DELETE FROM '+S_IDREUSE_TB+' WHERE ResvID='+IntToStr(iResult)+
          ' AND ItemType='+IntToStr(iType)+';';
      if not SQL_Exec(PAnsiChar(sSql), nil, @G_PErrMsg) then
      begin
        Result := -1;
        MessagePopup(GetLangStr(lsiError), G_PErrMsg, vgMessageError, [vgButtonOK],
            vgScene1, TxtAcInfoTip, True);
        Exit;
      end;
      SQL_Exec('COMMIT;', nil, nil);
    end
    else
    begin //GET MAX ONE
      EmptyDataSqlResult;
      if bForFolder then
        sTmp := S_FOLDER_TB
      else
        sTmp := S_AC_TB;
      sSql := 'SELECT MAX(ID) FROM '+sTmp+';';
      if not SQL_Exec(PAnsiChar(sSql), FN_CB_S3, @G_PErrMsg) then
      begin
        Result := -1;
        MessagePopup(GetLangStr(lsiError), G_PErrMsg, vgMessageError, [vgButtonOK],
            vgScene1, TxtAcInfoTip, True);
        Exit;
      end
      else begin
        sTmp := VarToStr(DataSqlResult[0][0]);
        if Length(sTmp) < 1 then
          iResult := 1 //0 for ROOT; start from 1;
        else
          iResult := StrToInt(sTmp) + 1;
      end;
    end;
  end;
  EmptyDataSqlResult; //cleanup..

  Result := iResult;
end;

function TPAKMainFrm.GetRealPwdIdx: Integer;
begin
  if 0 = GridBrwAc.Tag then
    Result := 6 //normal mode when all ACs have the same parent folder;
  else
    Result := 7;//search mode;
end;

procedure TPAKMainFrm.GridBrwAcGetValue(Sender: TObject; const Col,
  Row: Integer; var Value: Variant);
begin
  if Length(DataGridAC) < 1 then
    Exit;

  Value := DataGridAC[Row][Col];
end;

procedure TPAKMainFrm.GridBrwAcMouseLeave(Sender: TObject);
begin
  ResetLastPwdToMask;
end;

procedure TPAKMainFrm.GridBrwAcMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y, Dx, Dy: Single);
var
  iRow: Integer;
  ItmCol: TvgColumn;
  TxtItm: TvgTextBox;
begin
  //call OnMouseLeave as long as mouse is out of this CELL !
  ItmCol := GridBrwAc.ColumnByPoint(X, Y);
  if not Assigned(ItmCol) or (1 <> ItmCol.Tag) then //Column Pwd MUST
  begin
    ResetLastPwdToMask;
    Exit;
  end;

  iRow := GridBrwAc.RowByPoint(X, Y);
  if iRow > GridBrwAc.RowCount - 1 then
  begin
    ResetLastPwdToMask;
    Exit;
  end;

  if FLastHoverAcRow <> iRow then
  begin
    ResetLastPwdToMask;//reset first, then set;

    DataGridAC[iRow][1] := DataGridAC[iRow][GetRealPwdIdx];
    //with ColBrwAcPwd.CellControlByRow(iRow) as TvgTextBox do //may access 0x00000 error!
    TxtItm := TvgTextBox(ColBrwAcPwd.CellControlByRow(iRow));
    if Assigned(TxtItm) then
    begin
      TxtItm.Text := DataGridAC[iRow][GetRealPwdIdx];//force UI refresh!
    end;

    FLastHoverAcRow := iRow;
  end;
end;

procedure TPAKMainFrm.GridBrwAcMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  iRow: Integer;
  sTmp: AnsiString;
  pnt: TPoint; //TvgPoint;
begin
  if not FEditShareValueValid then
    Exit;

  iRow := GridBrwAc.RowByPoint(X, Y);
  if iRow > GridBrwAc.RowCount - 1 then
    Exit;

  sTmp := Format('COL:%d  ROW:%d', [GridBrwAc.ColumnIndex, iRow]);
  if mbLeft = Button then
  begin
    //MessageBoxA(0, PAnsiChar(sTmp), 'Test', MB_OK);
  end
  else if mbRight = Button then
  begin
    //set the row to selected state
    if iRow <> GridBrwAc.Selected then
    begin
      GridBrwAc.Selected := iRow;
      FCurViewAcIdx := iRow;
    end;
//    pnt.X := X;
//    pnt.Y := Y;
//    pnt := GridBrwAcct.LocalToAbsolute(pnt); //not right
    GetCursorPos(pnt);
    pm4File.Popup(pnt.X, pnt.Y);
  end;
end;

procedure TPAKMainFrm.ImgNote2Click(Sender: TObject);
begin
  EditNotelONG.Resource := '';
  EditNoteLong.ReadOnly := False;
  EditNoteLong.SetFocus;
end;

procedure TPAKMainFrm.InitAcCardInfo;
begin
  TxtAcInfoTip.Tag := -1;//tag AC index in table;
  //set init string "Click here to edit"
  AssignAcCardItem(TxtUsr, GetLangStr(lsiClickEdt));
  if not TxtUsr.Visible then
    TxtUsr.Visible := True;
  TxtUsr.Tag := 0; //not edited yet by user;
  AssignAcCardItem(TxtPwd, GetLangStr(lsiClickEdt));
  if TxtPwd.Visible then
    TxtPwd.Visible := False;
  TxtPwd.Tag := 0; //not edited yet by user;
  MakePwdMaskFit(TxtPwd.Width);
  if not LayoutPwdMask.Visible then
    LayoutPwdMask.Visible := True;
  AssignAcCardItem(TxtUrl, GetLangStr(lsiClickEdt));
  if not TxtUrl.Visible then
    TxtUrl.Visible := True;
  TxtUrl.Tag := 0;//not edited yet by user;
  AssignAcCardItem(TxtFolder, GetLangStr(lsiClickEdt));
  if not TxtFolder.Visible then
    TxtFolder.Visible := True;
  TxtFolder.Tag := -1;//tag AC belonged folder's index;
  AssignAcCardItem(TxtNoteShort, GetLangStr(lsiClickEdt));
  if not TxtNoteShort.Visible then
    TxtNoteShort.Visible := True;
  TxtNoteShort.Tag := 0;//not edited yet by user;
  EditNoteLong.Text := GetLangStr(lsiClickIco2Edt);
  if not EditNoteLong.ReadOnly then
  begin
    EditNoteLong.ReadOnly := True;
    EditNoteLong.Resource := 'MemoReadOnly';
  end;
  EditNoteLong.Tag := 0;//not edited yet by user;
end;

procedure TPAKMainFrm.InitPopupMenu4File;
var
  oMenuItem: TMenuItem;
begin
  pm4File.Items.Clear;
  //--Details ITEM--
  oMenuItem := TMenuItem.Create(nil);
  oMenuItem.Tag := Integer(mitDetail);
  oMenuItem.Caption := GetLangStr(lsiDetail);
  oMenuItem.RadioItem := true;
  oMenuItem.OnClick := OnMenuItem4FileClick;
  pm4File.Items.Add(oMenuItem);
  //--Open ITEM--
//  oMenuItem := TMenuItem.Create(nil);
//  oMenuItem.Tag := Integer(mitOpen);
//  oMenuItem.Caption := GetLangStr(lsiOpen);
//  oMenuItem.RadioItem := true;
//  //oMenuItem.OnClick := OnFileMenuClick;
//  pm4File.Items.Add(oMenuItem);
  //--Edit ITEM--
//  oMenuItem := TMenuItem.Create(nil);
//  oMenuItem.Tag := Integer(mitEdit);
//  oMenuItem.Caption := GetLangStr(lsiEdit);
//  oMenuItem.RadioItem := true;
//  //oMenuItem.OnClick := OnFileMenuClick;
//  pm4File.Items.Add(oMenuItem);
  //--Move Item--  //could do it in LayoutAcViewer;
//  oMenuItem := TMenuItem.Create(nil);
//  oMenuItem.Tag := Integer(mitMove);
//  oMenuItem.Caption := GetLangStr(lsiMove);
//  oMenuItem.RadioItem := true;
//  //oMenuItem.OnClick := OnFileMenuClick;
//  pm4File.Items.Add(oMenuItem);
  //--Delete Item--
  oMenuItem := TMenuItem.Create(nil);
  oMenuItem.Tag := Integer(mitDelete);
  oMenuItem.Caption := GetLangStr(lsiDelete);
  oMenuItem.RadioItem := true;
  oMenuItem.OnClick := OnMenuItem4FileClick;
  pm4File.Items.Add(oMenuItem);
  //--VisitUrl ITEM--
  oMenuItem := TMenuItem.Create(nil);
  oMenuItem.Tag := Integer(mitVstUrl);
  oMenuItem.Caption := GetLangStr(lsiVisitUrl);
  oMenuItem.RadioItem := true;
  oMenuItem.OnClick := OnMenuItem4FileClick;
  pm4File.Items.Add(oMenuItem);

end;

procedure TPAKMainFrm.InitPopupMenu4Folder;
var
  oMenuItem: TMenuItem;
begin
  pm4Folder.Items.Clear;

  //--Open ITEM--
  oMenuItem := TMenuItem.Create(nil);
  oMenuItem.Tag := Integer(mitOpen);
  oMenuItem.Caption := GetLangStr(lsiOpen);
  oMenuItem.RadioItem := true;
  oMenuItem.OnClick := OnMenuItem4FolderClick;
  pm4Folder.Items.Add(oMenuItem);
  //--Rename ITEM--
  oMenuItem := TMenuItem.Create(nil);
  oMenuItem.Tag := Integer(mitRename);
  oMenuItem.Caption := GetLangStr(lsiRename);
  oMenuItem.RadioItem := true;
  oMenuItem.OnClick := OnMenuItem4FolderClick;
  pm4Folder.Items.Add(oMenuItem);
  //--Move Item--
  oMenuItem := TMenuItem.Create(nil);
  oMenuItem.Tag := Integer(mitMove);
  oMenuItem.Caption := GetLangStr(lsiMove);
  oMenuItem.RadioItem := true;
  oMenuItem.OnClick := OnMenuItem4FolderClick;
  pm4Folder.Items.Add(oMenuItem);
  //--Delete Item--
  oMenuItem := TMenuItem.Create(nil);
  oMenuItem.Tag := Integer(mitDelete);
  oMenuItem.Caption := GetLangStr(lsiDelete);
  oMenuItem.RadioItem := true;
  oMenuItem.OnClick := OnMenuItem4FolderClick;
  pm4Folder.Items.Add(oMenuItem);
end;

procedure TPAKMainFrm.LanguageChanged(iNewIdx: TLanguageType);
var
  s1, s2:string;
begin
  if FCurLangIdx = iNewIdx then
    Exit;

  //switch language set
  FCurLangIdx := iNewIdx;
  if lteng = FCurLangIdx then
    FLangPointer := @LangEngArray
  else if ltchn = FCurLangIdx then
    FLangPointer := @LangChnArray;

  //all ctrls that need to change text..

  //----LogInPopup----
  TxtPakPwdTip.Text := GetLangStr(lsiSetPwdFstUse);
  TxtCfmPakPwd.Text := GetLangStr(lsiConfirm);
  BtnCancelLogIn.Text := GetLangStr(lsiCancel);
  BtnLogIn.Text := GetLangStr(lsiLogIn);

  //----LayoutAcViewer----
  TxtAcInfoTip.Text := GetLangStr(lsiAcInfo);
  TxtUsrTip.Text := GetLangStr(lsiUsr)+':';
  TxtPwdTip.Text := GetLangStr(lsiPwd)+':';
  TxtUrlTip.Text := GetLangStr(lsiUrl)+':';
  TxtFolderTip.Text := GetLangStr(lsiFolder)+':';
  TxtNoteShortTip.Text := GetLangStr(lsiNoteShort)+':';
  TxtNoteLongTip.Text := GetLangStr(lsiNoteLong)+':';
  BtnSaveAc.Text := GetLangStr(lsiSave);
  BtnCancelAc.Text := GetLangStr(lsiSaveN);
  BtnBack.Text := GetLangStr(lsiBack);

  //----LayoutBrowse----
  BtnNewAc.Hint := GetLangStr(lsiNewAc);
  BtnNewFolder.Hint := GetLangStr(lsiNewFolder);
  BtnParentFolder.Hint := GetLangStr(lsiParentFolder);
  BtnSearch.Hint := GetLangStr(lsiSearch);
  //局部字符串替换;
  s1 := LangEngArray[lsiCurPath];
  s2 := LangChnArray[lsiCurPath];
  if lteng = FCurLangIdx then
    TxtBrwCurDir.Text := StringReplace(TxtBrwCurDir.Text, s2, s1, [rfReplaceAll])
  else
    TxtBrwCurDir.Text := StringReplace(TxtBrwCurDir.Text, s1, s2, [rfReplaceAll]);

  EditSearch.Text := GetLangStr(lsiTypeKWord);
  //--Grid--
  ColBrwAcUsr.Header := GetLangStr(lsiUsr);
  ColBrwAcPwd.Header := GetLangStr(lsiPwd);
  ColBrwAcUrl.Header := GetLangStr(lsiUrl);

  //LayoutSetLock
  BtnSetLockReset.Text := GetLangStr(lsiReset);
  BtnSetLockOK.Text := GetLangStr(lsiChng);
  TxtSetLockNewPwdTip.Text := GetLangStr(lsiNewTokn)+':';
  TxtSetLockPwdCfmTip.Text := GetLangStr(lsiConfirm);

  //LayoutSetFAQ
  TxtFaq01_Q.Text := 'Q: '+GetLangStr(lsiFaq01Q);
  s1 := 'A: '+GetLangStr(lsiFaq01A)+#13#10+'    '+GetLangStr(lsiFaq01A2);
  TxtFaq01_A.Text := s1;
  TxtFaq02_Q.Text := 'Q: '+GetLangStr(lsiFaq02Q);
  s1 := 'A: '+GetLangStr(lsiFaq02A)+#13#10+'    '+GetLangStr(lsiFaq02A2);
  TxtFaq02_A.Text := s1;
  TxtFaq03_Q.Text := 'Q: '+GetLangStr(lsiFaq03Q);
  s1 := 'A: '+GetLangStr(lsiFaq03A)+#13#10+'    '+GetLangStr(lsiFaq03A2)+#13#10+'    '+GetLangStr(lsiFaq03A3);
  TxtFaq03_A.Text := s1;
  TxtFaq04_Q.Text := 'Q: '+GetLangStr(lsiFaq04Q);
  TxtFaq04_A.Text := 'A: '+GetLangStr(lsiFaq04A);
  TxtFaq05_Q.Text := 'Q: '+GetLangStr(lsiFaq05Q);
  TxtFaq05_A.Text := 'A: '+GetLangStr(lsiFaq05A);

  //LayoutSetSOS
  TxtSOS01.Text := GetLangStr(lsiSOS1);
  TxtSOS02.Text := GetLangStr(lsiSOS2);
  TxtSOS03.Text := GetLangStr(lsiSOS3);

  //LaySetSet
  TxtSetLangTip.Text := GetLangStr(lsiUILang)+':';

  //Form AboutAuthor

end;

procedure TPAKMainFrm.LayoutPwdMaskMouseEnter(Sender: TObject);
begin
  LayoutPwdMask.Visible := False;
  TxtPwd.Visible := True;
end;

function TPAKMainFrm.LoadAllFoldersToTree: Boolean;
var
  sSql: AnsiString;
  LstItem: TvgListBoxItem;
  I: Integer;
  ArrTreeItem,ArrTopFolders: array of PTreeDataModel;
  TreeItem: PTreeDataModel;
  bFindParent: Boolean;
   //Child procedure
   procedure TraverseToFindParent(AItem: PTreeDataModel; ATimes:Integer);
   var
    J, iTmp: Integer;
   begin
      bFindParent := False;
      for J := 0 to High(ArrTreeItem) do //traverse ParentedArray to find its parent;
      begin
        if ArrTreeItem[J]^.Index = AItem^.ParentIdx then
        begin
          AItem^.Parent := ArrTreeItem[J];
          iTmp := Length(ArrTreeItem[J].Chilren);
          SetLength(ArrTreeItem[J].Chilren, iTmp + 1);
          (ArrTreeItem[J].Chilren)[iTmp] := AItem;
          bFindParent := True;//AItem^.TagString has already been set;
          break;
        end;
      end;

      if 1 = ATimes then //Put it into ArrTreeItem find or not;
      begin
        iTmp := Length(ArrTreeItem);
        SetLength(ArrTreeItem, iTmp + 1);
        ArrTreeItem[iTmp] := AItem;
      end
      else if 2 = ATimes then
      begin
        if not bFindParent then //Must be top level folers;
        begin
          iTmp := Length(ArrTopFolders);
          SetLength(ArrTopFolders, iTmp + 1);
          ArrTopFolders[iTmp] := AItem;
        end;
      end;
   end; //child procedure end---;
begin
  //--Just load all folder form database--
  EmptyDataSqlResult;
  sSql := 'SELECT ID, Name, ParentIndex FROM '+S_FOLDER_TB+';';
  if not SQL_Exec(PAnsiChar(sSql), FN_CB_S3, @G_PErrMsg) then
  begin
    Result := False;
    Exit;
  end
  else begin //SQL_Exec() suc;
    //--Begin to construct the DirTree--
    for I := 0 to High(DataSqlResult) do //1st traverse;
    begin
      New(TreeItem);
      TreeItem^.Parent := nil;
      TreeItem^.Index := StrToInt(VarToStr(DataSqlResult[I][0]));
      TreeItem^.ParentIdx := StrToInt(VarToStr(DataSqlResult[I][2]));
      TreeItem^.Name := VarToStr(DataSqlResult[I][1]);

      TraverseToFindParent(TreeItem, 1);
    end;

    for I := 0 to High(ArrTreeItem) do  //2nd(last) traverse;
    begin
      if nil = ArrTreeItem[I]^.Parent then //haven't find parent;
      begin
        TraverseToFindParent(ArrTreeItem[I], 2);
      end;
    end;

    lstFolder.Clear;
    for I := 0 to High(ArrTopFolders) do
    begin
//      TreeViewItm := TvgTreeViewItem.Create(Self);
//      TreeViewItm.Parent := TreeDir;
//      TreeViewItm.Tag := ArrTopFolders[I]^.Index;
//      TreeViewItm.Text := ArrTopFolders[I]^.Name;
//      TreeViewItm.TagString := IntToStr(ArrTopFolders[I]^.ParentIdx);
      //init lstFolders by the way :)
      LstItem := CreateLstFderItem; //should be array of array!!!
      LstItem.Tag := ArrTopFolders[I]^.Index;
      LstItem.TagString := '1';//already-exist folder
      LstItem.Binding['ItemTxt'] := ArrTopFolders[I]^.Name;
    end;
    //Form tree(children level)..
    for I := 0 to High(ArrTopFolders) do
    begin
      FormTreeRecursive(ArrTopFolders[I], nil);
    end;
    //release job..
    for I := 0 to High(ArrTreeItem) do
      Dispose(ArrTreeItem[I]);
    SetLength(ArrTreeItem, 0);
    SetLength(ArrTopFolders, 0);
  end;

  Result := True;


{
  //dont' forget to update TxtBrwCurDir.Tag!!
  //--LOAD Folders--
  EmptyDataSqlResult;
  sSql := 'SELECT ID,Name FROM '+S_FOLDER_TB+' WHERE ParentIndex = ' +
    IntToStr(AFolderIdx) + ';';
  if not SQL_Exec(PAnsiChar(sSql), FN_CB_S3, @G_PErrMsg) then
  begin
    Result := False;
    Exit;
  end
  else begin //SQL_Exec suc;
    lstFolder.Clear;
    for I := 0 to High(DataSqlResult) do
    begin
      LstItem := CreateLstFderItem; //should be array of array!!!
      LstItem.Tag := DataSqlResult[I][0];
      LstItem.TagString := '1';//already-exist folder
      LstItem.Binding['ItemTxt'] := VarToStr(DataSqlResult[I][1]);
    end;

    if bGoParent then
    begin
      for I := Length(TxtBrwCurDir.Text) downto 1 do
      begin
        if '\' = TxtBrwCurDir.Text[I] then
          break;
      end;

      TxtBrwCurDir.Text := Copy(TxtBrwCurDir.Text, 1, I);//!!!!!!!!!!TEST TEST!!!!!!!
    end
    else begin
      if 0 = AFolderIdx then
      begin
        TxtBrwCurDir.Text := GetLangStr(lsiCurPath) + '\';
      end
      else begin
        EmptyDataSqlResult;
        sSql := 'SELECT Name FROM '+S_FOLDER_TB+' WHERE ID = ' + IntToStr(AFolderIdx) + ';';
        if not SQL_Exec(PAnsiChar(sSql), FN_CB_S3, @G_PErrMsg) then
        begin
          MessagePopup(GetLangStr(lsiError), G_PErrMsg, vgMessageError, [vgButtonYes],
              vgScene1, TxtBrwCurDir);
          //dont' need to exit
        end
        else
        begin
          TxtBrwCurDir.Text := TxtBrwCurDir.Text + VarToStr(DataSqlResult[0][0]) + '\';
        end;
      end;
    end;
    TxtBrwCurDir.Tag := AFolderIdx;
  end;

  //--LOAD Accounts-- !!!

  Result := True;
  }
end;

procedure TPAKMainFrm.lstBrwFolderMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  LstItem: TvgListBoxItem;
  pnt: TPoint;
begin
   if (mbRight <> Button) or (not FEditShareValueValid) then
      Exit;

   LstItem := lstFolder.ItemByPoint(X, Y);
   if Assigned(LstItem) then
   begin
     if not LstItem.IsSelected then
        LstItem.IsSelected := True;//RClick also make it selected state

     if GetCursorPos(pnt) then
     begin
       //if 0 = LstItem.Tag mod 2 then
        pm4Folder.Popup(pnt.X, pnt.Y);
       //else
        //pm4File.Popup(pnt.X, pnt.Y);
     end;
   end;

end;

procedure TPAKMainFrm.lstFolderDblClick(Sender: TObject);
var
  LstItem: TvgListBoxItem;
  TreeItm: TvgTreeViewItem;
  I: Integer;
begin
  //Send WM_MOUSEDOWN 2 times before sending WM_DBLCLICK..
  //So we could just take advantage of internal handler--"Selected"..
  LstItem := lstFolder.Selected;
  if (nil = LstItem) or (nil = FCurDirInTree) then
    Exit;

  for I := 0 to FCurDirInTree.Count - 1 do
  begin
    TreeItm := FCurDirInTree.ItemByIndex(I);
    if LstItem.Tag = TreeItm.Tag then
    begin
      SetCurDir(TreeItm, False);
      Break;
    end;
  end;
end;

procedure TPAKMainFrm.MakePwdMaskFit(iWidth: Single);
var
  i, iTmp, iExpect: Integer;
  oCircle: TvgCircle;
begin
  LayoutPwdMask.Width := iWidth;

  iExpect := Round(iWidth / (N_WIDTH_PWDCIRCLE + N_PADDR_PWDCIRCLE));
  if (iExpect < 1) then  //handle edge case
    iExpect := 1;

  iTmp := LayoutPwdMask.ChildrenCount;
  if (iExpect > iTmp) then
  begin //add mask circles
    for i := 0 to iExpect - iTmp - 1 do
    begin
      oCircle := TvgCircle.Create(Self);
      oCircle.Parent := LayoutPwdMask;
      oCircle.Align := vaLeft;
      oCircle.HitTest := False;
      oCircle.Width := N_WIDTH_PWDCIRCLE;
      oCircle.Height := N_WIDTH_PWDCIRCLE;
      oCircle.Padding.Right := N_PADDR_PWDCIRCLE;
      oCircle.Fill.Color := '#FF000000';
    end;
  end
  else if iExpect < iTmp then
  begin //delete mask circles
    for i := 0 to iTmp - iExpect - 1 do
    begin
      LayoutPwdMask.Children[0].Free; //coz the LayoutPwdMask.ChildrenCount changes
    end;
    LayoutPwdMask.Realign;
  end;
end;

procedure TPAKMainFrm.MakeTvgTextFit(TxtCtrl: TvgText;MaxWidth:Single);
var
  FontLast: TvgFont;
  oRc: TvgRect;
  fTmp: Single;
begin
  FontLast := TxtCtrl.Canvas.Font;  //assign font
  TxtCtrl.Canvas.Font.Assign(TxtCtrl.Font);
  oRc := vgRect(0, 0, 1000, 1000);
  TxtCtrl.Canvas.MeasureText(oRc, oRc, TxtCtrl.Text, False, TxtCtrl.HorzTextAlign, TxtCtrl.VertTextAlign);

  if vaClient = TxtCtrl.Align then
  begin
    fTmp := (TxtCtrl.Width - (oRc.Right - oRc.Left {+ N_SHORT4MEASURE})) / 2;//N_SHORT4MEASURE: make up the shorter result by MeasureText;
    TxtCtrl.Padding.Left := TxtCtrl.Padding.Left + fTmp;
    TxtCtrl.Padding.Right := TxtCtrl.Padding.Right + fTmp;
  end
  else if vaCenter = TxtCtrl.Align then //Using this For Now!
  begin
    TxtCtrl.Width := oRc.Right - oRc.Left + N_SHORT4MEASURE;//not accurate esp. for english!
    if TxtCtrl.Width > MaxWidth then
      TxtCtrl.Width := MaxWidth;
  end;
  //~!!!Other Align Not  Implement yet!!!!!!!!!!!!!!!!!
  TxtCtrl.Canvas.Font.Assign(FontLast); //recover font
  //ignore other cases as we don't use them..
end;

procedure TPAKMainFrm.OnHeaderBrwAcClick(Sender: TObject);
begin
  with Sender as TvgHeaderItem do
  begin
    case Tag of
      0:
      begin
        //MessageBox(0, 'Header item  User clicked!', 'Test', MB_OK);
      end;
      2:
      begin
        //MessageBox(0, 'Header item Url clicked!', 'Test', MB_OK);
      end;
    end;

  end;
end;

procedure TPAKMainFrm.OnLayoutSettingLeave;
begin
  //reposition Wheel
  BtnSettingWheelCenterClick(BtnSettingWheelCenter);
end;

procedure TPAKMainFrm.OnMenuItem4FileClick(Sender: TObject);
var
  sTmp: string;
begin
  with Sender as TMenuItem do
  begin
    if Integer(mitDetail) = Tag then
    begin
      //MessageBox(0, 'mitDetail', 'TEST',MB_OK);//if use 'Self.Handle' as 1st argument, no effect!
      ApplyMode4LayAcViewer(avmView);
      ShowPAKModul2(@LayoutAcViewer);
    end
    else if Integer(mitDelete) = Tag then
    begin
      sTmp := GetLangStr(lsiSureOprn) + ' [' + GetLangStr(lsiDelete) + ']';
      if mrOk = MessagePopup(GetLangStr(lsiWarn), sTmp, vgMessageConfirmation, [vgButtonCancel, vgButtonOK],
            vgScene1, TxtBrwCurDir, True) then
      begin
        DeleteAc(DataGridAC[FCurViewAcIdx][5]); //ID;
        RefreshGridAC;
      end;
    end
    else if Integer(mitVstUrl) = Tag then
    begin
      ShellExecuteW(0, 'open', PWideChar(VarToStr(DataGridAC[FCurViewAcIdx][2])), nil, nil, SW_SHOWNORMAL);
    end;
  end;
end;

procedure TPAKMainFrm.OnMenuItem4FolderClick(Sender: TObject);
var
  LstItem: TvgListBoxItem;
  TreeItm,TreeItmDel: TvgTreeViewItem;
  sTmp: string;
  I: Integer;
begin
  LstItem := lstFolder.Selected;
  if not Assigned(LstItem) then
    Exit;
    
  with Sender as TMenuItem do
  begin
    if Integer(mitOpen) = Tag then
    begin
      lstFolderDblClick(Self);
    end
    else if Integer(mitRename) = Tag then
    begin
      if FEditShareValueValid then
      begin
        ShowEditShare(LstItem, LstItem.Binding['ItemTxt']);
      end;
    end
    else if Integer(mitMove) = Tag then
    begin
      PopupDirTree.PlacementTarget := lstFolder;
      PopupDirTree.Placement := vgPlacementCenter;
      PopupDirTree.Popup;
    end
    else if Integer(mitDelete) = Tag then
    begin
      //ask first..
      sTmp := GetLangStr(lsiSureOprn) + ' [' + GetLangStr(lsiDelete) + ']' + #13#10 +
        GetLangStr(lsiAllAcGone);
      if mrOk = MessagePopup(GetLangStr(lsiWarn), sTmp, vgMessageConfirmation, [vgButtonCancel, vgButtonOK],
            vgScene1, TxtBrwCurDir, True) then
      begin
        TreeItmDel := nil;
        //1. find the tree item that will be deleted;
        for I := 0 to FCurDirInTree.Count - 1 do
        begin
          TreeItm := FCurDirInTree.ItemByIndex(I);
          if LstItem.Tag = TreeItm.Tag then
          begin
            TreeItmDel := TreeItm;
            System.Break;//Break; Error!'TMenuBreak'
          end;
        end;
        if nil = TreeItmDel then
        begin
          MessagePopup(GetLangStr(lsiError), 'DirTreeModel not Synced!', vgMessageError, [vgButtonOK],
              vgScene1, TxtBrwCurDir, True);
          Exit;
        end;

        //2. delete self and child folders and ACs under it in db..
        if not DeleteFolderInDB(TreeItmDel) then
          Exit;

        //3. delete the corresponding item in DirTree..
        TreeItmDel.Free;//children free inside?
        //move item-related db-data to TrashBox(store for another one month)..
        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

        //4. delete in lstFolder..
        LstItem.Destroy;
      end;

    end;
         
  end;
end;

procedure TPAKMainFrm.PathRearLegLClick(Sender: TObject);
begin
  if ContentContainer.Visible then
  begin
    //ctrls in ContengContainer..
    ContentContainer.Visible := False;
    //ctrls in LayoutTop..
    LayoutAppName.Visible := False;
    vglpsClose.Visible := False;

    //shorten lion..
    Root1.Scale.X := 0.5;
    Root1.Scale.Y := 0.5;
  end
  else begin
    //widen lion..
    Root1.Scale.X := 1;
    Root1.Scale.Y := 1;

    //ctrls in ContentContainer..
    ContentContainer.Visible := True;
    //ctrls in LayoutTop..
    LayoutAppName.Visible := True;
    vglpsClose.Visible := True;
  end;
end;

procedure TPAKMainFrm.RcAuthorClick(Sender: TObject);
var
  frmAbout: TFrmAbout;
  rcMain: TRect;
begin
  if not CheckShareEditValid(TxtBrwCurDir) then
    Exit;

  GetWindowRect(Handle, rcMain);
  frmAbout := TfrmAbout.Create(Self);
  frmAbout.FMainFrmObj := Self;
  frmAbout.LangChanged;
  frmAbout.ShowModal;
  frmAbout.SetBounds(rcMain.Left+(rcMain.Right-rcMain.Left-frmAbout.Width) div 2,
      rcMain.Top+(rcMain.Bottom-frmAbout.Height), frmAbout.Width, frmAbout.Height);
  frmAbout.Free;
end;

procedure TPAKMainFrm.RcAuthorMouseEnter(Sender: TObject);
begin
  PathAuthorEff.Enabled := True;
end;

procedure TPAKMainFrm.RcAuthorMouseLeave(Sender: TObject);
begin
  PathAuthorEff.Enabled := False;
end;

procedure TPAKMainFrm.RcBtnAddClick(Sender: TObject);
begin
  if not LayoutAcViewer.Visible then
  begin
    ApplyMode4LayAcViewer(avmNew);
    ShowPAKModul2(@LayoutAcViewer);//ShowPAKModule(mtAcView);
  end;
end;

procedure TPAKMainFrm.RcBtnBrowseClick(Sender: TObject);
begin
  if not LayoutBrowser.Visible then
    ShowPAKModul2(@LayoutBrowser);//ShowPAKModule(mtBrowse);
end;

procedure TPAKMainFrm.RcBtnSettingClick(Sender: TObject);
begin
  if not LayoutSetting.Visible then
    ShowPAKModul2(@LayoutSetting);//ShowPAKModule(mtSetting);
end;

procedure TPAKMainFrm.RcClpsClick(Sender: TObject);
begin
  RcOprWidthClps.Start;
end;

procedure TPAKMainFrm.RcCoverChangePwdClick(Sender: TObject);
begin
  ShowSetSubmodule(@laySetLOCK);
end;

procedure TPAKMainFrm.RcCoverChangePwdMouseEnter(Sender: TObject);
begin
  BtnChangePwd.Scale.X := F_SCALE_WHEELICON;
  BtnChangePwd.Scale.Y := F_SCALE_WHEELICON;
  EffChangePwd.Parent := BtnChangePwd;
  EffChangePwd.Enabled := True;
end;

procedure TPAKMainFrm.RcCoverChangePwdMouseLeave(Sender: TObject);
begin
  EffChangePwd.Enabled := False;//to avoid repaint when change parent below
  EffChangePwd.Parent := ContentContainer;

  BtnChangePwd.Scale.X := 1.0;
  BtnChangePwd.Scale.Y := 1.0;
end;

procedure TPAKMainFrm.RcCoverHelpClick(Sender: TObject);
begin
  ShowSetSubmodule(@laySetFAQ);
end;

procedure TPAKMainFrm.RcCoverHelpMouseEnter(Sender: TObject);
begin
  BtnHelp.Scale.X := F_SCALE_WHEELICON;
  BtnHelp.Scale.Y := F_SCALE_WHEELICON;
  EffChangePwd.Parent := BtnHelp;
  EffChangePwd.Enabled := True;
end;

procedure TPAKMainFrm.RcCoverHelpMouseLeave(Sender: TObject);
begin
  EffChangePwd.Enabled := False;//to avoid repaint when change parent below
  EffChangePwd.Parent := ContentContainer;

  BtnHelp.Scale.X := 1.0;
  BtnHelp.Scale.Y := 1.0;
end;

procedure TPAKMainFrm.RcCoverOtherSettingClick(Sender: TObject);
begin
  ShowSetSubmodule(@laySetSet);
end;

procedure TPAKMainFrm.RcCoverOtherSettingMouseEnter(Sender: TObject);
begin
  BtnOtherSetting.Scale.X := F_SCALE_WHEELICON;
  BtnOtherSetting.Scale.Y := F_SCALE_WHEELICON;
  EffChangePwd.Parent := BtnOtherSetting;
  EffChangePwd.Enabled := True;
end;

procedure TPAKMainFrm.RcCoverOtherSettingMouseLeave(Sender: TObject);
begin
  EffChangePwd.Enabled := False;//to avoid repaint when change parent below
  EffChangePwd.Parent := ContentContainer;

  BtnOtherSetting.Scale.X := 1.0;
  BtnOtherSetting.Scale.Y := 1.0;
end;

procedure TPAKMainFrm.RcCoverSoftAuthorClick(Sender: TObject);
begin
  RcAuthorClick(Self);
end;

procedure TPAKMainFrm.RcCoverSoftAuthorMouseEnter(Sender: TObject);
begin
  BtnSoftAuthor.Scale.X := F_SCALE_WHEELICON;
  BtnSoftAuthor.Scale.Y := F_SCALE_WHEELICON;
  EffChangePwd.Parent := BtnSoftAuthor;
  EffChangePwd.Enabled := True;
end;

procedure TPAKMainFrm.RcCoverSoftAuthorMouseLeave(Sender: TObject);
begin
  EffChangePwd.Enabled := False;//to avoid repaint when change parent below
  EffChangePwd.Parent := ContentContainer;

  BtnSoftAuthor.Scale.X := 1.0;
  BtnSoftAuthor.Scale.Y := 1.0;
end;

procedure TPAKMainFrm.RcCoverSOSClick(Sender: TObject);
begin
  ShowSetSubmodule(@LaySetSOS);
end;

procedure TPAKMainFrm.RcCoverSOSMouseEnter(Sender: TObject);
begin
  BtnSOS.Scale.X := F_SCALE_WHEELICON;
  BtnSOS.Scale.Y := F_SCALE_WHEELICON;
  EffChangePwd.Parent := BtnSOS;
  EffChangePwd.Enabled := True;
end;

procedure TPAKMainFrm.RcCoverSOSMouseLeave(Sender: TObject);
begin
  EffChangePwd.Enabled := False; //to avoid repaint when change parent below
  EffChangePwd.Parent := ContentContainer;
  BtnSOS.Scale.X := 1.0;
  BtnSOS.Scale.Y := 1.0;
end;

procedure TPAKMainFrm.RcDonateClick(Sender: TObject);
var
  frmDonate: TFormDonate;
  rcMain: TRect;
begin
  if not CheckShareEditValid(TxtBrwCurDir) then
    Exit;

  GetWindowRect(Handle, rcMain);
  frmDonate := TFormDonate.Create(Self);
  frmDonate.FMainFrmObj := Self;
  frmDonate.LangChanged;
  frmDonate.ShowModal;
  frmDonate.SetBounds(rcMain.Left+60, rcMain.Top+(rcMain.Bottom-frmDonate.Height),
    frmDonate.Width, frmDonate.Height);

  frmDonate.Free;
end;

procedure TPAKMainFrm.RcDonateMouseEnter(Sender: TObject);
begin
  PathDonateEff.Enabled := True;
end;

procedure TPAKMainFrm.RcDonateMouseLeave(Sender: TObject);
begin
  PathDonateEff.Enabled := False;
end;

procedure TPAKMainFrm.RcExpandMouseEnter(Sender: TObject);
begin
  RcExpand.Visible := False; //self invisible

  LayoutOpr.Visible := False;
  RcOperation.Visible := True;
  RcOprWidthOut.Start;
end;

procedure TPAKMainFrm.RcOprWidthClpsFinish(Sender: TObject);
begin
  RcOperation.Visible := False;
  RcExpand.Visible := True;
end;

procedure TPAKMainFrm.RcOprWidthOutFinish(Sender: TObject);
begin
  LayoutOpr.Visible := True;
end;

procedure TPAKMainFrm.RefreshGridAC;
var
  sSql: AnsiString;
  I, J, iTmp: Integer;
begin
//在搜索模式下可以将GridAC.tag设置为1;
//不论当前路径，搜索总是全局搜;如果只搜素当前目录,sql语句中FolderIdx还需递归设置不方便;

  //Load all accounts in current dir..
  if TxtBrwCurDir.Tag < 0 then
    Exit;

  ContentContainer.Enabled := False;
  EmptyDataSqlResult;
  if 0 = GridBrwAc.Tag then
    sSql := 'SELECT Usr,Pwd,URL,Note1,Note2,ID FROM '+S_AC_TB+' WHERE FolderIdx='+IntToStr(TxtBrwCurDir.Tag)+';'
  else
    sSql := 'SELECT Usr,Pwd,URL,Note1,Note2,ID,FolderIdx FROM '+S_AC_TB+' WHERE Usr LIKE ''%'+AnsiString(EditSearch.Text)+'%'';';
  if not SQL_Exec(PAnsiChar(sSql), FN_CB_S3, @G_PErrMsg) then
  begin
    MessagePopup(GetLangStr(lsiError), G_PErrMsg, vgMessageError, [vgButtonOK],
      vgScene1, TxtBrwCurDir, True);
    Exit;
  end;
  //copy DataSqlResult --> DataGridAC..
  EmptyDataGridAC;
  SetLength(DataGridAC, Length(DataSqlResult));
  for I := 0 to High(DataSqlResult) do
  begin
    iTmp := Length(DataSqlResult[I]);
    SetLength(DataGridAC[I], iTmp+1);
    //NormalMode: Usr,Pwd,URL,Note1,Note2,ID --> Usr,Pwd,URL,Note1,Note2,ID,RealPwd
    //SearchMode: Usr,Pwd,URL,Note1,Note2,ID,FolderIdx --> Usr,Pwd,URL,Note1,Note2,ID,FolderIdx,RealPwd
    for J := 0 to iTmp - 1 do
    begin
      if 1 = J then
        DataGridAC[I][J] := S_PWDSTAR //PWD MASK;
      else
        DataGridAC[I][J] := DataSqlResult[I][J];
    end;
    DataGridAC[I][GetRealPwdIdx] := DataSqlResult[I][1];
  end;

  ForceGridACDataToUI;

  ContentContainer.Enabled := True;
end;

procedure TPAKMainFrm.ResetLastPwdToMask;
var
  TxtItm: TvgTextBox;
begin
  if -1 <> FLastHoverAcRow then
  begin
    if FLastHoverAcRow < GridBrwAc.RowCount then
    begin
      DataGridAC[FLastHoverAcRow][1] := S_PWDSTAR;
      TxtItm := TvgTextBox(ColBrwAcPwd.CellControlByRow(FLastHoverAcRow));
      if Assigned(TxtItm) then
      begin
        TxtItm.Text := S_PWDSTAR;//force UI refresh!
      end;
    end;

    FLastHoverAcRow := -1;
  end;
end;

function TPAKMainFrm.SetCurDir(AFolder: TvgTreeViewItem; bGoParent:Boolean): Boolean;
var
  I, iTmp: Integer;
  LstItm: TvgListBoxItem;
  TreeItm: TvgTreeViewItem;
begin
  //Don't call this method just to refresh, either go forward or backward!!

  if nil = AFolder then //AFolder is @TreeItemRoot if go to root dir.
  begin
    Result := False;
    Exit;
  end;

  //enable/disable BtnParentFolder..
  if 0 = AFolder.Tag then//ROOT DIR;
    BtnParentFolder.Enabled := False
  else begin
    if not BtnParentFolder.Enabled then
      BtnParentFolder.Enabled := True;
  end;

  //update FCurDirInTree..
  FCurDirInTree := AFolder;

  //update TxtBrwCurDir..(Text and Tag)
  if 0 = AFolder.Tag then //root dir;
  begin
    TxtBrwCurDir.Text := GetLangStr(lsiCurPath)+' \';
    TxtBrwCurDir.Tag := 0;//root index;
  end
  else begin
    if bGoParent then
    begin
      iTmp := 0;
      for I := Length(TxtBrwCurDir.Text) downto 1 do
      begin
        if '\' = TxtBrwCurDir.Text[I] then
        begin
          iTmp := iTmp + 1;
          if 2 = iTmp then
            break;
        end;
      end;
      TxtBrwCurDir.Text := Copy(TxtBrwCurDir.Text, 1, I);//!!!!!!!!!!TEST TEST!!!!!!!
    end
    else begin
      TxtBrwCurDir.Text := IncludeTrailingPathDelimiter(TxtBrwCurDir.Text + AFolder.Text);
    end;
    TxtBrwCurDir.Tag := AFolder.Tag;
  end;

  //update lstFolder..
  lstFolder.Clear;
  for I := 0 to AFolder.Count - 1 do
  begin
    LstItm := CreateLstFderItem;
    TreeItm := AFolder.ItemByIndex(I);
    LstItm.Tag := TreeItm.Tag;
    LstItm.TagString := '1'; //old, not newed;
    LstItm.Binding['ItemTxt'] := TreeItm.Text;
  end;

  //如果是空的，显示"空空如也~"

  //update GridAC..
  GridBrwAC.Tag := 0;//normal mode!
  RefreshGridAC;
end;

procedure TPAKMainFrm.ShowEditShare(LstItem: TvgListBoxItem;ShowTxt: string);
begin
  if nil = LstItem then
    Exit;
  //exception cases. E.g. Click other ctrls to make EditShare lose focus,
  //then EditShare couldn't get focus;
  //In this case, the usr should continue to finish the operation
  if not FEditShareValueValid then
  begin
    EditShare.SetFocus;
    FEditShareKillFoucusCalled := False;
    Exit;
  end;
  
  if LayoutBrowser.Visible then //mtBrowse pattern
  begin
    //--set EditShare inside as we couldn't track the clientrect of listitem on runtime--
    EditShare.Parent := LstItem;
    EditShare.Align := vaBottom;
    EditShare.Height := 32;
    EditShare.Padding.Left := 5;
    EditShare.Padding.Right := 5;
    EditShare.Padding.Bottom := 7;
  end
  else if LayoutAcViewer.Visible then
  begin
    EditShare.Parent := LstItem;
    EditShare.Align := vaClient;
    EditShare.Padding.Left := 170;
    EditShare.Padding.Right := 150;
    EditShare.Padding.Top := 5;
    EditShare.Padding.Bottom := 5;
  end;
  //common procedure..
  EditShare.Tag := LstItem.Index;//clue to find which list item it's on
  EditShare.Visible := True;
  EditShare.Text := ShowTxt;
  EditShare.SelectAll;
  EditShare.SetFocus;
  FEditShareKillFoucusCalled := False;
end;

procedure TPAKMainFrm.ShowPAKModul2(AModule: PTvgLayout);
begin
  //handle globally-shared EditBox Ctrl;
  if not FEditShareValueValid then//operations not ok
  begin
    MessagePopup(GetLangStr(lsiError), GetLangStr(lsiEditShareInUse), vgMessageError, [vgButtonYes],
          vgScene1, LayoutOpr, False);//!!Don't ShowModal or the RcBtnBrowse.Draw() method will crash!!
    Exit;
  end
  else begin
    EditShareKillFocus(Self);
  end;

  if AModule = FCurPakModule then
    Exit;

  if nil <> FCurPakModule then
  begin
    if FCurPakModule = @LayoutAcViewer then //handle exceptions of current module;
    begin
      if not CheckAcInfoStored then
        Exit;
    end
    else if @LayoutSetting = FCurPakModule then
    begin
       OnLayoutSettingLeave;
    end
    else if @LayoutBrowser = FCurPakModule then
    begin
      //..
    end;

    FCurPakModule^.Visible := False; //invisible last module;
  end;

  if nil <> AModule then
    AModule^.Visible := True;
  FCurPakModule := AModule;
end;

procedure TPAKMainFrm.ShowSetSubmodule(AModule: PTvgLayout);
begin
  if nil = AModule then//
  begin
    LaySetModule.Visible := False;
    if nil <> FCurSetSubMod then
      FCurSetSubMod^.Visible := False;
    if 1.0 - vgcrclCircle1.Scale.X > 0.01 then //need to reset scale to 1.0
    begin
      vgcrclCircle1.Parent := LayoutSetting;
      vgcrclCircle1.Align := vaCenter;
      vgcrclCircle1.Width := 384;
      vgcrclCircle1.Height := 384;
      vgcrclCircle1.Scale.X := 1.0;
      vgcrclCircle1.Scale.Y := 1.0;
    end;
  end
  else begin
    //zoom out wheel..
    if vgcrclCircle1.Scale.X - 0.3 > 0.01 then
    begin
      vgcrclCircle1.Scale.X := 0.3;
      vgcrclCircle1.Scale.Y := 0.3;
      vgcrclCircle1.Parent := ContentContainer;
      vgcrclCircle1.Align := vaNone;
      vgcrclCircle1.Position.X := 640;
      vgcrclCircle1.Position.Y := 10;
    end;
    LaySetModule.Visible := True;
    if nil <> FCurSetSubMod then
      FCurSetSubMod^.Visible := False;
    AModule^.Visible := True;
    FCurSetSubMod := AModule;
  end;
end;

{
procedure TPAKMainFrm.ShowPAKModule(typename: TModuleType); //Not efficient, replaced by ShowPAKModul2;
begin
//  if EditShare.Visible then  //waste..
//  begin
//    EditShareKillFocus(Self);
    if not FEditShareValueValid then//operations not ok
    begin
      MessagePopup(GetLangStr(lsiError), GetLangStr(lsiEditShareInUse), vgMessageError, [vgButtonYes],
            vgScene1, LayoutOpr, False);//!!Don't ShowModal or the RcBtnBrowse.Draw() method will crash!!
      Exit;
    end
    else begin
      EditShareKillFocus(Self);
    end;

  if LayoutAcViewer.Visible then
  begin
    if not CheckAcInfoStored then
      Exit;
  end;

  if mtAcView = typename then
  begin
    LayoutBrowser.Visible := False;
    if LayoutSetting.Visible then
    begin
      OnLayoutSettingLeave;
      LayoutSetting.Visible := False;
    end;
    LayoutAcViewer.Visible := True;
  end
  else if mtBrowse = typename then
  begin
    LayoutAcViewer.Visible := False;
    if LayoutSetting.Visible then
    begin
      OnLayoutSettingLeave;
      LayoutSetting.Visible := False;
    end;
    LayoutBrowser.Visible := True;
  end
  else if mtSetting = typename then
  begin
    LayoutAcViewer.Visible := False;
    LayoutBrowser.Visible := False;
    LayoutSetting.Visible := True;
  end;
end;
}

procedure TPAKMainFrm.SplitterBrwDragIng(Sender: TObject);
var
  iNewCol:Integer;
begin
  iNewCol := Round(lstFolder.Width) div 80;
  if iNewCol <> lstFolder.Columns then
     lstFolder.Columns := iNewCol;
end;

procedure TPAKMainFrm.SwitchAcCard(iDirection:Integer);
var
  oTreeItm: TvgTreeViewItem;
begin
  if iDirection < 0 then
    FCurViewAcIdx := FCurViewAcIdx - 1
  else if iDirection > 0 then
    FCurViewAcIdx := FCurViewAcIdx + 1;
  if (FCurViewAcIdx<0) or (FCurViewAcIdx>Length(DataGridAC)-1) then
    Exit;

  AssignAcCardItem(TxtUsr, VarToStr(DataGridAC[FCurViewAcIdx][0]));
  TxtUsr.Tag := 1; //edited yet by user;
  AssignAcCardItem(TxtPwd, VarToStr(DataGridAC[FCurViewAcIdx][GetRealPwdIdx]));
  TxtPwd.Tag := 1; //edited yet by user;
  MakePwdMaskFit(TxtPwd.Width);
  if not LayoutPwdMask.Visible then
    LayoutPwdMask.Visible := True;
  AssignAcCardItem(TxtUrl, VarToStr(DataGridAC[FCurViewAcIdx][2]));
  AssignAcCardItem(TxtNoteShort, VarToStr(DataGridAC[FCurViewAcIdx][3]));
  EditNoteLong.Text := VarToStr(DataGridAC[FCurViewAcIdx][4]);
  TxtAcInfoTip.Tag := DataGridAC[FCurViewAcIdx][5]; //AC Index!
  //if not in search mode, then all ACs have the same parent folder;
  if 0 = GridBrwAc.Tag then
    TxtFolder.Tag := TxtBrwCurDir.Tag
  else
    TxtFolder.Tag := DataGridAC[FCurViewAcIdx][6];//FolderIdx!
  oTreeItm := GetDirTreeItmByID(TxtFolder.Tag);
  AssignAcCardItem(TxtFolder, GetFullPathByTreeNode(@oTreeItm));
  //set left/right arrows' state..
  if FCurViewAcIdx < 1 then
    BtnPrevCard.Visible := False
  else
    BtnPrevCard.Visible := True;
  if FCurViewAcIdx > Length(DataGridAC) - 2 then
    BtnNextCard.Visible := False
  else
    BtnNextCard.Visible := True;
end;

function TPAKMainFrm.SyncFolderToDb(LstItem: PTvgListBoxItem; AName:string): Boolean;
var
  sSql: AnsiString;
  sTmp: string;
  TreeItm: TvgTreeViewItem;
  I: Integer;
begin
  //insert or update sql
  sTmp := StringReplace(AName, '''', '''''', [rfReplaceAll]); //'-->'' (sovle sql conflict)

  if SameStr('0', LstItem^.TagString) then //INSERT
  begin
//    EmptyDataSqlResult; //NO NEED FOR "INSERT" SENTENCE;
    SQL_Exec('BEGIN;', nil, nil);
    sSql := 'INSERT INTO '+S_FOLDER_TB+' VALUES (' + IntToStr(LstItem^.Tag) + ',''' +
      sTmp + ''',' + IntToStr(TxtBrwCurDir.Tag) + ');';
    if not SQL_Exec(PAnsiChar(sSql), nil, @G_PErrMsg) then
    begin
      Result := False;
      Exit;
    end;
    SQL_Exec('COMMIT;', nil, nil);
    LstITEM^.TagString := '1';//folder:new-->old
    //sync new folder to DirTree..
    with TvgTreeViewItem.Create(Self) do
    begin
      Parent := FCurDirInTree;
      Tag := LstItem^.Tag;
      Text := AName;
      TagString := IntToStr(FCurDirInTree.Tag);
    end;
  end
  else if SameStr('1', LstItem^.TagString) then //'1' : UPDATE
  begin
    if FEdtShareTxtChgd then
    begin
      SQL_Exec('BEGIN;', nil, nil);
      sSql := 'UPDATE '+S_FOLDER_TB+ ' SET Name = ''' + sTmp + ''' WHERE ID = '+
        IntToStr(LstItem^.Tag) + ';';
      if not SQL_Exec(PAnsiChar(sSql), FN_CB_S3, @G_PErrMsg) then
      begin
        Result := False;
        Exit;
      end;
      SQL_Exec('COMMIT;', nil, nil);
      //sync changed folder to DirTree..
      for I := 0 to FCurDirInTree.Count - 1 do
      begin
        TreeItm := FCurDirInTree.ItemByIndex(I);
        if LstItem^.Tag = TreeItm.Tag then
        begin
          TreeItm.Text := AName;
          break;
        end;
      end;
    end;
  end;
  Result := True;
end;

procedure TPAKMainFrm.TxtFolderClick(Sender: TObject);
begin
  PopupDirTree.PlacementTarget := TxtFolder;
  PopupDirTree.Placement := vgPlacementBottom;
  PopupDirTree.Popup;
end;

procedure TPAKMainFrm.TxtNoteShortClick(Sender: TObject);
begin
  if FEditShareValueValid then
  begin
    TxtNoteShort.Visible := False;
    ShowEditShare(TvgListBoxItem(TxtNoteShort.Parent), TxtNoteShort.Text);
  end;
end;

procedure TPAKMainFrm.TxtPwdClick(Sender: TObject);
begin
  if FEditShareValueValid then
  begin
    LayoutPwdMask.Visible := False;
    TxtPwd.Visible := False;

    EditShare.Password := True;
    ShowEditShare(TvgListBoxItem(TxtPwd.Parent), TxtPwd.Text);
  end;
end;

procedure TPAKMainFrm.TxtPwdMouseLeave(Sender: TObject);
begin
  if FEditShareValueValid then
  begin
    TxtPwd.Visible := False;
    //if EditShare.Visible and EditShare.Tag = 1
    //   LayoutPwdMask.Visible := False;
    if (not EditShare.Visible) or (1 <> EditShare.Tag) then
      LayoutPwdMask.Visible := True;
  end;
end;

procedure TPAKMainFrm.TxtUrlClick(Sender: TObject);
begin
  if FEditShareValueValid then
  begin
    TxtUrl.Visible := False;
    ShowEditShare(TvgListBoxItem(TxtUrl.Parent), TxtUrl.Text);
  end;
end;

procedure TPAKMainFrm.TxtUsrClick(Sender: TObject);
begin
  if FEditShareValueValid then
  begin
    TxtUsr.Visible := False;
    ShowEditShare(TvgListBoxItem(TxtUsr.Parent), TxtUsr.Text);
  end;

end;

procedure TPAKMainFrm.vglpsCloseMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  ClosePAK;
end;

end.
