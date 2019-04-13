{*******************************************************************************
Title: T2Ti ERP
Description: Gerador

The MIT License

Copyright: Copyright (C) 2014 T2Ti.COM

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

@author Albert Eije (T2Ti.COM)
@version 1.1
Ultima modifica��o: 06/04/2012 Fernando L�cio Oliveira.
*******************************************************************************}

unit DelphiReverse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WideStrings, Buttons, StdCtrls, DB, SqlExpr, ExtCtrls,
  ComCtrls, FMTBcd, MidasLib, DBClient, Menus, DBCtrls, DBXMsSQL, DBXInterbase,
  DBXOracle, DBXFirebird, DBXMySql, FileCtrl, JvExStdCtrls, JvListBox,
  JvDriveCtrls, JvCombobox, Mask, JvExMask, JvToolEdit, JvComponentBase,
  JvEnterTab, IniFiles, IWSystem, StrUtils;

type
  TFGera = class(TForm)
    Panel1: TPanel;
    memo: TMemo;
    Panel2: TPanel;
    botaoGerar: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    editHost: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    editSenha: TEdit;
    editUsuario: TEdit;
    Panel3: TPanel;
    listaCampo: TListBox;
    listaTabelas: TListBox;
    StatusBar1: TStatusBar;
    Entidade: TSQLDataSet;
    comboConexao: TComboBox;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    DataSetEntidade: TClientDataSet;
    DataSetEntidadecampo: TStringField;
    DataSetEntidadeimplamentacao: TStringField;
    DataSource1: TDataSource;
    INTERBASE: TSQLConnection;
    Oracle: TSQLConnection;
    SQL: TSQLConnection;
    CONN: TSQLConnection;
    MySQL: TSQLConnection;
    Label5: TLabel;
    botaoSair: TButton;
    botaoLimparMemo: TButton;
    Label6: TLabel;
    OpenDialog1: TOpenDialog;
    FindDialog1: TFindDialog;
    editDiretorioVO: TJvDirectoryEdit;
    JvEnterAsTab1: TJvEnterAsTab;
    BotaoGerarTodos: TButton;
    cbxOpcao: TComboBox;
    EditAutor: TLabeledEdit;
    EditEmailAutor: TLabeledEdit;
    Label7: TLabel;
    editBancoDados: TJvFilenameEdit;
    botaoConectar: TBitBtn;
    Label2: TLabel;
    Label8: TLabel;
    editDiretorioControllerCliente: TJvDirectoryEdit;
    editDiretorioControllerServidor: TJvDirectoryEdit;
    BotaoGerarConjunto: TButton;
    Panel4: TPanel;
    EditBusca: TLabeledEdit;
    Button1: TButton;
    ListVOs: TFileListBox;
    MemoCopiaVO: TMemo;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Label9: TLabel;
    procedure botaoConectarClick(Sender: TObject);
    procedure listaTabelasClick(Sender: TObject);
    procedure botaoGerarClick(Sender: TObject);
    procedure botaoSairClick(Sender: TObject);
    procedure botaoLimparMemoClick(Sender: TObject);
    procedure BotaoGerarTodosClick(Sender: TObject);
    procedure cbxOpcaoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BotaoGerarConjuntoClick(Sender: TObject);
    procedure EditBuscaChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);


  private
    ListaCampos: TStringList;
    ListaPropriedades: TStringList;
    ListaPropriedadesXML: TStringList;
    ListaSets: TStringList;
    ListaProcedureSet: TStringList;

    function TrataNomeTabela: String;
    function NomeTabelaMaiusculo: String;
    function NomeTabelaMinusculo: String;
    function TrataNomeProperty(NomeCampo: String): String;
    function TrataNomeDisplay(NomeCampo: String): String;

    function GetUserFromWindows: String;

    procedure AdicionaLicenca;
    procedure GetPropriedades;
    procedure GetPropriedadesXML;
    procedure GetPropriedadesController;
    procedure CriarClasseVO;
    procedure CriarXML;
    procedure ConfigurePropertyListVO(Classe, Campo, Tamanho, Tipo, GetSet: String);
    procedure ConfigurePropertyListController(Classe, Campo, Tipo, GetSet: String);
    procedure Conectar(Driver: String; Conn: TSQLConnection; Server, Database, User, Pass: String);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FGera: TFGera;
  NomeClasse: String;
  TabelaVO, NomeTabela: String;
  Diretorio : TJvDirectoryEdit;

implementation

{$R *.dfm}

procedure TFGera.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(gsAppPath+'DelphiReverse.ini');
  try
    with Ini do
    begin
      WriteString('Autor','Autor',EditAutor.Text);
      WriteString('Autor','Email',EditEmailAutor.Text);
      WriteString('Banco','Banco',EditBancoDados.Text);
      WriteString('VO', 'VO',EditDiretorioVO.Text);
      WriteString('ControllerCliente','ControllerCliente',EditDiretorioControllerCliente.Text);
      WriteString('ControllerServidor','ControllerServidor',EditDiretorioControllerServidor.Text);
    end;
  finally
    Ini.Free;
  end;
end;

procedure TFGera.FormCreate(Sender: TObject);
begin
  cbxOpcaoChange(self);
  BotaoGerar.Enabled := False;
  BotaoGerarTodos.Enabled := False;
  BotaoGerarConjunto.Enabled := False;

end;

procedure TFGera.FormShow(Sender: TObject);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(gsAppPath+'DelphiReverse.ini');
  try
    with Ini do
    begin
      if not SectionExists('Autor') then
      begin
        WriteString('Autor','Autor',GetUserFromWindows);
        WriteString('Autor','Email','seuemail@email.com');
        WriteString('Banco','Banco','caminho do banco');
        WriteString('VO', 'VO','Caminho do VO');
        WriteString('ControllerCliente','ControllerCliente','Caminho Controller Cliente');
        WriteString('ControllerServidor','ControllerServidor','Caminho Controller Servidor');
      end;

      EditAutor.Text := ReadString('Autor','Autor','');
      EditEmailAutor.Text := ReadString('Autor','Email','');
      EditBancoDados.Text := ReadString('Banco','Banco','');
      EditDiretorioVO.Text := ReadString('VO','VO','');
      EditDiretorioControllerCliente.Text := ReadString('ControllerCliente','ControllerCliente','');
      EditDiretorioControllerServidor.Text := ReadString('ControllerServidor','ControllerServidor','');
    end;
  finally
    Ini.Free;
  end;
end;

procedure TFGera.Conectar(Driver: String; Conn: TSQLConnection; Server, Database, User, Pass: String);
begin
  Conn.Connected := false;
  if (Driver = 'MSSQL') then
  begin
    Conn.Params.Values['HostName'] := Server;
    Conn.Params.Values['DataBase'] := Database;
  end
  else if (Driver = 'INTERBASE') then
    Conn.Params.Values['DataBase'] := Server + ':' + Database
  else if (Driver = 'FIREBIRD') then
    Conn.Params.Values['DataBase'] := Server + ':' + Database
  else if (Driver = 'Oracle') then
    Conn.Params.Values['DataBase'] := Database
  else if (Driver = 'MySQL') then
  begin
    Conn.Params.Values['HostName'] := Server;
    Conn.Params.Values['DataBase'] := Database;
  end;
  Conn.Params.Values['User_Name'] := User;
  Conn.Params.Values['Password'] := Pass;
  Conn.Connected := True;
  Entidade.SQLConnection := CONN;
end;

procedure TFGera.botaoConectarClick(Sender: TObject);
var
  List: TStringList;
