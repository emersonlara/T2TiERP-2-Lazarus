{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado � tabela [AGENCIA_BANCO] 
                                                                                
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
           t2ti.com@gmail.com                                                   

@author Albert Eije (t2ti.com@gmail.com)
@version 2.0
*******************************************************************************}
unit AgenciaBancoVO;

{$mode objfpc}{$H+}

interface

uses
  VO, Classes, SysUtils, FGL,
  BancoVO;

type
  TAgenciaBancoVO = class(TVO)
  private
    FID: Integer;
    FID_BANCO: Integer;
    FCODIGO: String;
    FDIGITO: String;
    FNOME: String;
    FLOGRADOURO: String;
    FNUMERO: String;
    FCEP: String;
    FBAIRRO: String;
    FMUNICIPIO: String;
    FUF: String;
    FTELEFONE: String;
    FGERENTE: String;
    FCONTATO: String;
    FOBSERVACAO: String;

    //Transientes
    FBancoNome: String;

    FBancoVO: TBancoVO;

  published 
    constructor Create; override;
    destructor Destroy; override;

    property Id: Integer  read FID write FID;

    property IdBanco: Integer  read FID_BANCO write FID_BANCO;
    property BancoNome: String read FBancoNome write FBancoNome;

    property Codigo: String  read FCODIGO write FCODIGO;
    property Digito: String  read FDIGITO write FDIGITO;
    property Nome: String  read FNOME write FNOME;
    property Logradouro: String  read FLOGRADOURO write FLOGRADOURO;
    property Numero: String  read FNUMERO write FNUMERO;
    property Cep: String  read FCEP write FCEP;
    property Bairro: String  read FBAIRRO write FBAIRRO;
    property Municipio: String  read FMUNICIPIO write FMUNICIPIO;
    property Uf: String  read FUF write FUF;
    property Telefone: String  read FTELEFONE write FTELEFONE;
    property Gerente: String  read FGERENTE write FGERENTE;
    property Contato: String  read FCONTATO write FCONTATO;
    property Observacao: String  read FOBSERVACAO write FOBSERVACAO;


    //Transientes
    property BancoVO: TBancoVO read FBancoVO write FBancoVO;

  end;

  TListaAgenciaBancoVO = specialize TFPGObjectList<TAgenciaBancoVO>;

implementation

constructor TAgenciaBancoVO.Create;
begin
  inherited;

  FBancoVO := TBancoVO.Create;
end;

destructor TAgenciaBancoVO.Destroy;
begin
  FreeAndNil(FBancoVO);
  inherited;
end;

initialization
  Classes.RegisterClass(TAgenciaBancoVO);

finalization
  Classes.UnRegisterClass(TAgenciaBancoVO);

end.
