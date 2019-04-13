{ *******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de OperadoraPlanoSaude

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
  ******************************************************************************* }
unit UOperadoraPlanoSaude;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, OperadoraPlanoSaudeVO,
  OperadoraPlanoSaudeController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  MaskEdit, JvExMask, JvBaseEdits, Controller;

type

  { TFOperadoraPlanoSaude }

  TFOperadoraPlanoSaude = class(TFTelaCadastro)
    BevelEdits: TBevel;
    BotaoExportar: TSpeedButton;
    BotaoImprimir: TSpeedButton;
    BotaoSair: TSpeedButton;
    BotaoSeparador1: TSpeedButton;
    EditRegistroAns: TLabeledEdit;
    EditNome: TLabeledEdit;
    EditClassificacaoContabilConta: TLabeledEdit;
    Grid: TJvDBUltimGrid;
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

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

  end;

var
  FOperadoraPlanoSaude: TFOperadoraPlanoSaude;

implementation

uses ULookup, Biblioteca, UDataModule, PessoaVO, PessoaController, ContabilContaVO, ContabilContaController;
{$R *.lfm}

{$REGION 'Infra'}
procedure TFOperadoraPlanoSaude.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TOperadoraPlanoSaudeVO;
  ObjetoController := TOperadoraPlanoSaudeController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFOperadoraPlanoSaude.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditRegistroAns.SetFocus;
  end;
end;

function TFOperadoraPlanoSaude.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditRegistroAns.SetFocus;
  end;
end;

function TFOperadoraPlanoSaude.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      TController.ExecutarMetodo('OperadoraPlanoSaudeController.TOperadoraPlanoSaudeController', 'Exclui', [IdRegistroSelecionado], 'DELETE', 'Boolean');
      Result := TController.RetornoBoolean;
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TController.ExecutarMetodo('OperadoraPlanoSaudeController.TOperadoraPlanoSaudeController', 'Consulta', [Trim(Filtro), Pagina.ToString, False], 'GET', 'Lista');
end;

function TFOperadoraPlanoSaude.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TOperadoraPlanoSaudeVO.Create;

      TOperadoraPlanoSaudeVO(ObjetoVO).ClassificacaoContabilConta := EditClassificacaoContabilConta.Text;
      TOperadoraPlanoSaudeVO(ObjetoVO).RegistroAns := EditRegistroAns.Text;
      TOperadoraPlanoSaudeVO(ObjetoVO).Nome := EditNome.Text;

      if StatusTela = stInserindo then
      begin
        TController.ExecutarMetodo('OperadoraPlanoSaudeController.TOperadoraPlanoSaudeController', 'Insere', [TOperadoraPlanoSaudeController(ObjetoVO)], 'PUT', 'Lista');
      end
      else if StatusTela = stEditando then
      begin
        if TOperadoraPlanoSaudeVO(ObjetoVO).ToJSONString <> StringObjetoOld then
        begin
          TController.ExecutarMetodo('OperadoraPlanoSaudeController.TOperadoraPlanoSaudeController', 'Altera', [TOperadoraPlanoSaudeController(ObjetoVO)], 'POST', 'Boolean');
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFOperadoraPlanoSaude.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := TOperadoraPlanoSaudeVO(TController.BuscarObjeto('OperadoraPlanoSaudeController.TOperadoraPlanoSaudeController', 'ConsultaObjeto', ['ID=' + IdRegistroSelecionado.ToString], 'GET'));
  end;

  if Assigned(ObjetoVO) then
  begin
    EditClassificacaoContabilConta.Text := TOperadoraPlanoSaudeVO(ObjetoVO).ClassificacaoContabilConta;
    EditRegistroAns.Text := TOperadoraPlanoSaudeVO(ObjetoVO).RegistroAns;
    EditNome.Text := TOperadoraPlanoSaudeVO(ObjetoVO).Nome;


    // Serializa o objeto para consultar posteriormente se houve alterações
    FormatSettings.DecimalSeparator := '.';
    StringObjetoOld := ObjetoVO.ToJSONString;
    FormatSettings.DecimalSeparator := ',';
  end;
end;
{$ENDREGION}

end.
