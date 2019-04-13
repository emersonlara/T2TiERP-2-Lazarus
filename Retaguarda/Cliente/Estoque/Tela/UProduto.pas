{ *******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de Produtos

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

Albert Eije (T2Ti.COM)
@version 2.0
******************************************************************************* }

unit UProduto;

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

  TFProduto = class(TFTelaCadastro)
    ScrollBox: TScrollBox;
    BevelEdits: TBevel;
    PageControlDadosProduto: TPageControl;
    tsProdutoPrincipal: TTabSheet;
    tsDadosComplementares: TTabSheet;
    PanelDadosComplementares: TPanel;
    ImagemProduto: TImage;
    Label1: TLabel;
    ComboBoxIat: TLabeledComboBox;
    ComboBoxIppt: TLabeledComboBox;
    ComboBoxTipoItemSped: TLabeledComboBox;
    EditCodigoLst: TLabeledEdit;
    EditExTipi: TLabeledEdit;
    EditTotalizadorParcial: TLabeledEdit;
    EditCodigoBalanca: TLabeledCalcEdit;
    EditPeso: TLabeledCalcEdit;
    EditPorcentoComissao: TLabeledCalcEdit;
    EditPontoPedido: TLabeledCalcEdit;
    EditLoteEconomicoCompra: TLabeledCalcEdit;
    GroupBoxValoresPaf: TGroupBox;
    EditAliquotaIcmsPaf: TLabeledCalcEdit;
    EditAliquotaIssqnPaf: TLabeledCalcEdit;
    PanelProdutoPrincipal: TPanel;
    GroupBoxRG: TGroupBox;
    EditValorCompra: TLabeledCalcEdit;
    EditValorVenda: TLabeledCalcEdit;
    EditPrecoVendaMinimo: TLabeledCalcEdit;
    EditPrecoSugerido: TLabeledCalcEdit;
    EditCustoMedioLiquido: TLabeledCalcEdit;
    EditPrecoLucroZero: TLabeledCalcEdit;
    EditPrecoLucroMinimo: TLabeledCalcEdit;
    EditPrecoLucroMaximo: TLabeledCalcEdit;
    EditMarkup: TLabeledCalcEdit;
    EditQuantidadeEstoque: TLabeledCalcEdit;
    EditQuantidadeEstoqueAnterior: TLabeledCalcEdit;
    EditEstoqueIdeal: TLabeledCalcEdit;
    EditEstoqueMinimo: TLabeledCalcEdit;
    EditEstoqueMaximo: TLabeledCalcEdit;
    EditNome: TLabeledEdit;
    ComboBoxInativo: TLabeledComboBox;
    EditGtin: TLabeledEdit;
    EditCodigoInterno: TLabeledEdit;
    EditNcm: TLabeledEdit;
    ComboBoxClasseAbc: TLabeledComboBox;
    EditDescricaoPdv: TLabeledEdit;
    MemoDescricao: TLabeledMemo;
    PanelProdutoDadosBase: TPanel;
    EditIdSubgrupoProduto: TLabeledCalcEdit;
    EditSubGrupoProduto: TLabeledEdit;
    EditIdMarcaProduto: TLabeledCalcEdit;
    EditMarcaProduto: TLabeledEdit;
    EditUnidadeProduto: TLabeledEdit;
    EditIdUnidadeProduto: TLabeledCalcEdit;
    EditIdAlmoxarifado: TLabeledCalcEdit;
    EditAlmoxarifado: TLabeledEdit;
    EditIdTributGrupoTributario: TLabeledCalcEdit;
    EditTributGrupoTributario: TLabeledEdit;
    ComboboxIcmsCustomizado: TLabeledComboBox;
    ComboboxTipo: TLabeledComboBox;
    PopupMenu1: TPopupMenu;
    CarregarImaem1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ImagemProdutoClick(Sender: TObject);
    procedure ComboboxIcmsCustomizadoChange(Sender: TObject);
    procedure CarregarImaem1Click(Sender: TObject);
    procedure EditIdUnidadeProdutoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdSubgrupoProdutoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdMarcaProdutoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdAlmoxarifadoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdTributGrupoTributarioKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditNcmKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BotaoConsultarClick(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    UsadoPorOutroModulo: Boolean;

    procedure GridParaEdits; override;
    procedure LimparCampos; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;
    function DoCancelar: Boolean; override;

    procedure ConfigurarLayoutTela;

  end;

var
  FProduto: TFProduto;

implementation

uses Biblioteca, ProdutoVO, ProdutoController, ProdutoSubGrupoController, ProdutoSubGrupoVO,
  UnidadeProdutoVO, UnidadeProdutoController, ProdutoMarcaVO, ProdutoMarcaController,
  AlmoxarifadoVO, AlmoxarifadoController, TributGrupoTributarioVO, TributGrupoTributarioController,
  UDataModule, ULookup, NcmVO, NcmController, TributIcmsCustomCabVO, TributIcmsCustomCabController,
  UMenu;
{$R *.lfm}
{ TFProduto }

{$REGION 'Infra'}
procedure TFProduto.BotaoConsultarClick(Sender: TObject);
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
    RetornoConsulta := TProdutoController.Consulta(Filtro, IntToStr(Pagina));
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

procedure TFProduto.BotaoSalvarClick(Sender: TObject);
begin
  inherited;
  BotaoConsultarClick(Sender);
end;

procedure TFProduto.FormCreate(Sender: TObject);
begin
  UsadoPorOutroModulo := False;
  ClasseObjetoGridVO := TProdutoVO;
  ObjetoController := TProdutoController.Create;

  inherited;
end;

procedure TFProduto.ComboboxIcmsCustomizadoChange(Sender: TObject);
begin
  if ComboboxIcmsCustomizado.ItemIndex = 1 then
    EditIdTributGrupoTributario.CalcEditLabel.Caption := 'Grupo Tributário [F1]:'
  else
    EditIdTributGrupoTributario.CalcEditLabel.Caption := 'ICMS Customizado [F1]:';
end;

procedure TFProduto.ConfigurarLayoutTela;
begin
  PageControlDadosProduto.ActivePageIndex := 0;
  PanelEdits.Enabled := True;
  if StatusTela = stNavegandoEdits then
  begin
    PanelProdutoPrincipal.Enabled := False;
    PanelDadosComplementares.Enabled := False;
    PanelProdutoDadosBase.Enabled := False;
  end
  else
  begin
    PanelProdutoPrincipal.Enabled := True;
    PanelDadosComplementares.Enabled := True;
    PanelProdutoDadosBase.Enabled := True;
  end;
end;

procedure TFProduto.LimparCampos;
begin
  inherited;
  FDataModule.ImagemPadrao.GetBitmap(0, ImagemProduto.Picture.Bitmap);
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFProduto.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    if not UsadoPorOutroModulo then
      EditIdSubgrupoProduto.SetFocus;
  end;
end;

function TFProduto.DoCancelar: Boolean;
begin
  if UsadoPorOutroModulo then
    Close
  else
    Result := inherited DoCancelar;
end;

function TFProduto.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdSubgrupoProduto.SetFocus;
  end;
end;

function TFProduto.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TProdutoController.Exclui(IdRegistroSelecionado);
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

function TFProduto.DoSalvar: Boolean;
begin
  if EditIdSubgrupoProduto.AsInteger <= 0 then
  begin
    Application.MessageBox('Selecione o subgrupo do Produto.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdSubgrupoProduto.SetFocus;
    Exit(False);
  end
  else if EditIdUnidadeProduto.AsInteger <= 0 then
  begin
    Application.MessageBox('Selecione a unidade do Produto.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdUnidadeProduto.SetFocus;
    Exit(False);
  end
  else if EditGtin.Text = '' then
  begin
    Application.MessageBox('Informe o GTIN do Produto.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditGtin.SetFocus;
    Exit(False);
  end
  else if EditNome.Text = '' then
  begin
    Application.MessageBox('Informe o Nome do Produto.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditNome.SetFocus;
    Exit(False);
  end;

  Result := inherited DoSalvar;

  if Result then
  begin

    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TProdutoVO.Create;

      TProdutoVO(ObjetoVO).IdAlmoxarifado := EditIdAlmoxarifado.AsInteger;
      TProdutoVO(ObjetoVO).AlmoxarifadoNome := EditAlmoxarifado.Text;

      if ComboboxIcmsCustomizado.ItemIndex = 1 then
      begin
        TProdutoVO(ObjetoVO).IdGrupoTributario := EditIdTributGrupoTributario.AsInteger;
        TProdutoVO(ObjetoVO).TributGrupoTributarioDescricao := EditTributGrupoTributario.Text;
        TProdutoVO(ObjetoVO).IdIcmsCustomizado := 0;
      end
      else
      begin
        TProdutoVO(ObjetoVO).IdIcmsCustomizado := EditIdTributGrupoTributario.AsInteger;
        TProdutoVO(ObjetoVO).TributIcmsCustomCabDescricao := EditTributGrupoTributario.Text;
        TProdutoVO(ObjetoVO).IdGrupoTributario := 0;
      end;

      TProdutoVO(ObjetoVO).IdProdutoMarca := EditIdMarcaProduto.AsInteger;
      TProdutoVO(ObjetoVO).ProdutoMarcaNome := EditMarcaProduto.Text;
      TProdutoVO(ObjetoVO).IdSubGrupo := EditIdSubgrupoProduto.AsInteger;
      TProdutoVO(ObjetoVO).ProdutoSubgrupoNome := EditSubGrupoProduto.Text;
      TProdutoVO(ObjetoVO).IdUnidade := EditIdUnidadeProduto.AsInteger;
      TProdutoVO(ObjetoVO).UnidadeProdutoSigla := EditUnidadeProduto.Text;

      TProdutoVO(ObjetoVO).Gtin := EditGtin.Text;
      TProdutoVO(ObjetoVO).CodigoInterno := EditCodigoInterno.Text;
      TProdutoVO(ObjetoVO).Ncm := EditNcm.Text;
      TProdutoVO(ObjetoVO).Nome := EditNome.Text;
      TProdutoVO(ObjetoVO).Descricao := MemoDescricao.Text;
      TProdutoVO(ObjetoVO).DescricaoPdv := EditDescricaoPdv.Text;
      TProdutoVO(ObjetoVO).ValorCompra := EditValorCompra.Value;
      TProdutoVO(ObjetoVO).ValorVenda := EditValorVenda.Value;
      TProdutoVO(ObjetoVO).PrecoVendaMinimo := EditPrecoVendaMinimo.Value;
      TProdutoVO(ObjetoVO).PrecoSugerido := EditPrecoSugerido.Value;
      TProdutoVO(ObjetoVO).CustoMedioLiquido := EditCustoMedioLiquido.Value;
      TProdutoVO(ObjetoVO).PrecoLucroZero := EditPrecoLucroZero.Value;
      TProdutoVO(ObjetoVO).PrecoLucroMinimo := EditPrecoLucroMinimo.Value;
      TProdutoVO(ObjetoVO).PrecoLucroMaximo := EditPrecoLucroMaximo.Value;
      TProdutoVO(ObjetoVO).Markup := EditMarkup.Value;
      TProdutoVO(ObjetoVO).QuantidadeEstoque := EditQuantidadeEstoque.Value;
      TProdutoVO(ObjetoVO).QuantidadeEstoqueAnterior := EditQuantidadeEstoqueAnterior.Value;
      TProdutoVO(ObjetoVO).EstoqueMinimo := EditEstoqueMinimo.Value;
      TProdutoVO(ObjetoVO).EstoqueMaximo := EditEstoqueMaximo.Value;
      TProdutoVO(ObjetoVO).EstoqueIdeal := EditEstoqueIdeal.Value;
      TProdutoVO(ObjetoVO).Inativo := IfThen(ComboBoxInativo.ItemIndex = 0, 'S', 'N');
      TProdutoVO(ObjetoVO).ExTipi := EditExTipi.Text;
      TProdutoVO(ObjetoVO).CodigoLst := EditCodigoLst.Text;
      TProdutoVO(ObjetoVO).ClasseAbc := Copy(ComboBoxClasseAbc.Text, 1, 1);
      TProdutoVO(ObjetoVO).Iat := Copy(ComboBoxIat.Text, 1, 1);
      TProdutoVO(ObjetoVO).Ippt := Copy(ComboBoxIppt.Text, 1, 1);
      TProdutoVO(ObjetoVO).TipoItemSped := Copy(ComboBoxTipoItemSped.Text, 1, 2);
      TProdutoVO(ObjetoVO).Peso := EditPeso.Value;
      TProdutoVO(ObjetoVO).PorcentoComissao := EditPorcentoComissao.Value;
      TProdutoVO(ObjetoVO).PontoPedido := EditPontoPedido.Value;
      TProdutoVO(ObjetoVO).LoteEconomicoCompra := EditLoteEconomicoCompra.Value;
      TProdutoVO(ObjetoVO).AliquotaIcmsPaf := EditAliquotaIcmsPaf.Value;
      TProdutoVO(ObjetoVO).AliquotaIssqnPaf := EditAliquotaIssqnPaf.Value;
      TProdutoVO(ObjetoVO).TotalizadorParcial := EditTotalizadorParcial.Text;
      TProdutoVO(ObjetoVO).CodigoBalanca := EditCodigoBalanca.AsInteger;
      TProdutoVO(ObjetoVO).Tipo := Copy(ComboboxTipo.Text, 1, 1);

      if TProdutoVO(ObjetoVO).Imagem <> '' then
        TProdutoVO(ObjetoVO).FotoProduto := TProdutoVO(ObjetoVO).Gtin + TProdutoVO(ObjetoVO).TipoImagem;

      if StatusTela = stInserindo then
      begin
        TProdutoVO(ObjetoVO).DataCadastro := Date;
        TProdutoController.Insere(TProdutoVO(ObjetoVO));
      end
      else if StatusTela = stEditando then
      begin
        /// EXERCICIO: Verifique se tem como serializar as listas junto com o objeto para realizar a comparação
        //if TProdutoVO(ObjetoVO).ToJSONString <> StringObjetoOld then
        //begin
          TProdutoController.Altera(TProdutoVO(ObjetoVO));
        //TController.ExecutarMetodo('ProdutoController.TProdutoController', 'Altera', [TProdutoVO(ObjetoVO)], 'POST', 'Boolean');
        //end
        //else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;

      if UsadoPorOutroModulo then
        Close;
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFProduto.EditIdSubgrupoProdutoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if Key = VK_F1 then
  begin
    if EditIdSubgrupoProduto.Value <> 0 then
      Filtro := 'ID = ' + EditIdSubgrupoProduto.Text
    else
      Filtro := 'ID=0';

    try
      EditIdSubgrupoProduto.Clear;
      EditSubGrupoProduto.Clear;

        ProdutoSubGrupoVO := TProdutoSubGrupoController.ConsultaObjeto(Filtro);
        if Assigned(ProdutoSubGrupoVO) then
      begin
        EditIdSubgrupoProduto.Text := CDSTransiente.FieldByName('ID').AsString;
        EditSubGrupoProduto.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdSubgrupoProduto.SetFocus;
      end;
    finally
    end;
  end;
end;

procedure TFProduto.EditIdUnidadeProdutoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if Key = VK_F1 then
  begin
    if EditIdUnidadeProduto.Value <> 0 then
      Filtro := 'ID = ' + EditIdUnidadeProduto.Text
    else
      Filtro := 'ID=0';

    try
      EditIdUnidadeProduto.Clear;
      EditUnidadeProduto.Clear;

        UnidadeProdutoVO := TUnidadeProdutoController.ConsultaObjeto(Filtro);
        if Assigned(UnidadeProdutoVO) then
      begin
        EditIdUnidadeProduto.Text := CDSTransiente.FieldByName('ID').AsString;
        EditUnidadeProduto.Text := CDSTransiente.FieldByName('SIGLA').AsString;
      end
      else
      begin
        Exit;
        EditIdMarcaProduto.SetFocus;
      end;
    finally
    end;
  end;
end;

procedure TFProduto.EditIdMarcaProdutoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if Key = VK_F1 then
  begin
    if EditIdMarcaProduto.Value <> 0 then
      Filtro := 'ID = ' + EditIdMarcaProduto.Text
    else
      Filtro := 'ID=0';

    try
      EditIdMarcaProduto.Clear;
      EditMarcaProduto.Clear;

        ProdutoMarcaVO := TProdutoMarcaController.ConsultaObjeto(Filtro);
        if Assigned(ProdutoMarcaVO) then
      begin
        EditIdMarcaProduto.Text := CDSTransiente.FieldByName('ID').AsString;
        EditMarcaProduto.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdMarcaProduto.SetFocus;
      end;
    finally
    end;
  end;
end;

procedure TFProduto.EditIdAlmoxarifadoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if Key = VK_F1 then
  begin
    if EditIdAlmoxarifado.Value <> 0 then
      Filtro := 'ID = ' + EditIdAlmoxarifado.Text
    else
      Filtro := 'ID=0';

    try
      EditIdAlmoxarifado.Clear;
      EditAlmoxarifado.Clear;

        AlmoxarifadoVO := TAlmoxarifadoController.ConsultaObjeto(Filtro);
        if Assigned(AlmoxarifadoVO) then
      begin
        EditIdAlmoxarifado.Text := CDSTransiente.FieldByName('ID').AsString;
        EditAlmoxarifado.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdAlmoxarifado.SetFocus;
      end;
    finally
    end;
  end;
end;

procedure TFProduto.EditIdTributGrupoTributarioKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if Key = VK_F1 then
  begin
    if EditIdTributGrupoTributario.Value <> 0 then
      Filtro := 'ID = ' + EditIdTributGrupoTributario.Text
    else
      Filtro := 'ID=0';

    if ComboboxIcmsCustomizado.ItemIndex = 1 then
    begin

      try
        EditIdTributGrupoTributario.Clear;
        EditTributGrupoTributario.Clear;

        TributGrupoTributarioVO := TTributGrupoTributarioController.ConsultaObjeto(Filtro);
        if Assigned(TributGrupoTributarioVO) then
        begin
          EditIdTributGrupoTributario.Text := CDSTransiente.FieldByName('ID').AsString;
          EditTributGrupoTributario.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
        end
        else
        begin
          Exit;
          EditIdTributGrupoTributario.SetFocus;
        end;
      finally
      end;
    end
    else
    begin
      try
        EditIdTributGrupoTributario.Clear;
        EditTributGrupoTributario.Clear;

        TributIcmsCustomCabVO := TTributIcmsCustomCabController.ConsultaObjeto(Filtro);
        if Assigned(TributIcmsCustomCabVO) then
        begin
          EditIdTributGrupoTributario.Text := CDSTransiente.FieldByName('ID').AsString;
          EditTributGrupoTributario.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
        end
        else
        begin
          Exit;
          EditIdTributGrupoTributario.SetFocus;
        end;
      finally
      end;
    end;

  end;
end;

procedure TFProduto.EditNcmKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if Key = VK_F1 then
  begin
    if EditNcm.Text <> '' then
      Filtro := 'CODIGO = ' + QuotedStr(EditNcm.Text)
    else
      Filtro := 'CODIGO = ""';

    try
      EditNcm.Clear;

        NcmVO := TNcmController.ConsultaObjeto(Filtro);
        if Assigned(NcmVO) then
      begin
        EditNcm.Text := CDSTransiente.FieldByName('CODIGO').AsString;
      end
      else
      begin
        Exit;
        EditNcm.SetFocus;
      end;
    finally
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grids e ClientDataSets'}
procedure TFProduto.GridParaEdits;
var
  IdCabecalho: String;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    IdCabecalho := IntToStr(IdRegistroSelecionado);
    ObjetoVO := TProdutoController.ConsultaObjeto('ID=' + IdCabecalho);
  end;

  if Assigned(ObjetoVO) then
  begin
    if Assigned(TProdutoVO(ObjetoVO).AlmoxarifadoVO) then
    begin
      EditIdAlmoxarifado.AsInteger := TProdutoVO(ObjetoVO).IdAlmoxarifado;
      EditAlmoxarifado.Text := TProdutoVO(ObjetoVO).AlmoxarifadoVO.Nome;
    end;

    if TProdutoVO(ObjetoVO).IdGrupoTributario > 0 then
    begin
      EditIdTributGrupoTributario.AsInteger := TProdutoVO(ObjetoVO).IdGrupoTributario;
      EditTributGrupoTributario.Text := TProdutoVO(ObjetoVO).GrupoTributarioVO.Descricao;
    end
    else
    begin
      EditIdTributGrupoTributario.AsInteger := TProdutoVO(ObjetoVO).IdIcmsCustomizado;
      EditTributGrupoTributario.Text := TProdutoVO(ObjetoVO).TributIcmsCustomCabVO.Descricao;
    end;

    if Assigned(TProdutoVO(ObjetoVO).ProdutoMarcaVO) then
    begin
      EditIdMarcaProduto.AsInteger := TProdutoVO(ObjetoVO).IdProdutoMarca;
      EditMarcaProduto.Text := TProdutoVO(ObjetoVO).ProdutoMarcaVO.Nome;
    end;

    EditIdSubgrupoProduto.AsInteger := TProdutoVO(ObjetoVO).IdSubGrupo;
    EditSubGrupoProduto.Text := TProdutoVO(ObjetoVO).ProdutoSubGrupoVO.Nome;

    EditIdUnidadeProduto.AsInteger := TProdutoVO(ObjetoVO).IdUnidade;
    EditUnidadeProduto.Text := TProdutoVO(ObjetoVO).UnidadeProdutoVO.Sigla;

    EditGtin.Text := TProdutoVO(ObjetoVO).Gtin;
    EditCodigoInterno.Text := TProdutoVO(ObjetoVO).CodigoInterno;
    EditNcm.Text := TProdutoVO(ObjetoVO).Ncm;
    EditNome.Text := TProdutoVO(ObjetoVO).Nome;
    MemoDescricao.Text := TProdutoVO(ObjetoVO).Descricao;
    EditDescricaoPdv.Text := TProdutoVO(ObjetoVO).DescricaoPdv;
    EditValorCompra.Value := TProdutoVO(ObjetoVO).ValorCompra;
    EditValorVenda.Value := TProdutoVO(ObjetoVO).ValorVenda;
    EditPrecoVendaMinimo.Value := TProdutoVO(ObjetoVO).PrecoVendaMinimo;
    EditPrecoSugerido.Value := TProdutoVO(ObjetoVO).PrecoSugerido;
    EditCustoMedioLiquido.Value := TProdutoVO(ObjetoVO).CustoMedioLiquido;
    EditPrecoLucroZero.Value := TProdutoVO(ObjetoVO).PrecoLucroZero;
    EditPrecoLucroMinimo.Value := TProdutoVO(ObjetoVO).PrecoLucroMinimo;
    EditPrecoLucroMaximo.Value := TProdutoVO(ObjetoVO).PrecoLucroMaximo;
    EditMarkup.Value := TProdutoVO(ObjetoVO).Markup;
    EditQuantidadeEstoque.Value := TProdutoVO(ObjetoVO).QuantidadeEstoque;
    EditQuantidadeEstoqueAnterior.Value := TProdutoVO(ObjetoVO).QuantidadeEstoqueAnterior;
    EditEstoqueMinimo.Value := TProdutoVO(ObjetoVO).EstoqueMinimo;
    EditEstoqueMaximo.Value := TProdutoVO(ObjetoVO).EstoqueMaximo;
    EditEstoqueIdeal.Value := TProdutoVO(ObjetoVO).EstoqueIdeal;

    ComboBoxInativo.ItemIndex := IfThen(TProdutoVO(ObjetoVO).Inativo = 'S', 0, 1);

    EditExTipi.Text := TProdutoVO(ObjetoVO).ExTipi;
    EditCodigoLst.Text := TProdutoVO(ObjetoVO).CodigoLst;

    ComboBoxClasseAbc.ItemIndex := AnsiIndexStr(TProdutoVO(ObjetoVO).ClasseAbc, ['A', 'B', 'C']);

    ComboBoxIat.ItemIndex := IfThen(TProdutoVO(ObjetoVO).Iat = 'A', 0, 1);
    ComboBoxIppt.ItemIndex := IfThen(TProdutoVO(ObjetoVO).Ippt = 'P', 0, 1);
    if TProdutoVO(ObjetoVO).TipoItemSped <> '' then
      ComboBoxTipoItemSped.ItemIndex := IfThen(TProdutoVO(ObjetoVO).TipoItemSped = '99', 11, StrToInt(TProdutoVO(ObjetoVO).TipoItemSped));

    EditPeso.Value := TProdutoVO(ObjetoVO).Peso;
    EditPorcentoComissao.Value := TProdutoVO(ObjetoVO).PorcentoComissao;
    EditPontoPedido.Value := TProdutoVO(ObjetoVO).PontoPedido;
    EditLoteEconomicoCompra.Value := TProdutoVO(ObjetoVO).LoteEconomicoCompra;
    EditAliquotaIcmsPaf.Value := TProdutoVO(ObjetoVO).AliquotaIcmsPaf;
    EditAliquotaIssqnPaf.Value := TProdutoVO(ObjetoVO).AliquotaIssqnPaf;
    EditTotalizadorParcial.Text := TProdutoVO(ObjetoVO).TotalizadorParcial;
    EditCodigoBalanca.AsInteger := TProdutoVO(ObjetoVO).CodigoBalanca;
    ComboBoxTipo.ItemIndex := AnsiIndexStr(TProdutoVO(ObjetoVO).Tipo, ['V', 'C', 'P', 'I', 'U']);

    // Serializa o objeto para consultar posteriormente se houve alterações
    FormatSettings.DecimalSeparator := '.';
    StringObjetoOld := ObjetoVO.ToJSONString;
    FormatSettings.DecimalSeparator := ',';
  end;
  ConfigurarLayoutTela;
end;
{$ENDREGION}

{$REGION 'Controle de Imagens'}
procedure TFProduto.ImagemProdutoClick(Sender: TObject);
begin
  if StatusTela = stNavegandoEdits then
    Application.MessageBox('Não é permitido selecionar nova imagem em modo de consulta.', 'Informação do sistema.', MB_OK + MB_ICONINFORMATION)
  else
  begin
    if FDataModule.OpenDialog.Execute then
    begin
      try
        try
          TProdutoVO(ObjetoVO).FotoProduto := FDataModule.OpenDialog.FileName;
        except
          Application.MessageBox('Arquivo de imagem com formato inválido.', 'Erro do sistema.', MB_OK + MB_ICONERROR);
        end;
      finally
      end;
    end;
  end;
end;

procedure TFProduto.CarregarImaem1Click(Sender: TObject);
begin
  if TProdutoVO(ObjetoVO).FotoProduto <> '' then
    ImagemProduto.Picture.LoadFromFile(TProdutoVO(ObjetoVO).FotoProduto);
end;
{$ENDREGION}

end.

/// EXERCICIO
///  Adapte essa janela para receber os dados do requisito 010
///  Controle Grade / SKU
///  Controle por grade de cor, tamanho, marca, sabor com código identificador gerado (SKU).
///

