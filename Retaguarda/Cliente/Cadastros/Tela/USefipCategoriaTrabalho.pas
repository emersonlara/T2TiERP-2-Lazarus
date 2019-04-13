{*******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de SefipCategoriaTrabalho

The MIT License

Copyright: Copyright (C) 2015 T2Ti.COM

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
           t2ti.com@gmail.com</p>

t2ti.com@gmail.com
@author Albert Eije (T2Ti.COM)
@version 2.0
*******************************************************************************}
unit USefipCategoriaTrabalho;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, SefipCategoriaTrabalhoVO,
  SefipCategoriaTrabalhoController, Tipos, Atributos, Constantes, LabeledCtrls,
  Mask, JvExMask, JvToolEdit, JvBaseEdits, Controller, rxdbgrid;

type

  { TFSefipCategoriaTrabalho }

  TFSefipCategoriaTrabalho = class(TFTelaCadastro)
    BevelEdits: TBevel;
    BotaoExportar: TSpeedButton;
    BotaoImprimir: TSpeedButton;
    BotaoSair: TSpeedButton;
    BotaoSeparador1: TSpeedButton;
    Grid: TRxDBGrid;
    MemoNome: TLabeledMemo;
    EditCodigo: TLabeledCalcEdit;
    PageControl: TPageControl;
    PaginaGrid: TTabSheet;
    PanelFiltroRapido: TPanel;
    PanelGrid: TPanel;
    PanelToolBar: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure ControlaBotoes; override;
  end;

var
  FSefipCategoriaTrabalho: TFSefipCategoriaTrabalho;

implementation

{$R *.lfm}

{$REGION 'Infra'}
procedure TFSefipCategoriaTrabalho.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TSefipCategoriaTrabalhoVO;
  ObjetoController := TSefipCategoriaTrabalhoController.Create;

  inherited;
end;

procedure TFSefipCategoriaTrabalho.ControlaBotoes;
begin
  inherited;

  BotaoInserir.Visible := False;
  BotaoAlterar.Visible := False;
  BotaoExcluir.Visible := False;
  BotaoSalvar.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFSefipCategoriaTrabalho.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := TSefipCategoriaTrabalhoVO(TController.BuscarObjeto('SefipCategoriaTrabalhoController.TSefipCategoriaTrabalhoController', 'ConsultaObjeto', ['ID=' + IdRegistroSelecionado.ToString], 'GET'));
  end;

  if Assigned(ObjetoVO) then
  begin
    EditCodigo.AsInteger := TSefipCategoriaTrabalhoVO(ObjetoVO).Codigo;
    MemoNome.Text := TSefipCategoriaTrabalhoVO(ObjetoVO).Nome;
  end;
end;
{$ENDREGION}

end.
