unit PAK_DonateForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_objects, vg_scene, vg_effects, vg_controls, vg_layouts, vg_listbox;

type
  TFormDonate = class(TForm)
    vgScene1: TvgScene;
    vgRoot1: TvgBackground;
    RcTitle: TvgRectangle;
    RcContentContainer: TvgRectangle;
    RcBottom: TvgRectangle;
    ShadowEffect1: TvgShadowEffect;
    RcCover1: TvgRectangle;
    TxtDonateTip1: TvgText;
    BtnDonateClose: TvgButton;
    ImgAuthor: TvgImage;
    TxtDonate3ks: TvgText;
    ImgAlipay: TvgImage;
    TxtDonateAlipayAC: TvgText;
    ImgWeixin: TvgImage;
    TxtDonateWeixinAC: TvgText;
    LstDonateAC: TvgListBox;
    vgExtremeStyleMy: TvgResources;
    ItmDonateAlipay: TvgListBoxItem;
    ItmDonateWeixin: TvgListBoxItem;
    PopAlipayBCode: TvgPopup;
    Image1: TvgImage;
    Rectangle1: TvgRectangle;
    PopWeixinBCode: TvgPopup;
    Rectangle2: TvgRectangle;
    Image2: TvgImage;
    procedure BtnDonateCloseClick(Sender: TObject);
    procedure LstDonateACMouseMove(Sender: TObject; Shift: TShiftState; X, Y,
      Dx, Dy: Single);
    procedure FormCreate(Sender: TObject);
    procedure LstDonateACMouseLeave(Sender: TObject);
  private
    { Private declarations }
    FLastHoverItm: Integer;
  public
    { Public declarations }
    FMainFrmObj: TObject;

    procedure LangChanged;
  end;

var
  FormDonate: TFormDonate;

implementation
uses
  PAK_MainForm, PAK_Language;
{$R *.dfm}

procedure TFormDonate.BtnDonateCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormDonate.FormCreate(Sender: TObject);
begin
  FLastHoverItm := -1;
end;

procedure TFormDonate.LangChanged;
begin
  if nil = FMainFrmObj then
    Exit;
  with FMainFrmObj as TPAKMainFrm do
  begin
    TxtDonate3ks.Text := GetLangStr(lsiDonate3ks)+'!';
    TxtDonateTip1.Text := GetLangStr(lsiDonateTip1)+'!';
    BtnDonateClose.Text := GetLangStr(lsiClose);
  end;
end;

procedure TFormDonate.LstDonateACMouseLeave(Sender: TObject);
begin
  FLastHoverItm := -1;
  PopWeixinBCode.ClosePopup;
  PopAlipayBCode.ClosePopup;
end;

procedure TFormDonate.LstDonateACMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y, Dx, Dy: Single);
var
  ItmDonate: TvgListBoxItem;
begin
  ItmDonate := LstDonateAC.ItemByPoint(X, Y);
  //compare with FLastDonateItm..
  if Assigned(ItmDonate) and (FLastHoverItm <> ItmDonate.Index) then
  begin
    FLastHoverItm := ItmDonate.Index;
    if 0 = FLastHoverItm then
    begin
      PopWeixinBCode.ClosePopup;
      PopAlipayBCode.Popup;
    end
    else begin
      PopAlipayBCode.ClosePopup;
      PopWeixinBCode.Popup;
    end;
  end;
end;

end.
