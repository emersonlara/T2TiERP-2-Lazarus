{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado � tabela [FOLHA_HISTORICO_SALARIAL] 
                                                                                
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
unit FolhaHistoricoSalarialVO;

{$mode objfpc}{$H+}

interface

uses
  VO, Classes, SysUtils, FGL,
  ViewPessoaColaboradorVO;

type
  TFolhaHistoricoSalarialVO = class(TVO)
  private
    FID: Integer;
    FID_COLABORADOR: Integer;
    FCOMPETENCIA: String;
    FSALARIO_ATUAL: Extended;
    FPERCENTUAL_AUMENTO: Extended;
    FSALARIO_NOVO: Extended;
    FVALIDO_A_PARTIR: String;
    FMOTIVO: String;

    //Transientes
    FColaboradorNome: String;

    FColaboradorVO: TViewPessoaColaboradorVO;



  published
    constructor Create; override;
    destructor Destroy; override;

    property Id: Integer  read FID write FID;

    property IdColaborador: Integer  read FID_COLABORADOR write FID_COLABORADOR;
    property ColaboradorNome: String read FColaboradorNome write FColaboradorNome;

    property Competencia: String  read FCOMPETENCIA write FCOMPETENCIA;
    property SalarioAtual: Extended  read FSALARIO_ATUAL write FSALARIO_ATUAL;
    property PercentualAumento: Extended  read FPERCENTUAL_AUMENTO write FPERCENTUAL_AUMENTO;
    property SalarioNovo: Extended  read FSALARIO_NOVO write FSALARIO_NOVO;
    property ValidoAPartir: String  read FVALIDO_A_PARTIR write FVALIDO_A_PARTIR;
    property Motivo: String  read FMOTIVO write FMOTIVO;


    //Transientes
    property ColaboradorVO: TViewPessoaColaboradorVO read FColaboradorVO write FColaboradorVO;



  end;

  TListaFolhaHistoricoSalarialVO = specialize TFPGObjectList<TFolhaHistoricoSalarialVO>;

implementation

constructor TFolhaHistoricoSalarialVO.Create;
begin
  inherited;

  FColaboradorVO := TViewPessoaColaboradorVO.Create;
end;

destructor TFolhaHistoricoSalarialVO.Destroy;
begin
  FreeAndNil(FColaboradorVO);

  inherited;
end;

initialization
  Classes.RegisterClass(TFolhaHistoricoSalarialVO);

finalization
  Classes.UnRegisterClass(TFolhaHistoricoSalarialVO);

end.
