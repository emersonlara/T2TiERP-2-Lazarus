{ *******************************************************************************
Title: T2Ti ERP
Description: Janela de Resumo da Tesouraria

The MIT License

Copyright: Copyright (C) 2016 T2Ti.COM

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

@author Albert Eije
@version 2.0
******************************************************************************* }
unit UFinResumoTesouraria;

{$MODE Delphi}

interface

uses
  BrookHTTPClient, BrookFCLHTTPClientBroker, BrookHTTPUtils, BrookUtils, FPJson, ZDataset,
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  ComCtrls, LabeledCtrls, rxdbgrid, rxtoolbar, DBCtrls, StrUtils,
  Math, Constantes, CheckLst, ActnList, ToolWin, db, BufDataset, Biblioteca,
  ULookup, VO, ViewFinResumoTesourariaVO,
  ViewFinResumoTesourariaController;

  type

  { TFFinResumoTesouraria }

  TFFinResumoTesouraria = class(TFTelaCadastro)
    BevelEdits: TBevel;
    CDSResumoTesouraria: TBufDataset;
    PanelEditsInterno: TPanel;
    DSResumoTesouraria: TDataSource;
    EditIdContaCaixa: TLabeledCalcEdit;
    EditContaCaixa: TLabeledEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EditDataInicio: TLabeledDateEdit;
    EditDataFim: TLabeledDateEdit;
    PanelGridInterna: TPanel;
    GridPagamentos: TRxDbGrid;
    PanelTotais: TPanel;
    CDSResumoTesourariaID_CONTA_CAIXA: TIntegerField;
    CDSResumoTesourariaNOME_CONTA_CAIXA: TStringField;
    CDSResumoTesourariaNOME_PESSOA: TStringField;
    CDSResumoTesourariaDATA_LANCAMENTO: TDateField;
    CDSResumoTesourariaDATA_PAGO_RECEBIDO: TDateField;
    CDSResumoTesourariaHISTORICO: TStringField;
    CDSResumoTesourariaVALOR: TFMTBCDField;
    CDSResumoTesourariaDESCRICAO_DOCUMENTO_ORIGEM: TStringField;
    CDSResumoTesourariaOPERACAO: TStringField;
    PanelTotaisGeral: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure BotaoConsultarClick(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CalcularTotais;
    procedure CalcularTotaisGeral;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;
    function MontaFiltro: string; override;

    // Controles CRUD
    function DoEditar: Boolean; override;
  end;

var
  FFinResumoTesouraria: TFFinResumoTesouraria;

implementation

uses
  UTela;

{$R *.lfm}

{$REGION 'Infra'}
procedure TFFinResumoTesouraria.BotaoConsultarClick(Sender: TObject);
var
  RetornoConsulta: TZQuery;
  ListaCampos: TStringList;
  i: integer;
begin
  inherited;

  if Sessao.Camadas = 2 then
  begin
    Filtro := MontaFiltro;

    CDSGrid.Close;
    CDSGrid.Open;
    ConfiguraGridFromVO(Grid, ClasseObjetoGridVO);

    ListaCampos  := TStringList.Create;
    RetornoConsulta := TViewFinResumoTesourariaController.Consulta(Filtro, IntToStr(Pagina));
    RetornoConsulta.Active := True;

    RetornoConsulta.GetFieldNames(ListaCampos);

    RetornoConsulta.First;
    while not RetornoConsulta.EOF do begin
      CDSGrid.Append;
      for i := 0 to ListaCampos.Count - 1 do
      begin
        CDSGrid.FieldByName(ListaCampos[i]).Value := RetornoConsulta.FieldByName(ListaCampos[i]).Value;
      end;
      CDSGrid.Post;
      RetornoConsulta.Next;
    end;
  end;

  CalcularTotaisGeral;
end;

procedure TFFinResumoTesouraria.BotaoSalvarClick(Sender: TObject);
begin
  inherited;
  BotaoConsultarClick(Sender);
end;

procedure TFFinResumoTesouraria.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TViewFinResumoTesourariaVO;
  ObjetoController := TViewFinResumoTesourariaController.Create;

  inherited;

  ConfiguraCDSFromVO(CDSResumoTesouraria, TViewFinResumoTesourariaVO);
end;

procedure TFFinResumoTesouraria.FormShow(Sender: TObject);
begin
  inherited;
  EditDataInicio.Date := Now;
  EditDataFim.Date := Now;
  BotaoImprimir.Visible := False;
  BotaoInserir.Visible := False;
  BotaoExcluir.Visible := False;
  BotaoCancelar.Visible := False;
  BotaoAlterar.Caption := 'Filtrar Conta [F3]';
  BotaoAlterar.Hint := 'Filtrar Conta [F3]';
  BotaoAlterar.Width := 120;
  BotaoSalvar.Caption := 'Retornar [F12]';
  BotaoSalvar.Hint := 'Retornar [F12]';
  MenuImprimir.Visible := False;
  MenuInserir.Visible := False;
  MenuExcluir.Visible := False;
  MenuCancelar.Visible := False;
  MenuAlterar.Caption := 'Filtrar Conta [F3]';
  menuSalvar.Caption := 'Retornar [F12]';
end;

procedure TFFinResumoTesouraria.LimparCampos;
var
  DataInicioInformada, DataFimInformada: TDateTime;
begin
  DataInicioInformada := EditDataInicio.Date;
  DataFimInformada := EditDataFim.Date;
  inherited;
  CDSResumoTesouraria.Close;
  CDSResumoTesouraria.Open;
  EditDataInicio.Date := DataInicioInformada;
  EditDataFim.Date := DataFimInformada;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFinResumoTesouraria.DoEditar: Boolean;
begin
  Result := inherited DoEditar;
  if Result then
  begin
    EditIdContaCaixa.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFFinResumoTesouraria.GridParaEdits;
var
  IdCabecalho: String;
  Filtro: String;
  RetornoConsulta: TZQuery;
  ListaCampos: TStringList;
  I: Integer;
begin
  inherited;

  EditIdContaCaixa.AsInteger := CDSGrid.FieldByName('ID_CONTA_CAIXA').AsInteger;
  EditContaCaixa.Text := CDSGrid.FieldByName('NOME_CONTA_CAIXA').AsString;

  CDSResumoTesouraria.Close;
  CDSResumoTesouraria.Open;

  Filtro := '(DATA_PAGO_RECEBIDO between ' + QuotedStr(DataParaTexto(EditDataInicio.Date)) + ' and ' + QuotedStr(DataParaTexto(EditDataFim.Date)) + ') and ' + 'ID_CONTA_CAIXA=' + QuotedStr(EditIdContaCaixa.Text);

  ListaCampos  := TStringList.Create;
  RetornoConsulta := TViewFinResumoTesourariaController.Consulta(Filtro, '0');
  RetornoConsulta.Active := True;

  RetornoConsulta.GetFieldNames(ListaCampos);

  RetornoConsulta.First;
  while not RetornoConsulta.EOF do begin
    CDSResumoTesouraria.Append;
    for i := 0 to ListaCampos.Count - 1 do
    begin
      CDSResumoTesouraria.FieldByName(ListaCampos[i]).Value := RetornoConsulta.FieldByName(ListaCampos[i]).Value;
    end;
    CDSResumoTesouraria.Post;
    RetornoConsulta.Next;
  end;

  CalcularTotais;
end;
{$ENDREGION}

{$REGION 'Actions'}
function TFFinResumoTesouraria.MontaFiltro: string;
var
  Item: TItemComboBox;
  Idx: Integer;
  DataSetField: TField;
  DataSet: TBufDataset;
begin
  DataSet := CDSGrid;
  if ComboBoxCampos.ItemIndex <> -1 then
  begin
    Idx := ComboBoxCampos.ItemIndex;
    Item := TItemComboBox(ComboBoxCampos.Items.Objects[Idx]);

    Result := '(DATA_PAGO_RECEBIDO between ' + QuotedStr(DataParaTexto(EditDataInicio.Date)) + ' and ' + QuotedStr(DataParaTexto(EditDataFim.Date)) + ') and ' + Item.Campo + ' LIKE ' + QuotedStr('%' + EditCriterioRapido.Text + '%');
  end
  else
  begin
    Result := ' 1=1 ';
  end;
end;

procedure TFFinResumoTesouraria.CalcularTotais;
var
  Recebimentos, Pagamentos, Saldo: Extended;
begin
  Recebimentos := 0;
  Pagamentos := 0;
  Saldo := 0;
  //
  CDSResumoTesouraria.DisableControls;
  CDSResumoTesouraria.First;
  while not CDSResumoTesouraria.Eof do
  begin
    if CDSResumoTesouraria.FieldByName('OPERACAO').AsString = 'S' then
      Pagamentos := Pagamentos + CDSResumoTesouraria.FieldByName('VALOR').AsFloat
    else if CDSResumoTesouraria.FieldByName('OPERACAO').AsString = 'E' then
      Recebimentos := Recebimentos + CDSResumoTesouraria.FieldByName('VALOR').AsFloat;
    CDSResumoTesouraria.Next;
  end;
  CDSResumoTesouraria.First;
  CDSResumoTesouraria.EnableControls;
  //
  PanelTotais.Caption := '|      Recebimentos: ' +  FloatToStrF(Recebimentos, ffCurrency, 15, 2) +
                        '      |      Pagamentos: ' +   FloatToStrF(Pagamentos, ffCurrency, 15, 2) +
                        '      |      Saldo: ' +   FloatToStrF(Recebimentos - Pagamentos, ffCurrency, 15, 2) + '      |';
end;

procedure TFFinResumoTesouraria.CalcularTotaisGeral;
var
  Recebimentos, Pagamentos, Saldo: Extended;
begin
  Recebimentos := 0;
  Pagamentos := 0;
  Saldo := 0;
  //
  CDSGrid.DisableControls;
  CDSGrid.First;
  while not CDSGrid.Eof do
  begin
    if CDSGrid.FieldByName('OPERACAO').AsString = 'S' then
      Pagamentos := Pagamentos + CDSGrid.FieldByName('VALOR').AsFloat
    else if CDSGrid.FieldByName('OPERACAO').AsString = 'E' then
      Recebimentos := Recebimentos + CDSGrid.FieldByName('VALOR').AsFloat;
    CDSGrid.Next;
  end;
  CDSGrid.First;
  CDSGrid.EnableControls;
  //
  PanelTotaisGeral.Caption := '|      Recebimentos: ' +  FloatToStrF(Recebimentos, ffCurrency, 15, 2) +
                        '      |      Pagamentos: ' +   FloatToStrF(Pagamentos, ffCurrency, 15, 2) +
                        '      |      Saldo: ' +   FloatToStrF(Recebimentos - Pagamentos, ffCurrency, 15, 2) + '      |';
end;
{$ENDREGION}

end.

