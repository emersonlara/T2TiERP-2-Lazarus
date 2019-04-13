{ *******************************************************************************
Title: T2Ti ERP
Description: Janela de Lan�amentos para o m�dulo Contabilidade

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

@author Albert Eije (t2ti.com@gmail.com)
@version 2.0
******************************************************************************* }
unit UContabilLancamento;

{$MODE Delphi}

interface

uses
  BrookHTTPClient, BrookFCLHTTPClientBroker, BrookHTTPUtils, BrookUtils, FPJson, ZDataset,
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  ComCtrls, LabeledCtrls, rxdbgrid, rxtoolbar, DBCtrls, StrUtils,
  Math, Constantes, CheckLst, ActnList, ToolWin, db, BufDataset, Biblioteca,
  ULookup, VO, ContabilLancamentoCabecalhoVO,
  ContabilLancamentoCabecalhoController;

  type

  { TFContabilLancamento }

  TFContabilLancamento = class(TFTelaCadastro)
    CDSContabilLancamentoDetalhe: TBufDataset;
    DSContabilLancamentoDetalhe: TDataSource;
    PanelMestre: TPanel;
    EditIdLote: TLabeledCalcEdit;
    EditLote: TLabeledEdit;
    PageControlItens: TPageControl;
    tsItens: TTabSheet;
    PanelItens: TPanel;
    GridDetalhe: TRxDbGrid;
    ComboBoxTipo: TLabeledComboBox;
    EditDataLancamento: TLabeledDateEdit;
    EditDataInclusao: TLabeledDateEdit;
    ComboBoxLiberado: TLabeledComboBox;
    EditValor: TLabeledCalcEdit;
    procedure FormCreate(Sender: TObject);
    procedure GridDetalheKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdLoteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure BotaoConsultarClick(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
  private
    { Private declarations }
    function VerificarLancamentos: Boolean;
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

    procedure ConfigurarLayoutTela;
  end;

var
  FContabilLancamento: TFContabilLancamento;

implementation

uses UDataModule, ContabilLancamentoDetalheVO, ContabilLoteVO,
ContabilLoteController, ContabilContaVO, ContabilContaController, ContabilHistoricoVO,
ContabilHistoricoController;
{$R *.lfm}

{$REGION 'Controles Infra'}
procedure TFContabilLancamento.BotaoConsultarClick(Sender: TObject);
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
    RetornoConsulta := TContabilLancamentoCabecalhoController.Consulta(Filtro, IntToStr(Pagina));
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

procedure TFContabilLancamento.BotaoSalvarClick(Sender: TObject);
begin
  inherited;
  BotaoConsultarClick(Sender);
end;

procedure TFContabilLancamento.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TContabilLancamentoCabecalhoVO;
  ObjetoController := TContabilLancamentoCabecalhoController.Create;

  inherited;
  BotaoImprimir.Visible := False;
  MenuImprimir.Visible := False;

  ConfiguraCDSFromVO(CDSContabilLancamentoDetalhe, TContabilLancamentoDetalheVO);
  ConfiguraGridFromVO(GridDetalhe, TContabilLancamentoDetalheVO);
end;

procedure TFContabilLancamento.LimparCampos;
begin
  inherited;
  CDSContabilLancamentoDetalhe.Close;
  CDSContabilLancamentoDetalhe.Open;
end;

procedure TFContabilLancamento.ConfigurarLayoutTela;
begin
  PanelEdits.Enabled := True;

  if StatusTela = stNavegandoEdits then
  begin
    PanelMestre.Enabled := False;
    PanelItens.Enabled := False;
  end
  else
  begin
    PanelMestre.Enabled := True;
    PanelItens.Enabled := True;
  end;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFContabilLancamento.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditIdLote.SetFocus;
  end;
end;

function TFContabilLancamento.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditIdLote.SetFocus;
  end;
end;

function TFContabilLancamento.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TContabilLancamentoCabecalhoController.Exclui(IdRegistroSelecionado);
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

function TFContabilLancamento.DoSalvar: Boolean;
var
  ContabilLancamentoDetalhe: TContabilLancamentoDetalheVO;
begin
  if VerificarLancamentos then
  begin
    Result := inherited DoSalvar;

    if Result then
    begin
      try
        if not Assigned(ObjetoVO) then
          ObjetoVO := TContabilLancamentoCabecalhoVO.Create;

        TContabilLancamentoCabecalhoVO(ObjetoVO).IdEmpresa := Sessao.Empresa.Id;
        TContabilLancamentoCabecalhoVO(ObjetoVO).IdContabilLote := EditIdLote.AsInteger;
        TContabilLancamentoCabecalhoVO(ObjetoVO).LoteDescricao := EditLote.Text;
        TContabilLancamentoCabecalhoVO(ObjetoVO).DataLancamento := EditDataLancamento.Date;
        TContabilLancamentoCabecalhoVO(ObjetoVO).DataInclusao := EditDataInclusao.Date;
        TContabilLancamentoCabecalhoVO(ObjetoVO).Liberado := IfThen(ComboBoxLiberado.ItemIndex = 0, 'S', 'N');
        TContabilLancamentoCabecalhoVO(ObjetoVO).Valor := EditValor.Value;
        TContabilLancamentoCabecalhoVO(ObjetoVO).Tipo := Copy(ComboBoxTipo.Text, 1, 4);

        // Detalhes
        CDSContabilLancamentoDetalhe.DisableControls;
        CDSContabilLancamentoDetalhe.First;
        while not CDSContabilLancamentoDetalhe.Eof do
        begin
            ContabilLancamentoDetalhe := TContabilLancamentoDetalheVO.Create;
            ContabilLancamentoDetalhe.Id := CDSContabilLancamentoDetalhe.FieldByName('ID').AsInteger;
            ContabilLancamentoDetalhe.IdContabilLancamentoCab := TContabilLancamentoCabecalhoVO(ObjetoVO).Id;
            ContabilLancamentoDetalhe.IdContabilConta := CDSContabilLancamentoDetalhe.FieldByName('ID_CONTABIL_CONTA').AsInteger;
            ContabilLancamentoDetalhe.IdContabilHistorico := CDSContabilLancamentoDetalhe.FieldByName('ID_CONTABIL_HISTORICO').AsInteger;
            ContabilLancamentoDetalhe.Historico := CDSContabilLancamentoDetalhe.FieldByName('HISTORICO').AsString;
            ContabilLancamentoDetalhe.Tipo := CDSContabilLancamentoDetalhe.FieldByName('TIPO').AsString;
            ContabilLancamentoDetalhe.Valor := CDSContabilLancamentoDetalhe.FieldByName('VALOR').AsFloat;
            TContabilLancamentoCabecalhoVO(ObjetoVO).ListaContabilLancamentoDetalheVO.Add(ContabilLancamentoDetalhe);
          CDSContabilLancamentoDetalhe.Next;
        end;
        CDSContabilLancamentoDetalhe.EnableControls;

        if StatusTela = stInserindo then
        begin
        TContabilLancamentoCabecalhoController.Insere(TContabilLancamentoCabecalhoVO(ObjetoVO));
        end
        else if StatusTela = stEditando then
      begin
        /// EXERCICIO: Verifique se tem como serializar as listas junto com o objeto para realizar a compara��o
        //if TContabilLancamentoCabecalhoVO(ObjetoVO).ToJSONString <> StringObjetoOld then
        //begin
          TContabilLancamentoCabecalhoController.Altera(TContabilLancamentoCabecalhoVO(ObjetoVO));
        //end
        //else
        //Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
        end;
      except
        Result := False;
      end;
    end;
  end
  else
    Exit(False);
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFContabilLancamento.GridDetalheKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  {

  /// EXERCICIO: Implemente a busca usando a janela de lookup

  if Key = VK_F1 then
  begin
    try
      if GridDetalhe.Columns[GridDetalhe.SelectedIndex].Field.FieldName = 'ID_CONTABIL_CONTA' then
      begin
        if Assigned(IndiceEconomicoVO) then
        begin
          CDSContabilLancamentoDetalhe.Edit;
          CDSContabilLancamentoDetalhe.FieldByName('ID_CONTABIL_CONTA').AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
          CDSContabilLancamentoDetalhe.FieldByName('CONTABIL_CONTACLASSIFICACAO').AsString := CDSTransiente.FieldByName('CLASSIFICACAO').AsString;
          CDSContabilLancamentoDetalhe.FieldByName('TIPO').AsString := CDSTransiente.FieldByName('NATUREZA').AsString;
          CDSContabilLancamentoDetalhe.Post;
        end;
      end
      else if GridDetalhe.Columns[GridDetalhe.SelectedIndex].Field.FieldName = 'HISTORICO' then
      begin
        if Assigned(IndiceEconomicoVO) then
        begin
          CDSContabilLancamentoDetalhe.Edit;
          CDSContabilLancamentoDetalhe.FieldByName('ID_CONTABIL_HISTORICO').AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
          CDSContabilLancamentoDetalhe.FieldByName('HISTORICO').AsString := CDSTransiente.FieldByName('HISTORICO').AsString;
          CDSContabilLancamentoDetalhe.Post;
        end;
      end;
    finally
    end;
  end;
  }
  If Key = VK_RETURN then
    EditIdLote.SetFocus;
end;

procedure TFContabilLancamento.GridParaEdits;
var
  IdCabecalho: String;
  I: Integer;
  Current: TContabilLancamentoDetalheVO;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    IdCabecalho := IntToStr(IdRegistroSelecionado);
    ObjetoVO := TContabilLancamentoCabecalhoController.ConsultaObjeto('ID=' + IdCabecalho);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdLote.AsInteger := TContabilLancamentoCabecalhoVO(ObjetoVO).IdContabilLote;
    EditLote.Text := TContabilLancamentoCabecalhoVO(ObjetoVO).LoteDescricao;
    EditDataLancamento.Date := TContabilLancamentoCabecalhoVO(ObjetoVO).DataLancamento;
    EditDataInclusao.Date := TContabilLancamentoCabecalhoVO(ObjetoVO).DataInclusao;
    ComboBoxLiberado.ItemIndex := AnsiIndexStr(TContabilLancamentoCabecalhoVO(ObjetoVO).Liberado, ['S', 'N']);
    EditValor.Value := TContabilLancamentoCabecalhoVO(ObjetoVO).Valor;
    ComboBoxTipo.ItemIndex := AnsiIndexStr(TContabilLancamentoCabecalhoVO(ObjetoVO).Tipo, ['UDVC', 'UCVD', 'UDUC', 'VDVC']);

    // Detalhes
    for I := 0 to TContabilLancamentoCabecalhoVO(ObjetoVO).ListaContabilLancamentoDetalheVO.Count - 1 do
    begin
      Current := TContabilLancamentoCabecalhoVO(ObjetoVO).ListaContabilLancamentoDetalheVO[I];

      CDSContabilLancamentoDetalhe.Append;
      CDSContabilLancamentoDetalhe.FieldByName('ID').AsInteger := Current.id;
      CDSContabilLancamentoDetalhe.FieldByName('ID_CONTABIL_LANCAMENTO_CAB').AsInteger := Current.IdContabilLancamentoCab;
      CDSContabilLancamentoDetalhe.FieldByName('ID_CONTABIL_CONTA').AsInteger := Current.IdContabilConta;
      //CDSContabilLancamentoDetalhe.FieldByName('CONTABIL_CONTACLASSIFICACAO').AsString := Current.ContabilContaVO.Classificacao;
      CDSContabilLancamentoDetalhe.FieldByName('ID_CONTABIL_HISTORICO').AsInteger := Current.IdContabilHistorico;
      CDSContabilLancamentoDetalhe.FieldByName('HISTORICO').AsString := Current.Historico;
      CDSContabilLancamentoDetalhe.FieldByName('TIPO').AsString := Current.Tipo;
      CDSContabilLancamentoDetalhe.FieldByName('VALOR').AsFloat := Current.Valor;
      CDSContabilLancamentoDetalhe.Post;
    end;

    // Serializa o objeto para consultar posteriormente se houve altera��es
    FormatSettings.DecimalSeparator := '.';
    StringObjetoOld := ObjetoVO.ToJSONString;
    FormatSettings.DecimalSeparator := ',';
  end;

  ConfigurarLayoutTela;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFContabilLancamento.EditIdLoteKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
  ContabilLoteVO :TContabilLoteVO ;
begin
  if Key = VK_F1 then
  begin
    if EditIdLote.Value <> 0 then
      Filtro := 'ID = ' + EditIdLote.Text
    else
      Filtro := 'ID=0';

    try
      EditIdLote.Clear;
      EditLote.Clear;

      ContabilLoteVO := TContabilLoteController.ConsultaObjeto(Filtro);
      if Assigned(ContabilLoteVO) then
      begin
        EditLote.Text := ContabilLoteVO.Descricao;
        EditDataLancamento.SetFocus;
      end
      else
      begin
        Exit;
      end;
    finally
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Actions'}
function TFContabilLancamento.VerificarLancamentos: Boolean;
var
  Creditos, Debitos: Extended;
  QuantidadeCreditos, QuantidadeDebitos: Integer;
  Mensagem: String;
begin
  Creditos := 0;
  Debitos := 0;
  QuantidadeCreditos := 0;
  QuantidadeDebitos := 0;
  Result := False;
  //
  CDSContabilLancamentoDetalhe.DisableControls;
  CDSContabilLancamentoDetalhe.First;
  while not CDSContabilLancamentoDetalhe.Eof do
  begin
    if CDSContabilLancamentoDetalhe.FieldByName('TIPO').AsString = 'C' then
    begin
      Inc(QuantidadeCreditos);
      Creditos := Creditos + CDSContabilLancamentoDetalhe.FieldByName('VALOR').AsFloat;
    end
    else if CDSContabilLancamentoDetalhe.FieldByName('TIPO').AsString = 'D' then
    begin
      Inc(QuantidadeDebitos);
      Debitos := Debitos + CDSContabilLancamentoDetalhe.FieldByName('VALOR').AsFloat;
    end;
    CDSContabilLancamentoDetalhe.Next;
  end;
  CDSContabilLancamentoDetalhe.First;
  CDSContabilLancamentoDetalhe.EnableControls;

  { Verifica os totais }
  if Creditos <> Debitos then
    Mensagem := Mensagem + #13 + 'Total de cr�ditos difere do total de d�bitos.';

  { Verifica os tipos de lan�amento }
  // UDVC - Um D�bito para V�rios Cr�ditos
  if ComboBoxTipo.ItemIndex = 0 then
  begin
    if QuantidadeDebitos > 1  then
      Mensagem := Mensagem + #13 + 'UDVC - Mais do que um d�bito informado.';
    if QuantidadeDebitos < 1  then
      Mensagem := Mensagem + #13 + 'UDVC - Nenhum d�bito informado.';
    if QuantidadeCreditos < 1  then
      Mensagem := Mensagem + #13 + 'UDVC - Nenhum cr�dito informado.';
    if QuantidadeCreditos = 1  then
      Mensagem := Mensagem + #13 + 'UDVC - Apenas um cr�dito informado.';
  end;

  // UCVD - Um Cr�dito para V�rios D�bitos
  if ComboBoxTipo.ItemIndex = 1 then
  begin
    if QuantidadeCreditos > 1  then
      Mensagem := Mensagem + #13 + 'UCVD - Mais do que um cr�dito informado.';
    if QuantidadeCreditos < 1  then
      Mensagem := Mensagem + #13 + 'UCVD - Nenhum cr�dito informado.';
    if QuantidadeDebitos < 1  then
      Mensagem := Mensagem + #13 + 'UCVD - Nenhum d�bito informado.';
    if QuantidadeDebitos = 1  then
      Mensagem := Mensagem + #13 + 'UCVD - Apenas um d�bito informado.';
  end;

  // UDUC - Um D�bito para Um Cr�dito
  if ComboBoxTipo.ItemIndex = 2 then
  begin
    if QuantidadeCreditos > 1  then
      Mensagem := Mensagem + #13 + 'UDUC - Mais do que um cr�dito informado.';
    if QuantidadeDebitos > 1  then
      Mensagem := Mensagem + #13 + 'UDUC - Mais do que um cr�dito informado.';
    if QuantidadeCreditos < 1  then
      Mensagem := Mensagem + #13 + 'UDUC - Nenhum cr�dito informado.';
    if QuantidadeDebitos < 1  then
      Mensagem := Mensagem + #13 + 'UDUC - Nenhum d�bito informado.';
  end;

  // VDVC - V�rios D�bitos para V�rios Cr�ditos
  if ComboBoxTipo.ItemIndex = 3 then
  begin
    if QuantidadeCreditos < 1  then
      Mensagem := Mensagem + #13 + 'VDVC - Nenhum cr�dito informado.';
    if QuantidadeDebitos < 1  then
      Mensagem := Mensagem + #13 + 'VDVC - Nenhum d�bito informado.';
    if QuantidadeCreditos = 1  then
      Mensagem := Mensagem + #13 + 'VDVC - Apenas um cr�dito informado.';
    if QuantidadeDebitos = 1  then
      Mensagem := Mensagem + #13 + 'VDVC - Apenas um d�bito informado.';
  end;

  if Mensagem <> '' then
  begin
    Application.MessageBox(PChar('Ocorreram erros na valida��o dos dados informados. Lista de erros abaixo: ' + #13 + Mensagem), 'Erro do sistema', MB_OK + MB_ICONERROR);
    Result := False;
  end
  else
    Result := True;
end;
{$ENDREGION}

end.

