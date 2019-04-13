{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado � tabela [VIEW_COMPRA_REQ_ITEM_COTADO] 
                                                                                
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
unit ViewCompraReqItemCotadoVO;

{$mode objfpc}{$H+}

interface

uses
  VO, Classes, SysUtils, FGL;

type
  TViewCompraReqItemCotadoVO = class(TVO)
  private
    FID: Integer;
    FID_COMPRA_REQUISICAO: Integer;
    FID_PRODUTO: Integer;
    FPRODUTONOME: String;
    FQUANTIDADE: Extended;
    FQUANTIDADE_COTADA: Extended;
    FITEM_COTADO: String;
    FID_COTACAO: Integer;

    //Transientes



  published 
    property Id: Integer  read FID write FID;
    property IdCompraRequisicao: Integer  read FID_COMPRA_REQUISICAO write FID_COMPRA_REQUISICAO;
    property IdProduto: Integer  read FID_PRODUTO write FID_PRODUTO;
    property ProdutoNome: String  read FPRODUTONOME write FPRODUTONOME;
    property Quantidade: Extended  read FQUANTIDADE write FQUANTIDADE;
    property QuantidadeCotada: Extended  read FQUANTIDADE_COTADA write FQUANTIDADE_COTADA;
    property ItemCotado: String  read FITEM_COTADO write FITEM_COTADO;
    property IdCotacao: Integer  read FID_COTACAO write FID_COTACAO;


    //Transientes



  end;

  TListaViewCompraReqItemCotadoVO = specialize TFPGObjectList<TViewCompraReqItemCotadoVO>;

implementation


initialization
  Classes.RegisterClass(TViewCompraReqItemCotadoVO);

finalization
  Classes.UnRegisterClass(TViewCompraReqItemCotadoVO);

end.
