{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado � tabela [TRIBUT_COFINS_COD_APURACAO] 
                                                                                
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
unit TributCofinsCodApuracaoVO;

{$mode objfpc}{$H+}

interface

uses
  VO, Classes, SysUtils, FGL,
  CstCofinsVO, EfdTabela435VO;

type
  TTributCofinsCodApuracaoVO = class(TVO)
  private
    FID: Integer;
    FID_TRIBUT_CONFIGURA_OF_GT: Integer;
    FCST_COFINS: String;
    FEFD_TABELA_435: String;
    FMODALIDADE_BASE_CALCULO: String;
    FPORCENTO_BASE_CALCULO: Extended;
    FALIQUOTA_PORCENTO: Extended;
    FALIQUOTA_UNIDADE: Extended;
    FVALOR_PRECO_MAXIMO: Extended;
    FVALOR_PAUTA_FISCAL: Extended;

    FCstCofinsVO: TCstCofinsVO;
    FCodigoApuracaoEfdVO: TEfdTabela435VO;

  published 
    constructor Create; override;
    destructor Destroy; override;

    property Id: Integer  read FID write FID;
    property IdTributConfiguraOfGt: Integer  read FID_TRIBUT_CONFIGURA_OF_GT write FID_TRIBUT_CONFIGURA_OF_GT;
    property CstCofins: String  read FCST_COFINS write FCST_COFINS;
    property EfdTabela435: String  read FEFD_TABELA_435 write FEFD_TABELA_435;
    property ModalidadeBaseCalculo: String  read FMODALIDADE_BASE_CALCULO write FMODALIDADE_BASE_CALCULO;
    property PorcentoBaseCalculo: Extended  read FPORCENTO_BASE_CALCULO write FPORCENTO_BASE_CALCULO;
    property AliquotaPorcento: Extended  read FALIQUOTA_PORCENTO write FALIQUOTA_PORCENTO;
    property AliquotaUnidade: Extended  read FALIQUOTA_UNIDADE write FALIQUOTA_UNIDADE;
    property ValorPrecoMaximo: Extended  read FVALOR_PRECO_MAXIMO write FVALOR_PRECO_MAXIMO;
    property ValorPautaFiscal: Extended  read FVALOR_PAUTA_FISCAL write FVALOR_PAUTA_FISCAL;

    property CstCofinsVO: TCstCofinsVO read FCstCofinsVO write FCstCofinsVO;

    property CodigoApuracaoEfdVO: TEfdTabela435VO read FCodigoApuracaoEfdVO write FCodigoApuracaoEfdVO;

  end;

  TListaTributCofinsCodApuracaoVO = specialize TFPGObjectList<TTributCofinsCodApuracaoVO>;

implementation

constructor TTributCofinsCodApuracaoVO.Create;
begin
  inherited;
  FCstCofinsVO := TCstCofinsVO.Create;
  FCodigoApuracaoEfdVO := TEfdTabela435VO.Create;
end;

destructor TTributCofinsCodApuracaoVO.Destroy;
begin
  FreeAndNil(FCstCofinsVO);
  FreeAndNil(FCodigoApuracaoEfdVO);
  inherited;
end;

initialization
  Classes.RegisterClass(TTributCofinsCodApuracaoVO);

finalization
  Classes.UnRegisterClass(TTributCofinsCodApuracaoVO);

end.
