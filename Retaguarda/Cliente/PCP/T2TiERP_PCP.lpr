program T2TiERP_PCP;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, rxnew, printer4lazarus, zcore, EmpresaVO, UsuarioVO, VO, ProdutoVO,
  ContadorVO, EstadoCivilVO, PessoaTelefoneVO, PessoaJuridicaVO, PessoaFisicaVO,
  PessoaEnderecoVO, PessoaContatoVO, PessoaVO, SituacaoForCliVO,
  AtividadeForCliVO, TipoAdmissaoVO, TipoRelacionamentoVO, TipoColaboradorVO,
  SituacaoColaboradorVO, TipoDesligamentoVO, PaisVO, AlmoxarifadoVO, SetorVO,
  UfVO, BancoVO, CfopVO, NfeDestinatarioVO, Biblioteca, Constantes, T2TiORM,
  UDataModule, Tipos, SessaoUsuario, EstadoCivilController, Controller,
  EmpresaController, UBase, UTela, UFiltro, UTelaCadastro, ULookup, ULogin,
  umenu, UPcpInstrucao, UProdutoGrupo, UProdutoSubGrupo,
  UUnidadeProduto, UPcpOp;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TFMenu, FMenu);
  Application.CreateForm(TFDataModule, FDataModule);
  Application.Run;
end.

