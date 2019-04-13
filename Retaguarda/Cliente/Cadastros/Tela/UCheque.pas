{ *******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de Cheque

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
unit UCheque;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ChequeVO,
  ChequeController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  MaskEdit, JvExMask, JvBaseEdits, Math, StrUtils, Controller;

type

  { TFCheque }

  TFCheque = class(TFTelaCadastro)
    BevelEdits: TBevel;
    BotaoExportar: TSpeedButton;
    BotaoImprimir: TSpeedButton;
    BotaoSair: TSpeedButton;
    BotaoSeparador1: TSpeedButton;
    EditTalonarioCheque: TLabeledEdit;
    EditDataStatus: TLabeledDateEdit;
    EditIdTalonarioCheque: TLabeledCalcEdit;
    EditNumero: TLabeledCalcEdit;
    ComboboxStatusCheque: TLabeledComboBox;
    Grid: TJvDBUltimGrid;
    PageControl: TPageControl;
    PaginaGrid: TTabSheet;
    PanelFiltroRapido: TPanel;
    PanelGrid: TPanel;
    PanelToolBar: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure EditIdTalonarioChequeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);

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
  FCheque: TFCheque;

implementation

uses ULookup, Biblioteca, UDataModule, TalonarioChequeVO, TalonarioChequeController;
{$R *.lfm}

{$REGION 'Infra'}
procedure TFCheque.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TChequeVO;
  ObjetoController := TChequeController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFCheque.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdTalonarioCheque.SetFocus;
  end;
end;

function TFCheque.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdTalonarioCheque.SetFocus;
  end;
end;

function TFCheque.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      TController.ExecutarMetodo('ChequeController.TChequeController', 'Exclui', [IdRegistroSelecionado], 'DELETE', 'Boolean');
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
    TController.ExecutarMetodo('ChequeController.TChequeController', 'Consulta', [Trim(Filtro), Pagina.ToString, False], 'GET', 'Lista');
end;

function TFCheque.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TChequeVO.Create;

      TChequeVO(ObjetoVO).IdTalonarioCheque := EditIdTalonarioCheque.AsInteger;
      TChequeVO(ObjetoVO).Numero := EditNumero.AsInteger;
      TChequeVO(ObjetoVO).StatusCheque := Copy(ComboboxStatusCheque.Text, 1, 1);
      TChequeVO(ObjetoVO).DataStatus := EditDataStatus.Date;

      if StatusTela = stInserindo then
      begin
        TController.ExecutarMetodo('ChequeController.TChequeController', 'Insere', [TChequeVO(ObjetoVO)], 'PUT', 'Lista');
      end
      else if StatusTela = stEditando then
      begin
        if TChequeVO(ObjetoVO).ToJSONString <> StringObjetoOld then
        begin
          TController.ExecutarMetodo('ChequeController.TChequeController', 'Altera', [TChequeVO(ObjetoVO)], 'POST', 'Boolean');
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
procedure TFCheque.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := TChequeVO(TController.BuscarObjeto('ChequeController.TChequeController', 'ConsultaObjeto', ['ID=' + IdRegistroSelecionado.ToString], 'GET'));
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdTalonarioCheque.AsInteger := TChequeVO(ObjetoVO).IdTalonarioCheque;
    EditTalonarioCheque.Text := TChequeVO(ObjetoVO).TalonarioChequeTalao;
    EditNumero.AsInteger := TChequeVO(ObjetoVO).Numero;
    ComboboxStatusCheque.ItemIndex := AnsiIndexStr(TChequeVO(ObjetoVO).StatusCheque, ['E', 'B', 'U', 'C', 'N']);
    EditDataStatus.Date := TChequeVO(ObjetoVO).DataStatus;

    // Serializa o objeto para consultar posteriormente se houve alterações
    FormatSettings.DecimalSeparator := '.';
    StringObjetoOld := ObjetoVO.ToJSONString;
    FormatSettings.DecimalSeparator := ',';
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFCheque.EditIdTalonarioChequeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if Key = VK_F1 then
  begin
    if EditIdTalonarioCheque.Value <> 0 then
      Filtro := 'ID = ' + EditIdTalonarioCheque.Text
    else
      Filtro := 'ID=0';

    try
      EditIdTalonarioCheque.Clear;
      EditTalonarioCheque.Clear;
      if not PopulaCamposTransientes(Filtro, TTalonarioChequeVO, TTalonarioChequeController) then
        PopulaCamposTransientesLookup(TTalonarioChequeVO, TTalonarioChequeController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdTalonarioCheque.Text := CDSTransiente.FieldByName('ID').AsString;
        EditTalonarioCheque.Text := CDSTransiente.FieldByName('TALAO').AsString;
      end
      else
      begin
        Exit;
        EditIdTalonarioCheque.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end;
end;
{$ENDREGION}

end.
