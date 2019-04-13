{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado � tabela [CTE_RODOVIARIO_OCC] 
                                                                                
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
unit CteRodoviarioOccVO;

{$mode objfpc}{$H+}

interface

uses
  VO, Classes, SysUtils, FGL;

type
  TCteRodoviarioOccVO = class(TVO)
  private
    FID: Integer;
    FID_CTE_RODOVIARIO: Integer;
    FSERIE: String;
    FNUMERO: Integer;
    FDATA_EMISSAO: TDateTime;
    FCNPJ: String;
    FCODIGO_INTERNO: String;
    FIE: String;
    FUF: String;
    FTELEFONE: String;

    //Transientes



  published 
    property Id: Integer  read FID write FID;
    property IdCteRodoviario: Integer  read FID_CTE_RODOVIARIO write FID_CTE_RODOVIARIO;
    property Serie: String  read FSERIE write FSERIE;
    property Numero: Integer  read FNUMERO write FNUMERO;
    property DataEmissao: TDateTime  read FDATA_EMISSAO write FDATA_EMISSAO;
    property Cnpj: String  read FCNPJ write FCNPJ;
    property CodigoInterno: String  read FCODIGO_INTERNO write FCODIGO_INTERNO;
    property Ie: String  read FIE write FIE;
    property Uf: String  read FUF write FUF;
    property Telefone: String  read FTELEFONE write FTELEFONE;


    //Transientes



  end;

  TListaCteRodoviarioOccVO = specialize TFPGObjectList<TCteRodoviarioOccVO>;

implementation


initialization
  Classes.RegisterClass(TCteRodoviarioOccVO);

finalization
  Classes.UnRegisterClass(TCteRodoviarioOccVO);

end.
