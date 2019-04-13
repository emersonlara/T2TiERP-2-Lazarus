{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Cliente relacionado � tabela [VIEW_FIN_CHEQUE_NAO_COMPENSADO] 
                                                                                
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
unit ViewFinChequeNaoCompensadoController;

{$MODE Delphi}

interface

uses
  Classes, Dialogs, SysUtils, DB, LCLIntf, LCLType, LMessages, Forms, Controller,
  VO, ZDataset, ViewFinChequeNaoCompensadoVO;

type
  TViewFinChequeNaoCompensadoController = class(TController)
  private
  public
    class function Consulta(pFiltro: String; pPagina: String): TZQuery;
    class function ConsultaLista(pFiltro: String): TListaViewFinChequeNaoCompensadoVO;
    class function ConsultaObjeto(pFiltro: String): TViewFinChequeNaoCompensadoVO;

    class procedure Insere(pObjeto: TViewFinChequeNaoCompensadoVO);
    class function Altera(pObjeto: TViewFinChequeNaoCompensadoVO): Boolean;

  end;

implementation

uses UDataModule, T2TiORM;

var
  ObjetoLocal: TViewFinChequeNaoCompensadoVO;

class function TViewFinChequeNaoCompensadoController.Consulta(pFiltro: String; pPagina: String): TZQuery;
begin
  try
    ObjetoLocal := TViewFinChequeNaoCompensadoVO.Create;
    Result := TT2TiORM.Consultar(ObjetoLocal, pFiltro, pPagina);
  finally
    ObjetoLocal.Free;
  end;
end;

class function TViewFinChequeNaoCompensadoController.ConsultaLista(pFiltro: String): TListaViewFinChequeNaoCompensadoVO;
begin
  try
    ObjetoLocal := TViewFinChequeNaoCompensadoVO.Create;
    Result := TListaViewFinChequeNaoCompensadoVO(TT2TiORM.Consultar(ObjetoLocal, pFiltro, True));
  finally
    ObjetoLocal.Free;
  end;
end;

class function TViewFinChequeNaoCompensadoController.ConsultaObjeto(pFiltro: String): TViewFinChequeNaoCompensadoVO;
begin
  try
    Result := TViewFinChequeNaoCompensadoVO.Create;
    Result := TViewFinChequeNaoCompensadoVO(TT2TiORM.ConsultarUmObjeto(Result, pFiltro, True));
  finally
  end;
end;

class procedure TViewFinChequeNaoCompensadoController.Insere(pObjeto: TViewFinChequeNaoCompensadoVO);
var
  UltimoID: Integer;
begin
  try
    UltimoID := TT2TiORM.Inserir(pObjeto);
    Consulta('ID = ' + IntToStr(UltimoID), '0');
  finally
  end;
end;

class function TViewFinChequeNaoCompensadoController.Altera(pObjeto: TViewFinChequeNaoCompensadoVO): Boolean;
begin
  try
    Result := TT2TiORM.Alterar(pObjeto);
  finally
  end;
end;

initialization
  Classes.RegisterClass(TViewFinChequeNaoCompensadoController);

finalization
  Classes.UnRegisterClass(TViewFinChequeNaoCompensadoController);

end.

/// EXERCICIO: CRIE UMA JANELA DE CADASTRO QUE PERMITA O LANCAMENTO DE DO SALDO DISPONIVEL NA TABELA FIN_FECHAMENTO_CAIXA_BANCO
///  ESSE SER� O SALDO INICIAL DA CONTA
///  VERIFIQUE SE J� EXISTEM FECHAMENTOS REALIZADOS. NESSE CASO N�O PERMITA O CADASTRO

/// EXERCICIO: CRIE UMA JANELA QUE PERMITA A TRANSFERENCIA DE VALORES ENTRE CONTA/CAIXAS
///  SER� PRECISO CRIAR UMA TABELA PARA CONTROLAR ISSO?

/// EXERCICIO: CRIE O RELAT�RIO DE DEMONSTRA��ES FINANCEIRAS CONFORME ABAIXO:
///  ===========================================================================
///  DADOS MENSAIS - PERIODO: 01/2016
///  ===========================================================================
///  SALDO ANTERIOR                                                       100,00
///  TOTAL DE RECEBIMENTOS                                                 50,00
///  TOTAL DE PAGAMENTOS                                                   40,00
///  SALDO DISPONIVEL                                                     110,00
///  CHEQUES NAO COMPENSADOS                                              100,00
///  SALDO DE BANCO                                                        10,00
///  ===========================================================================
///  DADOS ANUAIS - ANO: 2016
///  ===========================================================================
///  SALDO ANTERIOR                                                       100,00
///  TOTAL DE RECEBIMENTOS                                                 50,00
///  TOTAL DE PAGAMENTOS                                                   40,00
///  SALDO DISPONIVEL                                                     110,00
///  CHEQUES NAO COMPENSADOS                                              100,00
///  SALDO DE BANCO                                                        10,00
///  ===========================================================================


