unit PAK_AcCardFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_objects;

type
  TAccountFrm = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Rectangle1: TvgRectangle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AccountFrm: TAccountFrm;

implementation

{$R *.dfm}

end.
