{ *******************************************************************************
Title: T2TiPDV
Description: Tela principal da NFCe - Caixa.

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
t2ti.com@gmail.com

@author Albert Eije
@version 2.0
******************************************************************************* }

unit UCaixa;

{$mode objfpc}{$H+}

interface

uses
  Windows, Dialogs, ExtCtrls, Classes, Messages, SysUtils, Variants, Graphics, Tipos,
  Controls, Forms, StdCtrls, Buttons, ACBrBase, TypInfo, Constantes, dateutils,
  ACBrBAL, ACBrDevice, ACBrInStore, ACBrLCB, inifiles, ACBrCalculadora, RXClock,
  RXCtrls, curredit, AutoPanel, Biblioteca, LCLType, UBase, Controller, ACBrNFeUtil, pcnConversao;

type

  { TFCaixa }

  TFCaixa = class(TFBase)
    LabelCliente: TLabel;
    LabelCaixa: TLabel;
    LabelOperador: TLabel;
    labelMenuPrincipal: TRxLabel;
    panelPrincipal: TPanel;
    imagePrincipal: TImage;
    labelTotalGeral: TRxLabel;
    labelMensagens: TRxLabel;
    imageProduto: TImage;
    Bobina: TListBox;
    panelMenuPrincipal: TPanel;
    imagePanelMenuPrincipal: TImage;
    listaMenuPrincipal: TListBox;
    panelMenuOperacoes: TPanel;
    imagePanelMenuOperacoes: TImage;
    listaMenuOperacoes: TListBox;
    panelSubMenu: TPanel;
    imagePanelSubMenu: TImage;
    listaSupervisor: TListBox;
    listaGerente: TListBox;
    labelMenuOperacoes: TRxLabel;
    labelDescricaoProduto: TRxLabel;
    panelTitulo: TRxLabel;
    Timer1: TTimer;
    TimerMarketing: TTimer;
    panelBotoes: TPanel;
    panelF1: TPanel;
    labelF1: TLabel;
    imageF1: TImage;
    panelF7: TPanel;
    labelF7: TLabel;
    imageF7: TImage;
    panelF2: TPanel;
    labelF2: TLabel;
    imageF2: TImage;
    panelF3: TPanel;
    labelF3: TLabel;
    imageF3: TImage;
    panelF4: TPanel;
    labelF4: TLabel;
    imageF4: TImage;
    panelF5: TPanel;
    labelF5: TLabel;
    imageF5: TImage;
    panelF6: TPanel;
    labelF6: TLabel;
    imageF6: TImage;
    panelF8: TPanel;
    labelF8: TLabel;
    imageF8: TImage;
    panelF9: TPanel;
    labelF9: TLabel;
    imageF9: TImage;
    panelF10: TPanel;
    labelF10: TLabel;
    imageF10: TImage;
    panelF11: TPanel;
    labelF11: TLabel;
    imageF11: TImage;
    panelF12: TPanel;
    labelF12: TLabel;
    imageF12: TImage;
    Calculadora: TACBrCalculadora;
    Relogio: TRxClock;
    LabelDescontoAcrescimo: TLabel;
    editCodigo: TEdit;
    ACBrBAL1: TACBrBAL;
    ACBrInStore1: TACBrInStore;
    edtNVenda: TLabel;
    edtNumeroNota: TLabel;
    editQuantidade: TCurrencyEdit;
    editUnitario: TCurrencyEdit;
    editTotalItem: TCurrencyEdit;
    editSubTotal: TCurrencyEdit;
    ACBrLCB1: TACBrLCB;
    procedure RecuperarVenda;
    procedure GerarXmlNfce;
    procedure SelecionarCertificadoDigital;
    procedure InstanciaVendaAtual;
    procedure DesmembraCodigoDigitado(CodigoDeBarraOuDescricaoOuIdProduto: String);
    procedure MensagemDeProdutoNaoEncontrado;
    procedure FechaMenuOperacoes;
    procedure CarregaDAV(Numero: String);
    procedure Timer1Timer(Sender: TObject);
    procedure TrataExcecao(Sender: TObject; E: Exception);
    procedure ConfiguraLayout;
    procedure ExecutaOutrosProcedimentosDeAbertura;
    procedure CompoeItemParaVenda;
    procedure ParametrosIniciaisVenda;
    procedure ConsultaProduto(Codigo: String; Tipo: Integer);
    procedure ImprimeCabecalhoBobina;
    procedure ImprimeItemBobina;
    procedure LocalizaProduto;
    procedure CancelaInutiliza;
    procedure AcionaMenuPrincipal;
    procedure AcionaMenuOperacoes;
    procedure IdentificaCliente;
    procedure IdentificaVendedor;
    procedure ConfiguraConstantes;
    procedure ConfiguraResolucao;
    procedure ConfiguraNfe;
    procedure IniciaMovimento;
    procedure EncerraMovimento;
    procedure CancelaVenda;
    procedure Suprimento;
    procedure Sangria;
    procedure DescontoOuAcrescimo;
    procedure TelaPadrao;
    procedure IniciaVenda;
    procedure IniciaEncerramentoVenda;
    procedure ConcluiEncerramentoVenda;
    procedure VendeItem;
    procedure IniciaVendaDeItens;
    procedure AtualizaTotais;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure listaMenuPrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure listaMenuOperacoesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure listaGerenteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure listaSupervisorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimerMarketingTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure panelF1MouseLeave(Sender: TObject);
    procedure panelF1MouseEnter(Sender: TObject);
    procedure panelF7MouseEnter(Sender: TObject);
    procedure panelF7MouseLeave(Sender: TObject);
    procedure panelF2MouseEnter(Sender: TObject);
    procedure panelF2MouseLeave(Sender: TObject);
    procedure panelF3MouseEnter(Sender: TObject);
    procedure panelF3MouseLeave(Sender: TObject);
    procedure panelF4MouseLeave(Sender: TObject);
    procedure panelF5MouseEnter(Sender: TObject);
    procedure panelF5MouseLeave(Sender: TObject);
    procedure panelF6MouseEnter(Sender: TObject);
    procedure panelF6MouseLeave(Sender: TObject);
    procedure panelF8MouseEnter(Sender: TObject);
    procedure panelF8MouseLeave(Sender: TObject);
    procedure panelF9MouseEnter(Sender: TObject);
    procedure panelF9MouseLeave(Sender: TObject);
    procedure panelF10MouseEnter(Sender: TObject);
    procedure panelF10MouseLeave(Sender: TObject);
    procedure panelF11MouseEnter(Sender: TObject);
    procedure panelF11MouseLeave(Sender: TObject);
    procedure panelF12MouseEnter(Sender: TObject);
    procedure panelF12MouseLeave(Sender: TObject);
    procedure panelF4MouseEnter(Sender: TObject);
    procedure panelF12Click(Sender: TObject);
    procedure panelF1Click(Sender: TObject);
    procedure panelF2Click(Sender: TObject);
    procedure panelF3Click(Sender: TObject);
    procedure panelF4Click(Sender: TObject);
    procedure panelF5Click(Sender: TObject);
    procedure panelF6Click(Sender: TObject);
    procedure panelF7Click(Sender: TObject);
    procedure panelF8Click(Sender: TObject);
    procedure panelF9Click(Sender: TObject);
    procedure panelF10Click(Sender: TObject);
    procedure panelF11Click(Sender: TObject);
    procedure editCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure editQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure editQuantidadeExit(Sender: TObject);
    procedure DesabilitaControlesVenda;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure editCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ConectaComBalanca;
    procedure ACBrBAL1LePeso(Peso: Double; Resposta: AnsiString);
    procedure FormShow(Sender: TObject);
    procedure ACBrLCB1LeCodigo(Sender: TObject);
    procedure ConectaComLeitorSerial;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    BalancaLePeso: Boolean;
    procedure ShowHint(Sender: TObject);
    procedure CancelaItem;
    { Private declarations }
  public
    procedure MenuSetaAcima(Indice: Integer; Lista: TListBox);
    procedure MenuSetaAbaixo(Indice: Integer; Lista: TListBox);
    procedure HabilitaControlesVenda;
    { Public declarations }
  end;

var
  FCaixa: TFCaixa;
  ItemCupom: Integer;
  SubTotal, TotalGeral, Desconto, Acrescimo, ValorICMS: Extended;
  Filtro: String;
  MensagemPersistente: String;

implementation

uses
  UDataModule, UImportaNumero, UIdentificaCliente, UValorReal,
  UDescontoAcrescimo, UIniciaMovimento, UDataModuleConexao,
  UEfetuaPagamento, UEncerraMovimento, UImportaCliente, UImportaProduto,
  UMovimentoAberto, ULoginGerenteSupervisor,
  UListaNFCe,

  ProdutoVO, NfcePosicaoComponentesVO, NfceSangriaVO,
  NfceSuprimentoVO, DAVDetalheVO, NfeCabecalhoVO,
  DavCabecalhoVO, VendedorVO, UnidadeProdutoVO, NfeConfiguracaoVO, NfeNumeroVO,
  NfeDetalheVO,

  VendaController, NfceMovimentoController, NfceSuprimentoController,
  NfceSangriaController, VendedorController, ProdutoController,
  NfeConfiguracaoController, DAVController, NfeNumeroController;

var
  DavCabecalho: TDavCabecalhoVO;
  VendaDetalhe: TNfeDetalheVO;
  ObjetoNfeConfiguracaoVO: TNfeConfiguracaoVO;

{$R *.lfm}

{$Region 'Procedimentos principais e de infra'}
procedure TFCaixa.FormActivate(Sender: TObject);
begin
  FCaixa.Repaint;
end;

procedure TFCaixa.FormShow(Sender: TObject);
begin
  ConfiguraAmbiente;

  Application.CreateForm(TFDataModuleConexao, FDataModuleConexao);
  Application.OnException := @TrataExcecao;

  DesabilitaControlesVenda;

  Sessao.PopulaObjetosPrincipais;
  Sessao.MenuAberto := snNao;
  Sessao.StatusCaixa := scFechado;
  Application.OnHint := @ShowHint;

  ConfiguraConstantes;
  ConfiguraLayout;
  ConfiguraResolucao;

  ExecutaOutrosProcedimentosDeAbertura;

  ObjetoNfeConfiguracaoVO := TNfeConfiguracaoController.ConsultaObjeto('ID=1');
  ConfiguraNfe;

  BalancaLePeso := False;
end;

procedure TFCaixa.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Sessao.Free;
end;

