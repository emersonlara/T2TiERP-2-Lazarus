{ *******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro PPP - Perfil Profissiográfico Previdenciário

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

@author Albert Eije (alberteije@gmail.com)
@version 2.0
******************************************************************************* }

unit UFolhaPpp;

{$MODE Delphi}

interface

uses
  BrookHTTPClient, BrookFCLHTTPClientBroker, BrookHTTPUtils, BrookUtils, FPJson, ZDataset,
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  ComCtrls, LabeledCtrls, rxdbgrid, rxtoolbar, DBCtrls, StrUtils,
  Math, Constantes, CheckLst, ActnList, ToolWin, db, BufDataset, Biblioteca,
  ULookup, VO;

  type

  TFFolhaPpp = class(TFTelaCadastro)
    ScrollBox: TScrollBox;
    BevelEdits: TBevel;
    PageControlDadosFolhaPpp: TPageControl;
    tsCat: TTabSheet;
    PanelCat: TPanel;
    GridCat: TRxDbGrid;
    tsAtividade: TTabSheet;
    PanelAtividade: TPanel;
    GridAtividade: TRxDbGrid;
    CDSFolhaPppCat: TBufDataSet;
    DSFolhaPppCat: TDataSource;
    CDSFolhaPppAtividade: TBufDataSet;
    DSFolhaPppAtividade: TDataSource;
    tsMovimentacaoBem: TTabSheet;
    PanelFatorRisco: TPanel;
    GridFatorRisco: TRxDbGrid;
    CDSFolhaPppFatorRisco: TBufDataSet;
    DSFolhaPppFatorRisco: TDataSource;
    EditIdColaborador: TLabeledCalcEdit;
    EditColaborador: TLabeledEdit;
    MemoObservacao: TLabeledMemo;
    CDSFolhaPppCatID: TIntegerField;
    CDSFolhaPppCatID_FOLHA_PPP: TIntegerField;
    CDSFolhaPppCatNUMERO_CAT: TIntegerField;
    CDSFolhaPppCatDATA_AFASTAMENTO: TDateField;
    CDSFolhaPppCatDATA_REGISTRO: TDateField;
    CDSFolhaPppAtividadeID: TIntegerField;
    CDSFolhaPppAtividadeID_FOLHA_PPP: TIntegerField;
    CDSFolhaPppAtividadeDATA_INICIO: TDateField;
    CDSFolhaPppAtividadeDATA_FIM: TDateField;
    CDSFolhaPppAtividadeDESCRICAO: TStringField;
    tsExameMedico: TTabSheet;
    PanelExameMedico: TPanel;
    GridExameMedico: TRxDbGrid;
    DSFolhaPppExameMedico: TDataSource;
    CDSFolhaPppExameMedico: TBufDataSet;
    CDSFolhaPppFatorRiscoID: TIntegerField;
    CDSFolhaPppFatorRiscoID_FOLHA_PPP: TIntegerField;
    CDSFolhaPppFatorRiscoDATA_INICIO: TDateField;
    CDSFolhaPppFatorRiscoDATA_FIM: TDateField;
    CDSFolhaPppFatorRiscoTIPO: TStringField;
    CDSFolhaPppFatorRiscoFATOR_RISCO: TStringField;
    CDSFolhaPppFatorRiscoINTENSIDADE: TStringField;
    CDSFolhaPppFatorRiscoTECNICA_UTILIZADA: TStringField;
    CDSFolhaPppFatorRiscoEPC_EFICAZ: TStringField;
    CDSFolhaPppFatorRiscoEPI_EFICAZ: TStringField;
    CDSFolhaPppFatorRiscoCA_EPI: TIntegerField;
    CDSFolhaPppFatorRiscoATENDIMENTO_NR06_1: TStringField;
    CDSFolhaPppFatorRiscoATENDIMENTO_NR06_2: TStringField;
    CDSFolhaPppFatorRiscoATENDIMENTO_NR06_3: TStringField;
    CDSFolhaPppFatorRiscoATENDIMENTO_NR06_4: TStringField;
    CDSFolhaPppFatorRiscoATENDIMENTO_NR06_5: TStringField;
    CDSFolhaPppExameMedicoID: TIntegerField;
    CDSFolhaPppExameMedicoID_FOLHA_PPP: TIntegerField;
    CDSFolhaPppExameMedicoDATA_ULTIMO: TDateField;
    CDSFolhaPppExameMedicoTIPO: TStringField;
    CDSFolhaPppExameMedicoNATUREZA: TStringField;
    CDSFolhaPppExameMedicoEXAME: TStringField;
    CDSFolhaPppExameMedicoINDICACAO_RESULTADOS: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure GridCatKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridAtividadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridFatorRiscoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridExameMedicoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdColaboradorKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BotaoConsultarClick(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
  private
    { Private declarations }
    IdTipoFolhaPpp: Integer;
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;
    procedure ControlaBotoes; override;
    procedure ControlaPopupMenu; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

  end;

var
  FFolhaPpp: TFFolhaPpp;

implementation

uses FolhaPppVO, FolhaPppController, FolhaPppCatVO, FolhaPppAtividadeVO, FolhaPppFatorRiscoVO,
FolhaPppExameMedicoVO, ViewPessoaColaboradorVO, ViewPessoaColaboradorController;
{$R *.lfm}

{$REGION 'Controles Infra'}
procedure TFFolhaPpp.BotaoConsultarClick(Sender: TObject);
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
    RetornoConsulta := TFolhaPppController.Consulta(Filtro, IntToStr(Pagina));
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

procedure TFFolhaPpp.BotaoSalvarClick(Sender: TObject);
begin
  inherited;
  BotaoConsultarClick(Sender);
end;

procedure TFFolhaPpp.FormCreate(Sender: TObject);
var
  Form: TForm;
begin
  ClasseObjetoGridVO := TFolhaPppVO;
  ObjetoController := TFolhaPppController.Create;

  inherited;
end;

procedure TFFolhaPpp.LimparCampos;
var
  i: Integer;
begin
  inherited;

  CDSFolhaPppCat.EmptyDataSet;
  CDSFolhaPppAtividade.EmptyDataSet;
  CDSFolhaPppFatorRisco.EmptyDataSet;
  CDSFolhaPppExameMedico.EmptyDataSet;
end;

procedure TFFolhaPpp.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;

procedure TFFolhaPpp.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFolhaPpp.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdColaborador.SetFocus;
  end;
end;

function TFFolhaPpp.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdColaborador.SetFocus;
  end;
end;

function TFFolhaPpp.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      /// EXERCICIO: que problema pode ocorrer aqui? caso encontre algum, corrija.
      Result := TFolhaPppController.Exclui(IdRegistroSelecionado);
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

function TFFolhaPpp.DoSalvar: Boolean;
var
  FolhaPppCatVO: TFolhaPppCatVO;
  FolhaPppAtividadeVO: TFolhaPppAtividadeVO;
  FolhaPppFatorRiscoVO: TFolhaPppFatorRiscoVO;
  FolhaPppExameMedicoVO: TFolhaPppExameMedicoVO;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TFolhaPppVO.Create;

      TFolhaPppVO(ObjetoVO).IdColaborador := EditIdColaborador.AsInteger;
      TFolhaPppVO(ObjetoVO).ColaboradorNome := EditColaborador.Text;
      TFolhaPppVO(ObjetoVO).Observacao := MemoObservacao.Text;

      /// EXERCICIO: carregue as listas abaixo conforme ensinado na Infra.

      // CAT
      TFolhaPppVO(ObjetoVO).ListaFolhaPppCatVO := TObjectList<TFolhaPppCatVO>.Create;
      CDSFolhaPppCat.DisableControls;
      CDSFolhaPppCat.First;
      while not CDSFolhaPppCat.Eof do
      begin
        FolhaPppCatVO := TFolhaPppCatVO.Create;
        FolhaPppCatVO.Id := CDSFolhaPppCat.FieldByName('ID').AsInteger;
        FolhaPppCatVO.IdFolhaPpp := TFolhaPppVO(ObjetoVO).Id;
        FolhaPppCatVO.NumeroCat := CDSFolhaPppCat.FieldByName('NUMERO_CAT').AsInteger;
        FolhaPppCatVO.DataAfastamento := CDSFolhaPppCat.FieldByName('DATA_AFASTAMENTO').AsDateTime;
        FolhaPppCatVO.DataRegistro := CDSFolhaPppCat.FieldByName('DATA_REGISTRO').AsDateTime;
        TFolhaPppVO(ObjetoVO).ListaFolhaPppCatVO.Add(FolhaPppCatVO);
        CDSFolhaPppCat.Next;
      end;
      CDSFolhaPppCat.EnableControls;

      // Atividade
      TFolhaPppVO(ObjetoVO).ListaFolhaPppAtividadeVO := TObjectList<TFolhaPppAtividadeVO>.Create;
      CDSFolhaPppAtividade.DisableControls;
      CDSFolhaPppAtividade.First;
      while not CDSFolhaPppAtividade.Eof do
      begin
        FolhaPppAtividadeVO := TFolhaPppAtividadeVO.Create;
        FolhaPppAtividadeVO.Id := CDSFolhaPppAtividade.FieldByName('ID').AsInteger;
        FolhaPppAtividadeVO.IdFolhaPpp := TFolhaPppVO(ObjetoVO).Id;
        FolhaPppAtividadeVO.DataInicio := CDSFolhaPppAtividade.FieldByName('DATA_INICIO').AsDateTime;
        FolhaPppAtividadeVO.DataFim := CDSFolhaPppAtividade.FieldByName('DATA_FIM').AsDateTime;
        FolhaPppAtividadeVO.Descricao := CDSFolhaPppAtividade.FieldByName('DESCRICAO').AsString;
        TFolhaPppVO(ObjetoVO).ListaFolhaPppAtividadeVO.Add(FolhaPppAtividadeVO);
        CDSFolhaPppAtividade.Next;
      end;
      CDSFolhaPppAtividade.EnableControls;

      // Fator Risco
      TFolhaPppVO(ObjetoVO).ListaFolhaPppFatorRiscoVO := TObjectList<TFolhaPppFatorRiscoVO>.Create;
      CDSFolhaPppFatorRisco.DisableControls;
      CDSFolhaPppFatorRisco.First;
      while not CDSFolhaPppFatorRisco.Eof do
      begin
        FolhaPppFatorRiscoVO := TFolhaPppFatorRiscoVO.Create;
        FolhaPppFatorRiscoVO.Id := CDSFolhaPppFatorRisco.FieldByName('ID').AsInteger;
        FolhaPppFatorRiscoVO.IdFolhaPpp := TFolhaPppVO(ObjetoVO).Id;
        FolhaPppFatorRiscoVO.DataInicio := CDSFolhaPppFatorRisco.FieldByName('DATA_INICIO').AsDateTime;
        FolhaPppFatorRiscoVO.DataFim := CDSFolhaPppFatorRisco.FieldByName('DATA_FIM').AsDateTime;
        FolhaPppFatorRiscoVO.Tipo := CDSFolhaPppFatorRisco.FieldByName('TIPO').AsString;
        FolhaPppFatorRiscoVO.FatorRisco := CDSFolhaPppFatorRisco.FieldByName('FATOR_RISCO').AsString;
        FolhaPppFatorRiscoVO.Intensidade := CDSFolhaPppFatorRisco.FieldByName('INTENSIDADE').AsString;
        FolhaPppFatorRiscoVO.TecnicaUtilizada := CDSFolhaPppFatorRisco.FieldByName('TECNICA_UTILIZADA').AsString;
        FolhaPppFatorRiscoVO.EpcEficaz := CDSFolhaPppFatorRisco.FieldByName('EPC_EFICAZ').AsString;
        FolhaPppFatorRiscoVO.EpiEficaz := CDSFolhaPppFatorRisco.FieldByName('EPI_EFICAZ').AsString;
        FolhaPppFatorRiscoVO.CaEpi := CDSFolhaPppFatorRisco.FieldByName('CA_EPI').AsInteger;
        FolhaPppFatorRiscoVO.AtendimentoNr061 := CDSFolhaPppFatorRisco.FieldByName('ATENDIMENTO_NR06_1').AsString;
        FolhaPppFatorRiscoVO.AtendimentoNr062 := CDSFolhaPppFatorRisco.FieldByName('ATENDIMENTO_NR06_2').AsString;
        FolhaPppFatorRiscoVO.AtendimentoNr063 := CDSFolhaPppFatorRisco.FieldByName('ATENDIMENTO_NR06_3').AsString;
        FolhaPppFatorRiscoVO.AtendimentoNr064 := CDSFolhaPppFatorRisco.FieldByName('ATENDIMENTO_NR06_4').AsString;
        FolhaPppFatorRiscoVO.AtendimentoNr065 := CDSFolhaPppFatorRisco.FieldByName('ATENDIMENTO_NR06_5').AsString;
        TFolhaPppVO(ObjetoVO).ListaFolhaPppFatorRiscoVO.Add(FolhaPppFatorRiscoVO);
        CDSFolhaPppFatorRisco.Next;
      end;
      CDSFolhaPppFatorRisco.EnableControls;

      // Exame Médico
      TFolhaPppVO(ObjetoVO).ListaFolhaPppExameMedicoVO := TObjectList<TFolhaPppExameMedicoVO>.Create;
      CDSFolhaPppExameMedico.DisableControls;
      CDSFolhaPppExameMedico.First;
      while not CDSFolhaPppExameMedico.Eof do
      begin
        FolhaPppExameMedicoVO := TFolhaPppExameMedicoVO.Create;
        FolhaPppExameMedicoVO.Id := CDSFolhaPppExameMedico.FieldByName('ID').AsInteger;
        FolhaPppExameMedicoVO.IdFolhaPpp := TFolhaPppVO(ObjetoVO).Id;
        FolhaPppExameMedicoVO.DataUltimo := CDSFolhaPppExameMedico.FieldByName('DATA_ULTIMO').AsDateTime;
        FolhaPppExameMedicoVO.Tipo := CDSFolhaPppExameMedico.FieldByName('TIPO').AsString;
        FolhaPppExameMedicoVO.Natureza := CDSFolhaPppExameMedico.FieldByName('NATUREZA').AsString;
        FolhaPppExameMedicoVO.Exame := CDSFolhaPppExameMedico.FieldByName('EXAME').AsString;
        FolhaPppExameMedicoVO.IndicacaoResultados := CDSFolhaPppExameMedico.FieldByName('INDICACAO_RESULTADOS').AsString;
        TFolhaPppVO(ObjetoVO).ListaFolhaPppExameMedicoVO.Add(FolhaPppExameMedicoVO);
        CDSFolhaPppExameMedico.Next;
      end;
      CDSFolhaPppExameMedico.EnableControls;

      if StatusTela = stInserindo then
      begin
        TFolhaPppController.Insere(TFolhaPppVO(ObjetoVO));
      end
      else if StatusTela = stEditando then
      begin
        /// EXERCICIO: Verifique se tem como serializar as listas junto com o objeto para realizar a comparação
        //if TFolhaPppVO(ObjetoVO).ToJSONString <> StringObjetoOld then
        //begin
          TFolhaPppController.Altera(TFolhaPppVO(ObjetoVO));
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
procedure TFFolhaPpp.GridParaEdits;
var
  IdCabecalho: String;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    IdCabecalho := IntToStr(IdRegistroSelecionado);
    ObjetoVO := TFolhaPppController.ConsultaObjeto('ID=' + IdCabecalho);
  end;

  if Assigned(ObjetoVO) then
  begin

    EditIdColaborador.AsInteger := TFolhaPppVO(ObjetoVO).IdColaborador;
    EditColaborador.Text := TFolhaPppVO(ObjetoVO).ColaboradorNome;
    MemoObservacao.Text := TFolhaPppVO(ObjetoVO).Observacao;

    // Preenche as grids internas com os dados das Listas que vieram no objeto
    // CAT
    TController.TratarRetorno<TFolhaPppCatVO>(TFolhaPppVO(ObjetoVO).ListaFolhaPppCatVO, True, True, CDSFolhaPppCat);
    // Atividade
    TController.TratarRetorno<TFolhaPppAtividadeVO>(TFolhaPppVO(ObjetoVO).ListaFolhaPppAtividadeVO, True, True, CDSFolhaPppAtividade);
    // Fator Risco
    TController.TratarRetorno<TFolhaPppFatorRiscoVO>(TFolhaPppVO(ObjetoVO).ListaFolhaPppFatorRiscoVO, True, True, CDSFolhaPppFatorRisco);
    // Exame Médico
    TController.TratarRetorno<TFolhaPppExameMedicoVO>(TFolhaPppVO(ObjetoVO).ListaFolhaPppExameMedicoVO, True, True, CDSFolhaPppExameMedico);


    // Limpa as listas para comparar posteriormente se houve inclusões/alterações e subir apenas o necessário para o servidor
    TFolhaPppVO(ObjetoVO).ListaFolhaPppCatVO.Clear;
    TFolhaPppVO(ObjetoVO).ListaFolhaPppAtividadeVO.Clear;
    TFolhaPppVO(ObjetoVO).ListaFolhaPppFatorRiscoVO.Clear;
    TFolhaPppVO(ObjetoVO).ListaFolhaPppExameMedicoVO.Clear;


    // Serializa o objeto para consultar posteriormente se houve alterações
    FormatSettings.DecimalSeparator := '.';
    StringObjetoOld := ObjetoVO.ToJSONString;
    FormatSettings.DecimalSeparator := ',';
  end;
end;

procedure TFFolhaPpp.GridCatKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridCat.SelectedIndex := GridCat.SelectedIndex + 1;
end;

procedure TFFolhaPpp.GridAtividadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridAtividade.SelectedIndex := GridAtividade.SelectedIndex + 1;
end;

procedure TFFolhaPpp.GridFatorRiscoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridFatorRisco.SelectedIndex := GridFatorRisco.SelectedIndex + 1;
end;

procedure TFFolhaPpp.GridExameMedicoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridExameMedico.SelectedIndex := GridExameMedico.SelectedIndex + 1;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFFolhaPpp.EditIdColaboradorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if Key = VK_F1 then
  begin
    if EditIdColaborador.Value <> 0 then
      Filtro := 'ID = ' + EditIdColaborador.Text
    else
      Filtro := 'ID=0';

    try
      EditIdColaborador.Clear;
      EditColaborador.Clear;

        ViewPessoaColaboradorVO := TViewPessoaColaboradorController.ConsultaObjeto(Filtro);
        if Assigned(ViewPessoaColaboradorVO) then
      begin
        EditIdColaborador.Text := CDSTransiente.FieldByName('ID').AsString;
        EditColaborador.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        MemoObservacao.SetFocus;
      end;
    finally
    end;
  end;
end;
{$ENDREGION}

end.

