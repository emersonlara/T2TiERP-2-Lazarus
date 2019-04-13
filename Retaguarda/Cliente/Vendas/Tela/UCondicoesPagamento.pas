{ *******************************************************************************
Title: T2Ti ERP
Description: Janela de Cadastro das Condi��es de Pagamento

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
t2ti.com@gmail.com

@author Albert Eije
@version 2.0
******************************************************************************* }
unit UCondicoesPagamento;

interface

uses
  BrookHTTPClient, BrookFCLHTTPClientBroker, BrookHTTPUtils, BrookUtils, FPJson, ZDataset,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  ComCtrls, LabeledCtrls, rxdbgrid, rxtoolbar, DBCtrls, StrUtils,
  Math, Constantes, CheckLst, ActnList, ToolWin, ShellApi, db, BufDataset, Biblioteca,
  ULookup, VO;

  type

  TFCondicoesPagamento = class(TFTelaCadastro)
    EditNome: TLabeledEdit;
    BevelEdits: TBevel;
    MemoDescricao: TLabeledMemo;
    EditFaturamentoMinimo: TLabeledCalcEdit;
    EditFaturamentoMaximo: TLabeledCalcEdit;
    EditDiasTolerancia: TLabeledCalcEdit;
    EditValorTolerancia: TLabeledCalcEdit;
    EditPrazoMedio: TLabeledCalcEdit;
    EditIndiceCorrecao: TLabeledCalcEdit;
    CDSCondicoesParcelas: TBufDataSet;
    DSCondicoesParcelas: TDataSource;
    GroupBoxParcelas: TGroupBox;
    GridParcelas: TRxDbGrid;
    PopupMenuParcelas: TPopupMenu;
    ExcluirParcela1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ExcluirParcela1Click(Sender: TObject);
    function VerificarParcelas: Boolean;
    procedure BotaoConsultarClick(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;
  end;

var
  FCondicoesPagamento: TFCondicoesPagamento;

implementation

uses UDataModule, VendaCondicoesPagamentoController, VendaCondicoesPagamentoVO,
  VendaCondicoesParcelasVO, VendaCondicoesParcelasController;
{$R *.lfm}

{$REGION 'Infra'}
procedure TFCondicoesPagamento.BotaoConsultarClick(Sender: TObject);
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
    RetornoConsulta := TVendaCondicoesPagamentoController.Consulta(Filtro, IntToStr(Pagina));
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
end;

procedure TFCondicoesPagamento.BotaoSalvarClick(Sender: TObject);
begin
  inherited;
  BotaoConsultarClick(Sender);
end;

procedure TFCondicoesPagamento.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TVendaCondicoesPagamentoVO;
  ObjetoController := TVendaCondicoesPagamentoController.Create;

  inherited;

  ConfiguraCDSFromVO(CDSCondicoesParcelas, TVendaCondicoesParcelasVO);

  BotaoImprimir.Visible := False;
  MenuImprimir.Visible := False;
end;

procedure TFCondicoesPagamento.LimparCampos;
begin
  inherited;
  // Condi��es Parcelas
  CDSCondicoesParcelas.Close;
  CDSCondicoesParcelas.Open;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFCondicoesPagamento.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFCondicoesPagamento.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFCondicoesPagamento.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TVendaCondicoesPagamentoController.Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    BotaoConsultar.Click;
end;

function TFCondicoesPagamento.DoSalvar: Boolean;
var
  CondicoesParcelas: TVendaCondicoesParcelasVO;
begin
  if not VerificarParcelas then begin
    Application.MessageBox('Os valores informados nas taxas n�o fecham em 100%.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    GridParcelas.SetFocus;
    Exit(False);
  end;

  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TVendaCondicoesPagamentoVO.Create;

      TVendaCondicoesPagamentoVO(ObjetoVO).IdEmpresa := Sessao.Empresa.Id;
      TVendaCondicoesPagamentoVO(ObjetoVO).Nome := EditNome.Text;
      TVendaCondicoesPagamentoVO(ObjetoVO).Descricao := MemoDescricao.Text;
      TVendaCondicoesPagamentoVO(ObjetoVO).FaturamentoMinimo := EditFaturamentoMinimo.Value;
      TVendaCondicoesPagamentoVO(ObjetoVO).FaturamentoMaximo := EditFaturamentoMaximo.Value;
      TVendaCondicoesPagamentoVO(ObjetoVO).IndiceCorrecao := EditIndiceCorrecao.Value;
      TVendaCondicoesPagamentoVO(ObjetoVO).DiasTolerancia := EditDiasTolerancia.AsInteger;
      TVendaCondicoesPagamentoVO(ObjetoVO).ValorTolerancia := EditValorTolerancia.Value;
      TVendaCondicoesPagamentoVO(ObjetoVO).PrazoMedio := EditPrazoMedio.AsInteger;

      if StatusTela = stEditando then
        TVendaCondicoesPagamentoVO(ObjetoVO).Id := IdRegistroSelecionado;

      // Condi��es - Parcelas
      CDSCondicoesParcelas.DisableControls;
      CDSCondicoesParcelas.First;
      while not CDSCondicoesParcelas.Eof do
      begin
        CondicoesParcelas := TVendaCondicoesParcelasVO.Create;
        CondicoesParcelas.Id := CDSCondicoesParcelas.FieldByName('ID').AsInteger;
        CondicoesParcelas.IdVendaCondicoesPagamento := TVendaCondicoesPagamentoVO(ObjetoVO).Id;
        CondicoesParcelas.Parcela := CDSCondicoesParcelas.FieldByName('PARCELA').AsInteger;
        CondicoesParcelas.Dias := CDSCondicoesParcelas.FieldByName('DIAS').AsInteger;
        CondicoesParcelas.Taxa := CDSCondicoesParcelas.FieldByName('TAXA').AsFloat;

        TVendaCondicoesPagamentoVO(ObjetoVO).ListaVendaCondicoesParcelasVO.Add(CondicoesParcelas);
        CDSCondicoesParcelas.Next;
      end;
      CDSCondicoesParcelas.EnableControls;

      if StatusTela = stInserindo then
      begin
        TVendaCondicoesPagamentoController.Insere(TVendaCondicoesPagamentoVO(ObjetoVO));
      end
      else if StatusTela = stEditando then
      begin
        /// EXERCICIO: Verifique se tem como serializar as listas junto com o objeto para realizar a compara��o
        //if TVendaCondicoesPagamentoVO(ObjetoVO).ToJSONString <> StringObjetoOld then
        //begin
          TVendaCondicoesPagamentoController.Altera(TVendaCondicoesPagamentoVO(ObjetoVO));
        //end
        //else
        //Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFCondicoesPagamento.GridParaEdits;
var
  IdCabecalho: String;
  Current: TVendaCondicoesParcelasVO;
  I: Integer;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    IdCabecalho := IntToStr(IdRegistroSelecionado);
    ObjetoVO := TVendaCondicoesPagamentoController.ConsultaObjeto('ID=' + IdCabecalho);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditNome.Text := TVendaCondicoesPagamentoVO(ObjetoVO).Nome;
    MemoDescricao.Text := TVendaCondicoesPagamentoVO(ObjetoVO).Descricao;
    EditFaturamentoMinimo.Value := TVendaCondicoesPagamentoVO(ObjetoVO).FaturamentoMinimo;
    EditFaturamentoMaximo.Value := TVendaCondicoesPagamentoVO(ObjetoVO).FaturamentoMaximo;
    EditIndiceCorrecao.Value := TVendaCondicoesPagamentoVO(ObjetoVO).IndiceCorrecao;
    EditDiasTolerancia.AsInteger := TVendaCondicoesPagamentoVO(ObjetoVO).DiasTolerancia;
    EditValorTolerancia.Value := TVendaCondicoesPagamentoVO(ObjetoVO).ValorTolerancia;
    EditPrazoMedio.AsInteger := TVendaCondicoesPagamentoVO(ObjetoVO).PrazoMedio;

    // Condi��es Parcelas
    for I := 0 to TVendaCondicoesPagamentoVO(ObjetoVO).ListaVendaCondicoesParcelasVO.Count - 1 do
    begin
      Current := TVendaCondicoesPagamentoVO(ObjetoVO).ListaVendaCondicoesParcelasVO[I];

      CDSCondicoesParcelas.Append;

      CDSCondicoesParcelas.FieldByName('ID').AsInteger := Current.Id;
      CDSCondicoesParcelas.FieldByName('ID_VENDA_CONDICOES_PAGAMENTO').AsInteger := Current.IdVendaCondicoesPagamento;
      CDSCondicoesParcelas.FieldByName('PARCELA').AsInteger := Current.Parcela;
      CDSCondicoesParcelas.FieldByName('DIAS').AsInteger := Current.Dias;
      CDSCondicoesParcelas.FieldByName('TAXA').AsFloat := Current.Taxa;

      CDSCondicoesParcelas.Post;
    end;

    // Serializa o objeto para consultar posteriormente se houve altera��es
    FormatSettings.DecimalSeparator := '.';
    StringObjetoOld := ObjetoVO.ToJSONString;
    FormatSettings.DecimalSeparator := ',';
  end;
end;

procedure TFCondicoesPagamento.ExcluirParcela1Click(Sender: TObject);
begin
  if CDSCondicoesParcelas.IsEmpty then
    Application.MessageBox('N�o existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      if StatusTela = stInserindo then
        CDSCondicoesParcelas.Delete
      else if StatusTela = stEditando then
      begin
        if TVendaCondicoesParcelasController.Exclui(CDSCondicoesParcelas.FieldByName('ID').AsInteger) then
          CDSCondicoesParcelas.Delete;
      end;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Actions'}
function TFCondicoesPagamento.VerificarParcelas: Boolean;
var
  TotalPorcento: Double;
  ListaDiasParcela: TStringList;
  i: Integer;
  PrazoMedio: Integer;
begin
  Result := False;
  //
  if CDSCondicoesParcelas.IsEmpty then
    exit(True);

  ListaDiasParcela := TStringList.Create;
  TotalPorcento := 0;
  PrazoMedio := 0;
  //
  CDSCondicoesParcelas.DisableControls;
  CDSCondicoesParcelas.First;
  while not CDSCondicoesParcelas.Eof do
  begin
    TotalPorcento := TotalPorcento + CDSCondicoesParcelas.FieldByName('TAXA').AsFloat;
    ListaDiasParcela.Add(CDSCondicoesParcelas.FieldByName('DIAS').AsString);
    CDSCondicoesParcelas.Next;
  end;
  CDSCondicoesParcelas.First;
  CDSCondicoesParcelas.EnableControls;

  //Calcula o prazo m�dio
  for i := 0 to ListaDiasParcela.Count - 1 do
  begin
    if i = 0 then
      PrazoMedio := StrToInt(ListaDiasParcela[i])
    else
      PrazoMedio := PrazoMedio + (StrToInt(ListaDiasParcela[i]) - StrToInt(ListaDiasParcela[i-1]));
  end;
  EditPrazoMedio.AsInteger := Trunc(PrazoMedio / ListaDiasParcela.Count);

  //
  if (TotalPorcento = 100) or (CDSCondicoesParcelas.IsEmpty) then
    Result := True;
end;
{$ENDREGION}

end.