begin
  if comboConexao.text = 'MSSQL' then
    Conectar(comboConexao.text,SQL, editHost.text,EditBancoDados.Text,editUsuario.text, editSenha.text)
  else if comboConexao.text = 'FIREBIRD' then
    Conectar(comboConexao.text, INTERBASE, edithost.text,EditBancoDados.Text,editUsuario.text, editSenha.text)
  else if comboConexao.text = 'INTERBASE' then
    Conectar(comboConexao.text, INTERBASE, edithost.text,EditBancoDados.Text,editUsuario.text, editSenha.text)
  else if comboConexao.text = 'Oracle' then
     Conectar(comboConexao.text, Oracle , edithost.text,EditBancoDados.Text,editUsuario.text, editSenha.text)
  else if comboConexao.text = 'MySQL' then
     Conectar(comboConexao.text, MySQL , edithost.text,EditBancoDados.Text,editUsuario.text, editSenha.text);

  List := TStringList.Create;
  Entidade.SQLConnection.GetTableNames(List, false);
  if listaTabelas.itemindex > -1 then
     if listaTabelas.Items.Strings[listaTabelas.itemindex] <> '' then
      Entidade.SQLConnection.GetFieldNames(listaTabelas.Items.Strings[listaTabelas.itemindex],listaCampo.Items);

  listaTabelas.Items.Assign(List);
  if List.Count>0 then
    BotaoGerarTodos.Enabled := True;

  EditBusca.SetFocus;
  List.Free;
end;

procedure TFGera.listaTabelasClick(Sender: TObject);
begin
  Entidade.SQLConnection.GetFieldNames(listaTabelas.Items.Strings[listaTabelas.itemindex],listaCampo.Items);
  if ListaCampo.Count > 0 then
  BotaoGerar.Enabled := True;
  BotaoGerarConjunto.Enabled := BotaoGerar.Enabled;
end;

