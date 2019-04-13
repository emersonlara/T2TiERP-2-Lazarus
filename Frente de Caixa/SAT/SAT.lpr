program SAT;

{$mode objfpc}{$H+}

uses
  Forms,
  LCLIntf, LCLType, LMessages,
  Dialogs, Interfaces,

  DAVDetalheVO in 'VO\DAVDetalheVO.pas',
  ProdutoController in 'Controller\ProdutoController.pas',
  VendaController in 'Controller\VendaController.pas',
  UCaixa in 'Tela\UCaixa.pas' {FCaixa},
  UDescontoAcrescimo in 'Tela\UDescontoAcrescimo.pas' {FDescontoAcrescimo},
  UEfetuaPagamento in 'Tela\UEfetuaPagamento.pas' {FEfetuaPagamento},
  UIdentificaCliente in 'Tela\UIdentificaCliente.pas' {FIdentificaCliente},
  UImportaCliente in 'Tela\UImportaCliente.pas' {FImportaCliente},
  UImportaNumero in 'Tela\UImportaNumero.pas' {FImportaNumero},
  UIniciaMovimento in 'Tela\UIniciaMovimento.pas' {FIniciaMovimento},
  UMovimentoAberto in 'Tela\UMovimentoAberto.pas' {FMovimentoAberto},
  UValorReal in 'Tela\UValorReal.pas' {FValorReal},
  UImportaProduto in 'Tela\UImportaProduto.pas' {FImportaProduto},
  Biblioteca in 'Util\Biblioteca.pas',
  DAVController in 'Controller\DAVController.pas',
  ULoginGerenteSupervisor in 'Tela\ULoginGerenteSupervisor.pas' {FLoginGerenteSupervisor},
  Constantes in 'Util\Constantes.pas',
  UFechaEfetuaPagamento in 'Tela\UFechaEfetuaPagamento.pas' {FFechaEfetuaPagamento},
  UParcelamento in 'Tela\UParcelamento.pas' {FParcelamento},
  UEncerraMovimento in 'Tela\UEncerraMovimento.pas' {FEncerraMovimento},
  DavCabecalhoVO in 'VO\DavCabecalhoVO.pas',
  UnidadeProdutoVO in 'VO\UnidadeProdutoVO.pas',
  VO in 'VO\VO.pas',
  UBase in 'Tela\UBase.pas' {FBase},
  SessaoUsuario in 'Util\SessaoUsuario.pas',
  Controller in 'Controller\Controller.pas',
  T2TiORM in 'Util\T2TiORM.pas',
  Tipos in 'Util\Tipos.pas',
  NFCeCaixaVO in 'VO\NFCeCaixaVO.pas',
  EmpresaVO in 'VO\EmpresaVO.pas',
  NFCeTurnoVO in 'VO\NFCeTurnoVO.pas',
  NFCeTurnoController in 'Controller\NFCeTurnoController.pas',
  NFCeOperadorController in 'Controller\NFCeOperadorController.pas',
  NFCeOperadorVO in 'VO\NFCeOperadorVO.pas',
  NFCeFechamentoVO in 'VO\NFCeFechamentoVO.pas',
  NFCeFechamentoController in 'Controller\NFCeFechamentoController.pas',
  NFCeSangriaVO in 'VO\NFCeSangriaVO.pas',
  NFCeSuprimentoVO in 'VO\NFCeSuprimentoVO.pas',
  NFCeSuprimentoController in 'Controller\NFCeSuprimentoController.pas',
  NFCeSangriaController in 'Controller\NFCeSangriaController.pas',
  NFCeMovimentoVO in 'VO\NFCeMovimentoVO.pas',
  NFCeMovimentoController in 'Controller\NFCeMovimentoController.pas',
  ViewNFCeClienteVO in 'VO\ViewNFCeClienteVO.pas',
  ViewNFCeClienteController in 'Controller\ViewNFCeClienteController.pas',
  NFCePosicaoComponentesVO in 'VO\NFCePosicaoComponentesVO.pas',
  NFCeResolucaoVO in 'VO\NFCeResolucaoVO.pas',
  NFCeConfiguracaoBalancaVO in 'VO\NFCeConfiguracaoBalancaVO.pas',
  NFCeConfiguracaoLeitorSerVO in 'VO\NFCeConfiguracaoLeitorSerVO.pas',
  NFCeConfiguracaoController in 'Controller\NFCeConfiguracaoController.pas',
  NFCeConfiguracaoVO in 'VO\NFCeConfiguracaoVO.pas',
  ProdutoVO in 'VO\ProdutoVO.pas',
  NFCeTipoPagamentoVO in 'VO\NFCeTipoPagamentoVO.pas',
  NFCeTipoPagamentoController in 'Controller\NFCeTipoPagamentoController.pas',
  VendedorVO in 'VO\VendedorVO.pas',
  VendedorController in 'Controller\VendedorController.pas',
  NfeCabecalhoVO in 'VO\NfeCabecalhoVO.pas',
  NfeConfiguracaoVO in 'VO\NfeConfiguracaoVO.pas',
  NfeDestinatarioVO in 'VO\NfeDestinatarioVO.pas',
  NfeDetalheImpostoIcmsVO in 'VO\NfeDetalheImpostoIcmsVO.pas',
  NfeDetalheVO in 'VO\NfeDetalheVO.pas',
  NfeFormaPagamentoVO in 'VO\NfeFormaPagamentoVO.pas',
  NfeNumeroVO in 'VO\NfeNumeroVO.pas',
  FiscalNotaFiscalEntradaVO in 'VO\FiscalNotaFiscalEntradaVO.pas',
  TributOperacaoFiscalVO in 'VO\TributOperacaoFiscalVO.pas',
  CfopVO in 'VO\CfopVO.pas',
  NfeConfiguracaoController in 'Controller\NfeConfiguracaoController.pas',
  UDataModule in 'DataModule\UDataModule.pas' {FDataModule: TDataModule},
  NfeNumeroController in 'Controller\NfeNumeroController.pas',
  NfeFormaPagamentoController in 'Controller\NfeFormaPagamentoController.pas',
  ProdutoLoteVO in 'VO\ProdutoLoteVO.pas',
  ControleEstoqueController in 'Controller\ControleEstoqueController.pas',
  EmpresaEnderecoVO in 'VO\EmpresaEnderecoVO.pas',
  UListaVendas in 'Tela\UListaVendas.pas' {FListaVendas},
  FinParcelaReceberVO in 'VO\FinParcelaReceberVO.pas',
  FinLancamentoReceberVO in 'VO\FinLancamentoReceberVO.pas',
  FinLancamentoReceberController in 'Controller\FinLancamentoReceberController.pas';

begin
  Application.Initialize;
  Application.Title := 'SAT';
  Application.CreateForm(TFCaixa, FCaixa);
  Application.CreateForm(TFDataModule, FDataModule);
  Application.Run;
end.

