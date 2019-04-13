{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Cliente relacionado � tabela [EMPRESA_TRANSPORTE_ITINERARIO] 
                                                                                
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
unit EmpresaTransporteItinerarioController;

{$MODE Delphi}

interface

uses
  Classes, Dialogs, SysUtils, DB, LCLIntf, LCLType, LMessages, Forms, Controller,
  VO, ZDataset, EmpresaTransporteItinerarioVO;

type
  TEmpresaTransporteItinerarioController = class(TController)
  private
  public
    class function Consulta(pFiltro: String; pPagina: String): TZQuery;
    class function ConsultaLista(pFiltro: String): TListaEmpresaTransporteItinerarioVO;
    class function ConsultaObjeto(pFiltro: String): TEmpresaTransporteItinerarioVO;

    class procedure Insere(pObjeto: TEmpresaTransporteItinerarioVO);
    class function Altera(pObjeto: TEmpresaTransporteItinerarioVO): Boolean;

    class function Exclui(pId: Integer): Boolean;

  end;

implementation

uses UDataModule, T2TiORM;

var
  ObjetoLocal: TEmpresaTransporteItinerarioVO;

class function TEmpresaTransporteItinerarioController.Consulta(pFiltro: String; pPagina: String): TZQuery;
begin
  try
    ObjetoLocal := TEmpresaTransporteItinerarioVO.Create;
    Result := TT2TiORM.Consultar(ObjetoLocal, pFiltro, pPagina);
  finally
    ObjetoLocal.Free;
  end;
end;

class function TEmpresaTransporteItinerarioController.ConsultaLista(pFiltro: String): TListaEmpresaTransporteItinerarioVO;
begin
  try
    ObjetoLocal := TEmpresaTransporteItinerarioVO.Create;
    Result := TListaEmpresaTransporteItinerarioVO(TT2TiORM.Consultar(ObjetoLocal, pFiltro, True));
  finally
    ObjetoLocal.Free;
  end;
end;

class function TEmpresaTransporteItinerarioController.ConsultaObjeto(pFiltro: String): TEmpresaTransporteItinerarioVO;
begin
  try
    Result := TEmpresaTransporteItinerarioVO.Create;
    Result := TEmpresaTransporteItinerarioVO(TT2TiORM.ConsultarUmObjeto(Result, pFiltro, True));
  finally
  end;
end;

class procedure TEmpresaTransporteItinerarioController.Insere(pObjeto: TEmpresaTransporteItinerarioVO);
var
  UltimoID: Integer;
begin
  try
    UltimoID := TT2TiORM.Inserir(pObjeto);
    Consulta('ID = ' + IntToStr(UltimoID), '0');
  finally
  end;
end;

class function TEmpresaTransporteItinerarioController.Altera(pObjeto: TEmpresaTransporteItinerarioVO): Boolean;
begin
  try
    Result := TT2TiORM.Alterar(pObjeto);
  finally
  end;
end;

class function TEmpresaTransporteItinerarioController.Exclui(pId: Integer): Boolean;
var
  ObjetoLocal: TEmpresaTransporteItinerarioVO;
begin
  try
    ObjetoLocal := TEmpresaTransporteItinerarioVO.Create;
    ObjetoLocal.Id := pId;
    Result := TT2TiORM.Excluir(ObjetoLocal);
  finally
    FreeAndNil(ObjetoLocal)
  end;
end;

initialization
  Classes.RegisterClass(TEmpresaTransporteItinerarioController);

finalization
  Classes.UnRegisterClass(TEmpresaTransporteItinerarioController);

end.