procedure TFGera.botaoGerarClick(Sender: TObject);
begin
  memo.Clear;
  if listaTabelas.itemindex > -1 then
  begin
     try
       Entidade.Active := false;
       Entidade.CommandText:= 'Select * From '+ listaTabelas.Items.Strings[listaTabelas.itemindex] +' where 0=1';
       Entidade.Active := true;

       NomeTabela := TrataNomeTabela;
       TabelaVO   := NomeTabela + 'VO';
       NomeClasse := NomeTabela + 'Controller';
       case (cbxOpcao.ItemIndex) of
          0:
          begin
            NomeClasse := TabelaVO;
            GetPropriedades;
            CriarClasseVO;
            Diretorio := EditDiretorioVO;
            memo.Lines.SaveToFile(Diretorio.Directory + '\' + NomeClasse+'.pas');
          end;
          1:
          begin
            NomeClasse := TabelaVO;
            GetPropriedadesXML;
            CriarXML;
            Diretorio := EditDiretorioVO;
            memo.Lines.SaveToFile(Diretorio.Directory + '\' + NomeClasse+'.xml');
          end;
       end;
     finally
       if (cbxOpcao.ItemIndex  = 0) or (cbxOpcao.ItemIndex  = 2) then
       begin
         ListaPropriedades.free;
         ListaCampos.free;
         ListaSets.free;
         ListaProcedureSet.free;
       end;
     end;
  end;
end;

procedure TFGera.botaoLimparMemoClick(Sender: TObject);
begin
  memo.Clear;
end;

procedure TFGera.botaoSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFGera.cbxOpcaoChange(Sender: TObject);
begin
   case (cbxOpcao.ItemIndex) of
     0:  botaoGerar.Caption :=  'Gerar VO';
     1:  botaoGerar.Caption :=  'Gerar XML';
   end
end;

procedure TFGera.BotaoGerarConjuntoClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to 3  do
  begin
    case I of
     1 :
      begin
         Diretorio := EditDiretorioVO;
         cbxOpcao.ItemIndex := 0;
      end;

     2 :
      begin
        Diretorio := EditDiretorioVO;
        cbxOpcao.ItemIndex := 1;
      end;

    end;
    botaoGerar.Click;
    Application.ProcessMessages;
  end;
  Memo.Clear;
  memo.Lines.Add('');
  memo.Lines.Add('VO Gerado no Diret�rio :');
  memo.Lines.Add(' '+EditDiretorioVO.Text);
  memo.Lines.Add('*************************************************');
  memo.Lines.Add('XML Gerado no Diret�rio :');
  memo.Lines.Add(' '+ EditDiretorioVO.Text);
  memo.Lines.Add('*************************************************');
end;

procedure TFGera.BotaoGerarTodosClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to listaTabelas.Count - 1 do
  begin
    listaTabelas.ItemIndex := I;
    BotaoGerarTodos.Caption := listaTabelas.Items.Strings[listaTabelas.itemindex];
    botaoGerar.Click;
    Application.ProcessMessages;
  end;
  BotaoGerarTodos.Caption := 'Gerar Todos';
end;

procedure TFGera.GetPropriedades;
var
  I: Integer;
  GetSet, Campo, Classe, Tamanho: String;
begin
  ListaCampos := TStringList.Create;
  ListaPropriedades := TStringList.Create;
  ListaSets := TStringList.Create;
  ListaProcedureSet := TStringList.Create;
  for I := 0 to Entidade.FieldList.Count - 1 do
  begin
    GetSet := ' read F' + Entidade.FieldList.Fields[I].FieldName + ' write F' + Entidade.FieldList.Fields[I].FieldName + ';';
    Campo := Entidade.FieldList.Fields[I].FieldName;

    // Calcular tamanho do campo (tam.campo * 8)
    Tamanho := IntToStr((Entidade.FieldList.Fields[I].DisplayWidth * 8));

    // o tamanho passar de 450 ent�o vamos deixar 450px
    if (StrToInt(Tamanho) > 450) then
      Tamanho := '450';

    // se o campo for do tipo memo fixamos em 450px
    if Entidade.FieldByName(Campo).DataType in [ftMemo] then
      Tamanho := '450';

    Classe := 'T' + listaTabelas.Items.Strings[listaTabelas.itemindex];

    if Entidade.FieldByName(Campo).DataType in [ftString, ftMemo] then
    begin
      if cbxOpcao.ItemIndex = 0 then
        ConfigurePropertyListVO(Classe, Campo, Tamanho, 'String', GetSet)
      else
        ConfigurePropertyListController(Classe, Campo, 'String', GetSet);
    end
    else if Entidade.FieldByName(Campo).DataType = ftBoolean then
    begin
      if cbxOpcao.ItemIndex = 0 then
        ConfigurePropertyListVO(Classe, Campo, Tamanho, 'Boolean', GetSet)
      else
        ConfigurePropertyListController(Classe, Campo, 'Boolean', GetSet);
    end
    else if Entidade.FieldByName(Campo).DataType in [ftSmallint, ftInteger, ftWord] then
    begin
      if cbxOpcao.ItemIndex = 0 then
        ConfigurePropertyListVO(Classe, Campo, Tamanho, 'Integer', GetSet)
      else
        ConfigurePropertyListController(Classe, Campo, 'Integer', GetSet);
    end
    else if Entidade.FieldByName(Campo).DataType in [ftFloat, ftCurrency, ftBCD] then
    begin
      if cbxOpcao.ItemIndex = 0 then
        ConfigurePropertyListVO(Classe, Campo, Tamanho, 'Extended', GetSet)
      else
        ConfigurePropertyListController(Classe, Campo, 'Extended', GetSet);
    end
    else if Entidade.FieldByName(Campo).DataType in [ftTime] then
    begin
      if cbxOpcao.itemindex = 0 then
        ConfigurePropertyListVO(Classe, Campo, Tamanho, 'String', GetSet)
      else
        ConfigurePropertyListController(Classe, Campo, 'String', GetSet);
    end
    else if Entidade.FieldByName(Campo).DataType in [ftDate, ftDateTime, ftTimeStamp] then
    begin
      if cbxOpcao.ItemIndex = 0 then
        ConfigurePropertyListVO(Classe, Campo, Tamanho, 'TDateTime', GetSet)
      else
        ConfigurePropertyListController(Classe, Campo, 'TDateTime', GetSet);
    end
    else if Entidade.FieldByName(Campo).DataType in [ftExtended, ftBCD, ftFMTBcd] then
    begin
      if cbxOpcao.ItemIndex = 0 then
        ConfigurePropertyListVO(Classe, Campo, Tamanho, 'Extended', GetSet)
      else
        ConfigurePropertyListController(Classe, Campo, 'Extended', GetSet);
    end;
  end;
end;

procedure TFGera.GetPropriedadesXML;
var
  I: Integer;
  Column, Name, Campo, Tamanho, TipoCampo: String;
begin
  ListaPropriedadesXML := TStringList.Create;
  for I := 0 to Entidade.FieldList.Count - 1 do
  begin
    Campo := Entidade.FieldList.Fields[I].FieldName;

    if Campo <> 'ID' then
    begin
      TipoCampo := FieldTypeNames[Entidade.FieldList.Fields[I].DataType];

      // Calcular tamanho do campo (tam.campo * 8)
      Tamanho := IntToStr((Entidade.FieldList.Fields[I].DisplayWidth * 8));

      // o tamanho passar de 450 ent�o vamos deixar 450px
      if (StrToInt(Tamanho) > 450) then
        Tamanho := '450';

      // se o campo for do tipo memo fixamos em 450px
      if Entidade.FieldByName(Campo).DataType in [ftMemo] then
        Tamanho := '450';

      ListaPropriedadesXML.add(
              '    <property name="' + TrataNomeProperty(Entidade.FieldList.Fields[I].FieldName) +
              '" column="' + Entidade.FieldList.Fields[I].FieldName +
              '" caption="' + TrataNomeDisplay(Entidade.FieldList.Fields[I].FieldName) +
              '" width="' + Tamanho +
              '" type="' + TipoCampo +
              '" />');
    end;
  end;
end;

procedure TFGera.GetPropriedadesController;
var
  I: Integer;
  GetSet, Campo, Classe: String;
begin
  ListaCampos := TStringList.Create;
  ListaPropriedades := TStringList.Create;
  ListaSets := TStringList.Create;
  ListaProcedureSet := TStringList.Create;
  for I := 0 to Entidade.FieldList.Count - 1 do
  begin
    GetSet := ' read F' + Entidade.FieldList.Fields[I].FieldName + ' write F' + Entidade.FieldList.Fields[I].FieldName + ';';
    Campo := Entidade.FieldList.Fields[I].FieldName;
    Classe := 'T' + listaTabelas.Items.Strings[listaTabelas.itemindex];

    if Entidade.FieldByName(Campo).DataType in [ftString, ftMemo] then
      ConfigurePropertyListController(Classe, Campo, 'String', GetSet)
    else if Entidade.FieldByName(Campo).DataType = ftBoolean then
      ConfigurePropertyListController(Classe, Campo, 'Boolean', GetSet)
    else if Entidade.FieldByName(Campo).DataType in [ftSmallint, ftInteger, ftWord] then
      ConfigurePropertyListController(Classe, Campo, 'Integer', GetSet)
    else if Entidade.FieldByName(Campo).DataType in [ftFloat, ftCurrency, ftBCD] then
      ConfigurePropertyListController(Classe, Campo, 'Currency', GetSet)
    else if Entidade.FieldByName(Campo).DataType in [ftTime] then
      ConfigurePropertyListController(Classe, Campo, 'String', GetSet)
    else if Entidade.FieldByName(Campo).DataType in [ftDate, ftDateTime, ftTimeStamp] then
      ConfigurePropertyListController(Classe, Campo, 'TDateTime', GetSet)
    else
      ConfigurePropertyListController(Classe, Campo, 'Double', GetSet);
  end;
end;

function TFGera.GetUserFromWindows: String;
var
  Buffer: PWideChar;
  Size: dword;
begin
  Size := 256;
  Buffer := '';

  if GetUserName(Buffer, Size) then
    Result := Buffer
  else
    Result := 'Desconhecido';
end;

procedure TFGera.ConfigurePropertyListVO(Classe, Campo, Tamanho, Tipo, GetSet : String);
begin
  ListaPropriedades.add('    property ' + TrataNomeProperty(Campo) + ': ' + Tipo + ' ' + GetSet);
  ListaCampos.add('    F' + Campo + ': ' + Tipo + ';')
end;

procedure TFGera.ConfigurePropertyListController(Classe, Campo, Tipo, GetSet: String);
begin
  if Tipo = 'String' then
    ListaCampos.add('        obj' + NomeTabela + '.' + TrataNomeProperty(Campo) + ':= resultSet.Value[' + QuotedStr(Campo) + '].AsString;')
  else if Tipo = 'Boolean' then
    ListaCampos.add('        obj' + NomeTabela + '.' + TrataNomeProperty(Campo) + ':= resultSet.Value[' + QuotedStr(Campo) + '].AsBoolean;')
  else if Tipo = 'Integer' then
    ListaCampos.add('        obj' + NomeTabela + '.' + TrataNomeProperty(Campo) + ':= resultSet.Value[' + QuotedStr(Campo) + '].AsInt32;')
  else if Tipo = 'Currency' then
    ListaCampos.add('        obj' + NomeTabela + '.' + TrataNomeProperty(Campo) + ':= resultSet.Value[' + QuotedStr(Campo) + '].AsCurrency;')
  else if Tipo = 'Double' then
    ListaCampos.add('        obj' + NomeTabela + '.' + TrataNomeProperty(Campo) + ':= resultSet.Value[' + QuotedStr(Campo) + '].AsDouble;')
  else if Tipo = 'Date' then
    ListaCampos.add('        obj' + NomeTabela + '.' + TrataNomeProperty(Campo) + ':= resultSet.Value[' + QuotedStr(Campo) + '].AsDate;')
end;

// -------------------------------------------------------------------------------------------------
// VOS
// -------------------------------------------------------------------------------------------------

procedure TFGera.CriarClasseVO;
begin
  AdicionaLicenca;

  NomeTabela := TrataNomeTabela + 'VO';

  memo.Lines.Add('unit ' + NomeTabela + ';');
  memo.Lines.Add('');

  memo.Lines.Add('{$mode objfpc}{$H+}');
  memo.Lines.Add('');

  memo.Lines.Add('interface');
  memo.Lines.Add('');

  memo.Lines.Add('uses');
  memo.Lines.Add('  VO, Classes, SysUtils, FGL;');
  memo.Lines.Add('');

  memo.Lines.Add('type');
  memo.Lines.Add('  T' + NomeTabela + ' = class(TVO)');
  memo.Lines.Add('  private');
  memo.Lines.Add(ListaCampos.Text);
  memo.Lines.Add('  published ');
  memo.Lines.Add(ListaPropriedades.Text);
  memo.Lines.Add('  end;');

  memo.Lines.Add('');
  memo.Lines.Add('  TLista' + NomeTabela + ' = specialize TFPGObjectList<T' + NomeTabela + '>;');
  memo.Lines.Add('');

  memo.Lines.Add('implementation');
  memo.Lines.Add('');
  memo.Lines.Add('');
  memo.Lines.Add('initialization');
  memo.Lines.Add('  Classes.RegisterClass(T'+ NomeTabela + ');');
  memo.Lines.Add('');
  memo.Lines.Add('finalization');
  memo.Lines.Add('  Classes.UnRegisterClass(T'+ NomeTabela + ');');
  memo.Lines.Add('');

  memo.Lines.Add('end.');
end;

procedure TFGera.CriarXML;
begin
  NomeTabela := TrataNomeTabela + 'VO';

  memo.Lines.Add('<?xml version="1.0" encoding="utf-8"?>');
  memo.Lines.Add('<t2ti-orm-mapping>');
  memo.Lines.Add('  <class name="' + NomeTabela + '" table="' + NomeTabelaMinusculo + '" >');

  memo.Lines.Add('');

  memo.Lines.Add('    <id name="Id" column="ID">');
  memo.Lines.Add('      <generator class="sequence">');
  memo.Lines.Add('        <param name="sequence">' + NomeTabelaMinusculo + '</param>');
  memo.Lines.Add('      </generator>');
  memo.Lines.Add('    </id>');

  memo.Lines.Add('');

  memo.Lines.Add(ListaPropriedadesXML.Text);

  memo.Lines.Add('  </class>');
  memo.Lines.Add('</t2ti-orm-mapping>');
end;

procedure TFGera.EditBuscaChange(Sender: TObject);
begin
  ListaTabelas.Perform(LB_SELECTSTRING,0,LongInt(PChar(EditBusca.Text)));
end;

function TFGera.TrataNomeTabela: String;
var
  NomeTabela: String;
  I: Integer;
begin
  NomeTabela := listaTabelas.Items.Strings[listaTabelas.itemindex];
  NomeTabela := UpperCase(Copy(NomeTabela, 1, 1)) + LowerCase(Copy(NomeTabela, 2, length(NomeTabela) - 1));

  for I := 1 to length(NomeTabela) do
  begin
    if Copy(NomeTabela, I, 1) = '_' then
    begin
      Delete(NomeTabela, I, 1);
      NomeTabela := Copy(NomeTabela, 1, I - 1) + UpperCase(Copy(NomeTabela, I, 1)) + LowerCase(Copy(NomeTabela, I + 1, length(NomeTabela) - 1));
    end;
  end;

  Result := NomeTabela;
end;

function TFGera.NomeTabelaMaiusculo: String;
var
  NomeTabela: String;
begin
  NomeTabela := UpperCase(listaTabelas.Items.Strings[listaTabelas.itemindex]);
  Result := NomeTabela;
end;

function TFGera.NomeTabelaMinusculo: String;
var
  NomeTabela: String;
begin
  NomeTabela := LowerCase(listaTabelas.Items.Strings[listaTabelas.itemindex]);
  Result := NomeTabela;
end;

function TFGera.TrataNomeProperty(NomeCampo: String): String;
var
  I: Integer;
begin
  NomeCampo := UpperCase(Copy(NomeCampo, 1, 1)) + LowerCase
    (Copy(NomeCampo, 2, length(NomeCampo) - 1));

  for I := 1 to length(NomeCampo) do
  begin
    if copy(NomeCampo,I,1) = '_' then
    begin
      Delete(NomeCampo,I,1);
      NomeCampo := Copy(NomeCampo,1,I-1) + UpperCase(Copy(NomeCampo,I,1)) + LowerCase(Copy(NomeCampo,I+1,length(NomeCampo)-1));
    end;
  end;

  Result := NomeCampo;
end;

function TFGera.TrataNomeDisplay(NomeCampo: String): String;
var
  I: Integer;
begin
  NomeCampo := UpperCase(Copy(NomeCampo,1,1)) + LowerCase(Copy(NomeCampo,2,length(NomeCampo)-1));
  for I := 1 to length(NomeCampo) do
  begin
    if copy(NomeCampo,I,1) = '_' then
    begin
      Delete(NomeCampo,I,1);
      Insert(' ',NomeCampo,I);
      NomeCampo := Copy(NomeCampo,1,I) + UpperCase(Copy(NomeCampo,I+1,1)) + (Copy(NomeCampo,I+2,length(NomeCampo)-1));
    end;
  end;
  result := NomeCampo;
end;

procedure TFGera.AdicionaLicenca;
var
  loOpcao: String;
begin
  case (cbxOpcao.ItemIndex) of
    0:  loOpcao:=  ' VO ';
    1:  loOpcao := 'Controller do lado Cliente';
    2:  loOpcao := 'Controller do lado Servidor';
  end;

  memo.Lines.Add('{*******************************************************************************');
  memo.Lines.Add('Title: T2Ti ERP                                                                 ');
  memo.Lines.Add('Description: ' + loOpcao + ' relacionado � tabela [' + NomeTabelaMaiusculo + '] ');
  memo.Lines.Add('                                                                                ');
  memo.Lines.Add('The MIT License                                                                 ');
  memo.Lines.Add('                                                                                ');
  memo.Lines.Add('Copyright: Copyright (C) 2014 T2Ti.COM                                          ');
  memo.Lines.Add('                                                                                ');
  memo.Lines.Add('Permission is hereby granted, free of charge, to any person                     ');
  memo.Lines.Add('obtaining a copy of this software and associated documentation                  ');
  memo.Lines.Add('files (the "Software"), to deal in the Software without                         ');
  memo.Lines.Add('restriction, including without limitation the rights to use,                    ');
  memo.Lines.Add('copy, modify, merge, publish, distribute, sublicense, and/or sell               ');
  memo.Lines.Add('copies of the Software, and to permit persons to whom the                       ');
  memo.Lines.Add('Software is furnished to do so, subject to the following                        ');
  memo.Lines.Add('conditions:                                                                     ');
  memo.Lines.Add('                                                                                ');
  memo.Lines.Add('The above copyright notice and this permission notice shall be                  ');
  memo.Lines.Add('included in all copies or substantial portions of the Software.                 ');
  memo.Lines.Add('                                                                                ');
  memo.Lines.Add('THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 ');
  memo.Lines.Add('EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 ');
  memo.Lines.Add('OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        ');
  memo.Lines.Add('NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     ');
  memo.Lines.Add('HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    ');
  memo.Lines.Add('WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    ');
  memo.Lines.Add('FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   ');
  memo.Lines.Add('OTHER DEALINGS IN THE SOFTWARE.                                                 ');
  memo.Lines.Add('                                                                                ');
  memo.Lines.Add('       The author may be contacted at:                                          ');
  memo.Lines.Add('           t2ti.com@gmail.com                                                   ');
  memo.Lines.Add('                                                                                ');
  memo.Lines.Add('@author ' + EditAutor.Text + ' (' + EditEmailAutor.Text + ')                    ');
  memo.Lines.Add('@version 2.0                                                                    ');
  memo.Lines.Add('*******************************************************************************}');
end;


procedure TFGera.Button2Click(Sender: TObject);
var
  NomeTabelaBanco: String;
begin
  Diretorio := EditDiretorioVO;
  NomeTabela := TrataNomeTabela;
  NomeTabelaBanco := listaTabelas.Items.Strings[listaTabelas.itemindex];

  memo.Clear;

  memo.Lines.Add('unit ' + NomeTabela + ';');
  memo.Lines.Add('');

  memo.Lines.Add('{$mode objfpc}{$H+}');
  memo.Lines.Add('');

  memo.Lines.Add('interface');
  memo.Lines.Add('');

  memo.Lines.Add('uses');
  memo.Lines.Add('  HTTPDefs, BrookRESTActions, BrookUtils;');
  memo.Lines.Add('');

  memo.Lines.Add('type');
  memo.Lines.Add('');

  memo.Lines.Add('  T' + NomeTabela + 'Options = class(TBrookOptionsAction)');
  memo.Lines.Add('  end;');
  memo.Lines.Add('');

  memo.Lines.Add('  T' + NomeTabela + 'Retrieve = class(TBrookRetrieveAction)');
  memo.Lines.Add('    procedure Request({%H-}ARequest: TRequest; AResponse: TResponse); override;');
  memo.Lines.Add('  end;');
  memo.Lines.Add('');

  memo.Lines.Add('  T' + NomeTabela + 'Show = class(TBrookShowAction)');
  memo.Lines.Add('  end;');
  memo.Lines.Add('');

  memo.Lines.Add('  T' + NomeTabela + 'Create = class(TBrookCreateAction)');
  memo.Lines.Add('  end;');
  memo.Lines.Add('');

  memo.Lines.Add('  T' + NomeTabela + 'Update = class(TBrookUpdateAction)');
  memo.Lines.Add('  end;');
  memo.Lines.Add('');

  memo.Lines.Add('  T' + NomeTabela + 'Destroy = class(TBrookDestroyAction)');
  memo.Lines.Add('  end;');
  memo.Lines.Add('');

  memo.Lines.Add('implementation');
  memo.Lines.Add('');

  memo.Lines.Add('procedure T' + NomeTabela + 'Retrieve.Request(ARequest: TRequest; AResponse: TResponse);');
  memo.Lines.Add('var');
  memo.Lines.Add('  Campo: String;');
  memo.Lines.Add('  Filtro: String;');
  memo.Lines.Add('begin');
  memo.Lines.Add('  Campo := Values[' + QuotedStr('campo') + '].AsString;');
  memo.Lines.Add('  Filtro := Values[' + QuotedStr('filtro') + '].AsString;');
  memo.Lines.Add('');
  memo.Lines.Add('  Values.Clear;');
  memo.Lines.Add('');
  memo.Lines.Add('  Table.Where(Campo + ' + QuotedStr(' LIKE "%') + ' + Filtro + ' + QuotedStr('%"') + ');');
  memo.Lines.Add('  inherited Request(ARequest, AResponse);');
  memo.Lines.Add('end;');

  memo.Lines.Add('');
  memo.Lines.Add('initialization');

  memo.Lines.Add('  T' + NomeTabela + 'Options.Register(' + QuotedStr(LowerCase(NomeTabelaBanco)) + ', ' + QuotedStr('/'+LowerCase(NomeTabelaBanco)) + ');');
  memo.Lines.Add('  T' + NomeTabela + 'Retrieve.Register(' + QuotedStr(LowerCase(NomeTabelaBanco)) + ', ' + QuotedStr('/'+LowerCase(NomeTabelaBanco) + '/:campo/:filtro/') + ');');
  memo.Lines.Add('  T' + NomeTabela + 'Show.Register(' + QuotedStr(LowerCase(NomeTabelaBanco)) + ', ' + QuotedStr('/'+LowerCase(NomeTabelaBanco) + '/:id') + ');');
  memo.Lines.Add('  T' + NomeTabela + 'Create.Register(' + QuotedStr(LowerCase(NomeTabelaBanco)) + ', ' + QuotedStr('/'+LowerCase(NomeTabelaBanco)) + ');');
  memo.Lines.Add('  T' + NomeTabela + 'Update.Register(' + QuotedStr(LowerCase(NomeTabelaBanco)) + ', ' + QuotedStr('/'+LowerCase(NomeTabelaBanco) + '/:id') + ');');
  memo.Lines.Add('  T' + NomeTabela + 'Destroy.Register(' + QuotedStr(LowerCase(NomeTabelaBanco)) + ', ' + QuotedStr('/'+LowerCase(NomeTabelaBanco) + '/:id') + ');');


  memo.Lines.Add('');
  memo.Lines.Add('end.');

  memo.Lines.SaveToFile(Diretorio.Directory + '\' + NomeTabela + '.pas');
end;



// CONVERTE VO
procedure TFGera.Button1Click(Sender: TObject);
var
  I, iContaVO: Integer;
  Linha, NomeArquivo: String;
begin
  // Carrega arquivos na lista
  ListVOs.Mask := '*.pas';
  ListVOs.Directory := editDiretorioVO.Text;
  ListVOs.Update;

  try
    // executa o la�o pela quantidade de VOs que foram carregados no componente ListVOs
    for iContaVO := 0 to ListVOs.Count - 1 do
    begin
      memo.Lines.LoadFromFile(ListVOs.Items[iContaVO]);
      MemoCopiaVO.Clear;

      for I := 0 to memo.Lines.Count - 1 do
      begin
        // Se n�o encontrar nada com "[" colchetes, copia par ao outro memo
        if (pos('[', memo.Lines[I]) = 0) or (I=2) then
        begin

          // Se encontrar o termo 'unit', realiza o procedimento
          if (pos('unit', memo.Lines[I]) <> 0) then
          begin
            MemoCopiaVO.Lines.Add(memo.Lines[I]);
            MemoCopiaVO.Lines.Add('');
            MemoCopiaVO.Lines.Add('{$mode objfpc}{$H+}');
          end

          // Se encontrar o termo 'VO,', realiza o procedimento
          else if (pos(' VO,', memo.Lines[I]) <> 0) then
          begin
            if Trim(memo.Lines[I+1]) = '' then
              MemoCopiaVO.Lines.Add('  VO, Classes, SysUtils, FGL;')
            else
              MemoCopiaVO.Lines.Add('  VO, Classes, SysUtils, FGL,');
          end

          // Se encontrar o termo ' end;', realiza o procedimento
          else if (pos(' end;', memo.Lines[I]) <> 0) then
          begin
            MemoCopiaVO.Lines.Add(memo.Lines[I]);
            MemoCopiaVO.Lines.Add('');
            NomeArquivo := ListVOs.Items[iContaVO];
            Delete(NomeArquivo, pos('.', NomeArquivo), 4);
            Linha := '  TLista' + NomeArquivo + ' = specialize TFPGObjectList<T' + NomeArquivo + '>;';
            MemoCopiaVO.Lines.Add(Linha);
          end

          // Se encontrar o termo 'TObjectList', realiza o procedimento
          else if (pos('TObjectList', memo.Lines[I]) <> 0) then
          begin
            Linha := memo.Lines[I];

            Linha := StringReplace(Linha, 'TObjectList<T', 'TLista', [rfReplaceAll]);
            Linha := StringReplace(Linha, '>', '', [rfReplaceAll]);

            MemoCopiaVO.Lines.Add(Linha);
          end

          // Se encontrar o termo '  public', realiza o procedimento
          else if (pos('  public', memo.Lines[I]) <> 0) then
          begin
            Linha := memo.Lines[I];
            Linha := StringReplace(Linha, '  public', '  published', [rfReplaceAll]);
            MemoCopiaVO.Lines.Add(Linha);
          end

          else
            MemoCopiaVO.Lines.Add(memo.Lines[I]);
        end;
      end;
      MemoCopiaVO.Lines.SaveToFile(ListVOs.Items[iContaVO]);
    end;
  finally
    ShowMessage('processo finalizado');
  end;
end;

// CONVERTE CONTROLLER
procedure TFGera.Button3Click(Sender: TObject);
var
  I, iContaController: Integer;
  Linha, NomeVO, NomeController: String;
begin
  // Carrega arquivos na lista
  ListVOs.Mask := '*.pas';
  ListVOs.Directory := editDiretorioVO.Text;
  ListVOs.Update;

  try
    // executa o la�o pela quantidade de Controllers que foram carregados no componente ListVOs
    for iContaController := 0 to ListVOs.Count - 1 do
    begin
      NomeController := ListVOs.Items[iContaController];
      Delete(NomeController, pos('.', NomeController), 4);

      NomeVO := Copy(NomeController, 1, pos('Controller', NomeController) - 1) + 'VO';

      memo.Lines.LoadFromFile(ListVOs.Items[iContaController]);
      MemoCopiaVO.Clear;

      I := 0;
      while I <= memo.Lines.Count do
      begin
        // Se encontrar o termo '  Classes,', realiza o procedimento
        if (pos('  Classes,', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'Classes, Dialogs, SysUtils, DBClient, DB,  Windows, Forms, Controller, Rtti,', 'Classes, Dialogs, SysUtils, DB, LCLIntf, LCLType, LMessages, Forms, Controller,', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end

        // Se encontrar o termo '  Atributos,', realiza o procedimento
        else if (pos('  Atributos,', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'Atributos, VO, Generics.Collections,', 'VO, ZDataset,', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end

        // Se encontrar o termo 'TClientDataSet', realiza o procedimento
        else if (pos('TClientDataSet', memo.Lines[I]) <> 0) or (pos('TratarListaRetorno', memo.Lines[I]) <> 0) then
        begin
          //pula essa linha - n�o copia nada
        end

        // Se encontrar o termo 'TEnumerator', realiza o procedimento
        else if (pos('TEnumerator', memo.Lines[I]) <> 0) or (pos('TratarRetorno', memo.Lines[I]) <> 0) then
        begin
          //pula essa linha - n�o copia nada
        end

        // Se encontrar o termo ' end;', realiza o procedimento
        else if (pos('uses UDataModule', memo.Lines[I]) <> 0) then
        begin
          MemoCopiaVO.Lines.Add(memo.Lines[I]);
          MemoCopiaVO.Lines.Add('');
          MemoCopiaVO.Lines.Add('var');
          MemoCopiaVO.Lines.Add('  ObjetoLocal: T' + NomeVO + ';');
        end

        // Se encontrar o termo 'class procedure Consulta(', realiza o procedimento - declara��o do metodo
        else if (pos('class procedure Consulta(', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'class procedure Consulta(', 'class function Consulta(', [rfReplaceAll]);
          Linha := StringReplace(Linha, '; pConsultaCompleta: Boolean = False);', '): TZQuery;', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end

        // Se encontrar o termo 'class procedure Consulta(', realiza o procedimento - implementa��o do metodo
        else if (pos('class procedure T' + NomeController + '.Consulta(', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'class procedure T' + NomeController + '.Consulta(', 'class function T' + NomeController + '.Consulta(', [rfReplaceAll]);
          Linha := StringReplace(Linha, '; pConsultaCompleta: Boolean);', '): TZQuery;', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);

          // incrementa o I para n�o pegar a variavel de retorno, que no Delphi � uma lista e no lazarus � uma zquery
          I := I + 2;
        end

        // Se encontrar o termo 'TObjectList', realiza o procedimento
        else if (pos('TObjectList', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];

          Linha := StringReplace(Linha, 'TObjectList<T', 'TLista', [rfReplaceAll]);
          Linha := StringReplace(Linha, '>', '', [rfReplaceAll]);

          MemoCopiaVO.Lines.Add(Linha);
        end

        // Se encontrar o termo 'Retorno := TT2TiORM.', realiza o procedimento
        else if (pos('Retorno := TT2TiORM.', memo.Lines[I]) <> 0) then
        begin
          Linha := '    ObjetoLocal := T' + NomeVO + '.Create;';
          MemoCopiaVO.Lines.Add(Linha);

          Linha := '    Result := TT2TiORM.Consultar(ObjetoLocal, pFiltro, pPagina);';
          MemoCopiaVO.Lines.Add(Linha);

          Linha := '  finally';
          MemoCopiaVO.Lines.Add(Linha);

          Linha := '    ObjetoLocal.Free;';
          MemoCopiaVO.Lines.Add(Linha);

          // incrementa o I para n�o pegar o codigo do metodo consulta que foi substituido acima
          I := I + 2;
        end

        // Se encontrar o termo 'Result := TT2TiORM.Consultar<', realiza o procedimento
        else if (pos('Result := TT2TiORM.Consultar<', memo.Lines[I]) <> 0) then
        begin
          Linha := '    ObjetoLocal := T' + NomeVO + '.Create;';
          MemoCopiaVO.Lines.Add(Linha);

          Linha := '    Result := TLista' + NomeVO + '(TT2TiORM.Consultar(ObjetoLocal, pFiltro, True));';
          MemoCopiaVO.Lines.Add(Linha);

          Linha := '  finally';
          MemoCopiaVO.Lines.Add(Linha);

          Linha := '    ObjetoLocal.Free;';
          MemoCopiaVO.Lines.Add(Linha);

          // incrementa o I para n�o pegar o codigo do metodo consulta que foi substituido acima
          I := I + 1;
        end

        // Se encontrar o termo 'Result := TT2TiORM.ConsultarUmObjeto', realiza o procedimento
        else if (pos('Result := TT2TiORM.ConsultarUmObjeto', memo.Lines[I]) <> 0) then
        begin
          Linha := '    Result := T' + NomeVO + '.Create;';
          MemoCopiaVO.Lines.Add(Linha);

          Linha := '    Result := T' + NomeVO + '(TT2TiORM.ConsultarUmObjeto(Result, pFiltro, True));';
          MemoCopiaVO.Lines.Add(Linha);
        end

        else
          MemoCopiaVO.Lines.Add(memo.Lines[I]);

        inc(I);
      end;
      MemoCopiaVO.Lines.SaveToFile(ListVOs.Items[iContaController]);
    end;
  finally
    ShowMessage('processo finalizado');
  end;
end;

// CONVERTE TELA - UNIT
procedure TFGera.Button4Click(Sender: TObject);
var
  I, J, iContaTela: Integer;
  Linha, NomeTela, NomeVO, NomeController, ObjetoTransiente: String;
  ListaCDS: TStringList;
  posicao1, posicao2: integer;
begin
  // Cria a lista que vai guardar os nomes dos CDS
  ListaCDS := TStringList.Create;

  // Carrega arquivos na lista
  ListVOs.Mask := '*.pas';
  ListVOs.Directory := editDiretorioVO.Text;
  ListVOs.Update;

  try
    // executa o la�o pela quantidade de VOs que foram carregados no componente ListVOs
    for iContaTela := 0 to ListVOs.Count - 1 do
    begin
      NomeTela := Copy(ListVOs.Items[iContaTela], 2, Length(ListVOs.Items[iContaTela]));
      Delete(NomeTela, pos('.', NomeTela), 4);

      NomeController := NomeTela + 'Controller';
      NomeVO := NomeTela + 'VO';

      memo.Lines.LoadFromFile(ListVOs.Items[iContaTela]);
      MemoCopiaVO.Clear;

      I := 0;
      while I <= memo.Lines.Count do
      begin
        // adiciona as units do brook e demais do lazarus e depois comenta as outras
        if (pos('uses', memo.Lines[I]) <> 0) and (I<50) then
        begin
          MemoCopiaVO.Lines.Add(memo.Lines[I]);
          MemoCopiaVO.Lines.Add('  BrookHTTPClient, BrookFCLHTTPClientBroker, BrookHTTPUtils, BrookUtils, FPJson, ZDataset,');
          MemoCopiaVO.Lines.Add('  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,');
          MemoCopiaVO.Lines.Add('  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,');
          MemoCopiaVO.Lines.Add('  ComCtrls, LabeledCtrls, rxdbgrid, rxtoolbar, DBCtrls, StrUtils,');
          MemoCopiaVO.Lines.Add('  Math, Constantes, CheckLst, ActnList, ToolWin, ShellApi, db, BufDataset, Biblioteca,');
          MemoCopiaVO.Lines.Add('  ULookup, VO;');
          MemoCopiaVO.Lines.Add('{');
        end
        else if (pos('type', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'type', '}type', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end

        // guarda o nome dos CDS
        else if (pos('CDS', memo.Lines[I]) <> 0) and ((pos(': TClientDataSet', memo.Lines[I]) <> 0)) then
        begin
          Linha := Trim(memo.Lines[I]);
          ListaCDS.Add(Copy(Linha, 1, pos(':', Linha) - 1));
          MemoCopiaVO.Lines.Add(memo.Lines[I]);
        end

        // substitui��o dos componentes
        else if (pos('TJvGListBox', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvGListBox', 'TListBox', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvListBox', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvListBox', 'TListBox', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvCalculator', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvCalculator', 'TACbrCalculadora', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvCalEdit', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvCalEdit', 'TCurrencyEdit', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvLabel', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvLabel', 'TLabel', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvImgBtn', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvImgBtn', 'TBitBtn', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvValidateEdit', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvValidateEdit', 'TCurrencyEdit', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvEnterAsTab', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvEnterAsTab', 'TACBrEnterTab', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TClientDataSet', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TClientDataSet', 'TBufDataset', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvProgressBar', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvProgressBar', 'TProgressBar', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvDbGrid', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvDbGrid', 'TRxDbGrid', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvDBUltimGrid', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvDBUltimGrid', 'TRxDbGrid', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvSpeedButton', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvSpeedButton', 'TSpeedButton', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvBitBtn', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvBitBtn', 'TBitBtn', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvScroolBox', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvScroolBox', 'TScroolBox', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvPanel', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvPanel', 'TPanel', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvSpinEdit', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvSpinEdit', 'TSpinEdit', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvBrowseForFolderDialog', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvBrowseForFolderDialog', 'TSelectDirectoryDialog', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TActionToolBar', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TActionToolBar', 'TToolPanel', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TActionManager', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TActionManager', 'TActionList', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end

		// EmptyDataSet
        else if (pos('EmptyDataSet', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'EmptyDataSet', 'Close', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
          Linha := StringReplace(Linha, 'Close', 'Open', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end		

        // adiciona os m�todos BotaoConsultarClick e BotaoSalvarClick
        else if (pos('  private', memo.Lines[I+1]) <> 0) then
        begin
          MemoCopiaVO.Lines.Add(memo.Lines[I]);
          MemoCopiaVO.Lines.Add('    procedure BotaoConsultarClick(Sender: TObject);');
          MemoCopiaVO.Lines.Add('    procedure BotaoSalvarClick(Sender: TObject);');
        end

        // adiciona a implementa��o dos m�todos BotaoConsultarClick e BotaoSalvarClick
        else if (pos('REGION', memo.Lines[I]) <> 0) and ((pos('Infra', memo.Lines[I]) <> 0)) then
        begin
          MemoCopiaVO.Lines.Add(memo.Lines[I]);
          MemoCopiaVO.Lines.Add('procedure TF' + NomeTela + '.BotaoConsultarClick(Sender: TObject);');
          MemoCopiaVO.Lines.Add('var');
          MemoCopiaVO.Lines.Add('  RetornoConsulta: TZQuery;');
          MemoCopiaVO.Lines.Add('  ListaCampos: TStringList;');
          MemoCopiaVO.Lines.Add('  i: integer;');
          MemoCopiaVO.Lines.Add('begin');
          MemoCopiaVO.Lines.Add('  inherited;');
          MemoCopiaVO.Lines.Add('');
          MemoCopiaVO.Lines.Add('  if Sessao.Camadas = 2 then');
          MemoCopiaVO.Lines.Add('  begin');
          MemoCopiaVO.Lines.Add('    Filtro := MontaFiltro;');
          MemoCopiaVO.Lines.Add('');
          MemoCopiaVO.Lines.Add('    CDSGrid.Close;');
          MemoCopiaVO.Lines.Add('    CDSGrid.Open;');
          MemoCopiaVO.Lines.Add('    ConfiguraGridFromVO(Grid, ClasseObjetoGridVO);');
          MemoCopiaVO.Lines.Add('');
          MemoCopiaVO.Lines.Add('    ListaCampos  := TStringList.Create;');
          MemoCopiaVO.Lines.Add('    RetornoConsulta := T' + NomeTela + 'Controller.Consulta(Filtro, IntToStr(Pagina));');
          MemoCopiaVO.Lines.Add('    RetornoConsulta.Active := True;');
          MemoCopiaVO.Lines.Add('');
          MemoCopiaVO.Lines.Add('    RetornoConsulta.GetFieldNames(ListaCampos);');
          MemoCopiaVO.Lines.Add('');
          MemoCopiaVO.Lines.Add('    RetornoConsulta.First;');
          MemoCopiaVO.Lines.Add('    while not RetornoConsulta.EOF do begin');
          MemoCopiaVO.Lines.Add('      CDSGrid.Append;');
          MemoCopiaVO.Lines.Add('      for i := 0 to ListaCampos.Count - 1 do');
          MemoCopiaVO.Lines.Add('      begin');
          MemoCopiaVO.Lines.Add('        CDSGrid.FieldByName(ListaCampos[i]).Value := RetornoConsulta.FieldByName(ListaCampos[i]).Value;');
          MemoCopiaVO.Lines.Add('      end;');
          MemoCopiaVO.Lines.Add('      CDSGrid.Post;');
          MemoCopiaVO.Lines.Add('      RetornoConsulta.Next;');
          MemoCopiaVO.Lines.Add('    end;');
          MemoCopiaVO.Lines.Add('  end;');
          MemoCopiaVO.Lines.Add('end;');
          MemoCopiaVO.Lines.Add('');
          MemoCopiaVO.Lines.Add('procedure TF' + NomeTela + '.BotaoSalvarClick(Sender: TObject);');
          MemoCopiaVO.Lines.Add('begin');
          MemoCopiaVO.Lines.Add('  inherited;');
          MemoCopiaVO.Lines.Add('  BotaoConsultarClick(Sender);');
          MemoCopiaVO.Lines.Add('end;');
          MemoCopiaVO.Lines.Add('');
        end

        // comenta e deixa como exerc�cio o esquema de compara��o com o JSON, caso existam listas
        else if (pos('else if StatusTela = stEditando then', memo.Lines[I]) <> 0) and (ListaCDS.Count > 0) then
        begin
          MemoCopiaVO.Lines.Add(memo.Lines[I]);
          MemoCopiaVO.Lines.Add('      begin');
          MemoCopiaVO.Lines.Add('        /// EXERCICIO: Verifique se tem como serializar as listas junto com o objeto para realizar a compara��o');
          MemoCopiaVO.Lines.Add('        //' + Trim(memo.Lines[I+2]));
          MemoCopiaVO.Lines.Add('        //' + Trim(memo.Lines[I+3]));
          MemoCopiaVO.Lines.Add('          T' + NomeTela + 'Controller.Altera(T' + NomeTela + 'VO(ObjetoVO));');
          //MemoCopiaVO.Lines.Add(memo.Lines[I+4]);
          MemoCopiaVO.Lines.Add('        //' + Trim(memo.Lines[I+5]));
          MemoCopiaVO.Lines.Add('        //' + Trim(memo.Lines[I+6]));
          MemoCopiaVO.Lines.Add('        //' + Trim(memo.Lines[I+7]));
          I := I + 7;
        end

        // altera o metodo de exclus�o
        else if (pos('TController.ExecutarMetodo', memo.Lines[I]) <> 0) and ((pos('Exclui', memo.Lines[I]) <> 0)) then
        begin
          MemoCopiaVO.Lines.Add('      Result := T' + NomeTela + 'Controller.Exclui(IdRegistroSelecionado);');
        end
        else if (pos('TController.ExecutarMetodo', memo.Lines[I]) <> 0) and ((pos('Consulta', memo.Lines[I]) <> 0)) then
        begin
          MemoCopiaVO.Lines.Add('    BotaoConsultar.Click;');
        end

        // altera o metodo de inclus�o
        else if (pos('TController.ExecutarMetodo', memo.Lines[I]) <> 0) and ((pos('Insere', memo.Lines[I]) <> 0)) then
        begin
          MemoCopiaVO.Lines.Add('        T' + NomeTela + 'Controller.Insere(T' + NomeTela + 'VO(ObjetoVO));');
        end

        // altera o metodo de altera��o
        else if (pos('TController.ExecutarMetodo', memo.Lines[I]) <> 0) and ((pos('Altera', memo.Lines[I]) <> 0)) then
        begin
          MemoCopiaVO.Lines.Add('          T' + NomeTela + 'Controller.Altera(T' + NomeTela + 'VO(ObjetoVO));');
        end

        // arruma o grid para edits
        else if (pos('.GridParaEdits', memo.Lines[I]) <> 0) then
        begin
          MemoCopiaVO.Lines.Add(memo.Lines[I]);
          MemoCopiaVO.Lines.Add('var');
          MemoCopiaVO.Lines.Add('  IdCabecalho: String;');
        end
        else if (pos('TController.BuscarObjeto', memo.Lines[I]) <> 0) and ((pos('IdRegistroSelecionado.ToString', memo.Lines[I]) <> 0)) then
        begin
          MemoCopiaVO.Lines.Add('    IdCabecalho := IntToStr(IdRegistroSelecionado);');
          MemoCopiaVO.Lines.Add('    ObjetoVO := T' + NomeTela + 'Controller.ConsultaObjeto(' + QuotedStr('ID=') + ' + IdCabecalho);');
        end

        // d� um jeitinho nos campos transiente, mas vai ter que arrumar manualmente
        else if (pos('if not PopulaCamposTransientes(', memo.Lines[I]) <> 0) then
        begin
          MemoCopiaVO.Lines.Add('');

          posicao1 := pos(', T', memo.Lines[I]) + 2;
          posicao2 := pos('VO,', memo.Lines[I]);

          ObjetoTransiente := Copy(memo.Lines[I], posicao1, posicao2-posicao1);
          MemoCopiaVO.Lines.Add('        '+ Copy(ObjetoTransiente, 2, Length(ObjetoTransiente)) + 'VO := ' + Copy(ObjetoTransiente, 1, Length(ObjetoTransiente)) + 'Controller.ConsultaObjeto(Filtro);');
        end
        else if (pos('CDSTransiente.RecordCount', memo.Lines[I]) <> 0) then
        begin
          MemoCopiaVO.Lines.Add('        if Assigned('+ Copy(ObjetoTransiente, 2, Length(ObjetoTransiente)) + 'VO) then');
        end

        // altera .AsExtended para .AsFloat
        else if pos('.AsExtended', memo.Lines[I]) <> 0 then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, '.AsExtended', '.AsFloat', [rfReplaceAll]);

          for J := 0 to ListaCDS.Count - 1 do
          begin
            if pos(ListaCDS[J], memo.Lines[I]) <> 0 then
            begin
              Linha := StringReplace(Linha, ListaCDS[J], ListaCDS[J] + '.FieldByName(' + Chr(39), [rfReplaceAll]);
              Linha := StringReplace(Linha, '.As',Chr(39) + ').As', [rfReplaceAll]);
              Break;
            end;
          end;

          MemoCopiaVO.Lines.Add(Linha);
        end

        // incluindo o FieldByName
        else if pos(':= CDS', memo.Lines[I]) <> 0 then
        begin
          Linha := memo.Lines[I];

          for J := 0 to ListaCDS.Count - 1 do
          begin
            if pos(ListaCDS[J], memo.Lines[I]) <> 0 then
            begin
              Linha := StringReplace(Linha, ListaCDS[J], ListaCDS[J] + '.FieldByName(' + Chr(39), [rfReplaceAll]);
              Linha := StringReplace(Linha, '.As',Chr(39) + ').As', [rfReplaceAll]);
              Break;
            end;
          end;
          MemoCopiaVO.Lines.Add(Linha);
        end


        // Termos que devem ser pulados
        else if (pos('[T', memo.Lines[I]) <> 0)
        or (pos('Result := TController.RetornoBoolean;', memo.Lines[I]) <> 0)
        or (pos('CDSTransiente.Close;', memo.Lines[I]) <> 0)
        or (pos('PopulaCamposTransientesLookup(', memo.Lines[I]) <> 0) then
        begin
          //pula essa linha - n�o copia nada
        end

        else
          MemoCopiaVO.Lines.Add(memo.Lines[I]);

        inc(I);
      end;
      MemoCopiaVO.Lines.SaveToFile(ListVOs.Items[iContaTela]);
    end;
  finally
    ShowMessage('processo finalizado');
  end;
end;

// CONVERTE TELA - FORM
procedure TFGera.Button5Click(Sender: TObject);
var
  I, iContaTela: Integer;
  Linha, NomeTela, NomeVO, NomeController: String;
begin
  // Carrega arquivos na lista
  ListVOs.Mask := '*.dfm';
  ListVOs.Directory := editDiretorioVO.Text;
  ListVOs.Update;

  try
    // executa o la�o pela quantidade de VOs que foram carregados no componente ListVOs
    for iContaTela := 0 to ListVOs.Count - 1 do
    begin
      NomeTela := Copy(ListVOs.Items[iContaTela], 2, Length(ListVOs.Items[iContaTela]));
      Delete(NomeTela, pos('.', NomeTela), 4);

      NomeController := NomeTela + 'Controller';
      NomeVO := NomeTela + 'VO';

      memo.Lines.LoadFromFile(ListVOs.Items[iContaTela]);
      MemoCopiaVO.Clear;

      I := 0;
      while I <= memo.Lines.Count do
      begin

        // substitui��o dos componentes
        if (pos('TJvGListBox', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvGListBox', 'TListBox', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvListBox', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvListBox', 'TListBox', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvCalculator', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvCalculator', 'TACbrCalculadora', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvCalEdit', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvCalEdit', 'TCurrencyEdit', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvLabel', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvLabel', 'TLabel', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvImgBtn', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvImgBtn', 'TBitBtn', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvValidateEdit', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvValidateEdit', 'TCurrencyEdit', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvEnterAsTab', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvEnterAsTab', 'TACBrEnterTab', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TClientDataSet', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TClientDataSet', 'TBufDataset', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvProgressBar', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvProgressBar', 'TProgressBar', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvDbGrid', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvDbGrid', 'TRxDbGrid', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvDBUltimGrid', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvDBUltimGrid', 'TRxDbGrid', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvSpeedButton', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvSpeedButton', 'TSpeedButton', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvBitBtn', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvBitBtn', 'TBitBtn', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvScroolBox', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvScroolBox', 'TScroolBox', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvPanel', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvPanel', 'TPanel', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvSpinEdit', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvSpinEdit', 'TSpinEdit', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TJvBrowseForFolderDialog', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TJvBrowseForFolderDialog', 'TSelectDirectoryDialog', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TActionToolBar', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TActionToolBar', 'TToolPanel', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end
        else if (pos('TActionManager', memo.Lines[I]) <> 0) then
        begin
          Linha := memo.Lines[I];
          Linha := StringReplace(Linha, 'TActionManager', 'TActionList', [rfReplaceAll]);
          MemoCopiaVO.Lines.Add(Linha);
        end


        // Termos que devem ser pulados
        else if (pos('ShowNullDate', memo.Lines[I]) <> 0)
        or (pos('AlternateRowColor', memo.Lines[I]) <> 0)
        or (pos('TitleArrow', memo.Lines[I]) <> 0)
        or (pos('CanDelete', memo.Lines[I]) <> 0)
        or (pos('EditControls', memo.Lines[I]) <> 0)
        or (pos('RowsHeight', memo.Lines[I]) <> 0)
        or (pos('TitleRowsHeight', memo.Lines[I]) <> 0)
        or (pos('TitleRowHeight', memo.Lines[I]) <> 0)
        or (pos('SortWith', memo.Lines[I]) <> 0)
        or ((pos('ActionToolBar', memo.Lines[I]) <> 0) and (pos('Caption', memo.Lines[I]) <> 0))
        or (pos('ActionManager', memo.Lines[I]) <> 0)
        or (pos('ColorMap', memo.Lines[I]) <> 0)
        or (pos('Orientation', memo.Lines[I]) <> 0)
        or (pos('Spacing', memo.Lines[I]) <> 0)
        or (pos('Aggregates', memo.Lines[I]) <> 0)
        or (pos('IndexDefs', memo.Lines[I]) <> 0)
        or (pos('.Data', memo.Lines[I]) <> 0)
        or (pos('SelectColumnsDialogStrings', memo.Lines[I]) <> 0) then
        begin
          //pula essa linha - n�o copia nada
        end

        else
          MemoCopiaVO.Lines.Add(memo.Lines[I]);

        inc(I);
      end;
      MemoCopiaVO.Lines.SaveToFile(ListVOs.Items[iContaTela]);
    end;
  finally
    ShowMessage('processo finalizado');
  end;
end;

end.
