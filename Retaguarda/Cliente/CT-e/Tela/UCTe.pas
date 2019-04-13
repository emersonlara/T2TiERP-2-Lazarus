{ *******************************************************************************
Title: T2Ti ERP
Description: Janela Para Emiss�o de CT-e

The MIT License

Copyright: Copyright (C) 2017 T2Ti.COM

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

@author Albert Eije (alberteije@gmail.com)
@version 2.0
******************************************************************************* }
unit UCTe;

{$MODE Delphi}

interface

uses
  BrookHTTPClient, BrookFCLHTTPClientBroker, BrookHTTPUtils, BrookUtils, FPJson, ZDataset,
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  ComCtrls, LabeledCtrls, rxdbgrid, rxtoolbar, DBCtrls, StrUtils,
  Math, Constantes, CheckLst, ActnList, ToolWin, db, BufDataset, Biblioteca,
  ULookup, VO;
{
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, Atributos, Constantes,
  ActnList, RibbonSilverStyleActnCtrls, ActnMan, JvExStdCtrls, JvEdit,
  JvValidateEdit, JvCombobox, Mask, JvExMask, JvToolEdit, ToolWin,
  ActnCtrls, Generics.Collections, ACBrDFeUtil, pcnConversao, StrUtils,
  LabeledCtrls, DB, DBClient, JvBaseEdits, JvExExtCtrls, JvNetscapeSplitter,
  Biblioteca, Actions, EmpresaVO, NFeConfiguracaoVO, NFeNumeroVO,
  ACBrCTe, ACBrCTeDACTEClass, ACBrBase, ACBrDFe, ACBrCTeDACTeRLClass,
  pcteConversaoCTe, ACBrUtil, ACBrCTeConhecimentos, Controller;

}type

  { TFCTe }

  TFCTe = class(TFTelaCadastro)
    ActionManager: TActionList;
    BotaoAlterar: TSpeedButton;
    BotaoConsultar: TSpeedButton;
    BotaoExportar: TSpeedButton;
    BotaoFiltrar: TSpeedButton;
    BotaoImprimir: TSpeedButton;
    BotaoSair: TSpeedButton;
    BotaoSeparador1: TSpeedButton;
    EditCriterioRapido: TLabeledMaskEdit;
    Grid: TRxDbGrid;
    PageControl: TPageControl;
    PaginaEdits: TTabSheet;
    PaginaGrid: TTabSheet;
    PanelEdits: TPanel;
    PanelFiltroRapido: TPanel;
    PanelGrid: TPanel;
    PanelToolBar: TPanel;
    PopupMenuAtalhosBotoesTela: TPopupMenu;
    PopupMenuAtalhosBotoesTelaCadastro: TPopupMenu;
    PopupMenuExportar: TPopupMenu;
    ScrollBox: TScrollBox;
    BevelEdits: TBevel;
    ActionToolBarEdits: TToolPanel;
    PageControlEdits: TPageControl;
    TabSheetDadosNotaFiscal: TTabSheet;
    PanelDadosCTe: TPanel;
    EditNumeroCTe: TLabeledEdit;
    EditSerie: TLabeledEdit;
    EditNaturezaOperacao: TLabeledEdit;
    GroupBoxDestinatario: TGroupBox;
    EditDestinatarioCpfCnpj: TLabeledEdit;
    EditDestinatarioIE: TLabeledEdit;
    EditDestinatarioTelefone: TLabeledEdit;
    EditDestinatarioLogradouro: TLabeledEdit;
    EditDestinatarioNumero: TLabeledEdit;
    EditDestinatarioBairro: TLabeledEdit;
    EditDestinatarioCEP: TLabeledEdit;
    EditDestinatarioCidade: TLabeledEdit;
    EditDestinatarioUF: TLabeledEdit;
    EditDestinatarioComplemento: TLabeledEdit;
    EditDestinatarioRazao: TLabeledEdit;
    EditDestinatarioEmail: TLabeledEdit;
    TabSheetTipoTransporte: TTabSheet;
    TabSheetEntregaRetirada: TTabSheet;
    PanelEntregaRetirada: TPanel;
    GroupBoxEntrega: TGroupBox;
    EditEntregaCpfCnpj: TLabeledEdit;
    EditEntregaLogradouro: TLabeledEdit;
    EditEntregaNumero: TLabeledEdit;
    EditEntregaBairro: TLabeledEdit;
    EditEntregaCidade: TLabeledEdit;
    EditEntregaUf: TLabeledEdit;
    EditEntregaComplemento: TLabeledEdit;
    GroupBoxRetirada: TGroupBox;
    EditRetiradaCpfCnpj: TLabeledEdit;
    EditRetiradaLogradouro: TLabeledEdit;
    EditRetiradaNumero: TLabeledEdit;
    EditRetiradaBairro: TLabeledEdit;
    EditRetiradaCidade: TLabeledEdit;
    EditRetiradaUf: TLabeledEdit;
    EditRetiradaComplemento: TLabeledEdit;
    TabSheetNF: TTabSheet;
    PanelDetalhes: TPanel;
    GridItens: TRxDbGrid;
    TabSheetInformacoesAdicionais: TTabSheet;
    TabSheetCobranca: TTabSheet;
    PanelCobranca: TPanel;
    PanelFatura: TPanel;
    GroupBoxFatura: TGroupBox;
    EditFaturaNumero: TLabeledEdit;
    TabSheetRespostaSefaz: TTabSheet;
    MemoRespostas: TMemo;
    EditDataHoraEmissao: TLabeledDateEdit;
    EditDataEntradaSaida: TLabeledDateEdit;
    EditHoraEntradaSaida: TLabeledMaskEdit;
    ComboTipoOperacao: TLabeledComboBox;
    ComboTipoEmissao: TLabeledComboBox;
    ComboFinalidadeEmissao: TLabeledComboBox;
    ComboFormaImpDaCTe: TLabeledComboBox;
    ComboBoxFormaPagamento: TLabeledComboBox;
    EditChaveAcesso: TLabeledEdit;
    GroupBox1: TGroupBox;
    GridDuplicatas: TRxDbGrid;
    EditFaturaValorOriginal: TLabeledCalcEdit;
    EditFaturaValorDesconto: TLabeledCalcEdit;
    EditFaturaValorLiquido: TLabeledCalcEdit;
    EditCodigoNumerico: TLabeledEdit;
    EditDigitoChaveAcesso: TLabeledEdit;
    EditEntregaIbge: TLabeledCalcEdit;
    EditRetiradaIbge: TLabeledCalcEdit;
    PageControlReferenciado: TPageControl;
    TabSheetTransporteRodoviario: TTabSheet;
    TabSheetTransporteAereo: TTabSheet;
    TabSheetTransporteAquaviario: TTabSheet;
    TabSheetTransporteFerroviario: TTabSheet;
    GridCTeReferenciada: TRxDbGrid;
    EditDestinatarioId: TLabeledCalcEdit;
    ComboboxModeloNotaFiscal: TLabeledComboBox;
    PageControlTotais: TPageControl;
    tsTotaisGeral: TTabSheet;
    PanelTotais: TPanel;
    EditBCIcms: TLabeledCalcEdit;
    EditValorIcms: TLabeledCalcEdit;
    EditBCIcmsSt: TLabeledCalcEdit;
    EditValorIcmsSt: TLabeledCalcEdit;
    EditValorCreditoPresumidoICMS: TLabeledCalcEdit;
    EditValorICMSOutraUF: TLabeledCalcEdit;
    EditSimplesNacionalTotal: TLabeledCalcEdit;
    EditValorTotalCarga: TLabeledCalcEdit;
    PanelInformacoesAdicionais: TPanel;
    ActionToolBar1: TToolPanel;
    PanelDetalhesAnexo: TPanel;
    JvNetscapeSplitter1: TJvNetscapeSplitter;
    ActionIncluirItem: TAction;
    ActionExcluirItem: TAction;
    ActionExcluirTipoTransporte: TAction;
    ActionToolBar2: TToolPanel;
    ActionToolBar3: TToolPanel;
    ActionExcluirEntregaRetirada: TAction;
    ActionExcluirTransporte: TAction;
    ActionToolBar5: TToolPanel;
    ActionExcluirCobranca: TAction;
    ActionSelecionarCertificado: TAction;
    ActionConsultarSefaz: TAction;
    ActionImprimirDaCTe: TAction;
    ActionCancelarCTe: TAction;
    ActionEnviar: TAction;
    ActionAssinar: TAction;
    ActionValidar: TAction;
    ActionAtualizarTotais: TAction;
    EditIdVenda: TLabeledCalcEdit;
    EditDestinatarioCodigoIbge: TLabeledEdit;
    ActionInutilizarCTe: TAction;
    ActionCCe: TAction;
    Button1: TButton;
    PageControlInformacoesAdicionais: TPageControl;
    TabSheet1: TTabSheet;
    Remetente: TTabSheet;
    Recebedor: TTabSheet;
    Expedidor: TTabSheet;
    Tomador: TTabSheet;
    GroupBox2: TGroupBox;
    EditCnpjEmitente: TLabeledEdit;
    EditIeEmitente: TLabeledEdit;
    EditTelefoneEmitente: TLabeledEdit;
    EditLogradouroEmitente: TLabeledEdit;
    EditNumeroEmitente: TLabeledEdit;
    EditBairroEmitente: TLabeledEdit;
    EditCepEmitente: TLabeledEdit;
    EditCidadeEmitente: TLabeledEdit;
    EditUfEmitente: TLabeledEdit;
    EditComplementoEmitente: TLabeledEdit;
    EditNomeEmitente: TLabeledEdit;
    EditEmailEmitente: TLabeledEdit;
    EditIdEmitente: TLabeledCalcEdit;
    EditIbgeEmitente: TLabeledEdit;
    GroupBox3: TGroupBox;
    EditCnpjRemetente: TLabeledEdit;
    EditIeRemetente: TLabeledEdit;
    EditTelefoneRemetente: TLabeledEdit;
    EditLogradouroRemetente: TLabeledEdit;
    EditNumeroRemetente: TLabeledEdit;
    EditBairroRemetente: TLabeledEdit;
    EditCepRemetente: TLabeledEdit;
    EditCidadeRemetente: TLabeledEdit;
    EditUfRemetente: TLabeledEdit;
    EditComplementoRemetente: TLabeledEdit;
    EditNomeRemetente: TLabeledEdit;
    EditEmailRemetente: TLabeledEdit;
    EditIdRemetente: TLabeledCalcEdit;
    EditIbgeRemetente: TLabeledEdit;
    EditCpfRemetente: TLabeledEdit;
    GroupBox4: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    LabeledEdit12: TLabeledEdit;
    LabeledCalcEdit1: TLabeledCalcEdit;
    LabeledEdit13: TLabeledEdit;
    LabeledEdit14: TLabeledEdit;
    GroupBox5: TGroupBox;
    LabeledEdit15: TLabeledEdit;
    LabeledEdit16: TLabeledEdit;
    LabeledEdit17: TLabeledEdit;
    LabeledEdit18: TLabeledEdit;
    LabeledEdit19: TLabeledEdit;
    LabeledEdit20: TLabeledEdit;
    LabeledEdit21: TLabeledEdit;
    LabeledEdit22: TLabeledEdit;
    LabeledEdit23: TLabeledEdit;
    LabeledEdit24: TLabeledEdit;
    LabeledEdit25: TLabeledEdit;
    LabeledEdit26: TLabeledEdit;
    LabeledCalcEdit2: TLabeledCalcEdit;
    LabeledEdit27: TLabeledEdit;
    LabeledEdit28: TLabeledEdit;
    GroupBox6: TGroupBox;
    LabeledEdit29: TLabeledEdit;
    LabeledEdit30: TLabeledEdit;
    LabeledEdit31: TLabeledEdit;
    LabeledEdit32: TLabeledEdit;
    LabeledEdit33: TLabeledEdit;
    LabeledEdit34: TLabeledEdit;
    LabeledEdit35: TLabeledEdit;
    LabeledEdit36: TLabeledEdit;
    LabeledEdit37: TLabeledEdit;
    LabeledEdit38: TLabeledEdit;
    LabeledEdit39: TLabeledEdit;
    LabeledEdit40: TLabeledEdit;
    LabeledCalcEdit3: TLabeledCalcEdit;
    LabeledEdit41: TLabeledEdit;
    LabeledEdit42: TLabeledEdit;
    EditAereoNumeroMinuta: TLabeledEdit;
    LabeledEdit43: TLabeledEdit;
    LabeledDateEdit1: TLabeledDateEdit;
    GroupBox7: TGroupBox;
    LabeledEdit44: TLabeledEdit;
    LabeledEdit45: TLabeledEdit;
    LabeledEdit46: TLabeledEdit;
    LabeledDateEdit2: TLabeledDateEdit;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    JvDBUltimGrid2: TRxDbGrid;
    TabSheet5: TTabSheet;
    JvDBUltimGrid3: TRxDbGrid;
    JvDBUltimGrid1: TRxDbGrid;
    JvDBUltimGrid4: TRxDbGrid;
    GroupBox8: TGroupBox;
    LabeledEdit48: TLabeledEdit;
    LabeledEdit49: TLabeledEdit;
    LabeledCalcEdit4: TLabeledCalcEdit;
    LabeledCalcEdit5: TLabeledCalcEdit;
    PageControl2: TPageControl;
    TabSheet6: TTabSheet;
    JvDBUltimGrid5: TRxDbGrid;
    GroupBox9: TGroupBox;
    LabeledEdit47: TLabeledEdit;
    LabeledEdit50: TLabeledEdit;
    LabeledCalcEdit6: TLabeledCalcEdit;
    PageControl3: TPageControl;
    TabSheet7: TTabSheet;
    JvDBUltimGrid6: TRxDbGrid;
    TabSheet8: TTabSheet;
    JvDBUltimGrid7: TRxDbGrid;
    ActionStatusServico: TAction;
    procedure FormCreate(Sender: TObject);
    procedure GridItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActionIncluirItemExecute(Sender: TObject);
    procedure ActionExcluirItemExecute(Sender: TObject);
    procedure ActionExcluirEntregaRetiradaExecute(Sender: TObject);
    procedure ActionExcluirCobrancaExecute(Sender: TObject);
    procedure ActionSelecionarCertificadoExecute(Sender: TObject);
    procedure ActionConsultarSefazExecute(Sender: TObject);
    procedure ActionImprimirDaCTeExecute(Sender: TObject);
    procedure ActionCancelarCTeExecute(Sender: TObject);
    procedure ActionEnviarExecute(Sender: TObject);
    procedure ActionAssinarExecute(Sender: TObject);
    procedure ActionValidarExecute(Sender: TObject);
    procedure ActionAtualizarTotaisExecute(Sender: TObject);
    procedure ActionGerarXmlExecute(Sender: TObject);
    procedure EditDestinatarioIdKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdVendaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActionInutilizarCTeExecute(Sender: TObject);
    procedure ActionCCeExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ActionStatusServicoExecute(Sender: TObject);
    procedure BotaoConsultarClick(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
  private
    { Private declarations }
    procedure ConfigurarCTe;
    procedure LimparCamposDestinatario;
    procedure ExcluirDadosEntregaRetirada;
    procedure ExcluirDadosCobranca;
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
  FCTe: TFCTe;
  ObjetoNFeConfiguracaoVO: TNFeConfiguracaoVO;
  NFeNumeroVO: TNFeNumeroVO;
  Mensagem: String;

implementation

uses UDataModuleCTe, UDataModule, UCTeDetalheAnexo,
  CTeCabecalhoController,
  CTeCabecalhoVO, CTeDuplicataVO, CTeInformacaoNfOutrosVO,
  ViewPessoaClienteVO, ViewPessoaClienteController,
  ViewPessoaTransportadoraVO, ViewPessoaTransportadoraController,
  ProdutoVO, ProdutoController, TributOperacaoFiscalController,
  VendaCabecalhoVO, VendaCabecalhoController, FinLancamentoReceberVO, FinParcelaReceberVO,
  FinLancamentoReceberController, NfeCabecalhoVO, NfeCabecalhoController,
  NFeNumeroController, NFeConfiguracaoController, EmpresaController;

{$R *.lfm}
{ TFCTe }

{$REGION 'Infra'}
procedure TFCTe.BotaoConsultarClick(Sender: TObject);
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
    RetornoConsulta := TCTeController.Consulta(Filtro, IntToStr(Pagina));
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

procedure TFCTe.BotaoSalvarClick(Sender: TObject);
begin
  inherited;
  BotaoConsultarClick(Sender);
end;

procedure TFCTe.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TCTeCabecalhoVO;
  ObjetoController := TCTeCabecalhoController.Create;
  inherited;

  FCTeDetalheAnexo := TFCTeDetalheAnexo.Create(PanelDetalhesAnexo);
  with FCTeDetalheAnexo do
  begin
    Align := alClient;
    BorderStyle := bsNone;
    Parent := PanelDetalhesAnexo;
  end;
  FCTeDetalheAnexo.Show;

  ConfiguraCDSFromVO(FDataModuleCTe.CDSDuplicata, TCTeDuplicataVO);
  ConfiguraGridFromVO(GridDuplicatas, TCTeDuplicataVO);

  ConfiguraCDSFromVO(FDataModuleCTe.CDSCTeNF, TCTeInformacaoNfOutrosVO);
  ConfiguraGridFromVO(GridItens, TCTeInformacaoNfOutrosVO);

  /// EXERCICIO
  ///  Adicione ao DataModule os demais CDS e fa�a as devidas configura��es


  /// EXERCICIO
  ///  � necess�rio criar uma tabela de configura��o exclusiva para o CTe?
  ObjetoNFeConfiguracaoVO := TNFeConfiguracaoController.ConsultaObjeto('ID=1'); //ObjetoNFeConfiguracaoVO := TNFeConfiguracaoVO(TController.BuscarObjeto('NFeConfiguracaoController.TNFeConfiguracaoController', 'ConsultaObjeto', ['ID=1'], 'GET'));

  FiltroComplementar := '';
end;

procedure TFCTe.LimparCampos;
begin
  inherited;
  FDataModuleCTe.CDSCTeNF.Close;
  FDataModuleCTe.CDSCTeNF.Open;
  FDataModuleCTe.CDSDuplicata.Close;
  FDataModuleCTe.CDSDuplicata.Open;
  ConfigurarLayoutTela;
end;

procedure TFCTe.LimparCamposDestinatario;
begin
  EditDestinatarioCpfCnpj.Clear;
  EditDestinatarioRazao.Clear;
  EditDestinatarioLogradouro.Clear;
  EditDestinatarioNumero.Clear;
  EditDestinatarioComplemento.Clear;
  EditDestinatarioBairro.Clear;
  EditDestinatarioCodigoIbge.Clear;
  EditDestinatarioCidade.Clear;
  EditDestinatarioUF.Clear;
  EditDestinatarioCEP.Clear;
  EditDestinatarioTelefone.Clear;
  EditDestinatarioIE.Clear;
  EditDestinatarioEmail.Clear;
end;

procedure TFCTe.ConfigurarLayoutTela;
begin
  PageControlEdits.ActivePageIndex := 0;
end;

procedure TFCTe.ConfigurarCTe;
begin

  ObjetoNFeConfiguracaoVO := TNFeConfiguracaoVO.Create;
  ObjetoNFeConfiguracaoVO.SalvarXml := 'S';
  ObjetoNFeConfiguracaoVO.WebserviceUf := 'DF';
  ObjetoNFeConfiguracaoVO.WebserviceAmbiente := 1;
  ObjetoNFeConfiguracaoVO.WebserviceVisualizar := 'S';
  ObjetoNFeConfiguracaoVO.CaminhoSalvarXml := 'C:\T2Ti\NFe\XML\';
  ObjetoNFeConfiguracaoVO.CaminhoSchemas := 'C:\Temp\ACBrDFe\Schemas\CTe';
  ObjetoNFeConfiguracaoVO.CertificadoDigitalSerie := '00d243d0';


  if ObjetoNFeConfiguracaoVO.SalvarXml = 'S' then
    FDataModule.ACBrCTe.Configuracoes.Geral.Salvar := True
  else
    FDataModule.ACBrCTe.Configuracoes.Geral.Salvar := False;

  FDataModule.ACBrCTe.Configuracoes.WebServices.Uf := ObjetoNFeConfiguracaoVO.WebserviceUf;

  if ObjetoNFeConfiguracaoVO.WebserviceAmbiente = 0 then
    FDataModule.ACBrCTe.Configuracoes.WebServices.Ambiente := taProducao
  else
    FDataModule.ACBrCTe.Configuracoes.WebServices.Ambiente := taHomologacao;

  if ObjetoNFeConfiguracaoVO.WebserviceVisualizar = 'S' then
    FDataModule.ACBrCTe.Configuracoes.WebServices.Visualizar := True
  else
    FDataModule.ACBrCTe.Configuracoes.WebServices.Visualizar := False;

  FDataModule.ACBrCTe.Configuracoes.Arquivos.PathSalvar := ObjetoNFeConfiguracaoVO.CaminhoSalvarXml;
  FDataModule.ACBrCTe.Configuracoes.Arquivos.PathSchemas := ObjetoNFeConfiguracaoVO.CaminhoSchemas;

  FDataModule.ACBrCTe.Configuracoes.Certificados.NumeroSerie := ObjetoNFeConfiguracaoVO.CertificadoDigitalSerie;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFCTe.DoInserir: Boolean;
begin
  try
    Result := inherited DoInserir;

    if Result then
    begin
      ConfigurarCTe;

      /// EXERCICIO:
      ///  � preciso/permitido trabalhar com o n�mero e a s�rie separados
      ///  assim como fizemos com a NFe? Controle os n�meros do CT-e
      ///  pois abaixo estamos utilizando a numera��o da NF-e

      //Pega um n�mero
      NFeNumeroVO := TNFeNumeroController.ConsultaObjeto('1=1');// TNFeNumeroVO(TController.BuscarObjeto('NFeNumeroController.', 'ConsultaObjeto', ['1=1'], 'GET'));

      //Persiste a nota com o status "0 - Em Edi��o"
      EditDataHoraEmissao.Date := Now;
      EditDataEntradaSaida.Date := Now;
      EditHoraEntradaSaida.Text := FormatDateTime('hh:MM:ss', Now);
      EditSerie.Text := NFeNumeroVO.Serie;
      EditNumeroCTe.Text := StringOfChar('0', 9 - Length(IntToStr(NFeNumeroVO.Numero))) + IntToStr(NFeNumeroVO.Numero);
      EditCodigoNumerico.Text := StringOfChar('0', 8 - Length(IntToStr(NFeNumeroVO.Numero))) + IntToStr(NFeNumeroVO.Numero);
      EditChaveAcesso.Text :=   IntToStr(Sessao.Empresa.CodigoIbgeUf) +
                                FormatDateTime('yy', EditDataHoraEmissao.Date) +
                                FormatDateTime('mm', EditDataHoraEmissao.Date) +
                                Sessao.Empresa.Cnpj +
                                '55' +
                                EditSerie.Text +
                                EditNumeroCTe.Text +
                                '1' +
                                EditCodigoNumerico.Text;
      EditDigitoChaveAcesso.Text := Modulo11(EditChaveAcesso.Text);
      EditChaveAcesso.Text := EditChaveAcesso.Text + EditDigitoChaveAcesso.Text;

      BotaoSalvar.Click;
      BotaoAlterar.Click;
    end;
  finally
    FreeAndNil(NFeNumeroVO);
  end;
end;

function TFCTe.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    ConfigurarCTe;
    StatusTela := stEditando;
    EditIdVenda.SetFocus;
  end;
end;

function TFCTe.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TCTeController.Exclui(IdRegistroSelecionado);
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

function TFCTe.DoSalvar: Boolean;
var
  CTeNF: TCteInformacaoNfOutrosVO;
begin
  FormatSettings.DecimalSeparator := '.';

  if StatusTela = stEditando then
  begin
    if (Trim(EditNumeroCTe.Text) = '') or (Trim(EditChaveAcesso.Text) = '') then
    begin
      Application.MessageBox('N�mero da nota ou chave de acesso n�o podem ficar em branco.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      Exit(False);
    end;

    ActionAtualizarTotais.Execute;
  end;

  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TCTeCabecalhoVO.Create;

      TCTeCabecalhoVO(ObjetoVO).IdEmpresa := Sessao.Empresa.Id;
      TCTeCabecalhoVO(ObjetoVO).EmpresaVO := TEmpresaController.ConsultaObjeto('ID=' + Sessao.Empresa.Id.ToString);//TEmpresaVO(TController.BuscarObjeto('EmpresaController.TEmpresaController', 'ConsultaObjeto', ['ID=' + Sessao.Empresa.Id.ToString], 'GET'));;

      /// EXERCICIO
      ///  Complemente o c�digo com os objetos e campos faltantes

      TCTeCabecalhoVO(ObjetoVO).UfEmitente := UFToInt(Sessao.Empresa.EnderecoPrincipal.Uf);
      TCTeCabecalhoVO(ObjetoVO).CodigoNumerico := EditCodigoNumerico.Text;
      TCTeCabecalhoVO(ObjetoVO).NaturezaOperacao := EditNaturezaOperacao.Text;
      TCTeCabecalhoVO(ObjetoVO).FormaPagamento := ComboBoxFormaPagamento.ItemIndex;
      TCTeCabecalhoVO(ObjetoVO).Modelo := Copy(ComboboxModeloNotaFiscal.Text, 1, 2);
      TCTeCabecalhoVO(ObjetoVO).Serie := EditSerie.Text;
      TCTeCabecalhoVO(ObjetoVO).Numero := EditNumeroCTe.Text;
      TCTeCabecalhoVO(ObjetoVO).DataHoraEmissao := EditDataHoraEmissao.Date;
      if Trim(EditDestinatarioCodigoIbge.Text) <> '' then
        TCTeCabecalhoVO(ObjetoVO).CodigoMunicipioEnvio := StrToInt(EditDestinatarioCodigoIbge.Text);
      TCTeCabecalhoVO(ObjetoVO).FormatoImpressaoDaCTe := ComboFormaImpDaCTe.ItemIndex;
      TCTeCabecalhoVO(ObjetoVO).TipoEmissao := ComboTipoEmissao.ItemIndex;
      TCTeCabecalhoVO(ObjetoVO).ChaveAcesso := EditChaveAcesso.Text;
      TCTeCabecalhoVO(ObjetoVO).DigitoChaveAcesso := EditDigitoChaveAcesso.Text;
      TCTeCabecalhoVO(ObjetoVO).Ambiente := ObjetoNFeConfiguracaoVO.WebserviceAmbiente;
      TCTeCabecalhoVO(ObjetoVO).ProcessoEmissao := ObjetoNFeConfiguracaoVO.ProcessoEmissao;
      TCTeCabecalhoVO(ObjetoVO).VersaoProcessoEmissao := ObjetoNFeConfiguracaoVO.VersaoProcessoEmissao;
      TCTeCabecalhoVO(ObjetoVO).BaseCalculoIcms := EditBCIcms.Value;
      TCTeCabecalhoVO(ObjetoVO).ValorIcms := EditValorIcms.Value;
      TCTeCabecalhoVO(ObjetoVO).ValorBcIcmsStRetido := EditBCIcmsSt.Value;
      TCTeCabecalhoVO(ObjetoVO).ValorIcmsStRetido := EditValorIcmsSt.Value;
      TCTeCabecalhoVO(ObjetoVO).ValorTotalCarga := EditValorTotalCarga.Value;

      //TCTeCabecalhoVO(ObjetoVO).InformacoesAddFisco := MemoInfComplementarFisco.Text;

      // a nota s� fica em modo de inser��o no in�cio para pegar seu n�mero, logo depois
      // ela fica sempre em modo de edi��o
      if StatusTela = stEditando then
      begin
        TCTeCabecalhoVO(ObjetoVO).Id := IdRegistroSelecionado;

        { Destinatario }
        TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.IdCTeCabecalho := TCTeCabecalhoVO(ObjetoVO).Id;
        TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Cnpj := EditDestinatarioCpfCnpj.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Nome := EditDestinatarioRazao.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Logradouro := EditDestinatarioLogradouro.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Numero := EditDestinatarioNumero.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Complemento := EditDestinatarioComplemento.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Bairro := EditDestinatarioBairro.Text;
        if Trim(EditDestinatarioCodigoIbge.Text) <> '' then
          TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.CodigoMunicipio := StrToInt(EditDestinatarioCodigoIbge.Text);
        TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.NomeMunicipio := EditDestinatarioCidade.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Uf := EditDestinatarioUF.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Cep := EditDestinatarioCEP.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.CodigoPais := 1058;
        TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.NomePais := 'Brazil';
        TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Telefone := EditDestinatarioTelefone.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Ie := EditDestinatarioIE.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Email := EditDestinatarioEmail.Text;

        { CTe Notas Fiscais }
        FDataModuleCTe.CDSCTeNF.First;
        while not FDataModuleCTe.CDSCTeNF.Eof do
        begin
          CTeNF := TCteInformacaoNfOutrosVO.Create;
          CTeNF.IdCTeCabecalho := TCTeCabecalhoVO(ObjetoVO).Id;
          if FDataModuleCTe.CDSCTeNF.FieldByName('PERSISTE').AsString  = 'I' then
            CTeNF.Id := 0
          else
            CTeNF.Id := FDataModuleCTe.CDSCTeNF.FieldByName('ID').AsInteger;
          CTeNF.DataEmissao := FDataModuleCTe.CDSCTeNF.FieldByName('DATA_EMISSAO').AsDateTime;
          CTeNF.NumeroRomaneio := FDataModuleCTe.CDSCTeNF.FieldByName('NUMERO_ROMANEIO').AsString;
          CTeNF.NumeroPedido := FDataModuleCTe.CDSCTeNF.FieldByName('NUMERO_PEDIDO').AsString;
          CTeNF.ChaveAcessoNFe := FDataModuleCTe.CDSCTeNF.FieldByName('CHAVE_ACESSO_NFE').AsString;
          CTeNF.CodigoModelo := FDataModuleCTe.CDSCTeNF.FieldByName('CODIGO_MODELO').AsString;
          CTeNF.Serie := FDataModuleCTe.CDSCTeNF.FieldByName('SERIE').AsString; ;
          CTeNF.Numero := FDataModuleCTe.CDSCTeNF.FieldByName('NUMERO').AsString;
          CTeNF.UfEmitente := FDataModuleCTe.CDSCTeNF.FieldByName('UF_EMITENTE').AsInteger;
          CTeNF.PinSuframa := FDataModuleCTe.CDSCTeNF.FieldByName('PIN_SUFRAMA').AsInteger;
          CTeNF.CfopPredominante := FDataModuleCTe.CDSCTeNF.FieldByName('CFOP_PREDOMINANTE').AsInteger;
          CTeNF.BaseCalculoIcms := FDataModuleCTe.CDSCTeNF.FieldByName('BASE_CALCULO_ICMS').AsFloat;
          CTeNF.ValorIcms := FDataModuleCTe.CDSCTeNF.FieldByName('VALOR_ICMS').AsFloat;
          CTeNF.BaseCalculoIcmsSt := FDataModuleCTe.CDSCTeNF.FieldByName('BASE_CALCULO_ICMS_ST').AsFloat;
          CTeNF.ValorIcmsSt := FDataModuleCTe.CDSCTeNF.FieldByName('VALOR_ICMS_ST').AsFloat;
          CTeNF.ValorTotalProdutos := FDataModuleCTe.CDSCTeNF.FieldByName('VALOR_TOTAL_PRODUTOS').AsFloat;
          CTeNF.ValorTotal := FDataModuleCTe.CDSCTeNF.FieldByName('VALOR_TOTAL').AsFloat;
          CTeNF.PesoTotalKg := FDataModuleCTe.CDSCTeNF.FieldByName('PESO_TOTAL_KG').AsFloat;
          CTeNF.DataPrevistaEntrega := FDataModuleCTe.CDSCTeNF.FieldByName('DATA_PREVISTA_ENTREGA').AsDateTime;

          /// EXERCICIO
          ///  Insira os demais ClientDataSets no DataModuleCTe para realizar os la�os abaixo

          { CTeNF - Carga }
          (*
          if FDataModuleCTe.CDSCTeNfCarga.RecordCount > 0 then
          begin
            if FDataModuleCTe.CDSCTeNfCarga.Locate('ID_CTE_INFORMACAO_NF', FDataModuleCTe.CDSCTeNF.FieldByName('ID').AsInteger, [loPartialKey]) then
            begin
              CTeNF.CTeInformacaoNfCargaVO.Id := FDataModuleCTe.CDSCTeNfCarga.FieldByName('ID').AsInteger;
              CTeNF.CTeInformacaoNfCargaVO.IdCTInformacaoNf := FDataModuleCTe.CDSCTeNfCarga.FieldByName('ID_CTE_INFORMACAO_NF').AsInteger;
              CTeNF.CTeInformacaoNfCargaVO.TipoUnidadeCarga := FDataModuleCTe.CDSCTeNfCarga.FieldByName('TIPO_UNIDADE_CARGA').AsInteger;
              CTeNF.CTeInformacaoNfCargaVO.IdUnidadeCarga := FDataModuleCTe.CDSCTeNfCarga.FieldByName('ID_UNIDADE_CARGA').AsString;
            end;
          end;
          *)

          { CTeNF - Transporte }
          (*
          if FDataModuleCTe.CDSCTeNfTransporte.RecordCount > 0 then
          begin
            if FDataModuleCTe.CDSCTeNfTransporte.Locate('ID_CTE_INFORMACAO_NF', FDataModuleCTe.CDSCTeNF.FieldByName('ID').AsInteger, [loPartialKey]) then
            begin
              CTeNF.CTeInformacaoNfTransporteVO.Id := FDataModuleCTe.CDSCTeNfTransporte.FieldByName('ID').AsInteger;
              CTeNF.CTeInformacaoNfTransporteVO.IdCTeNF := FDataModuleCTe.CDSCTeNfTransporte.FieldByName('ID_CTE_INFORMACAO_NF').AsInteger;
              CTeNF.CTeInformacaoNfTransporteVO.TipoUnidadeTransporte := FDataModuleCTe.CDSCTeNfTransporte.FieldByName('TIPO_UNIDADE_TRANSPORTE').AsFloat;
              CTeNF.CTeInformacaoNfTransporteVO.IdUnidadeTransporte := FDataModuleCTe.CDSCTeNfTransporte.FieldByName('ID_UNIDADE_TRANSPORTE').AsFloat;
            end;
          end;
          *)

          //TCTeCabecalhoVO(ObjetoVO).ListaCTeNFVO.Add(CTeNF);
          FDataModuleCTe.CDSCTeNF.Next;
        end;
        FDataModuleCTe.CDSCTeNF.First;
        FDataModuleCTe.CDSCTeNF.EnableControls;


        { CT-e Seguro }
        //if FDataModuleCTe.CDSCTeSeguro.RecordCount > 0 then
        //  TController.PreencherObjectListFromCDS<TCTeSeguroVO>(TCTeCabecalhoVO(ObjetoVO).ListaCTeSeguroVO, FDataModuleCTe.CDSCTeSeguro);

        { CT-e Perigoso }
        //if FDataModuleCTe.CDSCTePerigoso.RecordCount > 0 then
        //  TController.PreencherObjectListFromCDS<TCTePerigosoVO>(TCTeCabecalhoVO(ObjetoVO).ListaCTePerigosoVO, FDataModuleCTe.CDSCTePerigoso);

        { CT-e Componente }
        //if FDataModuleCTe.CDSCTeComponente.RecordCount > 0 then
        //  TController.PreencherObjectListFromCDS<TCTeComponenteVO>(TCTeCabecalhoVO(ObjetoVO).ListaCTeComponenteVO, FDataModuleCTe.CDSCTeComponente);

        { CT-e Passagem }
        //if FDataModuleCTe.CDSCTePassagem.RecordCount > 0 then
        //  TController.PreencherObjectListFromCDS<TCTePassagemVO>(TCTeCabecalhoVO(ObjetoVO).ListaCTePassagemVO, FDataModuleCTe.CDSCTePassagem);

        { CT-e Carga }
        //if FDataModuleCTe.CDSCTeCarga.RecordCount > 0 then
        //  TController.PreencherObjectListFromCDS<TCTeCargaVO>(TCTeCabecalhoVO(ObjetoVO).ListaCTeCargaVO, FDataModuleCTe.CDSCTeCarga);

        { Local Entrega }
        TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.IdCTeCabecalho := TCTeCabecalhoVO(ObjetoVO).Id;
        TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Cnpj := EditEntregaCpfCnpj.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Logradouro := EditEntregaLogradouro.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Numero := EditEntregaNumero.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Complemento := EditEntregaComplemento.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Bairro := EditEntregaBairro.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.CodigoMunicipio := EditEntregaIbge.AsInteger;
        TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.NomeMunicipio := EditEntregaCidade.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Uf := EditEntregaUf.Text;

        { Local Coleta }
        TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.IdCTeCabecalho := TCTeCabecalhoVO(ObjetoVO).Id;
        TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.Cnpj := EditRetiradaCpfCnpj.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.Logradouro := EditRetiradaLogradouro.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.Numero := EditRetiradaNumero.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.Complemento := EditRetiradaComplemento.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.Bairro := EditRetiradaBairro.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.CodigoMunicipio := EditRetiradaIbge.AsInteger;
        TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.NomeMunicipio := EditRetiradaCidade.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.Uf := EditRetiradaUf.Text;

        (* Grupo de Cobran�a *)

        { Cobran�a - Fatura }
        TCTeCabecalhoVO(ObjetoVO).CTeFaturaVO.IdCTeCabecalho := TCTeCabecalhoVO(ObjetoVO).Id;
        TCTeCabecalhoVO(ObjetoVO).CTeFaturaVO.Numero := EditFaturaNumero.Text;
        TCTeCabecalhoVO(ObjetoVO).CTeFaturaVO.ValorOriginal := EditFaturaValorOriginal.Value;
        TCTeCabecalhoVO(ObjetoVO).CTeFaturaVO.ValorDesconto := EditFaturaValorDesconto.Value;
        TCTeCabecalhoVO(ObjetoVO).CTeFaturaVO.ValorLiquido := EditFaturaValorLiquido.Value;

        { Cobran�a - Duplicatas }
        if FDataModuleCTe.CDSDuplicata.RecordCount > 0 then
          TController.PreencherObjectListFromCDS<TCTeDuplicataVO>(TCTeCabecalhoVO(ObjetoVO).ListaCTeDuplicataVO, FDataModuleCTe.CDSDuplicata);
      end;

      if StatusTela = stInserindo then
      begin
        TCTeController.Insere(TCTeVO(ObjetoVO));
      end
      else if StatusTela = stEditando then
      begin
        if TCTeCabecalhoVO(ObjetoVO).ToJSONString <> StringObjetoOld then
        begin
          TCTeController.Altera(TCTeVO(ObjetoVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    except
      Result := False;
    end;
  end;
  FormatSettings.DecimalSeparator := ',';
end;
{$ENDREGION}

{$REGION 'Controle de Grids e ClientDataSets'}
procedure TFCTe.GridItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    ActionIncluirItem.Execute;
  end;
  //
  if (Key = VK_DOWN) or (Key = VK_UP) then
  begin
    if FDataModuleCTe.CDSCTeNF.State in [dsEdit, dsInsert] then
    begin
      /// EXERCICIO
      ///  Insira os demais campos da NF
      FDataModuleCTe.CDSCTeNF.FieldByName('NUMERO_ROMANEIO').AsString := FDataModuleCTe.CDSCTeNF.FieldByName('NUMERO_ROMANEIO').AsString;
      FDataModuleCTe.CDSCTeNF.FieldByName('CHAVE_ACESSO_NFE').AsString := FDataModuleCTe.CDSCTeNF.FieldByName('CHAVE_ACESSO_NFE').AsString;
      FDataModuleCTe.CDSCTeNF.FieldByName('SERIE').AsString := FDataModuleCTe.CDSCTeNF.FieldByName('SERIE').AsString;
      FDataModuleCTe.CDSCTeNF.FieldByName('NUMERO').AsString := FDataModuleCTe.CDSCTeNF.FieldByName('NUMERO').AsString;
      FDataModuleCTe.CDSCTeNF.FieldByName('DATA_EMISSAO').AsString := FDataModuleCTe.CDSCTeNF.FieldByName('DATA_EMISSAO').AsString;
    end;
  end;
end;

procedure TFCTe.GridParaEdits;
var
  IdCabecalho: String;
var
  CTeNFEnumerator: TEnumerator<TCteInformacaoNfOutrosVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    IdCabecalho := IntToStr(IdRegistroSelecionado);
    ObjetoVO := TCTeController.ConsultaObjeto('ID=' + IdCabecalho);
  end;

  if Assigned(ObjetoVO) then
  begin
    { CT-e Cabe�alho }
    EditCodigoNumerico.Text := TCTeCabecalhoVO(ObjetoVO).CodigoNumerico;
    EditNaturezaOperacao.Text := TCTeCabecalhoVO(ObjetoVO).NaturezaOperacao;
    ComboBoxFormaPagamento.ItemIndex := TCTeCabecalhoVO(ObjetoVO).FormaPagamento;
    ComboboxModeloNotaFiscal.ItemIndex := AnsiIndexStr(TCTeCabecalhoVO(ObjetoVO).Modelo, ['01', '55']);
    EditSerie.Text := TCTeCabecalhoVO(ObjetoVO).Serie;
    EditNumeroCTe.Text := TCTeCabecalhoVO(ObjetoVO).Numero;
    EditDataHoraEmissao.Date := TCTeCabecalhoVO(ObjetoVO).DataHoraEmissao;
    EditHoraEntradaSaida.Text := FormatDateTime('hh:mm:ss', TCTeCabecalhoVO(ObjetoVO).DataHoraEmissao);
    EditDestinatarioCodigoIbge.Text := TCTeCabecalhoVO(ObjetoVO).CodigoMunicipioEnvio.ToString;
    ComboFormaImpDaCTe.ItemIndex := TCTeCabecalhoVO(ObjetoVO).FormatoImpressaoDaCTe;
    ComboTipoEmissao.ItemIndex := TCTeCabecalhoVO(ObjetoVO).TipoEmissao;
    EditChaveAcesso.Text := TCTeCabecalhoVO(ObjetoVO).ChaveAcesso;
    EditDigitoChaveAcesso.Text := TCTeCabecalhoVO(ObjetoVO).DigitoChaveAcesso;
    EditBCIcms.Value := TCTeCabecalhoVO(ObjetoVO).BaseCalculoIcms;
    EditValorIcms.Value := TCTeCabecalhoVO(ObjetoVO).ValorIcms;
    EditValorTotalCarga.Value := TCTeCabecalhoVO(ObjetoVO).ValorTotalCarga;

    { Destinatario }
    if TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Id > 0 then
    begin
      EditDestinatarioUF.Text := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Uf;
      EditDestinatarioCpfCnpj.Text := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Cnpj;
      EditDestinatarioRazao.Text := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Nome;
      EditDestinatarioLogradouro.Text := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Logradouro;
      EditDestinatarioNumero.Text := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Numero;
      EditDestinatarioComplemento.Text := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Complemento;
      EditDestinatarioBairro.Text := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Bairro;
      EditDestinatarioCodigoIbge.Text := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.CodigoMunicipio.ToString;
      EditDestinatarioCidade.Text := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.NomeMunicipio;
      EditDestinatarioUF.Text := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Uf;
      EditDestinatarioCEP.Text := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Cep;
      EditDestinatarioTelefone.Text := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Telefone;
      EditDestinatarioIE.Text := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Ie;
      EditDestinatarioEmail.Text := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Email;
    end;

    { Local Entrega }
    if TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Id > 0 then
    begin
      EditEntregaCpfCnpj.Text := TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Cnpj;
      EditEntregaLogradouro.Text := TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Logradouro;
      EditEntregaNumero.Text := TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Numero;
      EditEntregaComplemento.Text := TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Complemento;
      EditEntregaBairro.Text := TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Bairro;
      EditEntregaIbge.Text := IntToStr(TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.CodigoMunicipio);
      EditEntregaCidade.Text := TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.NomeMunicipio;
      EditEntregaUf.Text := TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Uf;
    end;

    { Local Coleta }
    if TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.Id > 0 then
    begin
      EditRetiradaCpfCnpj.Text := TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.Cnpj;
      EditRetiradaLogradouro.Text := TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.Logradouro;
      EditRetiradaNumero.Text := TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.Numero;
      EditRetiradaComplemento.Text := TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.Complemento;
      EditRetiradaBairro.Text := TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.Bairro;
      EditRetiradaIbge.Text := IntToStr(TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.CodigoMunicipio);
      EditRetiradaCidade.Text := TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.NomeMunicipio;
      EditRetiradaUf.Text := TCTeCabecalhoVO(ObjetoVO).CTeLocalColetaVO.Uf;
    end;

    (*
    { CT-e Seguro }
    TController.TratarRetorno<TCTeSeguroVO>(TCTeCabecalhoVO(ObjetoVO).ListaCTeSeguroVO, True, True, FDataModuleCTe.CDSCTeSeguro);
    { CT-e Perigoso }
    TController.TratarRetorno<TCTePerigosoVO>(TCTeCabecalhoVO(ObjetoVO).ListaCTePerigosoVO, True, True, FDataModuleCTe.CDSCTePerigoso);
    { CT-e Componente }
    TController.TratarRetorno<TCTeComponenteVO>(TCTeCabecalhoVO(ObjetoVO).ListaCTeComponenteVO, True, True, FDataModuleCTe.CDSCTeComponente);
    { CT-e Passagem }
    TController.TratarRetorno<TCTePassagemVO>(TCTeCabecalhoVO(ObjetoVO).ListaCTePassagemVO, True, True, FDataModuleCTe.CDSCTePassagem);
    { CT-e Carga }
    TController.TratarRetorno<TCTeCargaVO>(TCTeCabecalhoVO(ObjetoVO).ListaCTeCargaVO, True, True, FDataModuleCTe.CDSCTeCarga);
    *)

    (* Grupo de Cobran�a *)
    { Cobran�a - Fatura }
    if TCTeCabecalhoVO(ObjetoVO).CTeFaturaVO.Id > 0 then
    begin
      EditFaturaNumero.Text := TCTeCabecalhoVO(ObjetoVO).CTeFaturaVO.Numero;
      EditFaturaValorOriginal.Value := TCTeCabecalhoVO(ObjetoVO).CTeFaturaVO.ValorOriginal;
      EditFaturaValorDesconto.Value := TCTeCabecalhoVO(ObjetoVO).CTeFaturaVO.ValorDesconto;
      EditFaturaValorLiquido.Value := TCTeCabecalhoVO(ObjetoVO).CTeFaturaVO.ValorLiquido;
    end;

    { Cobran�a - Duplicatas }
    TController.TratarRetorno<TCTeDuplicataVO>(TCTeCabecalhoVO(ObjetoVO).ListaCTeDuplicataVO, True, True, FDataModuleCTe.CDSDuplicata);
    (* Fim Grupo de Cobran�a *)

    (* Grupo de Notas *)
    // Nota Fiscal
    TController.TratarRetorno<TCteInformacaoNfOutrosVO>(TCTeCabecalhoVO(ObjetoVO).ListaCteInformacaoNfOutrosVO, True, True, FDataModuleCTe.CDSCTeNF);

    CTeNFEnumerator := TCTeCabecalhoVO(ObjetoVO).ListaCteInformacaoNfOutrosVO.GetEnumerator;
    try
      with CTeNFEnumerator do
      begin
        while MoveNext do
        begin
          { CTeNF - Carga }
          (*
          if Current.CTeInformacaoNfCargaVO.Id > 0 then
          begin
            FDataModuleCTe.CDSCTeNfCarga.Append;
            FDataModuleCTe.CDSCTeNfCarga.FieldByName('ID').AsInteger := Current.CTeInformacaoNfCargaVO.Id;
            FDataModuleCTe.CDSCTeNfCarga.FieldByName('ID_CTE_INFORMACAO_NF').AsInteger := Current.CTeInformacaoNfCargaVO.IdCTInformacaoNf;
            FDataModuleCTe.CDSCTeNfCarga.FieldByName('TIPO_UNIDADE_CARGA').AsInteger := Current.CTeInformacaoNfCargaVO.TipoUnidadeCarga;
            FDataModuleCTe.CDSCTeNfCarga.FieldByName('ID_UNIDADE_CARGA').AsString := Current.CTeInformacaoNfCargaVO.IdUnidadeCarga;
            FDataModuleCTe.CDSCTeNfCarga.Post;
          end;
          *)

          { CTeNF - Transporte }
          (*
          if Current.CTeInformacaoNfTransporteVO.Id > 0 then
          begin
            FDataModuleCTe.CTeInformacaoNfTransporteVO.Append;
            FDataModuleCTe.CTeInformacaoNfTransporteVO.FieldByName('ID').AsInteger := Current.CTeNFImpostoIssqnVO.Id;
            FDataModuleCTe.CTeInformacaoNfTransporteVO.FieldByName('ID_CTE_INFORMACAO_NF').AsInteger := Current.CTeNFImpostoIssqnVO.IdCTeNF;
            FDataModuleCTe.CTeInformacaoNfTransporteVO.FieldByName('TIPO_UNIDADE_TRANSPORTE').AsFloat := Current.CTeNFImpostoIssqnVO.TipoUnidadeTransporte;
            FDataModuleCTe.CTeInformacaoNfTransporteVO.FieldByName('ID_UNIDADE_TRANSPORTE').AsFloat := Current.CTeNFImpostoIssqnVO.IdUnidadeTransporte;
            FDataModuleCTe.CDSCTeImpostoIssqn.Post;
          end;
          *)
        end;
      end;
    finally
      CTeNFEnumerator.Free;
    end;
    (* Fim do Grupo de Detalhe *)
  end;
end;
{$ENDREGION}

{$REGION 'Exclus�es Internas'}
procedure TFCTe.ActionExcluirCobrancaExecute(Sender: TObject);
begin
  if Application.MessageBox('Tem certeza que deseja remover os dados de cobran�a?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
  begin
    if StatusTela = stInserindo then
      ExcluirDadosCobranca
    else if StatusTela = stEditando then
    begin
      Result := TCTeController.Exclui(IdRegistroSelecionado);
      if TController.RetornoBoolean then
        ExcluirDadosCobranca;
    end;
  end;
end;

procedure TFCTe.ExcluirDadosCobranca;
begin
  FDataModuleCTe.CDSDuplicata.Close;
  FDataModuleCTe.CDSDuplicata.Open;
  //
  EditFaturaNumero.Clear;
  EditFaturaValorOriginal.Clear;
  EditFaturaValorDesconto.Clear;
  EditFaturaValorLiquido.Clear;
end;

procedure TFCTe.ActionExcluirEntregaRetiradaExecute(Sender: TObject);
begin
  if Application.MessageBox('Tem certeza que deseja remover os dados de entrega/retirada?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
  begin
    if StatusTela = stInserindo then
      ExcluirDadosEntregaRetirada
    else if StatusTela = stEditando then
    begin
      Result := TCTeController.Exclui(IdRegistroSelecionado);
      if TController.RetornoBoolean then
        ExcluirDadosEntregaRetirada;
    end;
  end;
end;

procedure TFCTe.ExcluirDadosEntregaRetirada;
begin
  { Local Entrega }
  EditEntregaCpfCnpj.Clear;
  EditEntregaLogradouro.Clear;
  EditEntregaNumero.Clear;
  EditEntregaComplemento.Clear;
  EditEntregaBairro.Clear;
  EditEntregaIbge.Clear;
  EditEntregaCidade.Clear;
  EditEntregaUf.Clear;

  { Local Retirada }
  EditRetiradaCpfCnpj.Clear;
  EditRetiradaLogradouro.Clear;
  EditRetiradaNumero.Clear;
  EditRetiradaComplemento.Clear;
  EditRetiradaBairro.Clear;
  EditRetiradaIbge.Clear;
  EditRetiradaCidade.Clear;
  EditRetiradaUf.Clear;
end;

procedure TFCTe.ActionExcluirItemExecute(Sender: TObject);
begin
  if Application.MessageBox('Tem certeza que deseja remover o item da nota fiscal?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
  begin
    if StatusTela = stInserindo then
      FDataModuleCTe.CDSCTeNF.Delete
    else if StatusTela = stEditando then
    begin
      Result := TCTeController.Exclui(IdRegistroSelecionado);
      if TController.RetornoBoolean then
        FDataModuleCTe.CDSCTeNF.Delete;
    end;
  end;
end;
{$EndREGION 'Exclus�es Internas'}

{$REGION 'Actions'}
procedure TFCTe.ActionIncluirItemExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  try
    try
        if Assigned(VO) then
      begin
        FDataModuleCTe.CDSCTeNF.Append;
        FDataModuleCTe.CDSCTeNF.FieldByName('ID').AsInteger := 1;
        FDataModuleCTe.CDSCTeNF.FieldByName('DATA_EMISSAO').AsDateTime := CDSTransiente.FieldByName('DATA_EMISSAO').AsDateTime;
        FDataModuleCTe.CDSCTeNF.FieldByName('NUMERO_ROMANEIO').AsString := CDSTransiente.FieldByName('NUMERO_ROMANEIO').AsString;
        FDataModuleCTe.CDSCTeNF.FieldByName('NUMERO_PEDIDO').AsString := CDSTransiente.FieldByName('NUMERO_PEDIDO').AsString;
        FDataModuleCTe.CDSCTeNF.FieldByName('CHAVE_ACESSO_NFE').AsString := CDSTransiente.FieldByName('CHAVE_ACESSO_NFE').AsString;
        FDataModuleCTe.CDSCTeNF.FieldByName('CODIGO_MODELO').AsString := CDSTransiente.FieldByName('CODIGO_MODELO').AsString;
        FDataModuleCTe.CDSCTeNF.FieldByName('SERIE').AsString := CDSTransiente.FieldByName('SERIE').AsString;
        FDataModuleCTe.CDSCTeNF.FieldByName('NUMERO').AsString := CDSTransiente.FieldByName('NUMERO').AsString;
        FDataModuleCTe.CDSCTeNF.FieldByName('UF_EMITENTE').AsString := CDSTransiente.FieldByName('UF_EMITENTE').AsString;
        FDataModuleCTe.CDSCTeNF.FieldByName('PIN_SUFRAMA').AsInteger := CDSTransiente.FieldByName('PIN_SUFRAMA').AsInteger;
        FDataModuleCTe.CDSCTeNF.FieldByName('CFOP_PREDOMINANTE').AsInteger := CDSTransiente.FieldByName('CFOP_PREDOMINANTE').AsInteger;
        FDataModuleCTe.CDSCTeNF.FieldByName('BASE_CALCULO_ICMS').AsFloat := CDSTransiente.FieldByName('BASE_CALCULO_ICMS').AsFloat;
        FDataModuleCTe.CDSCTeNF.FieldByName('VALOR_ICMS').AsFloat := CDSTransiente.FieldByName('VALOR_ICMS').AsFloat;
        FDataModuleCTe.CDSCTeNF.FieldByName('BASE_CALCULO_ICMS_ST').AsFloat := CDSTransiente.FieldByName('BASE_CALCULO_ICMS_ST').AsFloat;
        FDataModuleCTe.CDSCTeNF.FieldByName('VALOR_ICMS_ST').AsFloat := CDSTransiente.FieldByName('VALOR_ICMS_ST').AsFloat;
        FDataModuleCTe.CDSCTeNF.FieldByName('VALOR_TOTAL_PRODUTOS').AsFloat := CDSTransiente.FieldByName('VALOR_TOTAL_PRODUTOS').AsFloat;
        FDataModuleCTe.CDSCTeNF.FieldByName('VALOR_TOTAL').AsFloat := CDSTransiente.FieldByName('VALOR_TOTAL').AsFloat;
        FDataModuleCTe.CDSCTeNF.FieldByName('PESO_TOTAL_KG').AsFloat := CDSTransiente.FieldByName('PESO_TOTAL_KG').AsFloat;
        FDataModuleCTe.CDSCTeNF.FieldByName('DATA_PREVISTA_ENTREGA').AsDateTime := CDSTransiente.FieldByName('DATA_PREVISTA_ENTREGA').AsDateTime;

        FDataModuleCTe.CDSCTeNF.Post;
      end;
    except
      on E: Exception do
      begin
        FDataModuleCTe.CDSCTeNF.Cancel;
        Application.MessageBox(PChar('Ocorreu um erro ao tentar inserir um item.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
      end;
    end;
  finally
  end;
end;

procedure TFCTe.ActionAtualizarTotaisExecute(Sender: TObject);
var
  TotalProdutos, ValorFrete, ValorSeguro, ValorOutrasDespesas, Desconto, BaseCalculoIcms, ValorIcms, BaseCalculoIcmsSt, ValorIcmsSt, ValorIpi, ValorPis, ValorCofins, ValorNotaFiscal: Double;
  TotalServicos, BaseCalculoIssqn, ValorIssqn, ValorPisIssqn, ValorCofinsIssqn: Double;
begin
  /// EXERCICIO
  ///  � preciso realizar algum c�lculo aqui? Ou os valores totais devem ser informados diretamente pelo usu�rio?
  TotalProdutos := 0;
  ValorFrete := 0;
  ValorSeguro := 0;
  ValorOutrasDespesas := 0;
  Desconto := 0;
  BaseCalculoIcms := 0;
  ValorIcms := 0;
  BaseCalculoIcmsSt := 0;
  ValorIcmsSt := 0;
  ValorIpi := 0;
  ValorPis := 0;
  ValorCofins := 0;
  //
  TotalServicos := 0;
  BaseCalculoIssqn := 0;
  ValorIssqn := 0;
  ValorPisIssqn := 0;
  ValorCofinsIssqn := 0;

  FDataModuleCTe.CDSCTeNF.First;
  while not FDataModuleCTe.CDSCTeNF.Eof do
  begin
    TotalProdutos := TotalProdutos + FDataModuleCTe.CDSCTeNF.FieldByName('VALOR_TOTAL').AsFloat;
    ValorFrete := ValorFrete + FDataModuleCTe.CDSCTeNF.FieldByName('VALOR_FRETE').AsFloat;
    ValorSeguro := ValorSeguro + FDataModuleCTe.CDSCTeNF.FieldByName('VALOR_SEGURO').AsFloat;
    ValorOutrasDespesas := ValorOutrasDespesas + FDataModuleCTe.CDSCTeNF.FieldByName('VALOR_OUTRAS_DESPESAS').AsFloat;
    Desconto := Desconto + FDataModuleCTe.CDSCTeNF.FieldByName('VALOR_DESCONTO').AsFloat;
    FDataModuleCTe.CDSCTeNF.Next;
  end;
  FDataModuleCTe.CDSCTeNF.First;
  //
  ValorNotaFiscal := TotalProdutos + ValorIcmsSt + ValorPis + ValorCofins + ValorIpi - Desconto;

  EditBCIcms.Value := BaseCalculoIcms;
  EditValorIcms.Value := ValorIcms;
  EditBCIcmsSt.Value := BaseCalculoIcmsSt;
  EditValorIcmsSt.Value := ValorIcmsSt;
  //
  EditValorTotalCarga.Value := 0;
end;

procedure TFCTe.Button1Click(Sender: TObject);
var
  LancamentoReceber: TFinLancamentoReceberVO;
  ParcelaReceber: TFinParcelaReceberVO;
  i: integer;
begin
  /// EXERCICIO: implemente esse m�todo de acordo com a necessidade do seu cliente
  ///  01-Pergunte se ele quer lan�ar no contas a receber ap�s a emiss�o da nota
  ///  02-Deixe uma op��o na tela para mandar os dados para o financeiro
  ///  03-Deixe a op��o de capturar esses dados no financeiro apenas
  ///  04-Realize o lan�amento sem que o usu�rio da NF-e saiba o que est� ocorrendo e deixe o restante a cargo do profissional do setor financeiro
  ///
  ///  Corrija as informa��es est�ticas que est�o no c�digo.

  if Application.MessageBox('Deseja gerar os lan�amentos para o contas a Receber?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
  begin
    LancamentoReceber := TFinLancamentoReceberVO.Create;

    LancamentoReceber.IdCliente := EditDestinatarioId.AsInteger;
    LancamentoReceber.IdFinDocumentoOrigem := 32; // Carregue os dados do AdmParametroVO
    LancamentoReceber.QuantidadeParcela := 1;
    LancamentoReceber.ValorTotal := EditValorTotalCarga.Value;
    LancamentoReceber.ValorAReceber := EditValorTotalCarga.Value;
    LancamentoReceber.DataLancamento := now;
    LancamentoReceber.NumeroDocumento := 'NF-e: ' + EditNumeroCTe.text;
    LancamentoReceber.PrimeiroVencimento := now;
    LancamentoReceber.IntervaloEntreParcelas := 30;

    LancamentoReceber.ListaParcelaReceberVO := TObjectList<TFinParcelaReceberVO>.Create;
    for i := 0 to LancamentoReceber.QuantidadeParcela - 1 do
    begin
      ParcelaReceber := TFinParcelaReceberVO.Create;
      ParcelaReceber.NumeroParcela := i+1;
      ParcelaReceber.IdContaCaixa := 1; // Carregue os dados do AdmParametroVO
      ParcelaReceber.IdFinStatusParcela := 1;
      ParcelaReceber.DataEmissao := now;
      ParcelaReceber.DataVencimento := LancamentoReceber.PrimeiroVencimento + (LancamentoReceber.IntervaloEntreParcelas * i);
      ParcelaReceber.Valor := ArredondaTruncaValor('A', LancamentoReceber.ValorAReceber / LancamentoReceber.QuantidadeParcela, Constantes.TConstantes.DECIMAIS_VALOR);

      LancamentoReceber.ListaParcelaReceberVO.Add(ParcelaReceber);
    end;
        TCTeController.Insere(TCTeVO(ObjetoVO));
  end;
end;


{$REGION 'Actions CT-e'}
procedure TFCTe.ActionSelecionarCertificadoExecute(Sender: TObject);
begin
  try
    ObjetoNFeConfiguracaoVO.CertificadoDigitalSerie := FDataModule.ACBrCTe.SSL.SelecionarCertificado;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro ao tentar selecionar o certificado.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFCTe.ActionStatusServicoExecute(Sender: TObject);
begin
  FDataModule.ACBrCTe.WebServices.StatusServico.Executar;
end;

// EXERCICIO: selecione um local apropriado para inutilizar os conhecimentos.
procedure TFCTe.ActionInutilizarCTeExecute(Sender: TObject);
var
  Modelo, Serie, Ano, NumeroInicial, NumeroFinal, Justificativa : String;
begin
  if not(InputQuery('Inutiliza��o de CT-e', 'Ano',    Ano)) then
    exit;
  if not(InputQuery('Inutiliza��o de CT-e', 'Modelo', Modelo)) then
    exit;
  if not(InputQuery('Inutiliza��o de CT-e', 'Serie',  Serie)) then
    exit;
  if not(InputQuery('Inutiliza��o de CT-e', 'N�mero Inicial', NumeroInicial)) then
    exit;
  if not(InputQuery('Inutiliza��o de CT-e', 'N�mero Final', NumeroFinal)) then
    exit;
  if not(InputQuery('Inutiliza��o de CT-e', 'Justificativa', Justificativa)) then
    exit;
  //
  FDataModule.ACBrCTe.WebServices.Inutiliza(Sessao.Empresa.Cnpj, Justificativa, StrToInt(Ano), StrToInt(Modelo), StrToInt(Serie), StrToInt(NumeroInicial), StrToInt(NumeroFinal));
  MemoRespostas.Lines.Text := FDataModule.ACBrCTe.WebServices.Inutilizacao.RetWS;
end;

// EXERCICIO: Fa�a as devidas adapta��es na CC-e de acordo com sua necessidade
procedure TFCTe.ActionCCeExecute(Sender: TObject);
var
  idLote, nSeqEvento, Correcao: String;
begin
  idLote := '1';
  if not(InputQuery('WebServices Eventos: Carta de Corre��o', 'Identificador de controle do Lote de envio do Evento', idLote)) then
     exit;

  nSeqEvento := '1';
  if not(InputQuery('WebServices Eventos: Carta de Corre��o', 'Sequencial do evento para o mesmo tipo de evento', nSeqEvento)) then
     exit;

  Correcao := 'TEXTO CAPTURADO DO EXEMPLO DO ACBR - Corre��o a ser considerada, texto livre. A corre��o mais recente substitui as anteriores.';
  if not(InputQuery('WebServices Eventos: Carta de Corre��o', 'Corre��o a ser considerada', Correcao)) then
     exit;

  FDataModule.ACBrCTe.EventoCTe.Evento.Clear;
  with FDataModule.ACBrCTe.EventoCTe.Evento.Add do
   begin
     infEvento.chCTe := EditChaveAcesso.Text;
     infEvento.CNPJ   := Sessao.Empresa.Cnpj;
     infEvento.dhEvento := now;
     infEvento.tpEvento := teCCe;
     infEvento.nSeqEvento := StrToInt(nSeqEvento);
     infEvento.detEvento.xJust := Correcao;
   end;
  FDataModule.ACBrCTe.EnviarEvento(StrToInt(idLote));
  MemoRespostas.Lines.Text := FDataModule.ACBrCTe.WebServices.EnvEvento.RetWS;
end;

procedure TFCTe.ActionConsultarSefazExecute(Sender: TObject);
begin
  try
    FDataModule.ACBrCTe.WebServices.Consulta.CTeChave := EditChaveAcesso.Text;
    FDataModule.ACBrCTe.WebServices.Consulta.Executar;
    MemoRespostas.Lines.Text := UTF8Encode(FDataModule.ACBrCTe.WebServices.Consulta.RetWS);
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro durante a consulta.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFCTe.ActionImprimirDaCTeExecute(Sender: TObject);
begin
  FDataModule.ACBrCTe.Conhecimentos.Clear;
  FDataModule.ACBrCTe.Conhecimentos.LoadFromFile(ObjetoNFeConfiguracaoVO.CaminhoSalvarXml + TCTeCabecalhoVO(ObjetoVO).ChaveAcesso + '-CTe.xml');
  FDataModule.ACBrCTe.Conhecimentos.ImprimirPDF;
end;

procedure TFCTe.ActionCancelarCTeExecute(Sender: TObject);
var
  Chave, Lote, Justificativa: String;
begin
  try
    Lote := '1';
    if not(InputQuery('Cancelamento CT-e', 'Identificador de Controle do Lote', Lote)) then
      Exit;
    if not(InputQuery('Cancelamento CT-e', 'Justificativa', Justificativa)) then
      Exit;

    FDataModule.ACBrCTe.EventoCTe.Evento.Clear;
    FDataModule.ACBrCTe.EventoCTe.idLote := StrToInt(Lote);
    with FDataModule.ACBrCTe.EventoCTe.Evento.Add do
    begin
     infEvento.dhEvento := now;
     infEvento.tpEvento := teCancelamento;
     infEvento.detEvento.xJust := Justificativa;
    end;
    FDataModule.ACBrCTe.EnviarEvento(StrToInt(Lote));

    MemoRespostas.Lines.Text := FDataModule.ACBrCTe.WebServices.EnvEvento.RetWS;

    //TCTeCabecalhoVO(ObjetoVO).InformacoesAddContribuinte := 'NOTA FISCAL CANCELADA. LOTE: ' + Lote + '. JUSTIFICATIVA: ' + Justificativa;
          TCTeController.Altera(TCTeVO(ObjetoVO));
    BotaoCancelar.Click;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro ao tentar imprimir o DACTe.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFCTe.ActionEnviarExecute(Sender: TObject);
begin
  try
    FDataModule.ACBrCTe.Enviar(1, true);
    FDataModule.ACBrCTe.Conhecimentos.ImprimirPDF;

    MemoRespostas.Lines.Text := UTF8Encode(FDataModule.ACBrCTe.WebServices.Retorno.RetWS);
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro ao tentar enviar a NF-e.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFCTe.ActionAssinarExecute(Sender: TObject);
begin
  try
    FDataModule.ACBrCTe.Conhecimentos.LoadFromFile(ObjetoNFeConfiguracaoVO.CaminhoSalvarXml + EditChaveAcesso.Text + '-CTe.xml');
    if Assigned(FDataModule.ACBrCTe.Conhecimentos.Items[0]) then
    begin
      FDataModule.ACBrCTe.Conhecimentos.Assinar;
      Application.MessageBox('Nota fiscal assinada!', 'Informa��o do Sistema', MB_OK + MB_ICONEXCLAMATION);
    end;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro ao tentar assinar a NF-e.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFCTe.ActionValidarExecute(Sender: TObject);
begin
  try
    FDataModule.ACBrCTe.Conhecimentos.LoadFromFile(ObjetoNFeConfiguracaoVO.CaminhoSalvarXml + TCTeCabecalhoVO(ObjetoVO).ChaveAcesso + '-CTe.xml');
    if Assigned(FDataModule.ACBrCTe.Conhecimentos.Items[0]) then
    begin
      FDataModule.ACBrCTe.Conhecimentos.Validar;
      Application.MessageBox('Nota fiscal v�lida!', 'Informa��o do Sistema', MB_OK + MB_ICONEXCLAMATION);
    end;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro ao tentar validar a NF-e.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFCTe.ActionGerarXmlExecute(Sender: TObject);
var
  i, j: Integer;
  OK: Boolean;
begin
  try
    if FDataModule.ACBrCTe.Configuracoes.Certificados.NumeroSerie = '' then
    begin
      ObjetoNFeConfiguracaoVO.CertificadoDigitalSerie := FDataModule.ACBrCTe.SSL.SelecionarCertificado;
    end;

    FDataModule.ACBrCTe.Conhecimentos.Clear;
    with FDataModule.ACBrCTe.Conhecimentos.Add.CTe do
    begin

      /// EXERCICIO
      ///  Capture os dados faltantes do Banco de Dados

      { CTe Cabe�alho }
      Ide.cUF := Sessao.Empresa.CodigoIbgeUf;
      Ide.cCT := StrToInt(TCTeCabecalhoVO(ObjetoVO).CodigoNumerico);
      Ide.natOp := TCTeCabecalhoVO(ObjetoVO).NaturezaOperacao;
      Ide.forPag := TpcteFormaPagamento(TCTeCabecalhoVO(ObjetoVO).FormaPagamento); // ['0', '1', '2'][ipVista, ipPrazo, ipOutras]
      Ide.Modelo := StrToInt(TCTeCabecalhoVO(ObjetoVO).Modelo);
      Ide.Serie := StrToInt(TCTeCabecalhoVO(ObjetoVO).Serie);
      Ide.nCT := StrToInt(TCTeCabecalhoVO(ObjetoVO).Numero);
      Ide.dhEmi := EditDataHoraEmissao.Date;
      Ide.cMunEnv := TCTeCabecalhoVO(ObjetoVO).CodigoMunicipioEnvio;
      Ide.xMunEnv := 'BRASILIA';
      Ide.UFEnv := 'DF';
      Ide.tpImp := TpcnTipoImpressao(TCTeCabecalhoVO(ObjetoVO).FormatoImpressaoDaCTe); // ['1', '2'] [tiRetrato, tiPaisagem]  ver se vamos usar como parametro
      Ide.tpEmis := TpcnTipoEmissao(TCTeCabecalhoVO(ObjetoVO).TipoEmissao); // ['1', '2', '3', '4', '5', '7', '8'][teNormal, teContingencia, teSCAN, teDPEC, teFSDA, teSVCRS, teSVCSP]
      Ide.tpAmb := TpcnTipoAmbiente(TCTeCabecalhoVO(ObjetoVO).Ambiente); // ['1', '2'] [taProducao, taHomologacao]  ver se vamos usar como parametro
      Ide.procEmi := TpcnProcessoEmissao(TCTeCabecalhoVO(ObjetoVO).ProcessoEmissao); // ['0', '1', '2', '3'][peAplicativoContribuinte, peAvulsaFisco, peAvulsaContribuinte, peContribuinteAplicativoFisco]
      Ide.verProc := TCTeCabecalhoVO(ObjetoVO).VersaoProcessoEmissao; // versao do processo de emissao

      // TpcteModal = (mdRodoviario, mdAereo, mdAquaviario, mdFerroviario, mdDutoviario);
      Ide.modal:=mdRodoviario;

      // TpcteTipoServico = (tsNormal, tsSubcontratacao, tsRedespacho, tsIntermediario);
      case 0 of
        0: Ide.tpServ := tsNormal;
        1: Ide.tpServ := tsSubcontratacao;
        2: Ide.tpServ := tsRedespacho;
        3: Ide.tpServ := tsIntermediario;
      end;

      // Origem da Presta��o
      Ide.cMunIni := 5300108;
      Ide.xMunIni := 'BRASILIA';
      Ide.UFIni := 'DF';

      // Destino da Presta��o
      Ide.cMunFim := 5300108;
      Ide.xMunFim := 'BRASILIA';
      Ide.UFFim := 'DF';

      // TpcteRetira = (rtSim, rtNao);
      Ide.retira:=rtSim;
      Ide.xdetretira:='';

       case 0 of
        0: Ide.Toma03.Toma:=tmRemetente;
        1: Ide.Toma03.Toma:=tmExpedidor;
        2: Ide.Toma03.Toma:=tmRecebedor;
        3: Ide.Toma03.Toma:=tmDestinatario;
        4: Ide.Toma03.Toma:=tmRemetente;
       end;

       // Tomador do Servi�o no CTe 4 = Outros
       Ide.Toma4.Toma := tmOutros;
       Ide.Toma4.CNPJCPF := '61363944304';
       Ide.Toma4.IE := 'ISENTO';
       Ide.Toma4.xNome := 'ALBERT EIJE BARRETO MOUTA';
       Ide.Toma4.xFant := 'ALBERT EIJE BARRETO MOUTA';
       Ide.Toma4.fone := '6130425277';
       Ide.Toma4.EnderToma.xLgr := 'RUA TAL';
       Ide.Toma4.EnderToma.nro := '12';
       Ide.Toma4.EnderToma.xCpl := 'complemento';
       Ide.Toma4.EnderToma.xBairro := 'AGUAS CLARAS';

       Ide.Toma4.EnderToma.cMun := 5300108;
       Ide.Toma4.EnderToma.xMun := 'BRASILIA';
       Ide.Toma4.EnderToma.CEP := 71925000;
       Ide.Toma4.EnderToma.UF := 'DF';
       Ide.Toma4.EnderToma.cPais := 1058;
       Ide.Toma4.EnderToma.xPais := 'BRASIL';

       //
       //  Informa��es Complementares do CTe
       //
       compl.xCaracAd := '';
       compl.xCaracSer := '';
       compl.xEmi := 'JOAO PAULO';

       compl.fluxo.xOrig := '';
       with compl.fluxo.pass.Add do
       begin
          xPass := 'xPass';
       end;

       compl.fluxo.xDest := '';
       compl.fluxo.xRota := '';

      { Emitente }
      Emit.CNPJ := Sessao.Empresa.Cnpj;
      Emit.xNome := Sessao.Empresa.RazaoSocial;
      Emit.xFant := Sessao.Empresa.NomeFantasia;
      Emit.EnderEmit.xLgr := Sessao.Empresa.EnderecoPrincipal.Logradouro;
      Emit.EnderEmit.nro := Sessao.Empresa.EnderecoPrincipal.Numero;
      Emit.EnderEmit.xCpl := Sessao.Empresa.EnderecoPrincipal.Complemento;
      Emit.EnderEmit.xBairro := Sessao.Empresa.EnderecoPrincipal.Bairro;
      Emit.EnderEmit.cMun := Sessao.Empresa.CodigoIbgeCidade;
      Emit.EnderEmit.xMun := Sessao.Empresa.EnderecoPrincipal.Cidade;
      Emit.EnderEmit.Uf := Sessao.Empresa.EnderecoPrincipal.Uf;
      Emit.EnderEmit.Cep := StrToInt(Sessao.Empresa.EnderecoPrincipal.Cep);
      Emit.EnderEmit.Fone := Sessao.Empresa.EnderecoPrincipal.Fone;
      Emit.Ie := Sessao.Empresa.InscricaoEstadual;

       //
       //  Dados do Remetente
       //
       Rem.xNome := 'T2Ti.COM';
       Rem.xFant := 'T2Ti.COM';
       Rem.EnderReme.xLgr := 'QD 201';
       Rem.EnderReme.nro := '908';
       Rem.EnderReme.xCpl := 'COMPLEMENTO';
       Rem.EnderReme.xBairro := 'AGUAS CLARAS';
       Rem.EnderReme.cMun := 5300108;
       Rem.EnderReme.xMun := 'BRASILIA';
       Rem.EnderReme.CEP := 71925000;
       Rem.EnderReme.UF := 'DF';
       Rem.EnderReme.cPais := 1058;
       Rem.EnderReme.xPais := 'BRASIL';
       Rem.CNPJCPF := '10793118000178';
       Rem.IE := '0751990400114';
       Rem.fone := '30425277';

        { Destinatario }
        Dest.CNPJCPF := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Cnpj;
        Dest.xNome := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Nome;
        Dest.EnderDest.xLgr := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Logradouro;
        Dest.EnderDest.nro := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Numero;
        Dest.EnderDest.xCpl := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Complemento;
        Dest.EnderDest.xBairro := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Bairro;
        Dest.EnderDest.cMun := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.CodigoMunicipio;
        Dest.EnderDest.xMun := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.NomeMunicipio;
        Dest.EnderDest.Uf := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Uf;
        Dest.EnderDest.Cep := StrToInt(TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Cep);
        Dest.EnderDest.cPais := 1058;
        Dest.EnderDest.xPais := 'BRASIL';
        Dest.Ie := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.IE;
        Dest.Email := TCTeCabecalhoVO(ObjetoVO).CTeDestinatarioVO.Email;


       //
       // Rela��o das Notas Fiscais
       // Tipos Nota:
       // 0 - Nota Fiscal
       // 1 - Nota Fiscal Eletr�nica
       // 2 - Outros Tipos de Documentos
       case 1 of
        0: begin
            // Nota Fiscal
            with infCTeNorm.infDoc.infNF.Add do
             begin
              nRoma := '';
              nPed  := '';
              serie := '';
              nDoc  := '';
              dEmi  := date;
              vBC   := 0;
              vICMS := 0;
              vBCST := 0;
              vST   := 0;
              vProd := 0;
              vNF   := 0;
              nCFOP := 0;
              nPeso := 0;
              PIN   := '';

             end;
           end;
        1: begin
            // Nota Fiscal Eletr�nica
            with infCTeNorm.infDoc.InfNFe.Add do
             begin
              chave := '53151210793118000178550010004568931004568930';
              PIN   := '12345678';
              dPrev   := date;
             end;
           end;
        2: begin
            // Outros Tipos de Documentos
            with infCTeNorm.infDoc.InfOutros.Add do
             begin
              tpDoc := tdDeclaracao;
              nDoc     := '123456';
              dEmi     := date;
              vDocFisc := 0;
             end;
           end;
       end;


      { Local Entrega }
       Dest.locEnt.CNPJCPF := TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Cnpj;
       Dest.locEnt.xNome := '';
       Dest.locEnt.xLgr := TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Logradouro;
       Dest.locEnt.nro := TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Numero;
       Dest.locEnt.xCpl := TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Complemento;
       Dest.locEnt.xBairro := TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Bairro;
       Dest.locEnt.cMun := TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.CodigoMunicipio;
       Dest.locEnt.xMun := TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.NomeMunicipio;
       Dest.locEnt.UF := TCTeCabecalhoVO(ObjetoVO).CTeLocalEntregaVO.Uf;

       (*
      { Fatura }
      Cobr.Fat.nFat := TCTeCabecalhoVO(ObjetoVO).CTeFaturaVO.Numero;
      Cobr.Fat.vOrig := TCTeCabecalhoVO(ObjetoVO).CTeFaturaVO.ValorOriginal;
      Cobr.Fat.vDesc := TCTeCabecalhoVO(ObjetoVO).CTeFaturaVO.ValorDesconto;
      Cobr.Fat.vLiq := TCTeCabecalhoVO(ObjetoVO).CTeFaturaVO.ValorLiquido;

      { Duplicatas }
      if TCTeCabecalhoVO(ObjetoVO).ListaCTeDuplicataVO.Count > 0 then
      begin
        for i := 0 to TCTeCabecalhoVO(ObjetoVO).ListaCTeDuplicataVO.Count - 1 do
        begin
          Cobr.Dup.Add;
          Cobr.Dup.Items[i].nDup := TCTeDuplicataVO(TCTeCabecalhoVO(ObjetoVO).ListaCTeDuplicataVO.Items[i]).Numero;
          Cobr.Dup.Items[i].dVenc := TCTeDuplicataVO(TCTeCabecalhoVO(ObjetoVO).ListaCTeDuplicataVO.Items[i]).DataVencimento;
          Cobr.Dup.Items[i].vDup := TCTeDuplicataVO(TCTeCabecalhoVO(ObjetoVO).ListaCTeDuplicataVO.Items[i]).Valor;
        end;
      end;
      *)

    //
    //  Dados do Expedidor
    //
     Exped.CNPJCPF := '10793118000178';
     Exped.IE := '0751990400114';
     Exped.xNome := 'T2Ti.COM';
     Exped.EnderExped.xLgr := 'QD 201';
     Exped.EnderExped.nro := '908';
     Exped.EnderExped.xCpl := 'COMPLEMENTO';
     Exped.EnderExped.xBairro := 'AGUAS CLARAS';
     Exped.EnderExped.cMun := 5300108;
     Exped.EnderExped.xMun := 'BRASILIA';
     Exped.EnderExped.CEP := 71925000;
     Exped.EnderExped.UF := 'DF';
     Exped.EnderExped.cPais := 1058;
     Exped.EnderExped.xPais := 'BRASIL';
     Exped.fone := '30425277';

     //
     //  Dados do Recebedor
     //
       Receb.CNPJCPF := '78945688521';
       Receb.IE := 'ISENTO';
       Receb.xNome := 'ALBERT EIJE BARRETO MOUTA';
       Receb.EnderReceb.xLgr := 'RUA TAL';
       Receb.EnderReceb.nro := '10';
       Receb.EnderReceb.xCpl := 'COMPLEMENTO';
       Receb.EnderReceb.xBairro := 'AGUAS CLARAS';
       Receb.EnderReceb.cMun := 5300108;
       Receb.EnderReceb.xMun := 'BRASILIA';
       Receb.EnderReceb.CEP := 71925000;
       Receb.EnderReceb.UF := 'DF';
       Receb.EnderReceb.cPais := 1058;
       Receb.EnderReceb.xPais := 'BRASIL';
       Receb.fone := '30425277';


       //
       //  Valores da Presta��o de Servi�o
       //
       vPrest.vTPrest := 100;
       vPrest.vRec    := 100;

       //
       // Rela��o dos Componentes da Presta��o de Servi�o
       //
       with vPrest.comp.Add do
        begin
         xNome := 'FRETE PESO';
         vComp := 100;
        end;

       //
       //  Valores dos Impostos
       //
       // TpcnCSTIcms = (cst00, cst10, cst20, cst30, cst40, cst41, cst45, cst50, cst51, cst60, cst70, cst80, cst81, cst90);
       // 80 e 81 apenas para CTe

       case 00 of
       00: begin
            Imp.ICMS.SituTrib    := cst00;
            Imp.ICMS.ICMS00.CST   := cst00; // Tributa��o Normal ICMS
            Imp.ICMS.ICMS00.vBC   := 100;
            Imp.ICMS.ICMS00.pICMS := 17;
            Imp.ICMS.ICMS00.vICMS := 17;
           end;
       20: begin
            Imp.ICMS.SituTrib     := cst20;
            Imp.ICMS.ICMS20.CST    := cst20; // Tributa��o com BC reduzida do ICMS
            Imp.ICMS.ICMS20.pRedBC := 0;
            Imp.ICMS.ICMS20.vBC    := 0;
            Imp.ICMS.ICMS20.pICMS  := 0;
            Imp.ICMS.ICMS20.vICMS  := 0;
           end;
       40: begin
            Imp.ICMS.SituTrib  := cst40;
            Imp.ICMS.ICMS45.CST := cst40; // ICMS Isento
           end;
       41: begin
            Imp.ICMS.SituTrib  := cst41;
            Imp.ICMS.ICMS45.CST := cst41; // ICMS n�o Tributada
           end;
       51: begin
            Imp.ICMS.SituTrib  := cst51;
            Imp.ICMS.ICMS45.CST := cst51; // ICMS diferido
           end;
       60: begin
            Imp.ICMS.SituTrib    := cst80;
            Imp.ICMS.ICMS60.CST   := cst90; // Tributa��o atribuida ao tomador ou 3. por ST
            Imp.ICMS.ICMS60.vCred := 0;
           end;
       90: begin
            Imp.ICMS.SituTrib     := cst90;
            Imp.ICMS.ICMS90.CST    := cst90; // ICMS Outros
            Imp.ICMS.ICMS90.pRedBC := 0;
            Imp.ICMS.ICMS90.vBC    := 0;
            Imp.ICMS.ICMS90.pICMS  := 0;
            Imp.ICMS.ICMS90.vICMS  := 0;
            Imp.ICMS.ICMS90.vCred  := 0;
           end;
       end;

    end;

    try
      FDataModule.ACBrCTe.Conhecimentos.Assinar;
    except
      on E: Exception do
        Application.MessageBox(PChar('Ocorreu um erro ao tentar assinar a NF-e.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;

    try
      FDataModule.ACBrCTe.Conhecimentos.Items[0].GravarXML;
      Mensagem := 'Arquivo gerado em: ' + FDataModule.ACBrCTe.Conhecimentos.Items[0].NomeArq;
      Application.MessageBox(PChar(Mensagem), 'Informa��o do Sistema', MB_OK + MB_ICONEXCLAMATION);
    except
      on E: Exception do
        Application.MessageBox(PChar('Ocorreu um erro ao salvar o arquivo XML da NF-e.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro ao gerar o arquivo XML da NF-e.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;
{$ENDREGION}

{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFCTe.EditDestinatarioIdKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if Key = VK_F1 then
  begin
    if EditDestinatarioId.Value <> 0 then
      Filtro := 'ID = ' + EditDestinatarioId.Text
    else
      Filtro := 'ID=0';

    try
      LimparCamposDestinatario;

        ViewPessoaClienteVO := TViewPessoaClienteController.ConsultaObjeto(Filtro);
        if Assigned(ViewPessoaClienteVO) then
      begin
        EditDestinatarioId.Text := CDSTransiente.FieldByName('ID').AsString;
        EditDestinatarioCpfCnpj.Text := CDSTransiente.FieldByName('CPF_CNPJ').AsString;
        EditDestinatarioRazao.Text := CDSTransiente.FieldByName('NOME').AsString;
        EditDestinatarioLogradouro.Text := CDSTransiente.FieldByName('LOGRADOURO').AsString;
        EditDestinatarioNumero.Text := CDSTransiente.FieldByName('NUMERO').AsString;
        EditDestinatarioComplemento.Text := CDSTransiente.FieldByName('COMPLEMENTO').AsString;
        EditDestinatarioBairro.Text := CDSTransiente.FieldByName('BAIRRO').AsString;
        EditDestinatarioCodigoIbge.Text := CDSTransiente.FieldByName('MUNICIPIO_IBGE').AsString;
        EditDestinatarioCidade.Text := CDSTransiente.FieldByName('CIDADE').AsString;
        EditDestinatarioUF.Text := CDSTransiente.FieldByName('UF').AsString;
        EditDestinatarioCEP.Text := CDSTransiente.FieldByName('CEP').AsString;
        EditDestinatarioTelefone.Text := CDSTransiente.FieldByName('FONE').AsString;
        EditDestinatarioEmail.Text := CDSTransiente.FieldByName('EMAIL').AsString;
        EditDestinatarioIE.Text := CDSTransiente.FieldByName('RG_IE').AsString;
      end
      else
      begin
        Exit;
        EditDestinatarioId.SetFocus;
      end;
    finally
    end;
  end;
end;

procedure TFCTe.EditIdVendaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if Key = VK_F1 then
  begin
    if EditIdVenda.Value <> 0 then
      Filtro := 'ID = ' + EditIdVenda.Text
    else
      Filtro := 'ID=0';

    try
      EditIdVenda.Clear;

        VendaCabecalhoVO := TVendaCabecalhoController.ConsultaObjeto(Filtro);

        if Assigned(VendaCabecalhoVO) then
      begin
        EditIdVenda.Text := CDSTransiente.FieldByName('ID').AsString;
      end
      else
      begin
        Exit;
        EditIdVenda.SetFocus;
      end;
    finally
    end;
  end;
end;
{$ENDREGION}

end.

