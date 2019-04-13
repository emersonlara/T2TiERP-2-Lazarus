{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Cliente relacionado � tabela [FIN_COBRANCA_PARCELA_RECEBER] 
                                                                                
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
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                    
@version 2.0                                                                    
*******************************************************************************}
unit FinCobrancaParcelaReceberController;

{$MODE Delphi}

interface

uses
  Classes, Dialogs, SysUtils, DB, LCLIntf, LCLType, LMessages, Forms, Controller,
  VO, ZDataset, FinCobrancaParcelaReceberVO;

type
  TFinCobrancaParcelaReceberController = class(TController)
  private
  public
    class function Consulta(pFiltro: String; pPagina: String): TZQuery;
    class function ConsultaLista(pFiltro: String): TListaFinCobrancaParcelaReceberVO;
    class function ConsultaObjeto(pFiltro: String): TFinCobrancaParcelaReceberVO;

    class procedure Insere(pObjeto: TFinCobrancaParcelaReceberVO);
    class function Altera(pObjeto: TFinCobrancaParcelaReceberVO): Boolean;

    class function Exclui(pId: Integer): Boolean;

  end;

implementation

uses UDataModule, T2TiORM;

var
  ObjetoLocal: TFinCobrancaParcelaReceberVO;

class function TFinCobrancaParcelaReceberController.Consulta(pFiltro: String; pPagina: String): TZQuery;
begin
  try
    ObjetoLocal := TFinCobrancaParcelaReceberVO.Create;
    Result := TT2TiORM.Consultar(ObjetoLocal, pFiltro, pPagina);
  finally
    ObjetoLocal.Free;
  end;
end;

class function TFinCobrancaParcelaReceberController.ConsultaLista(pFiltro: String): TListaFinCobrancaParcelaReceberVO;
begin
  try
    ObjetoLocal := TFinCobrancaParcelaReceberVO.Create;
    Result := TListaFinCobrancaParcelaReceberVO(TT2TiORM.Consultar(ObjetoLocal, pFiltro, True));
  finally
    ObjetoLocal.Free;
  end;
end;

class function TFinCobrancaParcelaReceberController.ConsultaObjeto(pFiltro: String): TFinCobrancaParcelaReceberVO;
begin
  try
    Result := TFinCobrancaParcelaReceberVO.Create;
    Result := TFinCobrancaParcelaReceberVO(TT2TiORM.ConsultarUmObjeto(Result, pFiltro, True));
  finally
  end;
end;

class procedure TFinCobrancaParcelaReceberController.Insere(pObjeto: TFinCobrancaParcelaReceberVO);
var
  UltimoID: Integer;
begin
  try
    UltimoID := TT2TiORM.Inserir(pObjeto);
    Consulta('ID = ' + IntToStr(UltimoID), '0');
  finally
  end;
end;

class function TFinCobrancaParcelaReceberController.Altera(pObjeto: TFinCobrancaParcelaReceberVO): Boolean;
begin
  try
    Result := TT2TiORM.Alterar(pObjeto);
  finally
  end;
end;

class function TFinCobrancaParcelaReceberController.Exclui(pId: Integer): Boolean;
var
  ObjetoLocal: TFinCobrancaParcelaReceberVO;
begin
  try
    ObjetoLocal := TFinCobrancaParcelaReceberVO.Create;
    ObjetoLocal.Id := pId;
    Result := TT2TiORM.Excluir(ObjetoLocal);
  finally
    FreeAndNil(ObjetoLocal)
  end;
end;

initialization
  Classes.RegisterClass(TFinCobrancaParcelaReceberController);

finalization
  Classes.UnRegisterClass(TFinCobrancaParcelaReceberController);

end.

