{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado � tabela [VENDA_DETALHE] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2010 T2Ti.COM                                          
                                                                                
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
@version 1.0                                                                    
*******************************************************************************}
unit VendaDetalheVO;

{$mode objfpc}{$H+}

interface

uses
  VO, Classes, SysUtils, FGL;

type
  TVendaDetalheVO = class(TVO)
  private
    FID: Integer;
    FID_PRODUTO: Integer;
    FID_VENDA_CABECALHO: Integer;
    FQUANTIDADE: Extended;
    FVALOR_UNITARIO: Extended;
    FVALOR_SUBTOTAL: Extended;
    FTAXA_DESCONTO: Extended;
    FVALOR_DESCONTO: Extended;
    FVALOR_TOTAL: Extended;
    FTAXA_COMISSAO: Extended;
    FVALOR_COMISSAO: Extended;

  published 
    property Id: Integer  read FID write FID;
    property IdProduto: Integer  read FID_PRODUTO write FID_PRODUTO;
    property IdVendaCabecalho: Integer  read FID_VENDA_CABECALHO write FID_VENDA_CABECALHO;
    property Quantidade: Extended  read FQUANTIDADE write FQUANTIDADE;
    property ValorUnitario: Extended  read FVALOR_UNITARIO write FVALOR_UNITARIO;
    property ValorSubtotal: Extended  read FVALOR_SUBTOTAL write FVALOR_SUBTOTAL;
    property TaxaDesconto: Extended  read FTAXA_DESCONTO write FTAXA_DESCONTO;
    property ValorDesconto: Extended  read FVALOR_DESCONTO write FVALOR_DESCONTO;
    property ValorTotal: Extended  read FVALOR_TOTAL write FVALOR_TOTAL;
    property TaxaComissao: Extended  read FTAXA_COMISSAO write FTAXA_COMISSAO;
    property ValorComissao: Extended  read FVALOR_COMISSAO write FVALOR_COMISSAO;

  end;

  TListaVendaDetalheVO = specialize TFPGObjectList<TVendaDetalheVO>;

implementation

initialization
  Classes.RegisterClass(TVendaDetalheVO);

finalization
  Classes.UnRegisterClass(TVendaDetalheVO);


end.
