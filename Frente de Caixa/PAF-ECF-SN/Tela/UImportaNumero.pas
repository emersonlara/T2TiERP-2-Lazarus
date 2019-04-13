{*******************************************************************************
Title: T2TiPDV
Description: Permite a digitação e importação de um número inteiro.

The MIT License

Copyright: Copyright (C) 2012 T2Ti.COM

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

       The author may be contacted at:
           alberteije@gmail.com

@author T2Ti.COM
@version 1.0
*******************************************************************************}
unit UImportaNumero;

{$mode objfpc}{$H+}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, db, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, curredit, ZDataset, UBase;

type

  { TFImportaNumero }

  TFImportaNumero = class(TFBase)
    LabelEntrada: TLabel;
    EditEntrada: TCurrencyEdit;
    BotaoConfirma: TBitBtn;
    BotaoCancela: TBitBtn;
    Image1: TImage;
    procedure BotaoCancelaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FImportaNumero: TFImportaNumero;

implementation

Uses
UCaixa;

{$R *.lfm}

procedure TFImportaNumero.FormActivate(Sender: TObject);
begin
  Color := StringToColor(Sessao.Configuracao.CorJanelasInternas);
end;

procedure TFImportaNumero.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    botaoCancela.Click;
end;

procedure TFImportaNumero.BotaoCancelaClick(Sender: TObject);
begin
  Close;
end;

end.
