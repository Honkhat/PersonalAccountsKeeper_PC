object AccountFrm: TAccountFrm
  Left = 314
  Top = 282
  BorderStyle = bsNone
  Caption = 'AccountCard'
  ClientHeight = 403
  ClientWidth = 740
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object vgScene1: TvgScene
    Left = 0
    Top = 0
    Width = 740
    Height = 403
    Align = alClient
    Transparency = True
    ExplicitHeight = 440
    DesignSnapGridShow = False
    DesignSnapToGrid = False
    DesignSnapToLines = True
    object Root1: TvgBackground
      Align = vaClient
      Width = 740.000000000000000000
      Height = 403.000000000000000000
      HitTest = False
      object Rectangle1: TvgRectangle
        Align = vaClient
        Width = 740.000000000000000000
        Height = 403.000000000000000000
        HitTest = False
        Sides = [vgSideTop, vgSideLeft, vgSideBottom, vgSideRight]
      end
    end
  end
end