procedure TFCaixa.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (Sessao.StatusCaixa <> scVendaEmAndamento) then
  begin
    if Application.MessageBox('Tem Certeza Que Deseja Sair do Sistema?', 'Sair do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      SetTaskBar(true);
      Application.Terminate;
    end
    else
      CanClose := False;
  end
  else
  begin
    Application.MessageBox('Existe uma venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    CanClose := False;
  end;
end;

procedure TFCaixa.ExecutaOutrosProcedimentosDeAbertura;
begin
  TelaPadrao;
  HabilitaControlesVenda;

  if Sessao.Configuracao.NfceConfiguracaoBalancaVO.Modelo > 0 then
  begin
    try
      ConectaComBalanca;
    except
      Application.MessageBox('Balança não conectada ou desligada!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  end;

  if Sessao.Configuracao.NfceConfiguracaoLeitorSerVO.Usa = 'S' then
  begin
    try
      ConectaComLeitorSerial;
    except
      Application.MessageBox('Leitor de Código de Barras Serial não conectado ou está desligado!' + #13 + 'Verifique os cabos e reveja as configurações do dispositivo!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  end;
end;

procedure TFCaixa.ConfiguraLayout;
begin
  panelTitulo.Caption := Sessao.Configuracao.TituloTelaCaixa + '   Build : ' + VersaoExe(Application.ExeName, 'V');

  if FileExists(Sessao.Configuracao.CaminhoImagensLayout + Sessao.Configuracao.NfceResolucaoVO.ImagemTela) then
    imagePrincipal.Picture.LoadFromFile(Sessao.Configuracao.CaminhoImagensLayout + Sessao.Configuracao.NfceResolucaoVO.ImagemTela)
  else
    Sessao.Configuracao.CaminhoImagensLayout := 'Imagens\imgLayout\';

  imagePrincipal.Picture.LoadFromFile(Sessao.Configuracao.CaminhoImagensLayout + Sessao.Configuracao.NfceResolucaoVO.ImagemTela);
  imagePanelMenuPrincipal.Picture.LoadFromFile(Sessao.Configuracao.CaminhoImagensLayout + Sessao.Configuracao.NfceResolucaoVO.ImagemMenu);
  imagePanelMenuOperacoes.Picture.LoadFromFile(Sessao.Configuracao.CaminhoImagensLayout + Sessao.Configuracao.NfceResolucaoVO.ImagemMenu);
  imagePanelSubMenu.Picture.LoadFromFile(Sessao.Configuracao.CaminhoImagensLayout + Sessao.Configuracao.NfceResolucaoVO.ImagemSubMenu);
end;

procedure TFCaixa.ConfiguraNfe;
begin
  if ObjetoNfeConfiguracaoVO.SalvarXml = 'S' then
    FDataModule.ACBrNFe.Configuracoes.Geral.Salvar := True
  else
    FDataModule.ACBrNFe.Configuracoes.Geral.Salvar := False;

  FDataModule.ACBrNFe.Configuracoes.WebServices.Uf := ObjetoNfeConfiguracaoVO.WebserviceUf;

  if ObjetoNfeConfiguracaoVO.WebserviceAmbiente = 1 then
    FDataModule.ACBrNFe.Configuracoes.WebServices.Ambiente := taProducao
  else
    FDataModule.ACBrNFe.Configuracoes.WebServices.Ambiente := taHomologacao;

  if ObjetoNfeConfiguracaoVO.WebserviceVisualizar = 'S' then
    FDataModule.ACBrNFe.Configuracoes.WebServices.Visualizar := True
  else
    FDataModule.ACBrNFe.Configuracoes.WebServices.Visualizar := False;

  FDataModule.ACBrNFe.Configuracoes.Geral.PathSalvar := ObjetoNfeConfiguracaoVO.CaminhoSalvarXml;
  FDataModule.ACBrNFe.Configuracoes.Geral.PathSchemas := ObjetoNfeConfiguracaoVO.CaminhoSchemas;
  FDataModule.ACBrNFeDANFeRL.PathPDF := ObjetoNfeConfiguracaoVO.CaminhoSalvarPdf;

  FDataModule.ACBrNFe.Configuracoes.Geral.ModeloDF := moNFCe;
  FDataModule.ACBrNFe.Configuracoes.Geral.VersaoDF := ve310;

  FDataModule.ACBrNFe.Configuracoes.Certificados.NumeroSerie := ObjetoNfeConfiguracaoVO.CertificadoDigitalSerie;
end;

Procedure TFCaixa.TrataExcecao(Sender: TObject; E: Exception);
begin
  Application.MessageBox(PChar(E.Message), 'Erro do Sistema', MB_OK + MB_ICONERROR);
end;

procedure TFCaixa.ConfiguraConstantes;
begin
  Constantes.TConstantes.DECIMAIS_QUANTIDADE := Sessao.Configuracao.DecimaisQuantidade;
  Constantes.TConstantes.DECIMAIS_VALOR := Sessao.Configuracao.DecimaisValor;
end;

procedure TFCaixa.ConfiguraResolucao;
var
  i, j: Integer;
  ListaPosicoes: TListaNfcePosicaoComponentesVO;
  PosicaoComponente: TNfcePosicaoComponentesVO;
  NomeComponente: String;
begin
  ListaPosicoes := Sessao.Configuracao.NfceResolucaoVO.ListaNfcePosicaoComponentesVO;

  for j := 0 to componentcount - 1 do
  begin
    NomeComponente := components[j].Name;
    for i := 0 to ListaPosicoes.Count - 1 do
    begin
      PosicaoComponente := ListaPosicoes.Items[i];
      if PosicaoComponente.Nome = NomeComponente then
      begin
        (components[j] as TControl).Height := PosicaoComponente.Altura;
        (components[j] as TControl).Left := PosicaoComponente.Esquerda;
        (components[j] as TControl).Top := PosicaoComponente.Topo;
        (components[j] as TControl).Width := PosicaoComponente.Largura;
        if PosicaoComponente.TamanhoFonte <> 0 then
        begin
          if (components[j] is TEdit) then
            (components[j] as TEdit).Font.Size := PosicaoComponente.TamanhoFonte;
          if (components[j] is TListBox) then
            (components[j] as TListBox).Font.Size := PosicaoComponente.TamanhoFonte;
          if (components[j] is TRxLabel) then
            (components[j] as TRxLabel).Font.Size := PosicaoComponente.TamanhoFonte;
          if (components[j] is TPanel) then
            (components[j] as TPanel).Font.Size := PosicaoComponente.TamanhoFonte;
          if (components[j] is TCurrencyEdit) then
            (components[j] as TCurrencyEdit).Font.Size := PosicaoComponente.TamanhoFonte;
        end;
        if (components[j] is TLabel) then
          (components[j] as TLabel).Caption := PosicaoComponente.Texto;
        break;
      end;
    end;
  end;
//  FCaixa.Left := 0;
  FCaixa.Top := 0;
  FCaixa.Width := Sessao.Configuracao.NfceResolucaoVO.Largura;
  FCaixa.Height := Sessao.Configuracao.NfceResolucaoVO.Altura;

  FCaixa.AutoSize := true;
end;

procedure TFCaixa.ShowHint(Sender: TObject);
begin
  if Application.Hint <> '' then
    labelMensagens.Caption := Application.Hint
  else
    labelMensagens.Caption := MensagemPersistente;
end;

procedure TFCaixa.TelaPadrao;
begin
  if Assigned(Sessao.VendaAtual) then
    Sessao.LiberaVendaAtual;

  if not Assigned(Sessao.Movimento) then
  begin
    labelMensagens.Caption := 'CAIXA FECHADO';
    IniciaMovimento; // se o caixa estiver fechado abre o iniciaMovimento
  end
  else if Sessao.Movimento.StatusMovimento = 'T' then
    labelMensagens.Caption := 'SAIDA TEMPORÁRIA'
  else
    labelMensagens.Caption := 'CAIXA ABERTO';

  if Sessao.StatusCaixa = scVendaEmAndamento then
    labelMensagens.Caption := 'Venda em andamento...';

  MensagemPersistente := labelMensagens.Caption;

  if Assigned(Sessao.Movimento) then
  begin
    LabelCaixa.Caption := 'Terminal: ' + Sessao.Movimento.NfceCaixaVO.Nome;
    LabelOperador.Caption := 'Operador: ' + Sessao.Movimento.NfceOperadorVO.Login;
  end;

  EditQuantidade.Text := '1';
  EditCodigo.Text := '';
  EditUnitario.Text := '0';
  EditTotalItem.Text := '0';
  EditSubTotal.Text := '0';
  labelTotalGeral.Caption := '0,00';
  labelDescricaoProduto.Caption := '';
  LabelDescontoAcrescimo.Caption := '';
  LabelCliente.Caption := '';
  edtNVenda.Caption := '';
  edtNumeroNota.Caption := '';

  SubTotal := 0;
  TotalGeral := 0;
  ValorICMS := 0;
  Desconto := 0;
  Acrescimo := 0;

  Bobina.Clear;

  if Sessao.Configuracao.MarketingAtivo = 'S' then
    TimerMarketing.Enabled := true
  else
  begin
    if FileExists(Sessao.Configuracao.CaminhoImagensProdutos + 'padrao.png') then
      imageProduto.Picture.LoadFromFile(Sessao.Configuracao.CaminhoImagensProdutos + 'padrao.png')
    else
      imageProduto.Picture.LoadFromFile('Imagens\imgProdutos\padrao.png')
  end;
end;

procedure TFCaixa.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  if Assigned(Sessao.Movimento) then
  begin
    Application.CreateForm(TFMovimentoAberto, FMovimentoAberto);
    FMovimentoAberto.ShowModal;
  end;
end;

procedure TFCaixa.TimerMarketingTimer(Sender: TObject);
var
  Aleatorio: Integer;
begin
  if Sessao.StatusCaixa = scAberto then
  begin
    Aleatorio := 1 + Random(5);
    if FileExists(Sessao.Configuracao.CaminhoImagensMarketing + IntToStr(Aleatorio) + '.jpg') then
      imageProduto.Picture.LoadFromFile(Sessao.Configuracao.CaminhoImagensMarketing + IntToStr(Aleatorio) + '.jpg')
    else
      imageProduto.Picture.LoadFromFile('Imagens\imgMarketing\' + IntToStr(Aleatorio) + '.jpg')
  end;
end;

procedure TFCaixa.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // F1 - Identifica Cliente
  if Key = VK_F1 then
    IdentificaCliente;

  // F2 - Menu Principal
  if Key = VK_F2 then
    AcionaMenuPrincipal;

  // F3 - Menu Operações
  if Key = VK_F3 then
    AcionaMenuOperacoes;

  // F4 - Cancelar / Inutilizar
  if Key = VK_F4 then
    CancelaInutiliza;

  // F5 - Recuperar Venda
  if Key = VK_F5 then
    RecuperarVenda;

  // F6 - Localiza Produto
  if Key = VK_F6 then
    LocalizaProduto;

  // F7 - Encerra Venda
  if Key = VK_F7 then
    IniciaEncerramentoVenda;

  // F8 - Cancela Item
  if Key = VK_F8 then
    CancelaItem;

  // F9 - Cancela Venda
  if Key = VK_F9 then
    CancelaVenda;

  // F10 - Concede Desconto
  if Key = VK_F10 then
    DescontoOuAcrescimo;

  // F11 - Identifica Vendedor
  if Key = VK_F11 then
    IdentificaVendedor;

  // F12 - Sai do Caixa
  if Key = VK_F12 then
    Close;

  if (ssctrl in Shift) and (chr(Key) in ['B', 'b']) then
  begin
    if Sessao.Configuracao.NfceConfiguracaoBalancaVO.Modelo > 0 then
    begin
      try
        BalancaLePeso := True;
        ACBrBAL1.LePeso(Sessao.Configuracao.NfceConfiguracaoBalancaVO.TimeOut);
        EditCodigo.Text := '';
        EditCodigo.SetFocus;
      except
        Application.MessageBox('Balança não conectada ou desligada!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    end;
  end;
end;

procedure TFCaixa.AcionaMenuPrincipal;
begin
  if Sessao.StatusCaixa <> scVendaEmAndamento then
  begin
    if Sessao.MenuAberto = snNao then
    begin
      Sessao.MenuAberto := snSim;
      panelMenuPrincipal.Visible := true;
      listaMenuPrincipal.SetFocus;
      listaMenuPrincipal.ItemIndex := 0;
      DesabilitaControlesVenda;
    end
  end
  else
    Application.MessageBox('Existe uma venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFCaixa.AcionaMenuOperacoes;
begin
  if Sessao.StatusCaixa <> scVendaEmAndamento then
  begin
    if Sessao.MenuAberto = snNao then
    begin
      Sessao.MenuAberto := snSim;
      panelMenuOperacoes.Visible := true;
      listaMenuOperacoes.SetFocus;
      listaMenuOperacoes.ItemIndex := 0;
      DesabilitaControlesVenda;
    end;
  end
  else
    Application.MessageBox('Existe uma venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFCaixa.ACBrLCB1LeCodigo(Sender: TObject);
begin
  if editCodigo.Focused then // Para evitar que ponha o codigo no campo quantidade por exemplo
  begin
    editCodigo.Text := ACBrLCB1.UltimoCodigo; // Preenche o edit com o codigo lido
    keybd_event(VK_RETURN, 0, 0, 0); // Simula o acionamento da tecla ENTER
  end;
end;

procedure TFCaixa.MenuSetaAbaixo(Indice: Integer; Lista: TListBox);
begin
  if Indice = Lista.Count - 1 then
    labelMensagens.Caption := Lista.Items[Lista.ItemIndex]
  else
    labelMensagens.Caption := Lista.Items[Lista.ItemIndex + 1];
end;

procedure TFCaixa.MenuSetaAcima(Indice: Integer; Lista: TListBox);
begin
  if Indice = 0 then
    labelMensagens.Caption := Lista.Items[Lista.ItemIndex]
  else
    labelMensagens.Caption := Lista.Items[Lista.ItemIndex - 1];
end;
{$EndRegion}

{$Region 'Procedimentos referentes ao Menu Principal e seus SubMenus'}
procedure TFCaixa.listaMenuPrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    panelMenuPrincipal.Visible := False;
    labelMensagens.Caption := MensagemPersistente;
    Sessao.MenuAberto := snNao;
    panelSubMenu.Visible := False;
    //
    HabilitaControlesVenda;
    EditCodigo.SetFocus;
  end;

  if Key = VK_UP then
    MenuSetaAcima(listaMenuPrincipal.ItemIndex, listaMenuPrincipal);

  if Key = VK_DOWN then
    MenuSetaAbaixo(listaMenuPrincipal.ItemIndex, listaMenuPrincipal);

  if Key = VK_RETURN then
  begin
    // chama submenu do supervisor
    if listaMenuPrincipal.ItemIndex = 0 then
    begin
      Application.CreateForm(TFLoginGerenteSupervisor, FLoginGerenteSupervisor);
      try
        FLoginGerenteSupervisor.GerenteOuSupervisor := 'S';
        if (FLoginGerenteSupervisor.ShowModal = MROK) then
        begin
          if FLoginGerenteSupervisor.LoginOK then
          begin
            panelSubMenu.Visible := true;
            listaSupervisor.BringToFront;
            listaSupervisor.SetFocus;
            listaSupervisor.ItemIndex := 0;
          end
          else
            Application.MessageBox('Supervisor - dados incorretos.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
        end;
      finally
        if Assigned(FLoginGerenteSupervisor) then
          FLoginGerenteSupervisor.Free;
      end;
    end;

    // chama submenu do gerente
    if listaMenuPrincipal.ItemIndex = 1 then
    begin
      Application.CreateForm(TFLoginGerenteSupervisor, FLoginGerenteSupervisor);
      try
        FLoginGerenteSupervisor.GerenteOuSupervisor := 'G';
        if (FLoginGerenteSupervisor.ShowModal = MROK) then
        begin
          if FLoginGerenteSupervisor.LoginOK then
          begin
            panelSubMenu.Visible := true;
            listaGerente.BringToFront;
            listaGerente.SetFocus;
            listaGerente.ItemIndex := 0;
          end
          else
            Application.MessageBox('Gerente - dados incorretos.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
        end;
      finally
        if Assigned(FLoginGerenteSupervisor) then
          FLoginGerenteSupervisor.Free;
      end;
    end;

    // saida temporária
    if listaMenuPrincipal.ItemIndex = 2 then
    begin
      if Sessao.StatusCaixa = scAberto then
      begin
        if Application.MessageBox('Deseja fechar o caixa temporariamente?', 'Fecha o caixa temporariamente', Mb_YesNo + Mb_IconQuestion) = IdYes then
        begin
          Sessao.Movimento.StatusMovimento := 'T';
          TNfceMovimentoController.Altera(Sessao.Movimento);
          Application.CreateForm(TFMovimentoAberto, FMovimentoAberto);
          FMovimentoAberto.ShowModal;
        end;
      end
      else
        Application.MessageBox('Status do caixa não permite saída temporária.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;

  end;
end;

procedure TFCaixa.listaSupervisorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    panelSubMenu.Visible := False;
    listaMenuPrincipal.SetFocus;
    listaMenuPrincipal.ItemIndex := 0;
  end;

  if Key = VK_UP then
    MenuSetaAcima(listaSupervisor.ItemIndex, listaSupervisor);

  if Key = VK_DOWN then
    MenuSetaAbaixo(listaSupervisor.ItemIndex, listaSupervisor);

  if Key = VK_RETURN then
  begin
    // inicia movimento
    if listaSupervisor.ItemIndex = 0 then
      IniciaMovimento;
    // encerra movimento
    if listaSupervisor.ItemIndex = 1 then
      EncerraMovimento;
    // suprimento
    if listaSupervisor.ItemIndex = 3 then
      Suprimento;
    // sangria
    if listaSupervisor.ItemIndex = 4 then
      Sangria;

  end;
end;

procedure TFCaixa.listaGerenteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    panelSubMenu.Visible := False;
    listaMenuPrincipal.SetFocus;
    listaMenuPrincipal.ItemIndex := 0;
  end;

  if Key = VK_UP then
    MenuSetaAcima(listaGerente.ItemIndex, listaGerente);

  if Key = VK_DOWN then
    MenuSetaAbaixo(listaGerente.ItemIndex, listaGerente);

  if Key = VK_RETURN then
  begin
    // inicia movimento
    if listaGerente.ItemIndex = 0 then
      IniciaMovimento;
    // encerra movimento
    if listaGerente.ItemIndex = 1 then
      EncerraMovimento;
    // suprimento
    if listaGerente.ItemIndex = 3 then
      Suprimento;
    // sangria
    if listaGerente.ItemIndex = 4 then
      Sangria;

  end;
end;

procedure TFCaixa.IniciaMovimento;
begin
  try
    if not Assigned(Sessao.Movimento) then
    begin
      Application.CreateForm(TFIniciaMovimento, FIniciaMovimento);
      FIniciaMovimento.ShowModal;
    end
    else
    begin
      Application.MessageBox('Já existe um movimento aberto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
    end;
  finally
  end;
end;

procedure TFCaixa.EncerraMovimento;
begin
  if not Assigned(Sessao.Movimento) then
    Application.MessageBox('Não existe um movimento aberto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
  else
  begin
    Application.CreateForm(TFEncerraMovimento, FEncerraMovimento);
    FEncerraMovimento.ShowModal;
  end;
  TelaPadrao;
end;

procedure TFCaixa.Suprimento;
var
  SuprimentoVO: TNfceSuprimentoVO;
  ValorSuprimento: Extended;
begin
  if not Assigned(Sessao.Movimento) then
    Application.MessageBox('Não existe um movimento aberto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
  else
  begin
    Application.CreateForm(TFValorReal, FValorReal);
    FValorReal.Caption := 'Suprimento';
    FValorReal.LabelEntrada.Caption := 'Informe o valor do suprimento:';
    try
      if (FValorReal.ShowModal = MROK) then
      begin
        ValorSuprimento := FValorReal.EditEntrada.Value;

        SuprimentoVO := TNfceSuprimentoVO.Create;
        SuprimentoVO.IdNfceMovimento := Sessao.Movimento.Id;
        SuprimentoVO.DataSuprimento := Date;
        SuprimentoVO.Observacao := FValorReal.MemoObservacao.Text;
        SuprimentoVO.Valor := ValorSuprimento;
        TNfceSuprimentoController.Insere(SuprimentoVO);
        Sessao.Movimento.TotalSuprimento := Sessao.Movimento.TotalSuprimento + ValorSuprimento;
        TNfceMovimentoController.Altera(Sessao.Movimento);
      end;
    finally
    end;
  end;
end;

procedure TFCaixa.Sangria;
var
  SangriaVO: TNfceSangriaVO;
  ValorSangria: Extended;
begin
  if not Assigned(Sessao.Movimento) then
    Application.MessageBox('Não existe um movimento aberto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
  else
  begin
    Application.CreateForm(TFValorReal, FValorReal);
    FValorReal.Caption := 'Sangria';
    FValorReal.LabelEntrada.Caption := 'Informe o valor da sangria:';
    try
      if (FValorReal.ShowModal = MROK) then
      begin
        ValorSangria := FValorReal.EditEntrada.Value;

        SangriaVO := TNfceSangriaVO.Create;
        SangriaVO.IdNfceMovimento := Sessao.Movimento.Id;
        SangriaVO.DataSangria := Date;
        SangriaVO.Observacao := FValorReal.MemoObservacao.Text;
        SangriaVO.Valor := ValorSangria;
        TNfceSangriaController.Insere(SangriaVO);
        Sessao.Movimento.TotalSangria := Sessao.Movimento.TotalSangria + ValorSangria;
        TNfceMovimentoController.Altera(Sessao.Movimento);
      end;
    finally
    end;
  end;
end;

procedure TFCaixa.DescontoOuAcrescimo;
var
  // 0-Desconto em Dinheiro
  // 1-Desconto Percentual
  // 2-Acréscimo em Dinheiro
  // 3-Acréscimo Percentual
  // 5-Cancela o Desconto ou Acréscimo

  Operacao: Integer;
  Valor: Extended;
begin
  if Sessao.StatusCaixa = scVendaEmAndamento then
  begin
    Application.CreateForm(TFLoginGerenteSupervisor, FLoginGerenteSupervisor);
    try
      if (FLoginGerenteSupervisor.ShowModal = MROK) then
      begin
        if FLoginGerenteSupervisor.LoginOK then
        begin
          Application.CreateForm(TFDescontoAcrescimo, FDescontoAcrescimo);
          FDescontoAcrescimo.Caption := 'Desconto ou Acréscimo';
          try
            if (FDescontoAcrescimo.ShowModal = MROK) then
            begin
              Operacao := FDescontoAcrescimo.ComboOperacao.ItemIndex;
              Valor := FDescontoAcrescimo.EditEntrada.Value;

              // desconto em valor
              if Operacao = 0 then
              begin
                if Valor >= Sessao.VendaAtual.ValorTotalProdutos then
                  Application.MessageBox('Desconto não pode ser superior ou igual ao valor da venda.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                else
                begin
                  if Valor <= 0 then
                    Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                  else
                  begin
                    Desconto := Desconto + Valor;
                    AtualizaTotais;
                  end;
                end;
              end; // if Operacao = 0 then

              // desconto em taxa
              if Operacao = 1 then
              begin
                if Valor > 99 then
                  Application.MessageBox('Desconto não pode ser superior a 100%.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                else
                begin
                  if Valor <= 0 then
                    Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                  else
                  begin
                    Desconto := Desconto + TruncaValor(SubTotal * (Valor / 100), Constantes.TConstantes.DECIMAIS_VALOR);
                    AtualizaTotais;
                  end;
                end;
              end; // if Operacao = 1 then

              // acrescimo em valor
              if Operacao = 2 then
              begin
                if Valor <= 0 then
                  Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                else if Valor >= Sessao.VendaAtual.ValorTotalProdutos then
                  Application.MessageBox('Valor do acréscimo não pode ser igual ou superior ao valor da venda!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                else
                begin
                  Acrescimo := Acrescimo + Valor;
                  AtualizaTotais;
                end;
              end; // if Operacao = 2 then

              // acrescimo em taxa
              if Operacao = 3 then
              begin
                if Valor <= 0 then
                  Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                else if Valor > 99 then
                  Application.MessageBox('Acréscimo não pode ser superior a 100%!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                else
                begin
                  Acrescimo := Acrescimo + TruncaValor(SubTotal * (Valor / 100), Constantes.TConstantes.DECIMAIS_VALOR);
                  AtualizaTotais;
                end;
              end; // if Operacao = 3 then

              // cancela desconto ou acrescimo
              if Operacao = 5 then
              begin
                Acrescimo := 0;
                Desconto := 0;
                AtualizaTotais;
              end; // if Operacao = 5 then

            end;
          finally
            if Assigned(FDescontoAcrescimo) then
              FDescontoAcrescimo.Free;
          end;
        end
        else
          Application.MessageBox('Login - dados incorretos.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      end; // if (FLoginGerenteSupervisor.ShowModal = MROK) then
    finally
      if Assigned(FLoginGerenteSupervisor) then
        FLoginGerenteSupervisor.Free;
    end;
  end
  else
    Application.MessageBox('Não existe venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;
{$EndRegion}

{$Region 'Procedimentos referentes ao Menu Operações e seus SubMenus'}
procedure TFCaixa.listaMenuOperacoesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    FechaMenuOperacoes;
  end;

  if Key = VK_UP then
    MenuSetaAcima(listaMenuOperacoes.ItemIndex, listaMenuOperacoes);

  if Key = VK_DOWN then
    MenuSetaAbaixo(listaMenuOperacoes.ItemIndex, listaMenuOperacoes);

  if Key = VK_RETURN then
  begin

    // carrega dav
    if listaMenuOperacoes.ItemIndex = 0 then
    begin
      if Sessao.StatusCaixa = scAberto then
      begin
        Application.CreateForm(TFImportaNumero, FImportaNumero);
        FImportaNumero.Caption := 'Carrega DAV';
        FImportaNumero.LabelEntrada.Caption := 'Informe o número do DAV';
        try
          if (FImportaNumero.ShowModal = MROK) then
          begin
            FechaMenuOperacoes;
            CarregaDAV(FImportaNumero.EditEntrada.Text);
          end;
        finally
          if Assigned(FImportaNumero) then
            FImportaNumero.Free;
        end;
      end
      else
        Application.MessageBox('Já existe uma venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;

    // seleciona certificado
    if listaMenuOperacoes.ItemIndex = 1 then
    begin
      SelecionarCertificadoDigital;
    end;

    // verifica o status do serviço
    if listaMenuOperacoes.ItemIndex = 2 then
    begin
      FDataModule.ACBrNFe.WebServices.StatusServico.Executar;
    end;

  end; // if Key = VK_RETURN then
end;

procedure TFCaixa.FechaMenuOperacoes;
begin
  panelMenuOperacoes.Visible := False;
  labelMensagens.Caption := MensagemPersistente;
  Sessao.MenuAberto := snNao;
  HabilitaControlesVenda;
  EditCodigo.SetFocus;
end;

procedure TFCaixa.CarregaDAV(Numero: String);
var
  i: Integer;
begin
  try
    Filtro := 'SITUACAO = ' + QuotedStr('P') + ' and ID=' + Numero;
    DavCabecalho := TDAVController.ConsultaObjeto(Filtro);

    if Assigned(DavCabecalho) then
    begin
      if DavCabecalho.ListaDavDetalheVO.Count > 0 then
      begin
        IniciaVenda;
        Sessao.StatusCaixa := scImportandoOrcamento;
        for i := 0 to DavCabecalho.ListaDavDetalheVO.Count - 1 do
        begin
          VendaDetalhe := TNfeDetalheVO.Create;
          VendaDetalhe.ProdutoVO := TProdutoController.ConsultaPorTipo(IntToStr(DavCabecalho.ListaDavDetalheVO.Items[I].IdProduto), 4);

          VendaDetalhe.QuantidadeComercial := DavCabecalho.ListaDavDetalheVO.Items[i].Quantidade;
          VendaDetalhe.QuantidadeTributavel := DavCabecalho.ListaDavDetalheVO.Items[i].Quantidade;
          VendaDetalhe.ValorUnitarioComercial := DavCabecalho.ListaDavDetalheVO.Items[i].ValorUnitario;
          VendaDetalhe.ValorUnitarioTributavel := DavCabecalho.ListaDavDetalheVO.Items[i].ValorUnitario;
          VendaDetalhe.ValorBrutoProduto := TruncaValor(VendaDetalhe.QuantidadeComercial * DavCabecalho.ListaDavDetalheVO.Items[i].ValorUnitario, 2);
          VendaDetalhe.ValorSubtotal := DavCabecalho.ListaDavDetalheVO.Items[i].ValorTotal;
          // Exercício: implemente o desconto sobre o valor do item de acordo com a sua necessidade
          VendaDetalhe.ValorDesconto := 0;
          VendaDetalhe.ValorTotal := VendaDetalhe.ValorSubtotal - VendaDetalhe.ValorDesconto;
          VendeItem;
          SubTotal := SubTotal + VendaDetalhe.ValorTotal;
          TotalGeral := TotalGeral + VendaDetalhe.ValorTotal;
          ValorICMS := ValorICMS + VendaDetalhe.NfeDetalheImpostoIcmsVO.ValorIcms;
          AtualizaTotais;
        end;
        Bobina.ItemIndex := Bobina.Items.Count - 1;
        EditCodigo.SetFocus;
        Sessao.StatusCaixa := scVendaEmAndamento;
      end
      else
        Application.MessageBox('DAV sem itens.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end
    else
      Application.MessageBox('DAV inexistente ou já efetivado/mesclado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  finally
  end;
end;

{$EndRegion}

{$Region 'Procedimentos para controle da venda'}
procedure TFCaixa.InstanciaVendaAtual;
var
  NfeNumeroVO: TNfeNumeroVO;
begin
  try
    // instancia venda
    if not Assigned(Sessao.VendaAtual) then
    begin
      Sessao.VendaAtual := TNfeCabecalhoVO.Create;

      //Pega um número
      Filtro := '1=1';
      NfeNumeroVO := TNfeNumeroController.ConsultaObjeto(Filtro);

      //Gera a chave de acesso
      Sessao.VendaAtual.ChaveAcesso :=  IntToStr(Sessao.Configuracao.EmpresaVO.CodigoIbgeUf) +
                                        FormatDateTime('yy', Now) +
                                        FormatDateTime('mm', Now) +
                                        Sessao.Configuracao.EmpresaVO.Cnpj +
                                        '65' +
                                        NfeNumeroVO.Serie +
                                        StringOfChar('0', 9 - Length(IntToStr(NfeNumeroVO.Numero))) + IntToStr(NfeNumeroVO.Numero) +
                                        '1' +
                                        StringOfChar('0', 8 - Length(IntToStr(NfeNumeroVO.Numero))) + IntToStr(NfeNumeroVO.Numero);
      Sessao.VendaAtual.DigitoChaveAcesso := Modulo11(Sessao.VendaAtual.ChaveAcesso);

      Sessao.VendaAtual.UfEmitente := Sessao.Configuracao.EmpresaVO.CodigoIbgeUf;
      Sessao.VendaAtual.CodigoNumerico := StringOfChar('0', 8 - Length(IntToStr(NfeNumeroVO.Numero))) + IntToStr(NfeNumeroVO.Numero);
      Sessao.VendaAtual.NaturezaOperacao := 'VENDA';
      Sessao.VendaAtual.CodigoModelo := '65';
      Sessao.VendaAtual.Serie := NfeNumeroVO.Serie;
      Sessao.VendaAtual.Numero := StringOfChar('0', 9 - Length(IntToStr(NfeNumeroVO.Numero))) + IntToStr(NfeNumeroVO.Numero);
      Sessao.VendaAtual.DataHoraEmissao := Now;
      Sessao.VendaAtual.DataHoraEntradaSaida := Now;
      Sessao.VendaAtual.TipoOperacao := 1;
      Sessao.VendaAtual.CodigoMunicipio := Sessao.Configuracao.EmpresaVO.CodigoIbgeCidade;
      Sessao.VendaAtual.FormatoImpressaoDanfe := 4;
      Sessao.VendaAtual.TipoEmissao := 1;
      Sessao.VendaAtual.IdEmpresa := Sessao.Configuracao.EmpresaVO.Id;
      Sessao.VendaAtual.Ambiente := ObjetoNfeConfiguracaoVO.WebserviceAmbiente;
      Sessao.VendaAtual.FinalidadeEmissao := 1;
      Sessao.VendaAtual.ProcessoEmissao := ObjetoNfeConfiguracaoVO.ProcessoEmissao;
      Sessao.VendaAtual.VersaoProcessoEmissao := ObjetoNfeConfiguracaoVO.VersaoProcessoEmissao;
      Sessao.VendaAtual.ConsumidorPresenca := 1;

    end;
  finally
    NfeNumeroVO := Nil;
  end;
end;

procedure TFCaixa.LocalizaProduto;
begin
  Application.CreateForm(TFImportaProduto, FImportaProduto);
  FImportaProduto.ShowModal;
  if (Sessao.StatusCaixa = scVendaEmAndamento) and (trim(EditCodigo.Text) <> '') then
  begin
    EditCodigo.SetFocus;
    IniciaVendaDeItens;
  end;
end;

procedure TFCaixa.IdentificaCliente;
begin
  InstanciaVendaAtual;
  Application.CreateForm(TFIdentificaCliente, FIdentificaCliente);
  FIdentificaCliente.ShowModal;
  if Sessao.VendaAtual.NfeDestinatarioVO.CpfCnpj <> '' then
  begin
    if Sessao.StatusCaixa = scAberto then
    begin
      IniciaVenda;
    end;
    LabelCliente.Caption := 'Cliente: ' + Sessao.VendaAtual.NfeDestinatarioVO.Nome + ' - ' + Sessao.VendaAtual.NfeDestinatarioVO.CpfCnpj;
    LabelCliente.Repaint;
  end;
end;

procedure TFCaixa.IdentificaVendedor;
var
  Vendedor: TVendedorVO;
begin
  try
    if Sessao.StatusCaixa = scVendaEmAndamento then
    begin
      Application.CreateForm(TFImportaNumero, FImportaNumero);
      FImportaNumero.Caption := 'Identifica Vendedor';
      FImportaNumero.LabelEntrada.Caption := 'Informe o código do vendedor';
      try
        if (FImportaNumero.ShowModal = MROK) then
        begin
          Filtro := 'ID = ' + FImportaNumero.EditEntrada.Text;
          Vendedor := TVendedorController.ConsultaObjeto(Filtro);

          if Assigned(Vendedor) then
            Sessao.VendaAtual.IdVendedor := Vendedor.Id
          else
            Application.MessageBox('Vendedor: código inválido ou inexistente.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
        end;
      except
      end;
    end
    else
      Application.MessageBox('Não existe venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  finally
    Vendedor := Nil;
  end;
end;

procedure TFCaixa.IniciaVenda;
begin
  Bobina.Items.Text := '';

  if not Assigned(Sessao.Movimento) then
    Application.MessageBox('Não existe um movimento aberto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
  else
  begin
    // instancia venda
    InstanciaVendaAtual;

    ImprimeCabecalhoBobina;
    ParametrosIniciaisVenda;
    Sessao.StatusCaixa := scVendaEmAndamento;
    labelMensagens.Caption := 'Venda em andamento...';

    Sessao.VendaAtual.IdNfceMovimento := Sessao.Movimento.Id;

    Sessao.VendaAtual := TVendaController.Insere(Sessao.VendaAtual);

    EditCodigo.SetFocus;
    EditCodigo.SelectAll;

    edtNVenda.Caption := 'VENDA nº ' + IntToStr(Sessao.VendaAtual.Id);
    edtNumeroNota.Caption := 'NFC-e nº ' + Sessao.VendaAtual.Numero;
  end;
end;

procedure TFCaixa.ParametrosIniciaisVenda;
begin
  TimerMarketing.Enabled := False;

  if FileExists(Sessao.Configuracao.CaminhoImagensProdutos + 'padrao.png') then
    imageProduto.Picture.LoadFromFile(Sessao.Configuracao.CaminhoImagensProdutos + 'padrao.png')
  else
    imageProduto.Picture.LoadFromFile('Imagens\imgProdutos\padrao.png');

  ItemCupom := 0;
  SubTotal := 0;
  TotalGeral := 0;
  ValorICMS := 0;
end;

procedure TFCaixa.ImprimeCabecalhoBobina;
begin
  Bobina.Items.Add(StringOfChar('-', 48));
  Bobina.Items.Add('               **     NFC-e     **               ');
  Bobina.Items.Add(StringOfChar('-', 48));
  Bobina.Items.Add('ITEM CÓDIGO         DESCRIÇÃO                   ');
  Bobina.Items.Add('QTD.     UN      VL.UNIT.(R$)        VL.ITEM(R$)');
  Bobina.Items.Add(StringOfChar('-', 48));
end;

procedure TFCaixa.IniciaVendaDeItens;
var
  Unitario, Quantidade, Total: Extended;
begin
  if not Assigned(Sessao.Movimento) then
  begin
    labelMensagens.Caption := 'CAIXA FECHADO';
    IniciaMovimento; // se o caixa estiver fechado abre o iniciaMovimento
    Abort;
  end;

  if Sessao.MenuAberto = snNao then
  begin
    if Sessao.StatusCaixa = scAberto then
    begin
      IniciaVenda;
    end;
    if trim(EditCodigo.Text) <> '' then
    begin
      VendaDetalhe := TNfeDetalheVO.Create;
      DesmembraCodigoDigitado(trim(EditCodigo.Text));
      Application.ProcessMessages;

      if Assigned(VendaDetalhe.ProdutoVO) then
      begin
        if VendaDetalhe.ProdutoVO.ValorVenda <= 0 then
        begin
          Application.MessageBox('Produto não pode ser vendido com valor zerado ou negativo!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          EditCodigo.SetFocus;
          EditCodigo.SelectAll;
          FreeAndNil(VendaDetalhe);
          Abort;
        end;

        labelMensagens.Caption := 'Venda em andamento...';
        MensagemPersistente := labelMensagens.Caption;

        if ACBrInStore1.Peso > 0 then
          EditQuantidade.Value := ACBrInStore1.Peso;

        if ACBrInStore1.Total > 0 then
          EditQuantidade.Text := FormataFloat('Q', (ACBrInStore1.Total / VendaDetalhe.ProdutoVO.ValorVenda));

        if (VendaDetalhe.ProdutoVO.UnidadeProdutoVO.PodeFracionar = 'N') and (Frac(StrToFloat(EditQuantidade.Text)) > 0) then
        begin
          Application.MessageBox('Produto não pode ser vendido com quantidade fracionada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          EditUnitario.Text := '0';
          EditTotalItem.Text := '0';
          EditQuantidade.Text := '1';
          labelDescricaoProduto.Caption := '';
          EditCodigo.Text := '';
          EditCodigo.SetFocus;
          FreeAndNil(VendaDetalhe);
        end
        else
        begin
          EditUnitario.Text := FormataFloat('V', VendaDetalhe.ProdutoVO.ValorVenda);
          labelDescricaoProduto.Caption := VendaDetalhe.ProdutoVO.DescricaoPDV;
          // carrega imagem do produto
          if FileExists(Sessao.Configuracao.CaminhoImagensProdutos + VendaDetalhe.ProdutoVO.GTIN + '.jpg') then
            imageProduto.Picture.LoadFromFile(Sessao.Configuracao.CaminhoImagensProdutos + VendaDetalhe.ProdutoVO.GTIN + '.jpg')
          else
            imageProduto.Picture.LoadFromFile('Imagens\imgProdutos\padrao.png');

          Unitario := EditUnitario.Value;
          Quantidade := EditQuantidade.Value;

          Total := TruncaValor(Unitario * Quantidade, Constantes.TConstantes.DECIMAIS_VALOR);
          EditTotalItem.Text := FormataFloat('V', Total);

          VendeItem;

          SubTotal := SubTotal + VendaDetalhe.ValorTotal;
          TotalGeral := TotalGeral + VendaDetalhe.ValorTotal;
          ValorICMS := ValorICMS + VendaDetalhe.NfeDetalheImpostoIcmsVO.ValorIcms;
          AtualizaTotais;
          EditCodigo.Clear;
          EditCodigo.SetFocus;
          EditQuantidade.Text := '1';
          Application.ProcessMessages;
        end; // if (Produto.PodeFracionarUnidade = 'N') and (Frac(StrToFloat(EditQuantidade.Text))>0) then
      end
      else
      begin
        MensagemDeProdutoNaoEncontrado;
      end; // if Produto.Id <> 0 then
    end; // if trim(EditCodigo.Text) <> '' then
  end; // if Sessao.MenuAberto = 0 then
end;

procedure TFCaixa.ConsultaProduto(Codigo: String; Tipo: Integer);
begin
  VendaDetalhe.ProdutoVO := TProdutoController.ConsultaPorTipo(Codigo, Tipo);
end;

procedure TFCaixa.MensagemDeProdutoNaoEncontrado;
begin
  Application.MessageBox('Código não encontrado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  EditUnitario.Text := '0';
  EditTotalItem.Text := '0';
  EditQuantidade.Text := '1';
  labelDescricaoProduto.Caption := '';
  EditCodigo.SetFocus;
  EditCodigo.SelectAll;
end;

procedure TFCaixa.DesmembraCodigoDigitado(CodigoDeBarraOuDescricaoOuIdProduto: string);
var
  IdentificadorBalanca, vCodDescrId: String;
  LengthInteiro, LengthCodigo: Integer;
begin

  IdentificadorBalanca := Sessao.Configuracao.NfceConfiguracaoBalancaVO.Identificador;
  vCodDescrId := CodigoDeBarraOuDescricaoOuIdProduto;
  LengthInteiro := Length(DevolveInteiro(vCodDescrId));
  LengthCodigo := Length(vCodDescrId);
  ACBrInStore1.ZerarDados;

  try
    if (LengthInteiro = LengthCodigo) and (LengthCodigo <= 4) and (BalancaLePeso = true) then
    begin
      ConsultaProduto(vCodDescrId, 1);
      if Assigned(VendaDetalhe.ProdutoVO) then
        exit;
    end;
  finally
    BalancaLePeso := False;
  end;

  if ((LengthInteiro = 13) and (LengthCodigo = 13)) or ((LengthInteiro = 14) and (LengthCodigo = 14)) then
  begin
    if (LengthInteiro = 13) and (IdentificadorBalanca = Copy(vCodDescrId, 1, 1)) then
    begin
      ACBrInStore1.Codificacao := trim(Sessao.Configuracao.NfceConfiguracaoBalancaVO.TipoConfiguracao);
      ACBrInStore1.Desmembrar(trim(vCodDescrId));
      ConsultaProduto(ACBrInStore1.Codigo, 1);
      if Assigned(VendaDetalhe.ProdutoVO) then
        exit
      else
        ACBrInStore1.ZerarDados;
    end;
    ConsultaProduto(vCodDescrId, 2);
    if Assigned(VendaDetalhe.ProdutoVO) then
      exit;
  end;

  if LengthInteiro = LengthCodigo then
  begin
    ConsultaProduto(Copy(vCodDescrId, 1, 10), 4);
    if Assigned(VendaDetalhe.ProdutoVO) then
      exit;
  end
  else
  begin
    Application.CreateForm(TFImportaProduto, FImportaProduto);
    FImportaProduto.EditLocaliza.Text := vCodDescrId;
    FImportaProduto.ShowModal;
    if (Length(DevolveInteiro(EditCodigo.Text))) = (Length(trim(EditCodigo.Text))) then
    begin
      VendaDetalhe.ProdutoVO.Id := 0;
      ConsultaProduto(trim(EditCodigo.Text), 4);
    end
    else
    begin
      MensagemDeProdutoNaoEncontrado;
      Abort;
    end;
  end;
end;

procedure TFCaixa.editCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      if trim(EditCodigo.Text) <> '' then
        IniciaVendaDeItens;
  end;
end;

procedure TFCaixa.editCodigoKeyPress(Sender: TObject; var Key: Char);
var
  Quantidade: Extended;
begin
  if Key = '.' then
    Key := FormatSettings.DecimalSeparator;

  if (Key = #13) and (trim(EditCodigo.Text) = '') then
  begin
    Key := #0;
    Perform(Wm_NextDlgCtl, 0, 0);
  end;

  if Key = '*' then
  begin
    Key := #0;
    try
      Quantidade := StrToFloat(EditCodigo.Text);
      if (Quantidade <= 0) then
      begin
        Application.MessageBox('Quantidade inválida.', 'Erro', MB_OK + MB_ICONERROR);
        EditCodigo.Text := '';
        EditQuantidade.Text := '1';
      end
      else
      begin
        EditQuantidade.Text := EditCodigo.Text;
        EditCodigo.Text := '';
      end;
    except
      Application.MessageBox('Quantidade inválida.', 'Erro', MB_OK + MB_ICONERROR);
      EditCodigo.Text := '';
      EditQuantidade.Text := '1';
    end;
  end;
end;

procedure TFCaixa.editQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(Wm_NextDlgCtl, 0, 0);
  end;
end;

procedure TFCaixa.editQuantidadeExit(Sender: TObject);
begin
  if (EditQuantidade.Value <= 0) then
  begin
    Application.MessageBox('Quantidade inválida.', 'Erro', MB_OK + MB_ICONERROR);
    EditQuantidade.Value := 1;
  end;
end;

procedure TFCaixa.VendeItem;
begin
  try
    CompoeItemParaVenda;

    if VendaDetalhe.GTIN = '' then
    begin
      Application.MessageBox('Produto com Código ou GTIN Não Definido!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      EditUnitario.Text := '0';
      EditTotalItem.Text := '0';
      EditCodigo.SetFocus;
      EditCodigo.SelectAll;
      Dec(ItemCupom);
      FreeAndNil(VendaDetalhe);
      Abort;
    end;

    if VendaDetalhe.ProdutoVO.DescricaoPDV = '' then
    begin
      Application.MessageBox('Produto com Descrição Não Definida!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      EditUnitario.Text := '0';
      EditTotalItem.Text := '0';
      EditCodigo.SetFocus;
      EditCodigo.SelectAll;
      Dec(ItemCupom);
      FreeAndNil(VendaDetalhe);
      Abort;
    end;

    if VendaDetalhe.ProdutoVO.UnidadeProdutoVO.Sigla = '' then
    begin
      Application.MessageBox('Produto com Unidade Não Definida!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      EditUnitario.Text := '0';
      EditTotalItem.Text := '0';
      EditCodigo.SetFocus;
      EditCodigo.SelectAll;
      Dec(ItemCupom);
      FreeAndNil(VendaDetalhe);
      Abort;
    end;

    // Imposto
    VendaDetalhe.NfeDetalheImpostoIcmsVO.OrigemMercadoria := 0; //nacional
    VendaDetalhe.NfeDetalheImpostoIcmsVO.CstIcms := '00'; //nacional
    VendaDetalhe.NfeDetalheImpostoIcmsVO.ModalidadeBcIcms := 3; //valor da operação
    VendaDetalhe.NfeDetalheImpostoIcmsVO.AliquotaIcms := VendaDetalhe.ProdutoVO.AliquotaIcmsPaf;
    VendaDetalhe.NfeDetalheImpostoIcmsVO.BaseCalculoIcms := VendaDetalhe.ValorTotal;
    VendaDetalhe.NfeDetalheImpostoIcmsVO.ValorIcms := VendaDetalhe.ValorTotal * VendaDetalhe.ProdutoVO.AliquotaIcmsPaf / 100;

    VendaDetalhe := TVendaController.InsereItem(VendaDetalhe);
    Sessao.VendaAtual.ListaNfeDetalheVO.Add(VendaDetalhe);
    ImprimeItemBobina;
    Bobina.ItemIndex := Bobina.Items.Count - 1;

  finally
  end;
end;

procedure TFCaixa.CompoeItemParaVenda;
begin
  inc(ItemCupom);
  VendaDetalhe.NumeroItem := ItemCupom;
  VendaDetalhe.IdProduto := VendaDetalhe.ProdutoVO.Id;
  VendaDetalhe.CFOP := Sessao.Configuracao.CFOP;
  VendaDetalhe.IdNfeCabecalho := Sessao.VendaAtual.Id;
  VendaDetalhe.CodigoProduto := VendaDetalhe.ProdutoVO.GTIN;
  VendaDetalhe.GTIN := VendaDetalhe.ProdutoVO.GTIN;
  VendaDetalhe.NomeProduto := VendaDetalhe.ProdutoVO.Nome;
  VendaDetalhe.Ncm := VendaDetalhe.ProdutoVO.Ncm;
  //VendaDetalhe.ExTipi := StrToInt(VendaDetalhe.ProdutoVO.ExTipi);
  VendaDetalhe.UnidadeComercial := VendaDetalhe.ProdutoVO.UnidadeProdutoVO.Sigla;
  VendaDetalhe.UnidadeTributavel := VendaDetalhe.ProdutoVO.UnidadeProdutoVO.Sigla;

  if Sessao.StatusCaixa = scVendaEmAndamento then
  begin
    VendaDetalhe.QuantidadeComercial := EditQuantidade.Value;
    VendaDetalhe.QuantidadeTributavel := EditQuantidade.Value;
    VendaDetalhe.ValorUnitarioComercial := EditUnitario.Value;
    VendaDetalhe.ValorUnitarioTributavel := EditUnitario.Value;
    VendaDetalhe.ValorBrutoProduto := TruncaValor(VendaDetalhe.QuantidadeComercial * EditUnitario.Value, 2);
    VendaDetalhe.ValorSubtotal := EditTotalItem.Value;
    // Exercício: implemente o desconto sobre o valor do item de acordo com a sua necessidade
    VendaDetalhe.ValorDesconto := 0;
    VendaDetalhe.ValorTotal := VendaDetalhe.ValorSubtotal - VendaDetalhe.ValorDesconto;
  end;
end;

procedure TFCaixa.ImprimeItemBobina;
var
  Quantidade, Unitario, Total, Unidade: String;
begin
  Quantidade := FloatToStrF(VendaDetalhe.QuantidadeComercial, ffNumber, 8, 3);
  Unitario := FloatToStrF(VendaDetalhe.ValorUnitarioComercial, ffNumber, 13, 2);
  Total := FloatToStrF(VendaDetalhe.ValorTotal, ffNumber, 14, 2);
  Bobina.Items.Add(StringOfChar('0', 3 - Length(IntToStr(ItemCupom))) + IntToStr(ItemCupom) + '  ' + VendaDetalhe.GTIN + StringOfChar(' ', 14 - Length(VendaDetalhe.GTIN)) + ' ' + Copy(VendaDetalhe.ProdutoVO.DescricaoPDV, 1, 28));

  Unidade := trim(Copy(VendaDetalhe.ProdutoVO.UnidadeProdutoVO.Sigla, 1, 3));

  Bobina.Items.Add(StringOfChar(' ', 8 - Length(Quantidade)) + Quantidade + ' ' + StringOfChar(' ', 3 - Length(Unidade)) + Unidade + ' x ' + StringOfChar(' ', 13 - Length(Unitario)) + Unitario + '      ' + StringOfChar(' ', 14 - Length(Total)) + Total);
end;

procedure TFCaixa.AtualizaTotais;
var
  DescontoAcrescimo: Extended;
begin
  Sessao.VendaAtual.ValorTotalProdutos := SubTotal;
  Sessao.VendaAtual.ValorDesconto := Desconto;
  Sessao.VendaAtual.ValorDespesasAcessorias := Acrescimo;

  Sessao.VendaAtual.ValorTotal := TotalGeral - Desconto + Acrescimo;
  Sessao.VendaAtual.BaseCalculoIcms := Sessao.VendaAtual.ValorTotal;
  Sessao.VendaAtual.ValorIcms := ValorICMS;
  DescontoAcrescimo := Acrescimo - Desconto;

  if DescontoAcrescimo < 0 then
  begin
    LabelDescontoAcrescimo.Caption := 'Desconto: R$ ' + FormatFloat('0.00', -DescontoAcrescimo);
    LabelDescontoAcrescimo.Font.Color := clRed;
    Sessao.VendaAtual.ValorDesconto := -DescontoAcrescimo;
    Sessao.VendaAtual.ValorDespesasAcessorias := 0;
  end
  else if DescontoAcrescimo > 0 then
  begin
    LabelDescontoAcrescimo.Caption := 'Acréscimo: R$ ' + FormatFloat('0.00', DescontoAcrescimo);
    LabelDescontoAcrescimo.Font.Color := clBlue;
    Sessao.VendaAtual.ValorDesconto := 0;
    Sessao.VendaAtual.ValorDespesasAcessorias := DescontoAcrescimo;
  end
  else
  begin
    LabelDescontoAcrescimo.Caption := '';
    Acrescimo := 0;
    Desconto := 0;
  end;

  EditSubTotal.Text := FormatFloat('0.00', Sessao.VendaAtual.ValorTotalProdutos);
  labelTotalGeral.Caption := Format('%18.2n', [Sessao.VendaAtual.ValorTotal]);
end;

procedure TFCaixa.IniciaEncerramentoVenda;
begin
  if Sessao.StatusCaixa = scVendaEmAndamento then
  begin
    if Sessao.VendaAtual.ListaNfeDetalheVO.Count > 0 then
    begin
      if Sessao.VendaAtual.ValorTotal <= 0 then
      begin
        if Application.MessageBox('Não existem itens para o fechamento da venda.' + #13 + #13 + 'Deseja cancelar o procedimento?', 'Cancelar a venda', Mb_YesNo + Mb_IconQuestion) = IdYes then
          CancelaVenda;
        Abort;
      end;

      Application.CreateForm(TFEfetuaPagamento, FEfetuaPagamento);
      FEfetuaPagamento.ShowModal;
      edtNVenda.Caption := '';
      edtNumeroNota.Caption := '';
    end
    else
      Application.MessageBox('A venda não contém itens.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end
  else
    Application.MessageBox('Não existe venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFCaixa.ConcluiEncerramentoVenda;
var
  I: Integer;
begin
  try
    // Exercício: o Status da Nota está sendo alterado para "4=Autorizada" antes mesmo de enviar a nota. Corrija isso.
    Sessao.VendaAtual.StatusNota := 4;
    GerarXmlNfce;
    FDataModule.ACBrNFe.Enviar(1,True,False);
    // Exercício: Estamos guardando o número do protocolo no campo do pedido da compra. Analise como armazenar tal dado da forma devida.
    Sessao.VendaAtual.CompraPedido := FDataModule.ACBrNFe.WebServices.Retorno.Protocolo;
    TVendaController.Altera(Sessao.VendaAtual);
  finally
    FreeAndNil(DavCabecalho);
    TelaPadrao;
  end;
end;

procedure TFCaixa.CancelaVenda;
begin
  if not Assigned(Sessao.Movimento) then
    Application.MessageBox('Não existe um movimento aberto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
  else
  begin
    Application.CreateForm(TFLoginGerenteSupervisor, FLoginGerenteSupervisor);
    try
      if (FLoginGerenteSupervisor.ShowModal = MROK) then
      begin
        if FLoginGerenteSupervisor.LoginOK then
        begin

          if Application.MessageBox('Deseja cancelar a venda atual?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
          begin
            Sessao.StatusCaixa := scAberto;
            TelaPadrao;
          end;

        end
        else
          Application.MessageBox('Login - dados incorretos.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    finally
      if Assigned(FLoginGerenteSupervisor) then
        FLoginGerenteSupervisor.Free;
    end;
  end;
end;

procedure TFCaixa.CancelaItem;
var
  cancela: Integer;
begin
  if Sessao.StatusCaixa = scVendaEmAndamento then
  begin

    if Application.MessageBox('Tem certeza que deseja remover o item da nota fiscal?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
    begin
      Application.CreateForm(TFImportaNumero, FImportaNumero);
      FImportaNumero.Caption := 'Cancelar Item';
      FImportaNumero.LabelEntrada.Caption := 'Informe o número do Item';
      try
        if (FImportaNumero.ShowModal = MROK) then
        begin
          cancela := FImportaNumero.EditEntrada.AsInteger;
          if cancela > 0 then
          begin
            if cancela <= Sessao.VendaAtual.ListaNfeDetalheVO.Count then
            begin
              TVendaController.CancelaItemVenda(Cancela);

              Bobina.Items.Add(StringOfChar('*', 48));
              Bobina.Items.Add(StringOfChar('0', 3 - Length(IntToStr(cancela))) + IntToStr(cancela) + '  ' + VendaDetalhe.GTIN + StringOfChar(' ', 14 - Length(VendaDetalhe.GTIN)) + ' ' + Copy(VendaDetalhe.ProdutoVO.DescricaoPDV, 1, 28));

              Bobina.Items.Add('ITEM CANCELADO');
              Bobina.Items.Add(StringOfChar('*', 48));

              SubTotal := SubTotal - VendaDetalhe.ValorTotal;
              TotalGeral := TotalGeral - VendaDetalhe.ValorTotal;
              ValorICMS := ValorICMS - VendaDetalhe.NfeDetalheImpostoIcmsVO.ValorIcms;

              // cancela possíveis descontos ou acrescimos
              Desconto := 0;
              Acrescimo := 0;
              Bobina.ItemIndex := Bobina.Items.Count - 1;
              AtualizaTotais;

            end
            else
              Application.MessageBox('O item solicitado não existe na venda atual.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          end
          else
            Application.MessageBox('Informe um número de item válido.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
        end;
      finally
        if Assigned(FImportaNumero) then
          FImportaNumero.Free;
      end;
    end;
  end
  else
    Application.MessageBox('Não existe venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFCaixa.RecuperarVenda;
var
  i: Integer;
begin
  Application.CreateForm(TFListaNFCe, FListaNFCe);
  FListaNFCe.Operacao := 'RecuperarVenda';
  FListaNFCe.ShowModal;

  if FListaNFCe.Confirmou then
  begin

    Filtro := 'ID = ' + FListaNFCe.QNFCe.FieldByName('ID').AsString;
    Sessao.VendaAtual := TVendaController.ConsultaObjeto(Filtro);
    if Assigned(Sessao.VendaAtual) then
    begin

      ImprimeCabecalhoBobina;
      ParametrosIniciaisVenda;

      Sessao.StatusCaixa := scRecuperandoVenda;

      labelMensagens.Caption := 'Venda recuperada em andamento..';

      for i := 0 to Sessao.VendaAtual.ListaNfeDetalheVO.Count - 1 do
      begin
        VendaDetalhe := Sessao.VendaAtual.ListaNfeDetalheVO.Items[i];
        ConsultaProduto(VendaDetalhe.GTIN, 2);
        CompoeItemParaVenda;
        ImprimeItemBobina;

        if VendaDetalhe.NfeDetalheImpostoIcmsVO.Id = 0 then
        begin
          // Imposto
          VendaDetalhe.NfeDetalheImpostoIcmsVO.OrigemMercadoria := 0; //nacional
          VendaDetalhe.NfeDetalheImpostoIcmsVO.CstIcms := '00'; //nacional
          VendaDetalhe.NfeDetalheImpostoIcmsVO.ModalidadeBcIcms := 3; //valor da operação
          VendaDetalhe.NfeDetalheImpostoIcmsVO.AliquotaIcms := VendaDetalhe.ProdutoVO.AliquotaIcmsPaf;
          VendaDetalhe.NfeDetalheImpostoIcmsVO.BaseCalculoIcms := VendaDetalhe.ValorTotal;
          VendaDetalhe.NfeDetalheImpostoIcmsVO.ValorIcms := VendaDetalhe.ValorTotal * VendaDetalhe.ProdutoVO.AliquotaIcmsPaf / 100;
        end;

        SubTotal := SubTotal + VendaDetalhe.ValorTotal;
        TotalGeral := TotalGeral + VendaDetalhe.ValorTotal;
        ValorICMS := ValorICMS + VendaDetalhe.NfeDetalheImpostoIcmsVO.ValorIcms;
        AtualizaTotais;
      end;

      edtNVenda.Caption := 'VENDA nº ' + IntToStr(Sessao.VendaAtual.Id);
      edtNumeroNota.Caption := 'NFC-e nº ' + Sessao.VendaAtual.Numero;

      Bobina.ItemIndex := Bobina.Items.Count - 1;
      Sessao.StatusCaixa := scVendaEmAndamento;
    end;

  end;
end;

procedure TFCaixa.DesabilitaControlesVenda;
begin
  EditCodigo.Enabled := False;
  EditQuantidade.Enabled := False;
  EditUnitario.Enabled := False;
  EditTotalItem.Enabled := False;
  EditSubTotal.Enabled := False;
  Bobina.Enabled := False;
  panelBotoes.Enabled := False;
  FCaixa.KeyPreview := False;
end;

procedure TFCaixa.HabilitaControlesVenda;
begin
  EditCodigo.Enabled := true;
  EditQuantidade.Enabled := true;
  EditUnitario.Enabled := true;
  EditTotalItem.Enabled := true;
  EditSubTotal.Enabled := true;
  Bobina.Enabled := true;
  panelBotoes.Enabled := true;
  FCaixa.KeyPreview := true;
end;
{$EndRegion}

{$REGION 'Demais procedimentos para a NFC-e'}
procedure TFCaixa.SelecionarCertificadoDigital;
begin
  try
    ObjetoNfeConfiguracaoVO.CertificadoDigitalSerie := FDataModule.ACBrNFe.Configuracoes.Certificados.SelecionarCertificado;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro ao tentar selecionar o certificado.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFCaixa.CancelaInutiliza;
var
  NFCe: TNfeCabecalhoVO;
begin
  Application.CreateForm(TFListaNFCe, FListaNFCe);
  FListaNFCe.Operacao := 'CancelaInutiliza';
  FListaNFCe.ShowModal;

  if FListaNFCe.Confirmou then
  begin
    Filtro := 'ID = ' + FListaNFCe.QNFCe.FieldByName('ID').AsString;
    NFCe := TVendaController.ConsultaObjeto(Filtro);

    if FListaNFCe.ComboBoxProcedimento.Text = 'Cancelar NFC-e' then
    begin
      try
        if Assigned(NFCe) then
        begin
          FDataModule.ACBrNFe.EventoNFe.Evento.Clear;
          with FDataModule.ACBrNFe.EventoNFe.Evento.Add do
          begin
            infEvento.chNFe := NFCe.ChaveAcesso + NFCe.DigitoChaveAcesso;
            infEvento.CNPJ   := Sessao.Configuracao.EmpresaVO.Cnpj;
            infEvento.dhEvento := now;
            infEvento.tpEvento := teCancelamento;
            // Exercício: analise como informar a justificativa para o cancelamento da nota.
            infEvento.detEvento.xJust := 'CANCELAMENTO CANCELAMENTO CANCELAMENTO';
            infEvento.detEvento.nProt := NFCe.CompraPedido;
          end;
          FDataModule.ACBrNFe.EnviarEventoNFe(1);
          NFCe.StatusNota := 6;
          TVendaController.Altera(NFCe);
        end;
      except
        on E: Exception do
          Application.MessageBox(PChar('Ocorreu um erro ao tentar cancelar a NFC-e.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
      end;
    end
    else if FListaNFCe.ComboBoxProcedimento.Text = 'Inutilizar Número' then
    begin
      try
        if Assigned(NFCe) then
        begin
          FDataModule.ACBrNFe.WebServices.Inutiliza(
                                                    Sessao.Configuracao.EmpresaVO.Cnpj,
                                                    'INUTILIZACAO INUTILIZACAO INUTILIZACAO',
                                                    StrToInt(FormatDateTime('yyyy', NFCe.DataHoraEmissao)),
                                                    65,
                                                    StrToInt(NFCe.Serie),
                                                    StrToInt(NFCe.Numero),
                                                    StrToInt(NFCe.Numero)
                                                    );
          NFCe.StatusNota := 5;
          TVendaController.Altera(NFCe);
        end;
      except
        on E: Exception do
          Application.MessageBox(PChar('Ocorreu um erro ao tentar cancelar a NFC-e.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
      end;
    end;
  end;
end;

procedure TFCaixa.GerarXmlNfce;
var
  i, j: Integer;
  OK: Boolean;
begin
  try
    if FDataModule.ACBrNFe.Configuracoes.Certificados.NumeroSerie = '' then
    begin
      ObjetoNfeConfiguracaoVO.CertificadoDigitalSerie := FDataModule.ACBrNFe.Configuracoes.Certificados.SelecionarCertificado;
    end;

    FDataModule.ACBrNFe.NotasFiscais.Clear;
    with FDataModule.ACBrNFe.NotasFiscais.Add.NFe do
    begin
      { NFe Cabeçalho }
      Ide.cUF := Sessao.Configuracao.EmpresaVO.CodigoIbgeUf;
      Ide.cNF := StrToInt(Sessao.VendaAtual.CodigoNumerico);
      Ide.natOp := Sessao.VendaAtual.NaturezaOperacao;
      Ide.indPag := TpcnIndicadorPagamento(Sessao.VendaAtual.IndicadorFormaPagamento); // ['0', '1', '2'][ipVista, ipPrazo, ipOutras]
      Ide.Modelo := StrToInt(Sessao.VendaAtual.CodigoModelo);
      Ide.Serie := StrToInt(Sessao.VendaAtual.Serie);
      Ide.nNF := StrToInt(Sessao.VendaAtual.Numero);
      Ide.dEmi := Now;
      Ide.dSaiEnt := Now;
      Ide.hSaiEnt := Now;
      Ide.tpNF := TpcnTipoNfe(Sessao.VendaAtual.TipoOperacao); // ['0', '1'][tnEntrada, tnSaida]
      Ide.cMunFG := Sessao.VendaAtual.CodigoMunicipio;
      Ide.tpImp := tiNFCe;//TpcnTipoImpressao(Sessao.VendaAtual.FormatoImpressaoDanfe);
      Ide.tpEmis := teNormal;//TpcnTipoEmissao(Sessao.VendaAtual.TipoEmissao);
      Ide.tpAmb := taHomologacao;//TpcnTipoAmbiente(Sessao.VendaAtual.Ambiente);
      Ide.finNFe := fnNormal;//TpcnFinalidadeNfe(Sessao.VendaAtual.FinalidadeEmissao);
      Ide.indFinal := cfConsumidorFinal;
      Ide.indPres := pcPresencial;

      { NFe Cabeçalho -- Totais }
      Total.ICMSTot.vBC := Sessao.VendaAtual.BaseCalculoIcms;
      Total.ICMSTot.vICMS := Sessao.VendaAtual.ValorIcms;
      Total.ICMSTot.vBCST := Sessao.VendaAtual.BaseCalculoIcmsSt;
      Total.ICMSTot.vST := Sessao.VendaAtual.ValorIcmsSt;
      Total.ICMSTot.vProd := Sessao.VendaAtual.ValorTotalProdutos;
      Total.ICMSTot.vFrete := Sessao.VendaAtual.ValorFrete;
      Total.ICMSTot.vSeg := Sessao.VendaAtual.ValorSeguro;
      Total.ICMSTot.vDesc := Sessao.VendaAtual.ValorDesconto;
      Total.ICMSTot.vII := Sessao.VendaAtual.ValorImpostoImportacao;
      Total.ICMSTot.vIPI := Sessao.VendaAtual.ValorIpi;
      Total.ICMSTot.vPIS := Sessao.VendaAtual.ValorPis;
      Total.ICMSTot.vCOFINS := Sessao.VendaAtual.ValorCofins;
      Total.ICMSTot.vOutro := Sessao.VendaAtual.ValorDespesasAcessorias;
      Total.ICMSTot.vNF := Sessao.VendaAtual.ValorTotal;

      // lei da transparencia de impostos
      // Exercício: avalie se essa informação está sendo repassada corretamente
      Total.ICMSTot.vTotTrib := Sessao.VendaAtual.ValorIcms;

      Total.ISSQNtot.vServ := Sessao.VendaAtual.ValorServicos;
      Total.ISSQNtot.vBC := Sessao.VendaAtual.BaseCalculoIssqn;
      Total.ISSQNtot.vISS := Sessao.VendaAtual.ValorIssqn;
      Total.ISSQNtot.vPIS := Sessao.VendaAtual.ValorPisIssqn;
      Total.ISSQNtot.vCOFINS := Sessao.VendaAtual.ValorCofinsIssqn;

      Total.retTrib.vRetPIS := Sessao.VendaAtual.ValorRetidoPis;
      Total.retTrib.vRetCOFINS := Sessao.VendaAtual.ValorRetidoCofins;
      Total.retTrib.vRetCSLL := Sessao.VendaAtual.ValorRetidoCsll;
      Total.retTrib.vBCIRRF := Sessao.VendaAtual.BaseCalculoIrrf;
      Total.retTrib.vIRRF := Sessao.VendaAtual.ValorRetidoIrrf;
      Total.retTrib.vBCRetPrev := Sessao.VendaAtual.BaseCalculoPrevidencia;
      Total.retTrib.vRetPrev := Sessao.VendaAtual.ValorRetidoPrevidencia;

      { Emitente }
      Emit.CNPJCPF := Sessao.Configuracao.EmpresaVO.Cnpj;
      Emit.xNome := Sessao.Configuracao.EmpresaVO.RazaoSocial;
      Emit.xFant := Sessao.Configuracao.EmpresaVO.NomeFantasia;
      Emit.EnderEmit.xLgr := Sessao.Configuracao.EmpresaVO.EnderecoPrincipal.Logradouro;
      Emit.EnderEmit.nro := Sessao.Configuracao.EmpresaVO.EnderecoPrincipal.Numero;
      Emit.EnderEmit.xCpl := Sessao.Configuracao.EmpresaVO.EnderecoPrincipal.Complemento;
      Emit.EnderEmit.xBairro := Sessao.Configuracao.EmpresaVO.EnderecoPrincipal.Bairro;
      Emit.EnderEmit.cMun := Sessao.Configuracao.EmpresaVO.CodigoIbgeCidade;
      Emit.EnderEmit.xMun := Sessao.Configuracao.EmpresaVO.EnderecoPrincipal.Cidade;
      Emit.EnderEmit.Uf := Sessao.Configuracao.EmpresaVO.EnderecoPrincipal.Uf;
      Emit.EnderEmit.Cep := StrToInt(Sessao.Configuracao.EmpresaVO.EnderecoPrincipal.Cep);
      Emit.EnderEmit.cPais := 1058;
      Emit.EnderEmit.xPais := 'BRASIL';
      Emit.EnderEmit.Fone := Sessao.Configuracao.EmpresaVO.EnderecoPrincipal.Fone;
      Emit.Ie := Sessao.Configuracao.EmpresaVO.InscricaoEstadual;
      Emit.IM := Sessao.Configuracao.EmpresaVO.InscricaoMunicipal;
      Emit.Crt := StrToCRT(OK, Sessao.Configuracao.EmpresaVO.Crt);
      Emit.CNAE := Sessao.Configuracao.EmpresaVO.CodigoCnaePrincipal;

      { Destinatario }
      Dest.CNPJCPF := Sessao.VendaAtual.NfeDestinatarioVO.CpfCnpj;
      Dest.xNome := Sessao.VendaAtual.NfeDestinatarioVO.Nome;
      Dest.EnderDest.xLgr := Sessao.VendaAtual.NfeDestinatarioVO.Logradouro;
      Dest.EnderDest.nro := Sessao.VendaAtual.NfeDestinatarioVO.Numero;
      Dest.EnderDest.xCpl := Sessao.VendaAtual.NfeDestinatarioVO.Complemento;
      Dest.EnderDest.xBairro := Sessao.VendaAtual.NfeDestinatarioVO.Bairro;
      Dest.EnderDest.cMun := Sessao.VendaAtual.NfeDestinatarioVO.CodigoMunicipio;
      Dest.EnderDest.xMun := Sessao.VendaAtual.NfeDestinatarioVO.NomeMunicipio;
      Dest.EnderDest.Uf := Sessao.VendaAtual.NfeDestinatarioVO.Uf;
      if Sessao.VendaAtual.NfeDestinatarioVO.Cep <> '' then
        Dest.EnderDest.Cep := StrToInt(Sessao.VendaAtual.NfeDestinatarioVO.Cep);
      Dest.EnderDest.cPais := 1058;
      Dest.EnderDest.xPais := 'BRASIL';
      Dest.EnderDest.Fone := Sessao.VendaAtual.NfeDestinatarioVO.Telefone;
      Dest.Email := Sessao.VendaAtual.NfeDestinatarioVO.Email;
      Dest.indIEDest := inNaoContribuinte;

      // NFC-e não pode ter FRETE
      Transp.modFrete := mfSemFrete;

      // Exercício: pegue os pagamentos utilizados na venda e informe para a NFCe
      with pag.Add do
      begin
        tPag := fpDinheiro;
        vPag := Sessao.VendaAtual.ValorTotal;
      end;

      { NFe Detalhe }
      for i := 0 to Sessao.VendaAtual.ListaNfeDetalheVO.Count - 1 do
      begin
        with Det.Add do
        begin
          Prod.nItem := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NumeroItem;
          Prod.cProd := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).Gtin;
          Prod.cEAN := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).Gtin;
          Prod.xProd := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NomeProduto;
          Prod.Ncm := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).Ncm;
          Prod.Cfop := IntToStr(TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).Cfop);
          Prod.uCom := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).UnidadeComercial;
          Prod.qCom := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).QuantidadeComercial;
          Prod.vUnCom := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).ValorUnitarioComercial;
          Prod.vProd := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).ValorTotal;
          Prod.cEANTrib := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).GtinUnidadeTributavel;
          Prod.uTrib := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).UnidadeTributavel;
          Prod.qTrib := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).QuantidadeTributavel;
          Prod.vUnTrib := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).ValorUnitarioTributavel;
          Prod.vFrete := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).ValorFrete;
          Prod.vSeg := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).ValorSeguro;
          Prod.vDesc := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).ValorDesconto;
          Prod.vOutro := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).ValorOutrasDespesas;
          Prod.IndTot := TpcnIndicadorTotal(TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).EntraTotal); // ['0', '1'], [itNaoSomaTotalNFe, itSomaTotalNFe]
          infAdProd := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).InformacoesAdicionais; // definir se vira do cadastro de produtos ou se sera digitada, por exemplo informaçao de lotes

          { Detalhes -- Impostos }
          with Imposto do
          begin

            // lei da transparencia nos impostos
            // Exercício: avalie se essa informação está sendo repassada corretamente
            vTotTrib := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.ValorIcms;

            with ICMS do
            begin

              if Emit.Crt = crtSimplesNacional then
              begin
                Csosn := StrToCSOSNIcms(OK, TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.Csosn);

                // csosn 900
                if TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.Csosn = '900' then
                begin
                  orig := TpcnOrigemMercadoria(TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.OrigemMercadoria); // (oeNacional, oeEstrangeiraImportacaoDireta, oeEstrangeiraAdquiridaBrasil)
                  modBC := TpcnDeterminacaoBaseIcms(TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.ModalidadeBcIcms); // (dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao)
                  vBC := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.BaseCalculoIcms;
                  pRedBC := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.TaxaReducaoBcIcms;
                  pICMS := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.AliquotaIcms;
                  vICMS := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.ValorIcms;
                  modBCST := TpcnDeterminacaoBaseIcmsSt(TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.ModalidadeBcIcmsSt); // (dbisPrecoTabelado, dbisListaNegativa, dbisListaPositiva, dbisListaNeutra, dbisMargemValorAgregado, dbisPauta)
                  pMVAST := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.PercentualMvaIcmsSt;
                  pRedBCST := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.PercentualReducaoBcIcmsSt;
                  vBCST := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.ValorBaseCalculoIcmsSt;
                  pICMSST := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.AliquotaIcmsSt;
                  vICMSST := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.ValorIcmsSt;
                  pCredSN := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.AliquotaCreditoIcmsSn;
                  vCredICMSSN := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.ValorCreditoIcmsSn;
                end;
              end

              else
              begin
                CST := StrToCSTIcms(OK, TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.CstIcms);

                // 00 Tributada integralmente
                if TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.CstIcms = '00' then
                begin
                  orig := TpcnOrigemMercadoria(TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.OrigemMercadoria); // (oeNacional, oeEstrangeiraImportacaoDireta, oeEstrangeiraAdquiridaBrasil)
                  modBC := TpcnDeterminacaoBaseIcms(TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.ModalidadeBcIcms); // (dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao)
                  vBC := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.BaseCalculoIcms;
                  pICMS := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.AliquotaIcms;
                  vICMS := TNfeDetalheVO(Sessao.VendaAtual.ListaNfeDetalheVO.Items[i]).NfeDetalheImpostoIcmsVO.ValorIcms;
                end;

              end;
            end; // with ICMS do


          end; // with Imposto do
        end; // with Det.Add do
      end; // for i := 0 to ListaNFeDetalhe.Count - 1 do }
    end;

    try
      FDataModule.ACBrNFe.NotasFiscais.Assinar;
    except
      on E: Exception do
        Application.MessageBox(PChar('Ocorreu um erro ao tentar assinar a NF-e.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;

    try
      FDataModule.ACBrNFe.NotasFiscais.Items[0].SaveToFile;
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

{$Region 'Aparência e controle dos painéis com as funções do programa - F1 a F12'}
procedure TFCaixa.panelF1MouseEnter(Sender: TObject);
begin
  panelF1.BevelOuter := bvRaised;
  panelF1.BevelWidth := 2;
end;

procedure TFCaixa.panelF1MouseLeave(Sender: TObject);
begin
  panelF1.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF1Click(Sender: TObject);
begin
  IdentificaCliente;
end;

procedure TFCaixa.panelF2MouseEnter(Sender: TObject);
begin
  panelF2.BevelOuter := bvRaised;
  panelF2.BevelWidth := 2;
end;

procedure TFCaixa.panelF2MouseLeave(Sender: TObject);
begin
  panelF2.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF2Click(Sender: TObject);
begin
  AcionaMenuPrincipal;
end;

procedure TFCaixa.panelF3MouseEnter(Sender: TObject);
begin
  panelF3.BevelOuter := bvRaised;
  panelF3.BevelWidth := 2;
end;

procedure TFCaixa.panelF3MouseLeave(Sender: TObject);
begin
  panelF3.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF3Click(Sender: TObject);
begin
  AcionaMenuOperacoes;
end;

procedure TFCaixa.panelF4MouseEnter(Sender: TObject);
begin
  panelF4.BevelOuter := bvRaised;
  panelF4.BevelWidth := 2;
end;

procedure TFCaixa.panelF4MouseLeave(Sender: TObject);
begin
  panelF4.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF4Click(Sender: TObject);
begin
  CancelaInutiliza;
end;

procedure TFCaixa.panelF5MouseEnter(Sender: TObject);
begin
  panelF5.BevelOuter := bvRaised;
  panelF5.BevelWidth := 2;
end;

procedure TFCaixa.panelF5MouseLeave(Sender: TObject);
begin
  panelF5.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF5Click(Sender: TObject);
begin
  RecuperarVenda;
end;

procedure TFCaixa.panelF6MouseEnter(Sender: TObject);
begin
  panelF6.BevelOuter := bvRaised;
  panelF6.BevelWidth := 2;
end;

procedure TFCaixa.panelF6MouseLeave(Sender: TObject);
begin
  panelF6.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF6Click(Sender: TObject);
begin
  LocalizaProduto;
end;

procedure TFCaixa.panelF7MouseEnter(Sender: TObject);
begin
  panelF7.BevelOuter := bvRaised;
  panelF7.BevelWidth := 2;
end;

procedure TFCaixa.panelF7MouseLeave(Sender: TObject);
begin
  panelF7.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF7Click(Sender: TObject);
begin
  IniciaEncerramentoVenda;
end;

procedure TFCaixa.panelF8MouseEnter(Sender: TObject);
begin
  panelF8.BevelOuter := bvRaised;
  panelF8.BevelWidth := 2;
end;

procedure TFCaixa.panelF8MouseLeave(Sender: TObject);
begin
  panelF8.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF8Click(Sender: TObject);
begin
  CancelaItem;
end;

procedure TFCaixa.panelF9MouseEnter(Sender: TObject);
begin
  panelF9.BevelOuter := bvRaised;
  panelF9.BevelWidth := 2;
end;

procedure TFCaixa.panelF9MouseLeave(Sender: TObject);
begin
  panelF9.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF9Click(Sender: TObject);
begin
  CancelaVenda;
end;

procedure TFCaixa.panelF10MouseEnter(Sender: TObject);
begin
  panelF10.BevelOuter := bvRaised;
  panelF10.BevelWidth := 2;
end;

procedure TFCaixa.panelF10MouseLeave(Sender: TObject);
begin
  panelF10.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF10Click(Sender: TObject);
begin
  DescontoOuAcrescimo;
end;

procedure TFCaixa.panelF11MouseEnter(Sender: TObject);
begin
  panelF11.BevelOuter := bvRaised;
  panelF11.BevelWidth := 2;
end;

procedure TFCaixa.panelF11MouseLeave(Sender: TObject);
begin
  panelF11.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF11Click(Sender: TObject);
begin
  IdentificaVendedor;
end;

procedure TFCaixa.panelF12MouseEnter(Sender: TObject);
begin
  panelF12.BevelOuter := bvRaised;
  panelF12.BevelWidth := 2;
end;

procedure TFCaixa.panelF12MouseLeave(Sender: TObject);
begin
  panelF12.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF12Click(Sender: TObject);
begin
  Close;
end;
{$EndRegion}

{$Region 'Procedimentos para ler peso direto das balanças componente ACBrBal'}
procedure TFCaixa.ConectaComBalanca; // novo procedimento balança
begin
  // se houver conecção aberta, Fecha a conecção
  if ACBrBAL1.Ativo then
    ACBrBAL1.Desativar;

  // configura porta de comunicação
  ACBrBAL1.Modelo := TACBrBALModelo(Sessao.Configuracao.NfceConfiguracaoBalancaVO.Modelo);
  ACBrBAL1.Device.HandShake := TACBrHandShake(Sessao.Configuracao.NfceConfiguracaoBalancaVO.HandShake);
  ACBrBAL1.Device.Parity := TACBrSerialParity(Sessao.Configuracao.NfceConfiguracaoBalancaVO.Parity);
  ACBrBAL1.Device.Stop := TACBrSerialStop(Sessao.Configuracao.NfceConfiguracaoBalancaVO.StopBits);
  ACBrBAL1.Device.Data := Sessao.Configuracao.NfceConfiguracaoBalancaVO.DataBits;
  ACBrBAL1.Device.Baud := Sessao.Configuracao.NfceConfiguracaoBalancaVO.BaudRate;
  ACBrBAL1.Device.Porta := Sessao.Configuracao.NfceConfiguracaoBalancaVO.Porta;
  // Conecta com a balança
  ACBrBAL1.Ativar;
end;

procedure TFCaixa.ConectaComLeitorSerial;
begin
  // se houver conecção aberta, Fecha a conecção
  if ACBrLCB1.Ativo then
    ACBrBAL1.Desativar;

  // configura porta de comunicação
  ACBrLCB1.Porta := Sessao.Configuracao.NfceConfiguracaoLeitorSerVO.Porta;
  ACBrLCB1.Device.Baud := Sessao.Configuracao.NfceConfiguracaoLeitorSerVO.Baud;
  ACBrLCB1.Sufixo := Sessao.Configuracao.NfceConfiguracaoLeitorSerVO.Sufixo;
  ACBrLCB1.Intervalo := Sessao.Configuracao.NfceConfiguracaoLeitorSerVO.Intervalo;
  ACBrLCB1.Device.Data := Sessao.Configuracao.NfceConfiguracaoLeitorSerVO.DataBits;
  ACBrLCB1.Device.Parity := TACBrSerialParity(Sessao.Configuracao.NfceConfiguracaoLeitorSerVO.Parity);

  if Sessao.Configuracao.NfceConfiguracaoLeitorSerVO.HardFlow = 'N' then
    ACBrLCB1.Device.HardFlow := False
  else
    ACBrLCB1.Device.HardFlow := True;

  if Sessao.Configuracao.NfceConfiguracaoLeitorSerVO.SoftFlow = 'N' then
    ACBrLCB1.Device.SoftFlow := False
  else
    ACBrLCB1.Device.SoftFlow := True;

  ACBrLCB1.Device.HandShake := TACBrHandShake(Sessao.Configuracao.NfceConfiguracaoLeitorSerVO.HandShake);
  ACBrLCB1.Device.Stop := TACBrSerialStop(Sessao.Configuracao.NfceConfiguracaoLeitorSerVO.StopBits);

  if Sessao.Configuracao.NfceConfiguracaoLeitorSerVO.UsarFila = 'S' Then
    ACBrLCB1.UsarFila := True
  else
    ACBrLCB1.UsarFila := False;

  if Sessao.Configuracao.NfceConfiguracaoLeitorSerVO.ExcluirSufixo = 'S' then
    ACBrLCB1.ExcluirSufixo := True
  else
    ACBrLCB1.ExcluirSufixo := False;

  ACBrLCB1.Ativar;
end;

procedure TFCaixa.ACBrBAL1LePeso(Peso: Double; Resposta: AnsiString);
var
  valid: Integer;
begin
  EditCodigo.Text := FormatFloat('##0.000', Peso) + '*';
  if Peso > 0 then
  begin
    labelMensagens.Caption := 'Leitura da Balança OK !';
    EditQuantidade.Text := FormatFloat('##0.000', Peso);
    EditCodigo.SetFocus;
  end
  else
  begin
    valid := Trunc(ACBrBAL1.UltimoPesoLido);
    case valid of
      0:
        labelMensagens.Caption := 'Coloque o produto sobre a Balança!';
      -1:
        labelMensagens.Caption := 'Tente Nova Leitura';
      -2:
        labelMensagens.Caption := 'Peso Negativo !';
      -10:
        labelMensagens.Caption := 'Sobrepeso !';
    end;
  end;
end;
{$EndRegion}

end.
